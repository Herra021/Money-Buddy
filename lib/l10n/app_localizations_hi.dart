// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'मनी बडी';

  @override
  String get dashboard => 'डैशबोर्ड';

  @override
  String get transactions => 'लेन-देन';

  @override
  String get addExpense => 'खर्च जोड़ें';

  @override
  String get addIncome => 'आय जोड़ें';

  @override
  String get borrowLend => 'उधार/लेन-देन';

  @override
  String get reminders => 'अनुस्मारक';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get netBalance => 'कुल शेष';

  @override
  String get recentTransactions => 'हाल के लेन-देन';

  @override
  String get income => 'आय';

  @override
  String get expense => 'खर्च';

  @override
  String get save => 'सहेजें';

  @override
  String get amount => 'राशि';

  @override
  String get note => 'टिप्पणी';

  @override
  String get date => 'तिथि';

  @override
  String goodMorning(String userName) {
    return 'सुप्रभात, $userName 👋';
  }

  @override
  String goodAfternoon(String userName) {
    return 'नमस्कार, $userName 👋';
  }

  @override
  String goodEvening(String userName) {
    return 'शुभ संध्या, $userName 👋';
  }

  @override
  String get last6Months => 'पिछले 6 महीने';

  @override
  String get incomeVsExpense => 'आय बनाम खर्च';

  @override
  String get thisMonth => 'इस महीने';

  @override
  String get seeAll => 'सभी देखें';

  @override
  String get noTransactionsYet => 'अभी तक कोई लेन-देन नहीं हुआ';

  @override
  String get tapPlusToAdd => 'अपनी पहली आय या खर्च जोड़ने के लिए + बटन दबाएं';

  @override
  String get noChartDataYet => 'चार्ट के लिए कोई डेटा नहीं है';

  @override
  String get pleaseEnterAmountAndCategory =>
      'कृपया राशि दर्ज करें और एक श्रेणी चुनें';

  @override
  String get pleaseEnterAmountAndSource =>
      'कृपया राशि दर्ज करें और एक स्रोत चुनें';

  @override
  String get pleaseEnterValidAmount => 'कृपया वैध राशि दर्ज करें';

  @override
  String get expenseAdded => 'खर्च जोड़ा गया!';

  @override
  String get incomeAdded => 'आय जोड़ी गई!';

  @override
  String get category => 'श्रेणी';

  @override
  String get incomeSource => 'आय का स्रोत';

  @override
  String get couldNotLoadCategories => 'श्रेणियां लोड नहीं की जा सकीं';

  @override
  String get noteOptional => 'टिप्पणी (वैकल्पिक)';

  @override
  String get saveExpense => 'खर्च सहेजें';

  @override
  String get saveIncome => 'आय सहेजें';

  @override
  String get personNameAndAmountRequired => 'व्यक्ति का नाम और राशि आवश्यक है';

  @override
  String get recordAdded => 'रिकॉर्ड जोड़ा गया!';

  @override
  String get addBorrowLend => 'उधार / लेन-देन जोड़ें';

  @override
  String get iLent => '↗ मैंने उधार दिया';

  @override
  String get iBorrowed => '↙ मैंने उधार लिया';

  @override
  String get amountLent => 'दी गई राशि';

  @override
  String get amountBorrowed => 'ली गई राशि';

  @override
  String get lentToPerson => 'किसे उधार दिया (व्यक्ति का नाम)';

  @override
  String get borrowedFromPerson => 'किससे उधार लिया (व्यक्ति का नाम)';

  @override
  String get dueDateOptional => 'देय तिथि (वैकल्पिक)';

  @override
  String get tapToSetDueDate => 'देय तिथि सेट करने के लिए टैप करें';

  @override
  String get saveLendRecord => 'उधार देने का रिकॉर्ड सहेजें';

  @override
  String get saveBorrowRecord => 'उधार लेने का रिकॉर्ड सहेजें';

  @override
  String get noMoneyLentYet => 'अभी तक कोई पैसा उधार नहीं दिया';

  @override
  String get noBorrowedMoney => 'कोई उधार लिया हुआ पैसा नहीं है';

  @override
  String get addLentRecords => 'दूसरों को उधार दिए गए पैसे के रिकॉर्ड जोड़ें';

  @override
  String get addBorrowedRecords =>
      'दूसरों से उधार लिए गए पैसे के रिकॉर्ड जोड़ें';

  @override
  String get addRecord => 'रिकॉर्ड जोड़ें';

  @override
  String get paid => 'भुगतान किया गया';

  @override
  String get overdue => 'समय सीमा समाप्त';

  @override
  String get pending => 'लंबित';

  @override
  String get due => 'देय तिथि';

  @override
  String get markPaid => 'भुगतान चिह्नित करें';

  @override
  String get searchTransactions => 'लेन-देन खोजें...';

  @override
  String get all => 'सभी';

  @override
  String get noTransactionsFound => 'कोई लेन-देन नहीं मिला';

  @override
  String get adjustFilterOrSearch =>
      'फ़िल्टर या खोज क्वेरी बदलने का प्रयास करें';

  @override
  String get deleteTransaction => 'लेन-देन हटाएं';

  @override
  String get areYouSure => 'क्या आप सुनिश्चित हैं?';

  @override
  String get areYouSureDeleteTxn =>
      'क्या आप वाकई इस लेन-देन को हटाना चाहते हैं?';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएं';

  @override
  String get noRemindersYet => 'अभी तक कोई अनुस्मारक नहीं';

  @override
  String get addRemindersHelp =>
      'भुगतान अनुस्मारक जोड़ें और उनके देय होने पर हम आपको सूचित करेंगे';

  @override
  String get addReminder => 'अनुस्मारक जोड़ें';

  @override
  String get deleteReminder => 'अनुस्मारक हटाएं';

  @override
  String get overdueTag => 'देरी';

  @override
  String get todayTag => 'आज';

  @override
  String get done => 'पूर्ण';

  @override
  String get pleaseEnterTitle => 'कृपया एक शीर्षक दर्ज करें';

  @override
  String get newReminder => 'नया अनुस्मारक';

  @override
  String get reminderTitle => 'अनुस्मारक शीर्षक';

  @override
  String get amountOptional => 'राशि (वैकल्पिक)';

  @override
  String get dueDate => 'देय तिथि';

  @override
  String get saveReminder => 'अनुस्मारक सहेजें';

  @override
  String get welcomeTitle => 'मनी बडी में\nआपका स्वागत है';

  @override
  String get welcomeSubtitle =>
      'आपका व्यक्तिगत वित्त साथी। आय, खर्चों को ट्रैक करें और अपने पैसे पर नियंत्रण रखें।';

  @override
  String get fastEntryTitle => 'हर खर्च को आसानी से ट्रैक करें।';

  @override
  String get fastEntrySubtitle =>
      '5 सेकंड से कम समय में खर्च दर्ज करें। शुरुआती लोगों के लिए सरल, विशेषज्ञों के लिए शक्तिशाली।';

  @override
  String get voiceEntryTitle => 'अपनी आवाज से खर्च दर्ज करें।';

  @override
  String get voiceEntrySubtitle =>
      'बस कहें \'भोजन पर 200 खर्च किए\' और हम बाकी संभाल लेंगे। हैंड्स-फ्री वित्त ट्रैकिंग।';

  @override
  String get borrowLendTitle => 'उधार के पैसों का हिसाब कभी न खोएं।';

  @override
  String get borrowLendSubtitle =>
      'ट्रैक करें कि आपने किसे पैसे उधार दिए हैं और आपके पास किसका बकाया है। देय तिथि आने पर सूचित किया जाएगा।';

  @override
  String get getStarted => 'शुरू करें';

  @override
  String get next => 'आगे';

  @override
  String get skip => 'छोड़ें';

  @override
  String get appleSignInComingSoon => 'एप्पल साइन इन जल्द ही आ रहा है';

  @override
  String get welcomeBack => 'स्वागत है';

  @override
  String get signIn => 'साइन इन करें';

  @override
  String get continuePreferredAccount => 'अपने पसंदीदा खाते के साथ जारी रखें';

  @override
  String get continueGoogle => 'गूगल के साथ जारी रखें';

  @override
  String get continueApple => 'एप्पल के साथ जारी रखें';

  @override
  String get continueEmail => 'ईमेल के साथ जारी रखें';

  @override
  String get signUp => 'साइन अप करें';

  @override
  String get email => 'ईमेल';

  @override
  String get validEmailRequired => 'वैध ईमेल आवश्यक है';

  @override
  String get password => 'पासवर्ड';

  @override
  String get passwordLengthHelp => 'पासवर्ड कम से कम 6 अक्षरों का होना चाहिए';

  @override
  String get createAccount => 'खाता बनाएं';

  @override
  String get alreadyHaveAccount => 'पहले से ही खाता है? साइन इन करें';

  @override
  String get dontHaveAccount => 'खाता नहीं है? साइन अप करें';

  @override
  String get home => 'होम';

  @override
  String get history => 'इतिहास';

  @override
  String get borrowTab => 'उधार';

  @override
  String get addNew => 'नया जोड़ें';

  @override
  String get recordMoneySpent => 'खर्च किए गए पैसे दर्ज करें';

  @override
  String get recordMoneyReceived => 'प्राप्त धन दर्ज करें';

  @override
  String get trackWhoOwesWhom => 'ट्रैक करें कि कौन किसका कर्जदार है';

  @override
  String get languageCountry => 'भाषा / देश';

  @override
  String get searchLanguages => 'भाषाएं खोजें...';

  @override
  String get noLanguagesFound => 'कोई भाषा नहीं मिली।';

  @override
  String get currencyCountry => 'मुद्रा प्रतीक / देश';

  @override
  String get searchCurrencies => 'मुद्राएं या देश खोजें...';

  @override
  String get noCurrenciesFound => 'कोई मुद्रा नहीं मिली।';

  @override
  String get account => 'खाता';

  @override
  String get logout => 'लॉगआउट';

  @override
  String get deleteAccountConfirm =>
      'क्या आप वाकई अपना खाता स्थायी रूप से हटाना चाहते हैं? यह क्रिया पूर्ववत नहीं की जा सकती है और आपका सारा डेटा खो जाएगा।';

  @override
  String get deleteAccount => 'खाता हटाएं';

  @override
  String get lentTab => 'दिया';

  @override
  String get borrowedTab => 'लिया';

  @override
  String get transactionHistory => 'लेनदेन का इतिहास';

  @override
  String get netBalanceThisMonth => 'इस महीने का कुल शेष';

  @override
  String get tagGetStarted => 'शुरू करें';

  @override
  String get tagFastEntry => 'त्वरित प्रविष्टि';

  @override
  String get tagVoiceEntry => 'आवाज प्रविष्टि';

  @override
  String get tagBorrowLend => 'उधार और देना';

  @override
  String get resetData => 'ऐप डेटा रीसेट करें';

  @override
  String get resetDataConfirm =>
      'क्या आप वाकई सभी लेनदेन, उधार/लेन रिकॉर्ड और अनुस्मारक हटाना चाहते हैं? इसे वापस नहीं लिया जा सकता।';

  @override
  String get reset => 'रीसेट';

  @override
  String get resetSuccessful => 'सभी ऐप डेटा सफलतापूर्वक रीसेट कर दिया गया है।';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get selectCurrency => 'मुद्रा चुनें';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get guest => 'अतिथि';
}
