import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  final Widget child; // Ortada değişecek olan sayfa içeriği

  const MainLayout({super.key, required this.child});

  // Hangi sekmede olduğumuzu URL'den anlayan yardımcı fonksiyon
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/create')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  // Alt menüdeki butonlara tıklandığında ne olacağı
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/create');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child, // Ortadaki dinamik içerik
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
        selectedItemColor: const Color(0xFF3B82F6), // Tailwind Mavi (Aktif)
        unselectedItemColor: Colors.grey, // Pasif renk
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'İlanlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'İlan Ver',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profilim',
          ),
        ],
      ),
    );
  }
}