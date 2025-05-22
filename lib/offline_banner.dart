library offline_banner;

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum BannerPosition { top, bottom }

class OfflineBanner extends StatefulWidget {
  final Widget child;
  final VoidCallback? retryCallback;
  final Widget? customBanner;
  final Duration checkInterval;
  final BannerPosition bannerPosition;

  const OfflineBanner({
    super.key,
    required this.child,
    this.retryCallback,
    this.customBanner,
    this.bannerPosition = BannerPosition.bottom,
    this.checkInterval = const Duration(seconds: 3),
  });

  @override
  State<OfflineBanner> createState() => _OfflineBannerState();
}

class _OfflineBannerState extends State<OfflineBanner>
    with TickerProviderStateMixin {
  bool _isOffline = false;
  bool _isRetrying = false;
  bool _showOnlinePopup = false;

  final Connectivity _connectivity = Connectivity();
  late final AnimationController _offlineController;
  late final Animation<Offset> _offlineAnimation;

  @override
  void initState() {
    super.initState();
    _offlineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offlineAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // slide from bottom
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _offlineController, curve: Curves.easeInOut),
    );

    _startMonitoring();
  }

  @override
  void dispose() {
    _offlineController.dispose();
    super.dispose();
  }

  void _startMonitoring() {
    _connectivity.onConnectivityChanged.listen((result) {
      final isOffline = result.any(
        (result) => result == ConnectivityResult.none,
      );
      if (_isOffline != isOffline) {
        setState(() => _isOffline = isOffline);
        if (isOffline) {
          _offlineController.forward(); // show banner
        } else {
          _offlineController.reverse(); // hide banner
          _showOnlinePopupMessage();
        }
      }
    });
  }

  Future<void> _retryCheck() async {
    setState(() => _isRetrying = true);
    final result = await _connectivity.checkConnectivity();
    final stillOffline = result.any(
      (result) => result == ConnectivityResult.none,
    );
    setState(() {
      _isOffline = stillOffline;
      _isRetrying = false;
    });

    if (!stillOffline) {
      _offlineController.reverse();
      _showOnlinePopupMessage();
      widget.retryCallback?.call();
    }
  }

  void _showOnlinePopupMessage() {
    setState(() => _showOnlinePopup = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showOnlinePopup = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            widget.child,

            /// Offline animated banner
            Positioned(
              top: widget.bannerPosition == BannerPosition.top ? 0 : null,
              bottom: widget.bannerPosition == BannerPosition.bottom ? 0 : null,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: _offlineAnimation,
                child: widget.customBanner ??
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      color: Colors.redAccent,
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'No Internet Connection',
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                          _isRetrying
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : TextButton(
                                  onPressed: _retryCheck,
                                  child: const Text(
                                    'Retry',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                        ],
                      ),
                    ),
              ),
            ),

            /// Online popup message
            if (_showOnlinePopup)
              Positioned(
                top: widget.bannerPosition == BannerPosition.top ? 0 : null,
                bottom:
                    widget.bannerPosition == BannerPosition.bottom ? 50 : null,
                left: MediaQuery.of(context).size.width * 0.2,
                right: MediaQuery.of(context).size.width * 0.2,
                child: AnimatedOpacity(
                  opacity: _showOnlinePopup ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'You are online!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
