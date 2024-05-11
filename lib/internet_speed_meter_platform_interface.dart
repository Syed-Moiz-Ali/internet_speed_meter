import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'internet_speed_meter_method_channel.dart';

abstract class InternetSpeedMeterPlatform extends PlatformInterface {
  /// Constructs a InternetSpeedMeterPlatform.
  InternetSpeedMeterPlatform() : super(token: _token);

  static final Object _token = Object();

  static InternetSpeedMeterPlatform _instance =
      MethodChannelInternetSpeedMeter();

  /// The default instance of [InternetSpeedMeterPlatform] to use.
  ///
  /// Defaults to [MethodChannelInternetSpeedMeter].
  static InternetSpeedMeterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InternetSpeedMeterPlatform] when
  /// they register themselves.
  static set instance(InternetSpeedMeterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Stream<String> realtimeInternetSpeed() {
    throw UnimplementedError(
        'realtimeInternetSpeed() has not been implemented.');
  }
}
