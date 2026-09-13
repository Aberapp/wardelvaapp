import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/formatters.dart';
import '../core/tokens.dart';
import '../data/models.dart';
import '../state/app_state.dart';
import '../widgets/common.dart';
import 'tracking.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('طلباتي'),
          bottom: const TabBar(
            labelColor: WColors.green,
            unselectedLabelColor: WColors.gray,
            indicatorColor: WColors.green,
            tabs: [Tab(text: 'الحالية'), Tab(text: 'السابقة')],
          ),
        ),
        body: TabBarView(
          children: [
            _OrderList(orders: state.openOrders, emptyMessage: 'لا توجد طلبات جارية'),
            _OrderList(orders: state.pastOrders, emptyMessage: 'لا توجد طلبات سابقة'),
          ],
        ),
      ),
    );
  }
}

class _OrderList extends StatelessWidget {
  const _OrderList({required this.orders, required this.emptyMessage});

  final List<Order> orders;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return WEmpty(icon: Icons.inventory_2_outlined, message: emptyMessage);
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: orders.length,
      separatorBuilder: (_, __) => WGaps.sm,
      itemBuilder: (context, index) {
        final order = orders[index];
        return WCard(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => TrackingScreen(order: order)),
          ),
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
                    Text(order.summary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    Text(order.code,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(fontSize: 11, color: WColors.gray)),
                    const SizedBox(height: 5),
                    WTag.forStatus(order.status),
                  ],
                ),
              ),
              Text(money(order.total), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            ],
          ),
        );
      },
    );
  }
}
