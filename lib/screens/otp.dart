import 'package:flutter/material.dart';
import '../core/formatters.dart';
import '../core/tokens.dart';
import 'shell.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phone});

  final String phone;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _code = '';

  void _tap(String digit) {
    if (_code.length >= 4) return;
    setState(() => _code += digit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('رمز التحقق')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('أدخل الرمز المرسل', style: Theme.of(context).textTheme.titleLarge),
              WGaps.xs,
              Text('أرسلنا رمزاً من أربعة أرقام إلى الرقم ${widget.phone.isEmpty ? '5X XXX XXXX' : widget.phone}',
                  style: Theme.of(context).textTheme.bodySmall),
              WGaps.md,
              Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  final filled = i < _code.length;
                  return Container(
                    width: 54,
                    height: 62,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: filled ? WColors.green : WColors.line),
                    ),
                    child: Text(filled ? toArabicDigits(_code[i]) : '−',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: WColors.green)),
                  );
                }),
              ),
              WGaps.md,
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 2.1,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: [
                    for (final n in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'])
                      OutlinedButton(onPressed: () => _tap(n), child: Text(toArabicDigits(n))),
                    OutlinedButton(
                      onPressed: () => setState(() => _code = _code.isEmpty ? '' : _code.substring(0, _code.length - 1)),
                      child: const Icon(Icons.backspace_outlined, size: 18),
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: _code.length == 4
                    ? () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const AppShell()),
                          (route) => false,
                        )
                    : null,
                child: const Text('تأكيد'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
