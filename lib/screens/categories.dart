import 'package:flutter/material.dart';
import '../core/formatters.dart';
import '../core/tokens.dart';
import '../data/catalog.dart';
import '../widgets/common.dart';
import 'listing.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الأقسام')),
      body: GridView.count(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.95,
        children: [
          for (final category in Catalog.categories)
            WCard(
              padding: const EdgeInsets.all(16),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ListingScreen(categoryId: category.id, title: category.name)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(category.icon, size: 32, color: WColors.green),
                  const Spacer(),
                  Text(category.name, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 3),
                  Text('${toArabicDigits(Catalog.byCategory(category.id).length)} منتجات',
                      style: const TextStyle(fontSize: 11.5, color: WColors.gray)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
