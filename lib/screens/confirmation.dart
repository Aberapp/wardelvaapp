import 'package:flutter/material.dart';
import '../core/formatters.dart';
import '../core/theme.dart';
import '../core/tokens.dart';
import '../data/models.dart';
import '../widgets/logo.dart';
import 'tracking.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WColors.green,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: WardelvaLogo(size: 74, tone: LogoTone.cream, markOnly: true)),
              WGaps.md,
              const Text('تم تأكيد طلبك',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: WColors.cream, fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              const Text('شكراً لاختيارك ورديلڤا. نجهز هديتك الآن.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: WColors.cream, fontSize: 13)),
              WGaps.lg,
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: WColors.cream.withOpacity(0.25)),
                ),
                child: Column(
                  children: [
                    const Text('رقم الطلب', style: TextStyle(color: WColors.cream, fontSize: 12)),
                    Text(order.code,
                        textDirection: TextDirection.ltr,
                        style: displayLatin(size: 28, color: WColors.cream)),
                    Divider(color: WColors.cream.withOpacity(0.2), height: 24),
                    const Text('موعد التوصيل', style: TextStyle(color: WColors.cream, fontSize: 12)),
                    Text(order.delivery.slot,
                        style: const TextStyle(color: WColors.cream, fontSize: 14)),
                  ],
                ),
              ),
              WGaps.md,
              Text('ستكسب ${toArabicDigits(order.earnedPoints)} نقطة عند التسليم',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: WColors.cream, fontSize: 12)),
              WGaps.lg,
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: WColors.cream, foregroundColor: WColors.green),
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => TrackingScreen(order: order)),
                ),
                child: const Text('تتبع الطلب'),
              ),
              WGaps.sm,
              TextButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('العودة للرئيسية', style: TextStyle(color: WColors.cream)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
