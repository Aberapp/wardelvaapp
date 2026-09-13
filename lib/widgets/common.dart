import 'package:flutter/material.dart';
import '../core/tokens.dart';
import '../data/models.dart';

class WCard extends StatelessWidget {
  const WCard({super.key, required this.child, this.color, this.padding, this.onTap, this.borderColor});

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(WRadii.card),
        border: Border.all(color: borderColor ?? (color == null ? WColors.line : Colors.transparent)),
      ),
      child: child,
    );
    if (onTap == null) return content;
    return InkWell(
      borderRadius: BorderRadius.circular(WRadii.card),
      onTap: onTap,
      child: content,
    );
  }
}

class WSectionTitle extends StatelessWidget {
  const WSectionTitle(this.title, {super.key, this.actionLabel, this.onAction});

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Row(
        children: [
          Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14))),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Text(actionLabel!, style: const TextStyle(color: WColors.green, fontSize: 12)),
            ),
        ],
      ),
    );
  }
}

class WTag extends StatelessWidget {
  const WTag(this.text, {super.key, this.background = WColors.green100, this.foreground = WColors.green});

  final String text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
        decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(WRadii.pill)),
        child: Text(text, style: TextStyle(color: foreground, fontSize: 11, fontWeight: FontWeight.w500)),
      );

  static WTag forStatus(OrderStatus status) => switch (status) {
        OrderStatus.delivered => const WTag('تم التسليم', background: Color(0xFFDCEBDD), foreground: Color(0xFF2C6137)),
        OrderStatus.cancelled => const WTag('ملغي', background: Color(0xFFF6DCD8), foreground: Color(0xFF93392F)),
        OrderStatus.preparing => const WTag('قيد التجهيز', background: Color(0xFFF7E7D2), foreground: Color(0xFF8A5A18)),
        OrderStatus.onTheWay => const WTag('مع السائق', background: Color(0xFFF7E7D2), foreground: Color(0xFF8A5A18)),
        _ => WTag(status.label),
      };
}

class WChoiceChip extends StatelessWidget {
  const WChoiceChip({super.key, required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? WColors.green : Colors.white,
            borderRadius: BorderRadius.circular(WRadii.pill),
            border: Border.all(color: selected ? WColors.green : WColors.line),
          ),
          child: Text(label,
              style: TextStyle(fontSize: 12.5, color: selected ? WColors.cream : WColors.ink)),
        ),
      );
}

/// صف اختيار — دائري للاختيار المفرد ومربّع للمتعدد.
class WOptionTile extends StatelessWidget {
  const WOptionTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.trailing,
    this.multi = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? trailing;
  final bool multi;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: selected ? WColors.green : WColors.line),
            ),
            child: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: selected ? WColors.green : Colors.transparent,
                    borderRadius: BorderRadius.circular(multi ? 6 : 999),
                    border: Border.all(color: selected ? WColors.green : WColors.green100, width: 1.5),
                  ),
                  child: selected
                      ? const Icon(Icons.check, size: 12, color: WColors.cream)
                      : const SizedBox.shrink(),
                ),
                WGaps.wsm,
                Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
                if (trailing != null)
                  Text(trailing!, style: const TextStyle(fontSize: 12, color: WColors.gray)),
              ],
            ),
          ),
        ),
      );
}

class WEmpty extends StatelessWidget {
  const WEmpty({super.key, required this.icon, required this.message, this.action});

  final IconData icon;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 20),
        child: Column(
          children: [
            Icon(icon, size: 40, color: WColors.green300),
            WGaps.sm,
            Text(message, style: const TextStyle(color: WColors.gray, fontSize: 13)),
            if (action != null) ...[WGaps.md, action!],
          ],
        ),
      );
}

/// خلفية المنتج — تُستبدل لاحقاً بصورة حقيقية من الخادم.
class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.product, this.radius = 0, this.iconSize = 46});

  final Product product;
  final double radius;
  final double iconSize;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          color: product.tone,
          child: Center(child: Icon(product.icon, size: iconSize, color: WColors.green300)),
        ),
      );
}

class WStars extends StatelessWidget {
  const WStars(this.rating, {super.key, this.size = 12});

  final int rating;
  final double size;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          5,
          (i) => Icon(i < rating ? Icons.star : Icons.star_border, size: size, color: WColors.gold),
        ),
      );
}
