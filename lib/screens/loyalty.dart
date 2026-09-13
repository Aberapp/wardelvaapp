import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/formatters.dart';
import '../core/tokens.dart';
import '../state/app_state.dart';
import '../widgets/common.dart';
import '../widgets/logo.dart';

class LoyaltyScreen extends StatelessWidget {
  const LoyaltyScreen({super.key});

  static const _goldTier = 500;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final progress = (state.points / _goldTier).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: const Text('نقاط ورديلڤا')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
            decoration: BoxDecoration(color: WColors.green, borderRadius: BorderRadius.circular(22)),
            child: Stack(
              children: [
                Positioned(
                  bottom: -30,
                  left: -20,
                  child: Opacity(
                    opacity: 0.1,
                    child: WardelvaLogo(size: 120, tone: LogoTone.cream, markOnly: true),
                  ),
                ),
                Column(
                  children: [
                    const Text('رصيدك الحالي', style: TextStyle(color: WColors.cream, fontSize: 12)),
                    Text(toArabicDigits(state.points),
                        style: const TextStyle(color: WColors.cream, fontSize: 44, fontWeight: FontWeight.w300)),
                    Text('تعادل ${money((state.points ~/ WRules.redeemStep) * WRules.redeemValue)} خصم',
                        style: const TextStyle(color: WColors.cream, fontSize: 12)),
                    WGaps.sm,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: WColors.cream.withOpacity(0.25),
                        valueColor: const AlwaysStoppedAnimation<Color>(WColors.gold),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      state.points >= _goldTier
                          ? 'وصلت للمستوى الذهبي'
                          : '${toArabicDigits(_goldTier - state.points)} نقطة تفصلك عن المستوى الذهبي',
                      style: const TextStyle(color: WColors.cream, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const WSectionTitle('كيف تجمع النقاط'),
          const WCard(
            child: Column(
              children: [
                _Rule(icon: Icons.shopping_bag_outlined, text: 'كل ريال تنفقه يساوي نقطة'),
                Divider(color: WColors.line, height: 20),
                _Rule(icon: Icons.star_border, text: 'تقييم الطلب يعطيك ٢٠ نقطة'),
                Divider(color: WColors.line, height: 20),
                _Rule(icon: Icons.group_outlined, text: 'دعوة صديق تعطيك ١٠٠ نقطة'),
              ],
            ),
          ),
          const WSectionTitle('سجل النقاط'),
          if (state.pointsLedger.isEmpty)
            const WEmpty(icon: Icons.receipt_long_outlined, message: 'لا توجد حركات بعد')
          else
            WCard(
              child: Column(
                children: [
                  for (final entry in state.pointsLedger)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(toArabicDigits(entry), style: const TextStyle(fontSize: 12.5)),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(icon, size: 18, color: WColors.green),
          WGaps.wsm,
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12.5))),
        ],
      );
}
