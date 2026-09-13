import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/formatters.dart';
import '../core/tokens.dart';
import '../data/models.dart';
import '../screens/product_details.dart';
import '../state/app_state.dart';
import 'common.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final favorite = state.isFavorite(product.id);

    return InkWell(
      borderRadius: BorderRadius.circular(WRadii.card),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(WRadii.card),
          border: Border.all(color: WColors.line),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                AspectRatio(aspectRatio: 1, child: ProductImage(product: product)),
                Positioned(
                  top: 8,
                  left: 8,
                  child: GestureDetector(
                    onTap: () => context.read<AppState>().toggleFavorite(product.id),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white.withOpacity(0.92),
                      child: Icon(
                        favorite ? Icons.favorite : Icons.favorite_border,
                        size: 15,
                        color: favorite ? WColors.rose : WColors.green300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 9, 10, 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 3),
                  WStars(product.rating, size: 11),
                  const SizedBox(height: 3),
                  Text(
                    '${product.hasOptions ? 'من ' : ''}${money(product.basePrice)}',
                    style: const TextStyle(fontSize: 12, color: WColors.green, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
