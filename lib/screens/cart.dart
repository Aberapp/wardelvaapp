import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/formatters.dart';
import '../core/tokens.dart';
import '../state/app_state.dart';
import '../widgets/common.dart';
import 'checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(title: const Text('سلة التسوق')),
      body: state.cart.isEmpty
          ? const WEmpty(icon: Icons.shopping_bag_outlined, message: 'سلتك فارغة')
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                for (var i = 0; i < state.cart.length; i++) ...[
                  WCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 56,
                          height: 56,
                          child: ProductImage(product: state.cart[i].product, radius: 13, iconSize: 24),
                        ),
                        WGaps.wsm,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.cart[i].product.name,
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                              if (state.cart[i].optionsLabel.isNotEmpty)
                                Text(state.cart[i].optionsLabel,
                                    style: const TextStyle(fontSize: 11, color: WColors.gray)),
                              const SizedBox(height: 4),
                              Text(money(state.cart[i].total),
                                  style: const TextStyle(
                                      fontSize: 12.5, color: WColors.green, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                _RoundButton(icon: Icons.remove, onTap: () => context.read<AppState>().changeQty(i, -1)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(toArabicDigits(state.cart[i].qty)),
                                ),
                                _RoundButton(icon: Icons.add, onTap: () => context.read<AppState>().changeQty(i, 1)),
                              ],
                            ),
                            TextButton(
                              onPressed: () => context.read<AppState>().removeFromCart(i),
                              child: const Text('حذف', style: TextStyle(fontSize: 11.5, color: Color(0xFF93392F))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  WGaps.sm,
                ],
                WCard(
                  child: Column(
                    children: [
                      _SummaryRow('المنتجات والإضافات', money(state.subtotal)),
                      _SummaryRow('التوصيل', state.deliveryFee == 0 ? 'مجاني' : money(state.deliveryFee)),
                      if (state.discount > 0)
                        _SummaryRow('خصم النقاط', '−${money(state.discount)}', highlight: true),
                      const Divider(height: 18, color: WColors.line),
                      _SummaryRow('الإجمالي', money(state.total), bold: true),
                    ],
                  ),
                ),
                WGaps.sm,
                if (state.subtotal < WRules.freeDeliveryOver)
                  Text('أضف ${money(WRules.freeDeliveryOver - state.subtotal)} ويصير التوصيل مجانياً.',
                      style: Theme.of(context).textTheme.bodySmall),
                if (!state.meetsMinimum)
                  Text('أقل قيمة للطلب ${money(WRules.minOrder)}.',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF93392F))),
              ],
            ),
      bottomNavigationBar: state.cart.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: const BoxDecoration(
                color: WColors.paper,
                border: Border(top: BorderSide(color: WColors.line)),
              ),
              child: SafeArea(
                top: false,
                child: FilledButton(
                  onPressed: state.meetsMinimum
                      ? () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                          )
                      : null,
                  child: const Text('متابعة للدفع'),
                ),
              ),
            ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: WColors.line),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Icon(icon, size: 14, color: WColors.green),
        ),
      );
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow(this.label, this.value, {this.bold = false, this.highlight = false});

  final String label;
  final String value;
  final bool bold;
  final bool highlight;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Expanded(
              child: Text(label,
                  style: TextStyle(
                      fontSize: bold ? 14 : 12.5,
                      color: bold ? WColors.ink : WColors.gray,
                      fontWeight: bold ? FontWeight.w700 : FontWeight.w400)),
            ),
            Text(value,
                style: TextStyle(
                    fontSize: bold ? 14 : 12.5,
                    fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                    color: highlight ? WColors.green : WColors.ink)),
          ],
        ),
      );
}
