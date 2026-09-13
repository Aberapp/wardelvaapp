import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/tokens.dart';
import '../widgets/logo.dart';
import 'onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WColors.green,
      body: Stack(
        children: [
          Positioned(
            bottom: -70,
            left: -60,
            child: Opacity(
              opacity: 0.07,
              child: WardelvaLogo(size: 300, tone: LogoTone.cream),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const WardelvaLogo(size: 190, tone: LogoTone.cream),
                const SizedBox(height: 14),
                Text('Your Partner in Gifting',
                    textDirection: TextDirection.ltr,
                    style: displayLatin(size: 15, color: WColors.cream).copyWith(letterSpacing: 2.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
