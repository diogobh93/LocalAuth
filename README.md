# LocalAuth
Aplicativo feito em Flutter para estudo com foco na autenticação por biometria para Android.

![colletion2](https://user-images.githubusercontent.com/37723303/108143588-ce1fba80-70a6-11eb-8226-011f5e46a1d6.jpg)

## Configuração biometria para Android. ##

**Adicionar no pubspec.yaml**
```bash
dependencies:
  local_auth: ^0.6.3+4
```
**Link do package utilizado**
- [x] https://pub.dev/packages/local_auth 

**Adicionar a permissão no AndroidManifest.xml**
```bash
<uses-permission android:name="android.permission.USE_FINGERPRINT"/>
```

**Substituir código principal do MainActivity.kt em android> app> src> main> kotlin...**
```bash
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity() {
   override fun configureFlutterEngine( flutterEngine: 
     FlutterEngine) {
     GeneratedPluginRegistrant.registerWith(flutterEngine)
   }
}
```
**Obs: Não remova o package do projeto da primeira linha.**

**Verificar em gradle.properties se esta com a configuração do AndroidX conforme abaixo:**
```bash
android.useAndroidX=true
android.enableJetifier=true
```

## Configuração reconhecimento facial para IOS ##
**Obs: Não configurado.**

**Adicionar no info.plist**
```bash
<key>NSFaceIDUsageDescription</key>
<string>Face recognition authentication</string>
```


>#Flutter #Biometric
