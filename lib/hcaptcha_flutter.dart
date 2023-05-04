import 'hcaptcha_flutter_platform_interface.dart';

class HcaptchaFlutter {
  Future<String?> getPlatformVersion() {
    return HcaptchaFlutterPlatform.instance.getPlatformVersion();
  }

  Future<void> onClickSetup() {
    return HcaptchaFlutterPlatform.instance.onClickSetup();
  }

  Future<void> onClickVerify() {
    return HcaptchaFlutterPlatform.instance.onClickVerify();
  }

  Future<void> onClickReset() {
    return HcaptchaFlutterPlatform.instance.onClickReset();
  }
}
