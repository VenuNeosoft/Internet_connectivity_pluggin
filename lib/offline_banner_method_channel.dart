import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'offline_banner_platform_interface.dart';

/// An implementation of [OfflineBannerPlatform] that uses method channels.
class MethodChannelOfflineBanner extends OfflineBannerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('offline_banner');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
