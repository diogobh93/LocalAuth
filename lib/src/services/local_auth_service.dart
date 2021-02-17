import 'dart:async';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<List> checkBiometrics() async {
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      if (canCheckBiometrics) {
        return [
          canCheckBiometrics,
          "Autenticação disponível",
          'Pressione o botão abaixo para verificar qual autenticação está cadastrada em seu dispositivo.'
        ];
      } else {
        return [
          canCheckBiometrics,
          'Autenticação indisponível',
          'Nenhuma recurso de autenticação disponível',
        ];
      }
    } on PlatformException catch (e) {
      print(e);
      return [
        canCheckBiometrics,
        'Autenticação indisponível',
        'Nenhuma recurso de autenticação disponível',
      ];
    }
  }

  Future<List> getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
      if (availableBiometrics != null) {
        String type = availableBiometrics[0].toString().split('.')[1];
        String authType = type == 'fingerprint'
            ? 'Autenticação por Biometria'
            : 'Autenticação por Reconhecimento Facial';
        return [
          true,
          authType,
          'Pressione o botão abaixo para realizar a autenticação de acesso e ir para a próxima página!'
        ];
      } else {
        return [
          false,
          "Nenhuma autenticação disponível",
          "Não foi possível identificar uma autenticação válida!"
        ];
      }
    } on PlatformException catch (e) {
      print(e);
      return [
        false,
        "Nenhuma autenticação disponível",
        "Não foi possível identificar uma autenticação válida!"
      ];
    }
  }

  Future<List> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Digitalize sua impressão digital para autenticar',
          useErrorDialogs: true,
          stickyAuth: true);
      if (authenticated) {
        return [
          authenticated,
          'Acesso permitido!',
          'A autenticação foi validada com sucesso, agora é possível executar a ação desejada'
        ];
      } else {
        return [
          authenticated,
          'Acesso negado!',
          'Falha na autenticação, tente novamente',
        ];
      }
    } on PlatformException catch (e) {
      print(e);
      return [
        authenticated,
        'Acesso negado!',
        'Falha na autenticação, tente novamente',
      ];
    }
  }

  cancelAuthentication() {
    auth.stopAuthentication();
  }
}
