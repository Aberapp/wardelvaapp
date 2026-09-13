# دليل النشر — أبل ستور وقوقل بلاي

## قبل كل شيء

- معرّف التطبيق: `com.wardelva.app` — ثبّته من البداية لأن تغييره بعد النشر يعني تطبيقاً جديداً.
- سجل تجاري ووثيقة خصوصية منشورة على رابط عام. المتجران يرفضان بدونها.
- أيقونة التطبيق وشاشة البداية من الشعار الرسمي:

```bash
flutter pub add --dev flutter_launcher_icons flutter_native_splash
```

ثم أضف إعداداتهما في `pubspec.yaml` مشيراً إلى `assets/logo/mark_cream.png`، ونفّذ:

```bash
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

## قوقل بلاي

1. حساب مطوّر (رسوم لمرة واحدة ٢٥ دولاراً).
2. أنشئ مفتاح توقيع واحفظه خارج المستودع:

```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

3. اربطه عبر `android/key.properties` وعدّل `android/app/build.gradle` لاستخدامه في `release`.
4. ابنِ الحزمة المطلوبة للمتجر:

```bash
flutter build appbundle --release
```

5. في Play Console: املأ استمارة أمان البيانات، صنّف المحتوى، وارفع الحزمة على مسار الاختبار الداخلي أولاً.

## أبل ستور

1. حساب Apple Developer (‏٩٩ دولاراً سنوياً) وجهاز macOS مع Xcode.
2. أنشئ App ID و Provisioning Profile، وحدّث `ios/Runner.xcodeproj` بالمعرّف والفريق.
3. ابنِ ثم ارفع:

```bash
flutter build ipa --release
```

ثم افتح `build/ios/archive/Runner.xcarchive` في Xcode وارفعه إلى App Store Connect، أو استخدم Transporter.

4. جهّز في App Store Connect: الوصف بالعربي والإنجليزي، لقطات شاشة لكل مقاس مطلوب، وسياسة الخصوصية، وبطاقة خصوصية التطبيق.

## نقاط ترفض بسببها المتاجر عادةً

- **حذف الحساب:** أبل تشترط إمكانية حذف الحساب داخل التطبيق ما دام فيه تسجيل دخول. الزر موجود في شاشة «حسابي» ويحتاج ربطاً فعلياً بالخادم.
- **تسجيل الدخول:** إذا أضفت الدخول عبر Google أو Facebook، أبل تطلب إتاحة Sign in with Apple أيضاً.
- **الدفع:** بيع سلع مادية عبر بوابة خارجية مسموح. لا تستخدم مشتريات داخل التطبيق للورد والهدايا.
- **الأذونات:** كل إذن (موقع، إشعارات، كاميرا) يحتاج نص تبرير في `Info.plist` بالعربي والإنجليزي.
- **حساب تجريبي:** جهّز حساباً بأرقام تجريبية لمراجعي أبل، وإلا يرفضون لعدم قدرتهم على الدخول.

## ترتيب مقترح

اختبار داخلي على بلاي و TestFlight أولاً بأسبوع على الأقل، ثم إصدار محدود، ثم النشر العام.
