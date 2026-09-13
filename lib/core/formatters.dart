/// تحويل الأرقام إلى صيغة عربية-هندية موحّدة في كل التطبيق.
const _arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

String toArabicDigits(Object value) {
  final buffer = StringBuffer();
  for (final rune in value.toString().runes) {
    final index = rune - 48;
    buffer.write(index >= 0 && index <= 9 ? _arabicDigits[index] : String.fromCharCode(rune));
  }
  return buffer.toString();
}

String groupNumber(num value) {
  final text = value.round().abs().toString();
  final chunks = <String>[];
  for (var i = text.length; i > 0; i -= 3) {
    chunks.insert(0, text.substring(i - 3 < 0 ? 0 : i - 3, i));
  }
  return (value < 0 ? '−' : '') + toArabicDigits(chunks.join('٬'));
}

/// مثال: ٢٣٠ ريال
String money(num value) => '${groupNumber(value)} ريال';
