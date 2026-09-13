import 'package:flutter/material.dart';

/// ألوان الهوية — مأخوذة من دليل ورديلڤا البصري.
class WColors {
  static const green = Color(0xFF1F3D29);
  static const green600 = Color(0xFF2E5239);
  static const green300 = Color(0xFF8FA48D);
  static const green100 = Color(0xFFDFE5D6);
  static const cream = Color(0xFFF1F3E0);
  static const paper = Color(0xFFFBFBF4);
  static const ink = Color(0xFF1A1A1A);
  static const gray = Color(0xFF6B6B6B);
  static const line = Color(0xFFE3E6D3);
  static const rose = Color(0xFFD69A98);
  static const blush = Color(0xFFEBCEC6);
  static const gold = Color(0xFFB7924F);
}

class WRadii {
  static const card = 18.0;
  static const button = 14.0;
  static const field = 12.0;
  static const pill = 999.0;
}

class WGaps {
  static const xs = SizedBox(height: 6);
  static const sm = SizedBox(height: 10);
  static const md = SizedBox(height: 16);
  static const lg = SizedBox(height: 24);
  static const wsm = SizedBox(width: 10);
}

/// قواعد العمل — عدّلها من مكان واحد.
class WRules {
  static const int minOrder = 150;
  static const int deliveryFee = 40;
  static const int freeDeliveryOver = 259;
  static const int pointsPerRiyal = 1;
  static const int redeemStep = 200; // ٢٠٠ نقطة = ١٠ ريال
  static const int redeemValue = 10;
}
