# Internet Speed Meter

A Flutter package for monitoring network speed.

## Installation

Add `internet_speed_meter ` to your `pubspec.yaml` file:

```yaml
dependencies:
  internet_speed_meter: ^1.0.2
```

## Permissions

Ensure that you have the necessary permissions in your AndroidManifest.xml file:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.yourapp">
    <!-- Other permissions and declarations -->

    <!-- Required for checking network connectivity -->
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <!-- Required for accessing the internet -->
    <uses-permission android:name="android.permission.INTERNET"/>

    <application
        <!-- Other application configurations -->
    >
        <!-- Activities, services, receivers, etc. -->

    </application>
</manifest>

```

## Usage

Import the package in your Dart file:

```dart
import 'package:internet_speed_meter/internet_speed_meter.dart';
```

Create an instance of InternetSpeedMeter and use the getCurrentInternetSpeed stream to get real-time internet speed updates:

```dart
void main() {
  InternetSpeedMeter _internetSpeedMeterPlugin = InternetSpeedMeter();

  _internetSpeedMeterPlugin.getCurrentInternetSpeed().listen((speed) {
    print('Current Speed: $speed');
  });
}

```

## Features

- Real-time monitoring of network speed.
- Supports both kbps and Mbps units.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for bug fixes, feature requests, or any improvements you'd like to see in the package.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

```vbnet

This README.md file provides clear instructions on how to install the package, use the `NetworkSpeedMonitor` class, and contribute to the project.

```
