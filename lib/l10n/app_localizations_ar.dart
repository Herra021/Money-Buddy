// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Money Buddy';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get transactions => 'المعاملات';

  @override
  String get addExpense => 'إضافة مصروف';

  @override
  String get addIncome => 'إضافة دخل';

  @override
  String get borrowLend => 'الاستدانة والإقراض';

  @override
  String get reminders => 'التذكيرات';

  @override
  String get settings => 'الإعدادات';

  @override
  String get netBalance => 'صافي الرصيد';

  @override
  String get recentTransactions => 'المعاملات الأخيرة';

  @override
  String get income => 'الدخل';

  @override
  String get expense => 'المصروف';

  @override
  String get save => 'حفظ';

  @override
  String get amount => 'المبلغ';

  @override
  String get note => 'ملاحظة';

  @override
  String get date => 'التاريخ';

  @override
  String goodMorning(String userName) {
    return 'صباح الخير، $userName 👋';
  }

  @override
  String goodAfternoon(String userName) {
    return 'طاب يومك، $userName 👋';
  }

  @override
  String goodEvening(String userName) {
    return 'مساء الخير، $userName 👋';
  }

  @override
  String get last6Months => 'آخر 6 أشهر';

  @override
  String get incomeVsExpense => 'الدخل مقابل المصروفات';

  @override
  String get thisMonth => 'هذا الشهر';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get noTransactionsYet => 'لا توجد معاملات بعد';

  @override
  String get tapPlusToAdd => 'اضغط على زر + لإضافة أول مصروف أو دخل لك';

  @override
  String get noChartDataYet => 'لا توجد بيانات مخطط بعد';

  @override
  String get pleaseEnterAmountAndCategory => 'يرجى إدخال المبلغ وتحديد الفئة';

  @override
  String get pleaseEnterAmountAndSource => 'يرجى إدخال المبلغ وتحديد المصدر';

  @override
  String get pleaseEnterValidAmount => 'يرجى إدخال مبلغ صالح';

  @override
  String get expenseAdded => 'تمت إضافة المصروف!';

  @override
  String get incomeAdded => 'تمت إضافة الدخل!';

  @override
  String get category => 'الفئة';

  @override
  String get incomeSource => 'مصدر الدخل';

  @override
  String get couldNotLoadCategories => 'تعذر تحميل الفئات';

  @override
  String get noteOptional => 'ملاحظة (اختياري)';

  @override
  String get saveExpense => 'حفظ المصروف';

  @override
  String get saveIncome => 'حفظ الدخل';

  @override
  String get personNameAndAmountRequired => 'اسم الشخص والمبلغ مطلوبان';

  @override
  String get recordAdded => 'تمت إضافة السجل!';

  @override
  String get addBorrowLend => 'إضافة استدانة / إقراض';

  @override
  String get iLent => '↗ أقرضت';

  @override
  String get iBorrowed => '↙ استعرت';

  @override
  String get amountLent => 'المبلغ المقرض';

  @override
  String get amountBorrowed => 'المبلغ المستعار';

  @override
  String get lentToPerson => 'مقرض لـ (اسم الشخص)';

  @override
  String get borrowedFromPerson => 'مستعار من (اسم الشخص)';

  @override
  String get dueDateOptional => 'تاريخ الاستحقاق (اختياري)';

  @override
  String get tapToSetDueDate => 'اضغط لتعيين تاريخ الاستحقاق';

  @override
  String get saveLendRecord => 'حفظ سجل الإقراض';

  @override
  String get saveBorrowRecord => 'حفظ سجل الاستعارة';

  @override
  String get noMoneyLentYet => 'لم تقرض أي أموال بعد';

  @override
  String get noBorrowedMoney => 'لم تستعر أي أموال';

  @override
  String get addLentRecords => 'أضف سجلات بالأموال التي أقرضتها للآخرين';

  @override
  String get addBorrowedRecords =>
      'أضف سجلات بالأموال التي استعرتها من الآخرين';

  @override
  String get addRecord => 'إضافة سجل';

  @override
  String get paid => 'مدفوع';

  @override
  String get overdue => 'متأخر';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get due => 'مستحق';

  @override
  String get markPaid => 'تحديد كمدفوع';

  @override
  String get searchTransactions => 'البحث عن المعاملات...';

  @override
  String get all => 'الكل';

  @override
  String get noTransactionsFound => 'لم يتم العثور على معاملات';

  @override
  String get adjustFilterOrSearch => 'حاول ضبط الفلتر أو استعلام البحث';

  @override
  String get deleteTransaction => 'حذف المعاملة';

  @override
  String get areYouSure => 'هل أنت متأكد؟';

  @override
  String get areYouSureDeleteTxn =>
      'هل أنت متأكد من رغبتك في حذف هذه المعاملة؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get noRemindersYet => 'لا توجد تذكيرات بعد';

  @override
  String get addRemindersHelp =>
      'أضف تذكيرات الدفع وسنقوم بإخطارك عندما يحين موعدها';

  @override
  String get addReminder => 'إضافة تذكير';

  @override
  String get deleteReminder => 'حذف التذكير';

  @override
  String get overdueTag => 'متأخر';

  @override
  String get todayTag => 'اليوم';

  @override
  String get done => 'تم';

  @override
  String get pleaseEnterTitle => 'يرجى إدخال عنوان';

  @override
  String get newReminder => 'تذكير جديد';

  @override
  String get reminderTitle => 'عنوان التذكير';

  @override
  String get amountOptional => 'المبلغ (اختياري)';

  @override
  String get dueDate => 'تاريخ الاستحقاق';

  @override
  String get saveReminder => 'حفظ التذكير';

  @override
  String get welcomeTitle => 'مرحباً بك في\nMoney Buddy';

  @override
  String get welcomeSubtitle =>
      'رفيقك المالي الشخصي. تتبع الدخل والمصروفات وتحكم في أموالك.';

  @override
  String get fastEntryTitle => 'تتبع كل مصروف دون عناء.';

  @override
  String get fastEntrySubtitle =>
      'سجل الإنفاق في أقل من 5 ثوانٍ. بسيط للمبتدئين، قوي للمحترفين.';

  @override
  String get voiceEntryTitle => 'سجل المصروفات بصوتك.';

  @override
  String get voiceEntrySubtitle =>
      'فقط قل \"أنفقت 200 على الطعام\" وسنتولى الباقي. تتبع مالي بدون استخدام اليدين.';

  @override
  String get borrowLendTitle => 'لا تفقد تتبع الديون أبداً.';

  @override
  String get borrowLendSubtitle =>
      'تتبع من أقرضته المال ومن يدين لك. احصل على إشعارات عند اقتراب موعد الاستحقاق.';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get next => 'التالي';

  @override
  String get skip => 'تخطي';

  @override
  String get appleSignInComingSoon => 'تسجيل الدخول باستخدام Apple قريباً';

  @override
  String get welcomeBack => 'مرحباً بعودتك';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get continuePreferredAccount => 'المتابعة باستخدام حسابك المفضل';

  @override
  String get continueGoogle => 'المتابعة باستخدام Google';

  @override
  String get continueApple => 'المتابعة باستخدام Apple';

  @override
  String get continueEmail => 'المتابعة باستخدام البريد الإلكتروني';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get validEmailRequired => 'البريد الإلكتروني الصالح مطلوب';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordLengthHelp =>
      'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get createAccount => 'إنشاء الحساب';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟ تسجيل الدخول';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ إنشاء حساب';

  @override
  String get home => 'الرئيسية';

  @override
  String get history => 'السجل';

  @override
  String get borrowTab => 'الاستدانة';

  @override
  String get addNew => 'إضافة جديد';

  @override
  String get recordMoneySpent => 'سجل الأموال المنفقة';

  @override
  String get recordMoneyReceived => 'سجل الأموال المستلمة';

  @override
  String get trackWhoOwesWhom => 'تتبع من يدين لمن';

  @override
  String get languageCountry => 'اللغة / البلد';

  @override
  String get searchLanguages => 'البحث عن اللغات...';

  @override
  String get noLanguagesFound => 'لم يتم العثور على لغات.';

  @override
  String get currencyCountry => 'رمز العملة / البلد';

  @override
  String get searchCurrencies => 'البحث عن العملات أو البلدان...';

  @override
  String get noCurrenciesFound => 'لم يتم العثور على عملات.';

  @override
  String get account => 'الحساب';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get deleteAccountConfirm =>
      'هل أنت متأكد من رغبتك في حذف حسابك نهائياً؟ لا يمكن التراجع عن هذا الإجراء وستفقد جميع بياناتك.';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get lentTab => 'المقرض';

  @override
  String get borrowedTab => 'المستعار';

  @override
  String get transactionHistory => 'سجل المعاملات';

  @override
  String get netBalanceThisMonth => 'صافي الرصيد هذا الشهر';

  @override
  String get tagGetStarted => 'ابدأ الآن';

  @override
  String get tagFastEntry => 'إدخال سريع';

  @override
  String get tagVoiceEntry => 'إدخال صوتي';

  @override
  String get tagBorrowLend => 'الاستدانة والإقراض';

  @override
  String get resetData => 'إعادة ضبط بيانات التطبيق';

  @override
  String get resetDataConfirm =>
      'هل أنت متأكد من رغبتك في حذف جميع المعاملات وسجلات الاستعارة والإعارة والتذكيرات؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get reset => 'إعادة ضبط';

  @override
  String get resetSuccessful => 'تم إعادة ضبط جميع بيانات التطبيق بنجاح.';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get selectCurrency => 'اختر العملة';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get guest => 'زائر';
}
