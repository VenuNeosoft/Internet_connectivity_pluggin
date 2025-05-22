# 🛑 offline_banner

A simple Flutter plugin to automatically show a banner when the internet is disconnected.

## 🚀 Features

- 🔍 Monitors internet connectivity
- 📢 Displays a red banner when offline
- 🔁 Retry button integration
- 🎨 Customizable banner support

---

### 📷 Checking Internet Connection:

<table>

  <tr>
    <td><img src="https://raw.githubusercontent.com/VenuNeosoft/image_to_text_mlkit/main/camera.gif" width=270 height=560></td>
  </tr>
 </table>



## 🚀 Getting Started

### 1. **Add Dependency**
Add the following to your `pubspec.yaml`:
``` yaml
dependencies:
  offline_banner: ^1.0.0
  ```
2. Install Package
Run the following command:

flutter pub get

3. Import the Package
``` package
import 'package:offline_banner/offline_banner.dart';
```

## 🔧 Usage

```dart
OfflineBanner(
  retryCallback: () => fetchData(),
  customBanner: MyCustomBannerWidget(),
  child: MaterialApp(),
);



⚙️ Permissions
🟢 Android Permissions

Add the following permissions in android/app/src/main/AndroidManifest.xml:

``` xml
<uses-permission android:name="android.permission.INTERNET"/>


 ```
    
Add the following permissions in  /android/app/src/main/res/xml/network_security_config.xml
if you dont have create one file and add below code in xml/network_security_config.xml

``` network_security_config.xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">images.template.net</domain>
    </domain-config>
</network-security-config>
```

Add the following permissions in android/app/build.gradle:

``` xml
android {
    compileSdkVersion 34 // Or latest
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```
🍎 iOS Permissions

Add the following keys to your ios/Runner/Info.plist file:

``` plist
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

# 📸 Developed by
✅ VENU RENANGI  
✅ SONAM GUPTA
✅ KAMNA JOSHI
