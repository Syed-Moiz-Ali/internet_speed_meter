import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_speed_meter/internet_speed_meter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelInternetSpeedMeter platform = MethodChannelInternetSpeedMeter();
  const MethodChannel channel = MethodChannel('internet_speed_meter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
  test('realtimeInternetSpeed', () async {
    expect(await platform.getCurrentSpeed(), '0.0');
  });
}
