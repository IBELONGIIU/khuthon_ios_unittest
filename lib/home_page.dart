// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'camera_page.dart';
import 'map_page.dart';
import 'report_page.dart';
import 'main_dashboard.dart'; // 이거 추가!
import 'components/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // 여기에서 페이지 순서를 정의함
  final List<Widget> _pages = [
    MainDashboard(), // ← 0번 인덱스: 홈 (Lovable의 Index.tsx 스타일)
    CameraPage(),    // ← 1번: 작물 스캔
    ReportPage(),    // ← 2번: 알림 역할 (임시)
    MapPage(),       // ← 3번: 정보 역할 (임시)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}