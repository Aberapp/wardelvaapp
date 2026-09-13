import 'package:flutter/material.dart';
import 'categories.dart';
import 'home.dart';
import 'loyalty.dart';
import 'orders.dart';
import 'profile.dart';

/// الهيكل الرئيسي مع الشريط السفلي.
class AppShell extends StatefulWidget {
  const AppShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<AppShell> createState() => AppShellState();

  /// للتنقل بين التبويبات من أي شاشة داخلية.
  static void goToTab(BuildContext context, int index) {
    context.findAncestorStateOfType<AppShellState>()?.setTab(index);
  }
}

class AppShellState extends State<AppShell> {
  late int _index = widget.initialIndex;

  void setTab(int index) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    setState(() => _index = index);
  }

  static const _pages = [
    HomeScreen(),
    CategoriesScreen(),
    OrdersScreen(),
    LoyaltyScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), activeIcon: Icon(Icons.grid_view), label: 'الأقسام'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), activeIcon: Icon(Icons.inventory_2), label: 'طلباتي'),
          BottomNavigationBarItem(icon: Icon(Icons.star_border), activeIcon: Icon(Icons.star), label: 'الولاء'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}
