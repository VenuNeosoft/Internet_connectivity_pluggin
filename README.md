# 🛑 offline_banner

A simple Flutter plugin to automatically show a banner when the internet is disconnected.

## 🚀 Features

- 🔍 Monitors internet connectivity
- 📢 Displays a red banner when offline
- 🔁 Retry button integration
- 🎨 Customizable banner support

## 🔧 Usage

```dart
OfflineBanner(
  retryCallback: () => fetchData(),
  customBanner: MyCustomBannerWidget(),
  child: MyApp(),
);
