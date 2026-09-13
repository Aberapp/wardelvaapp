import 'package:flutter_test/flutter_test.dart';
import 'package:wardelva/core/tokens.dart';
import 'package:wardelva/data/catalog.dart';
import 'package:wardelva/data/models.dart';
import 'package:wardelva/state/app_state.dart';

void main() {
  test('حساب سعر المنتج مع الحجم والإضافات', () {
    final item = CartItem(
      product: Catalog.byId('p1'),
      size: Catalog.sizes[1],
      addOns: [Catalog.addOns.first],
    );
    expect(item.unitPrice, 120 + 70 + 10);
  });

  test('التوصيل مجاني فوق الحد', () {
    final state = AppState();
    state.addToCart(CartItem(product: Catalog.byId('p4'))); // ٢٨٠ ريال
    expect(state.subtotal, 280);
    expect(state.deliveryFee, 0);
  });

  test('رسوم التوصيل تُضاف تحت الحد', () {
    final state = AppState();
    state.addToCart(CartItem(product: Catalog.byId('p1')));
    expect(state.deliveryFee, WRules.deliveryFee);
    expect(state.total, 120 + WRules.deliveryFee);
  });

  test('إنشاء طلب يفرغ السلة ويولد رقماً', () {
    final state = AppState();
    state.addToCart(CartItem(product: Catalog.byId('p2')));
    final order = state.placeOrder(
      delivery: const DeliveryDetails(recipient: 'سارة', phone: '0555', district: 'الملقا'),
      paymentMethod: 'مدى',
    );
    expect(order.code.startsWith('WD-'), isTrue);
    expect(state.cart, isEmpty);
    expect(state.orders.length, 1);
  });

  test('النقاط تُضاف عند التسليم', () {
    final state = AppState();
    state.addToCart(CartItem(product: Catalog.byId('p1')));
    final order = state.placeOrder(
      delivery: const DeliveryDetails(recipient: 'سارة', phone: '0555', district: 'الملقا'),
      paymentMethod: 'مدى',
    );
    final before = state.points;
    while (order.status != OrderStatus.delivered) {
      state.advance(order);
    }
    expect(state.points, before + order.earnedPoints);
  });
}
