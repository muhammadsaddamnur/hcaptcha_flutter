import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hcaptcha_flutter_method_channel.dart';

abstract class HcaptchaFlutterPlatform extends PlatformInterface {
  /// Constructs a HcaptchaFlutterPlatform.
  HcaptchaFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static HcaptchaFlutterPlatform _instance = MethodChannelHcaptchaFlutter();

  /// The default instance of [HcaptchaFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelHcaptchaFlutter].
  static HcaptchaFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HcaptchaFlutterPlatform] when
  /// they register themselves.
  static set instance(HcaptchaFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> onClickSetup() {
    throw UnimplementedError('onClickSetup() has not been implemented.');
  }

  Future<void> onClickVerify() {
    throw UnimplementedError('onClickVerify() has not been implemented.');
  }

  Future<void> onClickReset() {
    throw UnimplementedError('onClickReset() has not been implemented.');
  }
}
