import 'package:flutter/material.dart';
import '../core/formatters.dart';
import '../core/tokens.dart';
import '../data/catalog.dart';
import '../data/models.dart';
import '../widgets/common.dart';
import '../widgets/product_card.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key, required this.categoryId, required this.title});

  final String? categoryId;
  final String title;

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

enum _Sort { popular, cheap, expensive }

class _ListingScreenState extends State<ListingScreen> {
  _Sort _sort = _Sort.popular;

  List<Product> get _products {
    final list = widget.categoryId == null
        ? [...Catalog.products]
        : Catalog.byCategory(widget.categoryId!);
    switch (_sort) {
      case _Sort.popular:
        list.sort((a, b) => b.sold.compareTo(a.sold));
        break;
      case _Sort.cheap:
        list.sort((a, b) => a.basePrice.compareTo(b.basePrice));
        break;
      case _Sort.expensive:
        list.sort((a, b) => b.basePrice.compareTo(a.basePrice));
        break;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final products = _products;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (final entry in const {
                  _Sort.popular: 'الأكثر مبيعاً',
                  _Sort.cheap: 'الأقل سعراً',
                  _Sort.expensive: 'الأعلى سعراً',
                }.entries)
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: WChoiceChip(
                      label: entry.value,
                      selected: _sort == entry.key,
                      onTap: () => setState(() => _sort = entry.key),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text('${toArabicDigits(products.length)} منتجاً · التوصيل خلال ساعتين داخل الرياض',
                  style: const TextStyle(fontSize: 12, color: WColors.gray)),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.68,
              children: [for (final product in products) ProductCard(product: product)],
            ),
          ),
        ],
      ),
    );
  }
}
