import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/formatters.dart';
import '../core/tokens.dart';
import '../data/catalog.dart';
import '../data/models.dart';
import '../state/app_state.dart';
import '../widgets/common.dart';
import 'cart.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _sizeIndex = 1;
  int _colorIndex = 0;
  final Set<String> _addOnIds = {};
  final _message = TextEditingController();
  final _note = TextEditingController();

  @override
  void dispose() {
    _message.dispose();
    _note.dispose();
    super.dispose();
  }

  List<AddOn> get _selectedAddOns =>
      Catalog.addOns.where((a) => _addOnIds.contains(a.id)).toList();

  int get _price {
    final sizeExtra = widget.product.hasOptions ? Catalog.sizes[_sizeIndex].extra : 0;
    return widget.product.basePrice +
        sizeExtra +
        _selectedAddOns.fold<int>(0, (sum, a) => sum + a.price);
  }

  void _addToCart() {
    final product = widget.product;
    context.read<AppState>().addToCart(
          CartItem(
            product: product,
            size: product.hasOptions ? Catalog.sizes[_sizeIndex] : null,
            color: product.hasOptions ? Catalog.colors[_colorIndex] : null,
            addOns: _selectedAddOns,
            cardMessage: _message.text,
            note: _note.text,
          ),
        );
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const CartScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final state = context.watch<AppState>();
    final favorite = state.isFavorite(product.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: WColors.paper,
            flexibleSpace: FlexibleSpaceBar(background: ProductImage(product: product, iconSize: 90)),
            actions: [
              IconButton(
                onPressed: () => context.read<AppState>().toggleFavorite(product.id),
                icon: Icon(favorite ? Icons.favorite : Icons.favorite_border,
                    color: favorite ? WColors.rose : WColors.green),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    Expanded(child: Text(product.name, style: Theme.of(context).textTheme.titleLarge)),
                    Text(money(_price),
                        style: const TextStyle(color: WColors.green, fontWeight: FontWeight.w700, fontSize: 15)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(children: [
                  WStars(product.rating),
                  const SizedBox(width: 6),
                  Text('(${toArabicDigits(product.sold)} طلباً)',
                      style: const TextStyle(fontSize: 11.5, color: WColors.gray)),
                ]),
                WGaps.sm,
                Text(product.description, style: Theme.of(context).textTheme.bodySmall),
                if (!product.inStock) ...[
                  WGaps.sm,
                  WCard(
                    borderColor: WColors.rose,
                    child: const Text('نفد المخزون حالياً — نعلمك عند توفره',
                        style: TextStyle(fontSize: 12.5, color: Color(0xFF93392F))),
                  ),
                ],
                if (product.hasOptions) ...[
                  const WSectionTitle('الحجم'),
                  Wrap(
                    spacing: 7,
                    children: [
                      for (var i = 0; i < Catalog.sizes.length; i++)
                        WChoiceChip(
                          label: Catalog.sizes[i].extra == 0
                              ? Catalog.sizes[i].name
                              : '${Catalog.sizes[i].name} +${toArabicDigits(Catalog.sizes[i].extra)}',
                          selected: _sizeIndex == i,
                          onTap: () => setState(() => _sizeIndex = i),
                        ),
                    ],
                  ),
                  const WSectionTitle('اللون'),
                  Row(
                    children: [
                      for (var i = 0; i < Catalog.colors.length; i++)
                        GestureDetector(
                          onTap: () => setState(() => _colorIndex = i),
                          child: Container(
                            width: 32,
                            height: 32,
                            margin: const EdgeInsets.only(left: 9),
                            decoration: BoxDecoration(
                              color: Catalog.colors[i].value,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _colorIndex == i ? WColors.green : WColors.line,
                                width: _colorIndex == i ? 2 : 1,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
                const WSectionTitle('أضف إلى هديتك'),
                for (final addOn in Catalog.addOns)
                  WOptionTile(
                    label: addOn.name,
                    multi: true,
                    trailing: '+${toArabicDigits(addOn.price)}',
                    selected: _addOnIds.contains(addOn.id),
                    onTap: () => setState(() {
                      _addOnIds.contains(addOn.id) ? _addOnIds.remove(addOn.id) : _addOnIds.add(addOn.id);
                    }),
                  ),
                if (_addOnIds.contains('card')) ...[
                  const WSectionTitle('رسالة البطاقة'),
                  TextField(
                    controller: _message,
                    maxLines: 3,
                    decoration: const InputDecoration(hintText: 'اكتب رسالتك هنا…'),
                  ),
                ],
                const WSectionTitle('ملاحظات للمنسق'),
                TextField(
                  controller: _note,
                  decoration: const InputDecoration(hintText: 'مثلاً: بدون ورد أحمر'),
                ),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomBar(
        child: FilledButton(
          onPressed: product.inStock ? _addToCart : null,
          child: Text('أضف إلى السلة — ${money(_price)}'),
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: const BoxDecoration(
          color: WColors.paper,
          border: Border(top: BorderSide(color: WColors.line)),
        ),
        child: SafeArea(top: false, child: child),
      );
}
