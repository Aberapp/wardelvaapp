import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/formatters.dart';
import '../core/tokens.dart';
import '../data/models.dart';
import '../state/app_state.dart';
import '../widgets/common.dart';
import 'confirmation.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipient = TextEditingController(text: 'سارة');
  final _phone = TextEditingController(text: '0555 123 456');
  final _district = TextEditingController(text: 'الملقا');
  final _street = TextEditingController(text: 'أنس بن مالك');
  final _building = TextEditingController();
  final _driverNote = TextEditingController();

  bool _surprise = false;
  int _slotIndex = 0;
  String _payment = 'مدى';

  static const _slots = ['اليوم خلال ساعتين', 'اليوم ٧:٠٠ مساءً', 'غداً صباحاً'];
  static const _payments = ['مدى', 'Apple Pay', 'فيزا أو ماستركارد', 'تابي', 'تمارا'];

  @override
  void dispose() {
    for (final controller in [_recipient, _phone, _district, _street, _building, _driverNote]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _placeOrder() {
    if (!_formKey.currentState!.validate()) return;
    final order = context.read<AppState>().placeOrder(
          delivery: DeliveryDetails(
            recipient: _recipient.text,
            phone: _phone.text,
            district: _district.text,
            street: _street.text,
            building: _building.text,
            driverNote: _driverNote.text,
            slot: _slots[_slotIndex],
            surprise: _surprise,
          ),
          paymentMethod: _payment,
        );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => ConfirmationScreen(order: order)),
      (route) => route.isFirst,
    );
  }

  String? _required(String? value) =>
      (value == null || value.trim().isEmpty) ? 'هذا الحقل مطلوب' : null;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(title: const Text('التوصيل والدفع')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const WSectionTitle('المستلم'),
            TextFormField(
              controller: _recipient,
              validator: _required,
              decoration: const InputDecoration(labelText: 'الاسم'),
            ),
            WGaps.sm,
            TextFormField(
              controller: _phone,
              validator: _required,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              decoration: const InputDecoration(labelText: 'رقم الجوال'),
            ),
            WGaps.sm,
            WOptionTile(
              label: 'مفاجأة — لا تخبر المستلم بالمرسل',
              multi: true,
              selected: _surprise,
              onTap: () => setState(() => _surprise = !_surprise),
            ),
            const WSectionTitle('العنوان'),
            TextFormField(
              controller: _district,
              validator: _required,
              decoration: const InputDecoration(labelText: 'الحي'),
            ),
            WGaps.sm,
            TextFormField(controller: _street, decoration: const InputDecoration(labelText: 'الشارع')),
            WGaps.sm,
            TextFormField(controller: _building, decoration: const InputDecoration(labelText: 'رقم المبنى')),
            WGaps.sm,
            TextFormField(controller: _driverNote, decoration: const InputDecoration(labelText: 'ملاحظة للسائق')),
            const WSectionTitle('وقت التوصيل'),
            for (var i = 0; i < _slots.length; i++)
              WOptionTile(
                label: _slots[i],
                selected: _slotIndex == i,
                onTap: () => setState(() => _slotIndex = i),
              ),
            const WSectionTitle('طريقة الدفع'),
            for (final method in _payments)
              WOptionTile(
                label: method,
                selected: _payment == method,
                onTap: () => setState(() => _payment = method),
              ),
            WGaps.sm,
            WCard(
              color: WColors.green,
              child: Row(
                children: [
                  const Icon(Icons.star, color: WColors.gold, size: 20),
                  WGaps.wsm,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('لديك ${toArabicDigits(state.points)} نقطة',
                            style: const TextStyle(color: WColors.cream, fontSize: 13, fontWeight: FontWeight.w500)),
                        Text('كل ${toArabicDigits(WRules.redeemStep)} نقطة = ${money(WRules.redeemValue)} خصم',
                            style: const TextStyle(color: WColors.cream, fontSize: 11)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: state.canRedeem && state.discount == 0
                        ? () => context.read<AppState>().redeemPoints()
                        : null,
                    child: Text(state.discount > 0 ? 'مستخدمة' : 'استخدم',
                        style: const TextStyle(color: WColors.cream)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: const BoxDecoration(
          color: WColors.paper,
          border: Border(top: BorderSide(color: WColors.line)),
        ),
        child: SafeArea(
          top: false,
          child: FilledButton(
            onPressed: _placeOrder,
            child: Text('ادفع ${money(state.total)}'),
          ),
        ),
      ),
    );
  }
}
