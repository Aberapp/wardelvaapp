import 'package:flutter/material.dart';

/// الشعار الرسمي كما هو، بنسختين: على خلفية فاتحة أو داكنة.
enum LogoTone { green, cream }

class WardelvaLogo extends StatelessWidget {
  const WardelvaLogo({super.key, this.size = 120, this.tone = LogoTone.green, this.markOnly = false});

  final double size;
  final LogoTone tone;
  final bool markOnly;

  @override
  Widget build(BuildContext context) {
    final file = '${markOnly ? 'mark' : 'lock'}_${tone == LogoTone.green ? 'green' : 'cream'}.png';
    return Image.asset(
      'assets/logo/$file',
      width: size,
      height: size * (markOnly ? 0.92 : 0.98),
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}
