import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'internet_speed_meter_platform_interface.dart';

/// An implementation of [InternetSpeedMeterPlatform] that uses method channels.
class MethodChannelInternetSpeedMeter extends InternetSpeedMeterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('internet_speed_meter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Stream<String> realtimeInternetSpeed() async* {
    while (true) {
      yield await getCurrentSpeed(); // Yield the result of getCurrentSpeed()
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<String> getCurrentSpeed() async {
    try {
      var speed = await methodChannel.invokeMethod('getSpeed');
      var newSpeed = speed / 1024;
      String speedUnit;
      double speedValue;

      if (double.parse(newSpeed.toString()) >= 1024) {
        speedUnit = 'Mbps';
        speedValue = double.parse(newSpeed.toString()) / 1024;
      } else {
        speedUnit = 'kbps';
        speedValue = double.parse(newSpeed.toString());
      }

      // Return the formatted speed with unit
      return speedValue.toStringAsFixed(2) + speedUnit;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to get current speed: '${e.message}'.");
      }
      return '0.0'; // Return a default value if an error occurs
    }
  }
}
