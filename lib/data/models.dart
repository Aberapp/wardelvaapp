import 'package:flutter/material.dart';

class Category {
  const Category({required this.id, required this.name, required this.icon});
  final String id;
  final String name;
  final IconData icon;
}

class SizeOption {
  const SizeOption(this.name, this.extra);
  final String name;
  final int extra;
}

class ColorOption {
  const ColorOption(this.name, this.value);
  final String name;
  final Color value;
}

class AddOn {
  const AddOn(this.id, this.name, this.price);
  final String id;
  final String name;
  final int price;
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.basePrice,
    required this.description,
    this.rating = 5,
    this.sold = 0,
    this.stock = 20,
    this.hasOptions = false,
    this.tone = const Color(0xFFF6EEEA),
    this.icon = Icons.local_florist_outlined,
  });

  final String id;
  final String name;
  final String categoryId;
  final int basePrice;
  final String description;
  final int rating;
  final int sold;
  final int stock;
  final bool hasOptions;
  final Color tone;
  final IconData icon;

  bool get inStock => stock > 0;
}

class CartItem {
  CartItem({
    required this.product,
    this.size,
    this.color,
    this.addOns = const [],
    this.cardMessage = '',
    this.note = '',
    this.qty = 1,
  });

  final Product product;
  final SizeOption? size;
  final ColorOption? color;
  final List<AddOn> addOns;
  final String cardMessage;
  final String note;
  int qty;

  int get unitPrice =>
      product.basePrice + (size?.extra ?? 0) + addOns.fold<int>(0, (sum, a) => sum + a.price);

  int get total => unitPrice * qty;

  String get optionsLabel {
    final parts = <String>[
      if (size != null) size!.name,
      if (color != null) color!.name,
      ...addOns.map((a) => a.name),
    ];
    return parts.join(' · ');
  }
}

enum OrderStatus { newOrder, confirmed, preparing, qualityCheck, ready, onTheWay, delivered, cancelled }

extension OrderStatusX on OrderStatus {
  String get label => switch (this) {
        OrderStatus.newOrder => 'جديد',
        OrderStatus.confirmed => 'مؤكد',
        OrderStatus.preparing => 'قيد التجهيز',
        OrderStatus.qualityCheck => 'فحص الجودة',
        OrderStatus.ready => 'جاهز للتوصيل',
        OrderStatus.onTheWay => 'مع السائق',
        OrderStatus.delivered => 'تم التسليم',
        OrderStatus.cancelled => 'ملغي',
      };

  bool get isOpen => this != OrderStatus.delivered && this != OrderStatus.cancelled;
}

/// تسلسل الحالات الطبيعي للطلب.
const orderFlow = [
  OrderStatus.newOrder,
  OrderStatus.confirmed,
  OrderStatus.preparing,
  OrderStatus.qualityCheck,
  OrderStatus.ready,
  OrderStatus.onTheWay,
  OrderStatus.delivered,
];

class DeliveryDetails {
  const DeliveryDetails({
    required this.recipient,
    required this.phone,
    required this.district,
    this.street = '',
    this.building = '',
    this.driverNote = '',
    this.slot = 'اليوم خلال ساعتين',
    this.surprise = false,
  });

  final String recipient;
  final String phone;
  final String district;
  final String street;
  final String building;
  final String driverNote;
  final String slot;
  final bool surprise;
}

class Order {
  Order({
    required this.code,
    required this.items,
    required this.delivery,
    required this.total,
    required this.paymentMethod,
    this.status = OrderStatus.newOrder,
    this.branch = 'المونسية',
    this.rating,
  });

  final String code;
  final List<CartItem> items;
  final DeliveryDetails delivery;
  final int total;
  final String paymentMethod;
  OrderStatus status;
  String branch;
  int? rating;

  int get earnedPoints => (total * WRulesPoints.perRiyal).round();
  String get summary => items.map((i) => i.product.name).join(' + ');
}

class WRulesPoints {
  static const int perRiyal = 1;
}
