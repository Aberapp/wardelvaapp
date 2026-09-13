import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/tokens.dart';
import '../data/catalog.dart';
import '../state/app_state.dart';
import '../widgets/common.dart';
import '../widgets/logo.dart';
import '../widgets/product_card.dart';
import 'cart.dart';
import 'listing.dart';
import 'shell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          children: [
            const WardelvaLogo(size: 30, markOnly: true),
            const SizedBox(width: 8),
            const Text('ورديلڤا', style: TextStyle(fontSize: 15)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ),
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
              if (state.cartCount > 0)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: const BoxDecoration(color: WColors.rose, shape: BoxShape.circle),
                    child: Text('${state.cartCount}',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          Text('ماذا تحب أن تهدي اليوم؟', style: Theme.of(context).textTheme.titleLarge),
          WGaps.sm,
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ListingScreen(categoryId: null, title: 'كل المنتجات')),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(WRadii.field),
                border: Border.all(color: WColors.line),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, size: 18, color: WColors.green300),
                  SizedBox(width: 8),
                  Text('ابحث عن ورد، هدية أو مناسبة', style: TextStyle(color: WColors.gray, fontSize: 13)),
                ],
              ),
            ),
          ),
          WGaps.md,
          _HeroBanner(onTap: () => AppShell.goToTab(context, 1)),
          WSectionTitle('الأقسام', actionLabel: 'عرض الكل', onAction: () => AppShell.goToTab(context, 1)),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 9,
            crossAxisSpacing: 9,
            childAspectRatio: 1.05,
            children: [
              for (final category in Catalog.categories)
                WCard(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ListingScreen(categoryId: category.id, title: category.name),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(category.icon, size: 26, color: WColors.green),
                      const SizedBox(height: 6),
                      Text(category.name.split(' ').first,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
            ],
          ),
          const WSectionTitle('الأكثر طلباً'),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.68,
            children: [for (final product in Catalog.bestSellers()) ProductCard(product: product)],
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [WColors.green, WColors.green600],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('اجعل مناسبتك أجمل',
              style: TextStyle(color: WColors.cream, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('تنسيقات كاملة للحفلات والمناسبات',
              style: TextStyle(color: WColors.cream, fontSize: 12)),
          WGaps.sm,
          FilledButton(
            onPressed: onTap,
            style: FilledButton.styleFrom(
              backgroundColor: WColors.cream,
              foregroundColor: WColors.green,
              minimumSize: const Size(120, 38),
            ),
            child: const Text('اكتشف الآن'),
          ),
        ],
      ),
    );
  }
}
