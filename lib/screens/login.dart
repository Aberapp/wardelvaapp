import 'package:flutter/material.dart';
import '../core/tokens.dart';
import '../widgets/logo.dart';
import 'otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phone = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 34, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: WardelvaLogo(size: 130)),
              WGaps.lg,
              Text('مرحباً بك في ورديلڤا', style: Theme.of(context).textTheme.titleLarge),
              WGaps.xs,
              Text('أدخل رقم جوالك ونرسل لك رمز تحقق.',
                  style: Theme.of(context).textTheme.bodySmall),
              WGaps.md,
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(WRadii.field),
                      border: Border.all(color: WColors.line),
                    ),
                    child: const Text('+966', textDirection: TextDirection.ltr),
                  ),
                  WGaps.wsm,
                  Expanded(
                    child: TextField(
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(hintText: '5X XXX XXXX'),
                    ),
                  ),
                ],
              ),
              WGaps.md,
              FilledButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => OtpScreen(phone: _phone.text)),
                ),
                child: const Text('إرسال رمز التحقق'),
              ),
              WGaps.md,
              Row(children: const [
                Expanded(child: Divider(color: WColors.line)),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('أو', style: TextStyle(color: WColors.gray, fontSize: 12))),
                Expanded(child: Divider(color: WColors.line)),
              ]),
              WGaps.sm,
              OutlinedButton(onPressed: () {}, child: const Text('المتابعة عبر Apple')),
              WGaps.sm,
              OutlinedButton(onPressed: () {}, child: const Text('المتابعة عبر Google')),
              WGaps.md,
              const Center(
                child: Text('بالمتابعة أنت توافق على الشروط وسياسة الخصوصية.',
                    style: TextStyle(fontSize: 11, color: WColors.gray)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
