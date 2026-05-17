import 'package:flutter/material.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/discovery/screens/discovery_screen.dart';
import '../constants/app_colors.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // Alt bardaki sekmelerin sırasıyla açacağı ekran listesi
  final List<Widget> _screens = [
    const HomeScreen(),
    const DiscoveryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children:
            _screens, // Sayfaların durumunu (state) kaybetmemesi için IndexedStack kullanıyoruz
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Kullanıcı tıkladığında sayfayı değiştir
          });
        },
        selectedItemColor: AppColors.primaryOrange, // Aktif olan sekme turuncu
        unselectedItemColor: Colors.grey, // Aktif olmayanlar gri
        backgroundColor: AppColors.surfaceLight,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Keşif',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
