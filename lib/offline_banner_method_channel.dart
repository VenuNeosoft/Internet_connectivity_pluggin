import 'package:flutter/services.dart';
import 'offline_banner_platform_interface.dart';

class MethodChannelOfflineBanner extends OfflineBannerPlatform {
  static const MethodChannel _channel = MethodChannel('offline_banner');

  @override
  Future<bool> get isOffline async {
    final bool result = await _channel.invokeMethod('isOffline');
    return result;
  }
}
