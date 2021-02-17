import 'package:LocalAuth/src/services/local_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  bool _isAuthenticating;
  bool _availableBiometrics;
  String titleAuth = "";
  String subTitleAuth =
      "Pressione o botão abaixo para verificar se há autenticação de biometria ou reconhecimento facial disponível";

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_isAuthenticating == null)
                  Image.asset(
                    'assets/biometric.png',
                    height: 0.25 * MediaQuery.of(context).size.height,
                    fit: BoxFit.contain,
                  ),
                if (_isAuthenticating != null && _isAuthenticating)
                  Image.asset(
                    'assets/sucessful.png',
                    height: 0.25 * MediaQuery.of(context).size.height,
                    fit: BoxFit.contain,
                  ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    titleAuth,
                    style: TextStyle(
                        fontSize: 20 * MediaQuery.of(context).textScaleFactor,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    subTitleAuth,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12 * MediaQuery.of(context).textScaleFactor,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 40),
                if (!_canCheckBiometrics)
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    color: Colors.red,
                    splashColor: Colors.blueGrey[900],
                    child: const Text(
                      'Verificar autenticação',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => {
                      LocalAuthService().checkBiometrics().then((response) => {
                            setState(() {
                              _canCheckBiometrics = response[0];
                              titleAuth = response[1];
                              subTitleAuth = response[2];
                            })
                          })
                    },
                  ),
                if (_canCheckBiometrics && _availableBiometrics == null)
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      color: Colors.blue,
                      splashColor: Colors.blueGrey[900],
                      child: const Text(
                        'Buscar autenticação',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => {
                            LocalAuthService()
                                .getAvailableBiometrics()
                                .then((response) => {
                                      setState(() {
                                        _availableBiometrics = response[0];
                                        titleAuth = response[1];
                                        subTitleAuth = response[2];
                                      })
                                    })
                          }),
                if (_availableBiometrics != null)
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    color: Colors.green,
                    splashColor: Colors.blueGrey[900],
                    child: Text(
                      _isAuthenticating != null
                          ? 'Tentar novamente'
                          : 'Usar autenticação',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () =>
                        LocalAuthService().authenticate().then((response) => {
                              setState(() {
                                _isAuthenticating = response[0];
                                titleAuth = response[1];
                                subTitleAuth = response[2];
                              })
                            }),
                  )
              ])),
    ));
  }
}
