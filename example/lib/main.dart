import 'package:flutter/material.dart';
import 'package:offline_banner/offline_banner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OfflineBanner(
        retryCallback: () {
          // Any action after reconnection
          debugPrint("Retry successful — now online!");
        },
        child: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internet Connection Checking'),
        backgroundColor: Colors.blue,
      ),
      body: Center(child: Text('Home Screen')),
    );
  }
}
