import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hcaptcha_flutter/hcaptcha_flutter_method_channel.dart';

void main() {
  MethodChannelHcaptchaFlutter platform = MethodChannelHcaptchaFlutter();
  const MethodChannel channel = MethodChannel('hcaptcha_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
