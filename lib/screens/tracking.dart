import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/tokens.dart';
import '../data/models.dart';
import '../state/app_state.dart';
import '../widgets/common.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key, required this.order});

  final Order order;

  static const _labels = {
    OrderStatus.newOrder: 'استلمنا الطلب',
    OrderStatus.confirmed: 'تم تأكيد الدفع',
    OrderStatus.preparing: 'المنسق يجهز هديتك',
    OrderStatus.qualityCheck: 'فحص الجودة والتصوير',
    OrderStatus.ready: 'جاهز للتوصيل',
    OrderStatus.onTheWay: 'مع السائق',
    OrderStatus.delivered: 'تم التسليم',
  };

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();
    final currentIndex = orderFlow.indexOf(order.status);

    return Scaffold(
      appBar: AppBar(title: Text('طلب ${order.code}')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          WCard(
            color: WColors.cream,
            child: Row(
              children: [
                SizedBox(
                  width: 54,
                  height: 54,
                  child: ProductImage(product: order.items.first.product, radius: 13, iconSize: 24),
                ),
                WGaps.wsm,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.summary, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      Text('للمستلم ${order.delivery.recipient} · ${order.delivery.district}',
                          style: const TextStyle(fontSize: 11.5, color: WColors.gray)),
                    ],
                  ),
                ),
                WTag.forStatus(order.status),
              ],
            ),
          ),
          WGaps.md,
          for (var i = 0; i < orderFlow.length; i++)
            _Step(
              title: _labels[orderFlow[i]]!,
              done: i < currentIndex,
              current: i == currentIndex,
              last: i == orderFlow.length - 1,
            ),
          if (order.status != OrderStatus.delivered)
            OutlinedButton(
              onPressed: () => context.read<AppState>().advance(order),
              child: const Text('محاكاة الخطوة التالية (للاختبار)'),
            ),
          if (order.status == OrderStatus.delivered && order.rating == null) ...[
            WGaps.md,
            const WSectionTitle('كيف كانت تجربتك؟'),
            Row(
              children: [
                for (var stars = 1; stars <= 5; stars++)
                  IconButton(
                    onPressed: () {
                      context.read<AppState>().rateOrder(order, stars);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('شكراً لك — أضفنا ٢٠ نقطة لرصيدك')),
                      );
                    },
                    icon: const Icon(Icons.star_border, color: WColors.gold),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.title, required this.done, required this.current, required this.last});

  final String title;
  final bool done;
  final bool current;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final active = done || current;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  color: done ? WColors.green : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: active ? WColors.green : WColors.green100, width: 2),
                ),
              ),
              if (!last) Expanded(child: Container(width: 2, color: WColors.green100)),
            ],
          ),
          WGaps.wsm,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: active ? WColors.ink : WColors.gray,
                  fontWeight: current ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
