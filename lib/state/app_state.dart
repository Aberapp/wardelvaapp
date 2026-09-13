import 'package:flutter/foundation.dart';
import '../core/tokens.dart';
import '../data/models.dart';

/// حالة التطبيق كاملة في مكان واحد.
/// عند الربط بـ Supabase استبدل التخزين المحلي هنا فقط، والشاشات تبقى كما هي.
class AppState extends ChangeNotifier {
  String customerName = 'سارة أحمد';
  String phone = '0555 123 456';
  int points = 240;

  final List<CartItem> cart = [];
  final Set<String> favorites = <String>{'p1'};
  final List<Order> orders = <Order>[];
  final List<String> pointsLedger = <String>[];

  int _nextCode = 10245;

  // ------- السلة -------
  int get subtotal => cart.fold<int>(0, (sum, item) => sum + item.total);
  int get deliveryFee => cart.isEmpty || subtotal >= WRules.freeDeliveryOver ? 0 : WRules.deliveryFee;
  int discount = 0;
  int get total {
    final value = subtotal + deliveryFee - discount;
    return value < 0 ? 0 : value;
  }
  int get cartCount => cart.fold<int>(0, (sum, item) => sum + item.qty);
  bool get meetsMinimum => subtotal >= WRules.minOrder;

  void addToCart(CartItem item) {
    cart.add(item);
    notifyListeners();
  }

  void changeQty(int index, int delta) {
    final item = cart[index];
    final next = item.qty + delta;
    item.qty = next < 1 ? 1 : (next > 99 ? 99 : next);
    notifyListeners();
  }

  void removeFromCart(int index) {
    cart.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    discount = 0;
    notifyListeners();
  }

  // ------- المفضلة -------
  bool isFavorite(String id) => favorites.contains(id);
  void toggleFavorite(String id) {
    favorites.contains(id) ? favorites.remove(id) : favorites.add(id);
    notifyListeners();
  }

  // ------- النقاط -------
  bool get canRedeem => points >= WRules.redeemStep;
  void redeemPoints() {
    if (!canRedeem || discount > 0) return;
    points -= WRules.redeemStep;
    discount += WRules.redeemValue;
    pointsLedger.insert(0, 'استبدال مكافأة · −${WRules.redeemStep}');
    notifyListeners();
  }

  // ------- الطلبات -------
  Order placeOrder({required DeliveryDetails delivery, required String paymentMethod}) {
    final order = Order(
      code: 'WD-${_nextCode++}',
      items: List<CartItem>.from(cart),
      delivery: delivery,
      total: total,
      paymentMethod: paymentMethod,
      status: OrderStatus.confirmed,
    );
    orders.insert(0, order);
    clearCart();
    return order;
  }

  List<Order> get openOrders => orders.where((o) => o.status.isOpen).toList();
  List<Order> get pastOrders => orders.where((o) => !o.status.isOpen).toList();

  /// تقديم حالة الطلب — يستخدمها تطبيق الفريق لاحقاً، وهنا للتجربة.
  void advance(Order order) {
    final index = orderFlow.indexOf(order.status);
    if (index < 0 || index >= orderFlow.length - 1) return;
    order.status = orderFlow[index + 1];
    if (order.status == OrderStatus.delivered) {
      points += order.earnedPoints;
      pointsLedger.insert(0, 'طلب ${order.code} · +${order.earnedPoints}');
    }
    notifyListeners();
  }

  void rateOrder(Order order, int stars) {
    order.rating = stars;
    points += 20;
    pointsLedger.insert(0, 'تقييم ${order.code} · +20');
    notifyListeners();
  }
}
