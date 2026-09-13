import 'package:flutter/material.dart';
import '../core/tokens.dart';
import 'login.dart';
import 'shell.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _Slide {
  const _Slide(this.icon, this.title, this.body);
  final IconData icon;
  final String title;
  final String body;
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  static const _slides = [
    _Slide(Icons.local_florist_outlined, 'هديتك تبدأ من ورديلڤا',
        'ورد وهدايا وبالونات نجهزها بعناية ونوصلها لمن تحب.'),
    _Slide(Icons.tune, 'خصّص كل تفصيل',
        'الحجم واللون والبطاقة والإضافات — كما تتخيلها تماماً.'),
    _Slide(Icons.local_shipping_outlined, 'نوصلها في وقتها',
        'توصيل داخل الرياض وتتبع مباشر من التجهيز حتى التسليم.'),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_index < _slides.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 280), curve: Curves.easeOut);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) {
                  final slide = _slides[i];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6EEEA),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Icon(slide.icon, size: 90, color: WColors.green300),
                          ),
                        ),
                        WGaps.lg,
                        Text(slide.title,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1.5)),
                        WGaps.sm,
                        Text(slide.body, style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: List.generate(
                      _slides.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(left: 6),
                        width: i == _index ? 22 : 8,
                        height: 4,
                        decoration: BoxDecoration(
                          color: i == _index ? WColors.green : WColors.green100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  WGaps.md,
                  FilledButton(
                    onPressed: _next,
                    child: Text(_index == _slides.length - 1 ? 'ابدأ الآن' : 'التالي'),
                  ),
                  WGaps.xs,
                  TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (_) => const AppShell())),
                    child: const Text('تصفح كزائر'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
