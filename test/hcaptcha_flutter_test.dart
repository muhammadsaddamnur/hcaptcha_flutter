import 'package:flutter_test/flutter_test.dart';
import 'package:hcaptcha_flutter/hcaptcha_flutter.dart';
import 'package:hcaptcha_flutter/hcaptcha_flutter_platform_interface.dart';
import 'package:hcaptcha_flutter/hcaptcha_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHcaptchaFlutterPlatform
    with MockPlatformInterfaceMixin
    implements HcaptchaFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HcaptchaFlutterPlatform initialPlatform = HcaptchaFlutterPlatform.instance;

  test('$MethodChannelHcaptchaFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHcaptchaFlutter>());
  });

  test('getPlatformVersion', () async {
    HcaptchaFlutter hcaptchaFlutterPlugin = HcaptchaFlutter();
    MockHcaptchaFlutterPlatform fakePlatform = MockHcaptchaFlutterPlatform();
    HcaptchaFlutterPlatform.instance = fakePlatform;

    expect(await hcaptchaFlutterPlugin.getPlatformVersion(), '42');
  });
}
