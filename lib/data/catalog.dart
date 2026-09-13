import 'package:flutter/material.dart';
import 'models.dart';

/// بيانات أولية للتطوير. تُستبدل لاحقاً بمصدر خارجي (Supabase مثلاً)
/// دون تغيير الشاشات، لأن الشاشات تقرأ من AppState فقط.
class Catalog {
  static const categories = <Category>[
    Category(id: 'flowers', name: 'الورد والتنسيقات', icon: Icons.local_florist_outlined),
    Category(id: 'gifts', name: 'الهدايا', icon: Icons.card_giftcard_outlined),
    Category(id: 'cards', name: 'البطاقات', icon: Icons.mail_outline),
    Category(id: 'balloons', name: 'البالونات', icon: Icons.celebration_outlined),
    Category(id: 'newborn', name: 'استقبال المواليد', icon: Icons.child_friendly_outlined),
    Category(id: 'events', name: 'تنسيق الحفلات', icon: Icons.auto_awesome_outlined),
  ];

  static const sizes = <SizeOption>[
    SizeOption('صغير', 0),
    SizeOption('متوسط', 70),
    SizeOption('كبير', 120),
  ];

  static const colors = <ColorOption>[
    ColorOption('أبيض', Color(0xFFF3EFE9)),
    ColorOption('وردي', Color(0xFFE8B7B4)),
    ColorOption('أحمر', Color(0xFFC0504E)),
    ColorOption('بيج', Color(0xFFDCCBA8)),
    ColorOption('أخضر', Color(0xFF9CB295)),
  ];

  static const addOns = <AddOn>[
    AddOn('card', 'بطاقة مكتوبة بخط اليد', 10),
    AddOn('choco', 'شوكولاتة', 40),
    AddOn('balloon', 'بالونات', 30),
    AddOn('wrap', 'تغليف خاص', 25),
  ];

  static const products = <Product>[
    Product(
      id: 'p1',
      name: 'باقة روز كلاسيكية',
      categoryId: 'flowers',
      basePrice: 120,
      sold: 64,
      stock: 90,
      hasOptions: true,
      tone: Color(0xFFF6EEEA),
      description: 'خمس وعشرون وردة روز طازجة مع لمسة أوكالبتوس، بتغليف كريمي وشريط ساتان.',
    ),
    Product(
      id: 'p2',
      name: 'باقة روز أحمر',
      categoryId: 'flowers',
      basePrice: 150,
      sold: 52,
      stock: 60,
      hasOptions: true,
      tone: Color(0xFFF3E7E4),
      description: 'ورد أحمر مخملي لمناسبات الحب والذكرى السنوية.',
    ),
    Product(
      id: 'p3',
      name: 'تنسيق تيوليب',
      categoryId: 'flowers',
      basePrice: 190,
      rating: 4,
      sold: 22,
      stock: 24,
      hasOptions: true,
      tone: Color(0xFFF4F1E8),
      description: 'تيوليب هولندي مستورد بتنسيق بسيط وأنيق.',
    ),
    Product(
      id: 'p4',
      name: 'بوكس هدية فاخر',
      categoryId: 'gifts',
      basePrice: 280,
      rating: 4,
      sold: 41,
      stock: 24,
      tone: Color(0xFFEFEFE2),
      icon: Icons.card_giftcard_outlined,
      description: 'صندوق يجمع ورداً وشوكولاتة وشمعة معطرة.',
    ),
    Product(
      id: 'p5',
      name: 'صندوق شوكولاتة',
      categoryId: 'gifts',
      basePrice: 95,
      sold: 28,
      stock: 0,
      tone: Color(0xFFF0EDE3),
      icon: Icons.cake_outlined,
      description: 'ست عشرة قطعة شوكولاتة بلجيكية.',
    ),
    Product(
      id: 'p6',
      name: 'نبتة داخلية',
      categoryId: 'gifts',
      basePrice: 110,
      rating: 4,
      sold: 19,
      stock: 30,
      tone: Color(0xFFEEF1E5),
      icon: Icons.eco_outlined,
      description: 'نبتة منزلية مع أصيص فخاري.',
    ),
    Product(
      id: 'p7',
      name: 'بطاقة «كل عام وأنت بخير»',
      categoryId: 'cards',
      basePrice: 10,
      sold: 88,
      stock: 200,
      tone: Color(0xFFF6F4E8),
      icon: Icons.mail_outline,
      description: 'بطاقة مطبوعة بخط عربي، تُكتب رسالتها يدوياً.',
    ),
    Product(
      id: 'p8',
      name: 'تنسيق بالونات مميز',
      categoryId: 'balloons',
      basePrice: 80,
      rating: 4,
      sold: 33,
      stock: 12,
      tone: Color(0xFFF3F1E6),
      icon: Icons.celebration_outlined,
      description: 'خمس وعشرون بالونة بألوان مختارة مع التركيب.',
    ),
    Product(
      id: 'p9',
      name: 'باقة استقبال مولود',
      categoryId: 'newborn',
      basePrice: 250,
      sold: 26,
      stock: 15,
      tone: Color(0xFFF1F1E6),
      icon: Icons.child_friendly_outlined,
      description: 'بالونات وورد وهدية صغيرة للأم.',
    ),
    Product(
      id: 'p10',
      name: 'تنسيق حفل صغير',
      categoryId: 'events',
      basePrice: 1500,
      sold: 9,
      stock: 99,
      tone: Color(0xFFEFF0E3),
      icon: Icons.auto_awesome_outlined,
      description: 'خلفية وطاولة وورد وبالونات لحفل حتى ثلاثين ضيفاً.',
    ),
  ];

  static Product byId(String id) => products.firstWhere((p) => p.id == id);
  static List<Product> byCategory(String categoryId) =>
      products.where((p) => p.categoryId == categoryId).toList();
  static List<Product> bestSellers([int take = 4]) {
    final list = [...products]..sort((a, b) => b.sold.compareTo(a.sold));
    return list.take(take).toList();
  }
}
