import 'package:flutter_test/flutter_test.dart';
import 'package:wardelva/core/formatters.dart';

void main() {
  test('تحويل الأرقام إلى العربية', () {
    expect(toArabicDigits(2025), '٢٠٢٥');
    expect(toArabicDigits('WD-10245'), 'WD-١٠٢٤٥');
  });

  test('تنسيق المبالغ', () {
    expect(money(230), '٢٣٠ ريال');
    expect(money(12450), '١٢٬٤٥٠ ريال');
  });
}
