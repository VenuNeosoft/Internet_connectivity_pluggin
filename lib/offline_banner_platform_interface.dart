import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'offline_banner_method_channel.dart';

abstract class OfflineBannerPlatform extends PlatformInterface {
  /// Constructs a OfflineBannerPlatform.
  OfflineBannerPlatform() : super(token: _token);

  static final Object _token = Object();

  static OfflineBannerPlatform _instance = MethodChannelOfflineBanner();

  /// The default instance of [OfflineBannerPlatform] to use.
  ///
  /// Defaults to [MethodChannelOfflineBanner].
  static OfflineBannerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OfflineBannerPlatform] when
  /// they register themselves.
  static set instance(OfflineBannerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
