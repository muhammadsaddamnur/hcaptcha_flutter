import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hcaptcha_flutter_platform_interface.dart';

/// An implementation of [HcaptchaFlutterPlatform] that uses method channels.
class MethodChannelHcaptchaFlutter extends HcaptchaFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hcaptcha_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> onClickSetup() async {
    await methodChannel.invokeMethod<String>('onClickSetup');
  }

  @override
  Future<void> onClickVerify() async {
    await methodChannel.invokeMethod<String>('onClickVerify');
  }

  @override
  Future<void> onClickReset() async {
    await methodChannel.invokeMethod<String>('onClickReset');
  }
}
