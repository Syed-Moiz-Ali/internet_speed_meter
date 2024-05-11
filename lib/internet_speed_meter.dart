import 'internet_speed_meter_platform_interface.dart';

class InternetSpeedMeter {
  Future<String?> getPlatformVersion() {
    return InternetSpeedMeterPlatform.instance.getPlatformVersion();
  }

  Stream<String> getCurrentInternetSpeed() {
    return InternetSpeedMeterPlatform.instance.realtimeInternetSpeed();
  }
}
