import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/formatters.dart';
import '../core/tokens.dart';
import '../data/catalog.dart';
import '../state/app_state.dart';
import '../widgets/common.dart';
import '../widgets/product_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(title: const Text('حسابي')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          WCard(
            color: WColors.green,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundColor: WColors.cream.withOpacity(0.15),
                  child: Text(state.customerName.substring(0, 1),
                      style: const TextStyle(color: WColors.cream, fontSize: 17)),
                ),
                WGaps.wsm,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.customerName,
                          style: const TextStyle(color: WColors.cream, fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(state.phone,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(color: WColors.cream, fontSize: 11.5)),
                    ],
                  ),
                ),
                WTag(state.points >= 500 ? 'ذهبي' : 'فضي',
                    background: WColors.gold, foreground: const Color(0xFF221A06)),
              ],
            ),
          ),
          const WSectionTitle('حسابي'),
          _Tile(icon: Icons.favorite_border, label: 'المفضلة', trailing: toArabicDigits(state.favorites.length),
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const _FavoritesScreen()),
                  )),
          _Tile(icon: Icons.location_on_outlined, label: 'عناويني', onTap: () {}),
          _Tile(icon: Icons.credit_card, label: 'طرق الدفع', onTap: () {}),
          _Tile(icon: Icons.event_outlined, label: 'المناسبات المحفوظة', onTap: () {}),
          const WSectionTitle('الدعم والإعدادات'),
          _Tile(icon: Icons.chat_bubble_outline, label: 'تواصل معنا', onTap: () {}),
          _Tile(icon: Icons.notifications_none, label: 'الإشعارات', onTap: () {}),
          _Tile(icon: Icons.lock_outline, label: 'الخصوصية والشروط', onTap: () {}),
          _Tile(icon: Icons.delete_outline, label: 'حذف الحساب', onTap: () {}),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.icon, required this.label, required this.onTap, this.trailing});

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? trailing;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: WCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          onTap: onTap,
          child: Row(
            children: [
              Icon(icon, size: 18, color: WColors.green),
              WGaps.wsm,
              Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
              if (trailing != null)
                Text(trailing!, style: const TextStyle(fontSize: 12, color: WColors.gray)),
              const Icon(Icons.chevron_left, size: 18, color: WColors.green300),
            ],
          ),
        ),
      );
}

class _FavoritesScreen extends StatelessWidget {
  const _FavoritesScreen();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final products = Catalog.products.where((p) => state.isFavorite(p.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('المفضلة')),
      body: products.isEmpty
          ? const WEmpty(icon: Icons.favorite_border, message: 'لم تحفظ أي منتج بعد')
          : GridView.count(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.68,
              children: [for (final product in products) ProductCard(product: product)],
            ),
    );
  }
}
