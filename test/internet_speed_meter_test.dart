import 'package:flutter_test/flutter_test.dart';
import 'package:internet_speed_meter/internet_speed_meter.dart';
import 'package:internet_speed_meter/internet_speed_meter_platform_interface.dart';
import 'package:internet_speed_meter/internet_speed_meter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInternetSpeedMeterPlatform
    with MockPlatformInterfaceMixin
    implements InternetSpeedMeterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Stream<String> realtimeInternetSpeed() => Stream.value('0.0');
}

void main() {
  final InternetSpeedMeterPlatform initialPlatform =
      InternetSpeedMeterPlatform.instance;

  test('$MethodChannelInternetSpeedMeter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelInternetSpeedMeter>());
  });

  test('getPlatformVersion', () async {
    InternetSpeedMeter internetSpeedMeterPlugin = InternetSpeedMeter();
    MockInternetSpeedMeterPlatform fakePlatform =
        MockInternetSpeedMeterPlatform();
    InternetSpeedMeterPlatform.instance = fakePlatform;

    expect(await internetSpeedMeterPlugin.getPlatformVersion(), '42');
  });
  test('realtimeInternetSpeed', () async {
    InternetSpeedMeter internetSpeedMeterPlugin = InternetSpeedMeter();
    MockInternetSpeedMeterPlatform fakePlatform =
        MockInternetSpeedMeterPlatform();
    InternetSpeedMeterPlatform.instance = fakePlatform;

    expect(internetSpeedMeterPlugin.getCurrentInternetSpeed(), '0.0');
  });
}
