import 'package:flutter/material.dart';
import 'home_page.dart';
import 'camera_page.dart';
import 'map_page.dart';
import 'report_page.dart';
import 'main_dashboard.dart'; // 혹시 필요하면
// 알림, 정보 페이지도 추가 예정이면 여기에 import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
      routes: {
        '/camera': (context) => CameraPage(),
        '/map': (context) => MapPage(),
        '/report': (context) => ReportPage(),
        // '/alerts': (context) => AlertsPage(), ← 만들게 되면 추가
        // '/info': (context) => InfoPage(),     ← 만들게 되면 추가
      },
    );
  }
}