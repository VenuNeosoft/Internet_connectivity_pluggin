import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class OfflineBannerPlatform extends PlatformInterface {
  OfflineBannerPlatform() : super(token: _token);

  static final Object _token = Object();

  static OfflineBannerPlatform _instance = MethodChannelOfflineBanner();

  static OfflineBannerPlatform get instance => _instance;

  static set instance(OfflineBannerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> get isOffline;
}

class MethodChannelOfflineBanner extends OfflineBannerPlatform {
  @override
  Future<bool> get isOffline async => throw UnimplementedError();
}
