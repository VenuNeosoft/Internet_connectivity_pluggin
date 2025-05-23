## [1.0.0] - 2025-05-22

### Added
- Initial release of `offline_banner`.
- Detects internet connectivity changes using `connectivity_plus`.
- Displays an animated offline banner (customizable position: top or bottom).
- Includes a retry button with loading indicator.
- Shows a popup animation when internet is restored.
- Allows custom banner widget injection.

## [1.0.1] - 2025-05-22

### Added

- Allows banner possition with animation.

## [1.0.2] - 2025-05-23
Changed
- Removed dependency on the third-party connectivity_plus package.

- Implemented native internet connectivity detection using platform-specific code:

- iOS: Utilizes NWPathMonitor for reliable network status updates.

- Android: Uses ConnectivityManager.NetworkCallback for real-time connectivity state.

- Improved performance and reduced package size by eliminating external connectivity libraries.

- Enhanced reliability by directly integrating with platform APIs for more accurate offline/online detection.
