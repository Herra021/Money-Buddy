import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Money Buddy'**
  String get appTitle;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @addExpense.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get addExpense;

  /// No description provided for @addIncome.
  ///
  /// In en, this message translates to:
  /// **'Add Income'**
  String get addIncome;

  /// No description provided for @borrowLend.
  ///
  /// In en, this message translates to:
  /// **'Borrow/Lend'**
  String get borrowLend;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @netBalance.
  ///
  /// In en, this message translates to:
  /// **'Net Balance'**
  String get netBalance;

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning, {userName} 👋'**
  String goodMorning(String userName);

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon, {userName} 👋'**
  String goodAfternoon(String userName);

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening, {userName} 👋'**
  String goodEvening(String userName);

  /// No description provided for @last6Months.
  ///
  /// In en, this message translates to:
  /// **'Last 6 Months'**
  String get last6Months;

  /// No description provided for @incomeVsExpense.
  ///
  /// In en, this message translates to:
  /// **'Income vs Expense'**
  String get incomeVsExpense;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get thisMonth;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @noTransactionsYet.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactionsYet;

  /// No description provided for @tapPlusToAdd.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to add your first expense or income'**
  String get tapPlusToAdd;

  /// No description provided for @noChartDataYet.
  ///
  /// In en, this message translates to:
  /// **'No chart data yet'**
  String get noChartDataYet;

  /// No description provided for @pleaseEnterAmountAndCategory.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount and select a category'**
  String get pleaseEnterAmountAndCategory;

  /// No description provided for @pleaseEnterAmountAndSource.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount and select a source'**
  String get pleaseEnterAmountAndSource;

  /// No description provided for @pleaseEnterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get pleaseEnterValidAmount;

  /// No description provided for @expenseAdded.
  ///
  /// In en, this message translates to:
  /// **'Expense added!'**
  String get expenseAdded;

  /// No description provided for @incomeAdded.
  ///
  /// In en, this message translates to:
  /// **'Income added!'**
  String get incomeAdded;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @incomeSource.
  ///
  /// In en, this message translates to:
  /// **'Income Source'**
  String get incomeSource;

  /// No description provided for @couldNotLoadCategories.
  ///
  /// In en, this message translates to:
  /// **'Could not load categories'**
  String get couldNotLoadCategories;

  /// No description provided for @noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteOptional;

  /// No description provided for @saveExpense.
  ///
  /// In en, this message translates to:
  /// **'Save Expense'**
  String get saveExpense;

  /// No description provided for @saveIncome.
  ///
  /// In en, this message translates to:
  /// **'Save Income'**
  String get saveIncome;

  /// No description provided for @personNameAndAmountRequired.
  ///
  /// In en, this message translates to:
  /// **'Person name and amount are required'**
  String get personNameAndAmountRequired;

  /// No description provided for @recordAdded.
  ///
  /// In en, this message translates to:
  /// **'Record added!'**
  String get recordAdded;

  /// No description provided for @addBorrowLend.
  ///
  /// In en, this message translates to:
  /// **'Add Borrow / Lend'**
  String get addBorrowLend;

  /// No description provided for @iLent.
  ///
  /// In en, this message translates to:
  /// **'↗ I Lent'**
  String get iLent;

  /// No description provided for @iBorrowed.
  ///
  /// In en, this message translates to:
  /// **'↙ I Borrowed'**
  String get iBorrowed;

  /// No description provided for @amountLent.
  ///
  /// In en, this message translates to:
  /// **'Amount Lent'**
  String get amountLent;

  /// No description provided for @amountBorrowed.
  ///
  /// In en, this message translates to:
  /// **'Amount Borrowed'**
  String get amountBorrowed;

  /// No description provided for @lentToPerson.
  ///
  /// In en, this message translates to:
  /// **'Lent to (Person name)'**
  String get lentToPerson;

  /// No description provided for @borrowedFromPerson.
  ///
  /// In en, this message translates to:
  /// **'Borrowed from (Person name)'**
  String get borrowedFromPerson;

  /// No description provided for @dueDateOptional.
  ///
  /// In en, this message translates to:
  /// **'Due Date (optional)'**
  String get dueDateOptional;

  /// No description provided for @tapToSetDueDate.
  ///
  /// In en, this message translates to:
  /// **'Tap to set due date'**
  String get tapToSetDueDate;

  /// No description provided for @saveLendRecord.
  ///
  /// In en, this message translates to:
  /// **'Save Lend Record'**
  String get saveLendRecord;

  /// No description provided for @saveBorrowRecord.
  ///
  /// In en, this message translates to:
  /// **'Save Borrow Record'**
  String get saveBorrowRecord;

  /// No description provided for @noMoneyLentYet.
  ///
  /// In en, this message translates to:
  /// **'No money lent yet'**
  String get noMoneyLentYet;

  /// No description provided for @noBorrowedMoney.
  ///
  /// In en, this message translates to:
  /// **'No borrowed money'**
  String get noBorrowedMoney;

  /// No description provided for @addLentRecords.
  ///
  /// In en, this message translates to:
  /// **'Add records of money you\'ve lent to others'**
  String get addLentRecords;

  /// No description provided for @addBorrowedRecords.
  ///
  /// In en, this message translates to:
  /// **'Add records of money you\'ve borrowed from others'**
  String get addBorrowedRecords;

  /// No description provided for @addRecord.
  ///
  /// In en, this message translates to:
  /// **'Add Record'**
  String get addRecord;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @due.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get due;

  /// No description provided for @markPaid.
  ///
  /// In en, this message translates to:
  /// **'Mark Paid'**
  String get markPaid;

  /// No description provided for @searchTransactions.
  ///
  /// In en, this message translates to:
  /// **'Search transactions...'**
  String get searchTransactions;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @noTransactionsFound.
  ///
  /// In en, this message translates to:
  /// **'No transactions found'**
  String get noTransactionsFound;

  /// No description provided for @adjustFilterOrSearch.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filter or search query'**
  String get adjustFilterOrSearch;

  /// No description provided for @deleteTransaction.
  ///
  /// In en, this message translates to:
  /// **'Delete Transaction'**
  String get deleteTransaction;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @areYouSureDeleteTxn.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this transaction?'**
  String get areYouSureDeleteTxn;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @noRemindersYet.
  ///
  /// In en, this message translates to:
  /// **'No reminders yet'**
  String get noRemindersYet;

  /// No description provided for @addRemindersHelp.
  ///
  /// In en, this message translates to:
  /// **'Add payment reminders and we\'ll notify you when they\'re due'**
  String get addRemindersHelp;

  /// No description provided for @addReminder.
  ///
  /// In en, this message translates to:
  /// **'Add Reminder'**
  String get addReminder;

  /// No description provided for @deleteReminder.
  ///
  /// In en, this message translates to:
  /// **'Delete Reminder'**
  String get deleteReminder;

  /// No description provided for @overdueTag.
  ///
  /// In en, this message translates to:
  /// **'OVERDUE'**
  String get overdueTag;

  /// No description provided for @todayTag.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get todayTag;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @pleaseEnterTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get pleaseEnterTitle;

  /// No description provided for @newReminder.
  ///
  /// In en, this message translates to:
  /// **'New Reminder'**
  String get newReminder;

  /// No description provided for @reminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminder Title'**
  String get reminderTitle;

  /// No description provided for @amountOptional.
  ///
  /// In en, this message translates to:
  /// **'Amount (optional)'**
  String get amountOptional;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDate;

  /// No description provided for @saveReminder.
  ///
  /// In en, this message translates to:
  /// **'Save Reminder'**
  String get saveReminder;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to\nMoney Buddy'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your personal finance companion. Track income, expenses, and take control of your money.'**
  String get welcomeSubtitle;

  /// No description provided for @fastEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Track every expense effortlessly.'**
  String get fastEntryTitle;

  /// No description provided for @fastEntrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Record spending in less than 5 seconds. Simple enough for beginners, powerful enough for experts.'**
  String get fastEntrySubtitle;

  /// No description provided for @voiceEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Log expenses with your voice.'**
  String get voiceEntryTitle;

  /// No description provided for @voiceEntrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Just say \"Spent 200 on food\" and we\'ll handle the rest. Hands-free finance tracking.'**
  String get voiceEntrySubtitle;

  /// No description provided for @borrowLendTitle.
  ///
  /// In en, this message translates to:
  /// **'Never lose track of IOUs.'**
  String get borrowLendTitle;

  /// No description provided for @borrowLendSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track who you\'ve lent money to and who owes you. Get notified when dues are coming up.'**
  String get borrowLendSubtitle;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'SKIP'**
  String get skip;

  /// No description provided for @appleSignInComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Apple Sign In coming soon'**
  String get appleSignInComingSoon;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @continuePreferredAccount.
  ///
  /// In en, this message translates to:
  /// **'Continue with your preferred account'**
  String get continuePreferredAccount;

  /// No description provided for @continueGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueGoogle;

  /// No description provided for @continueApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueApple;

  /// No description provided for @continueEmail.
  ///
  /// In en, this message translates to:
  /// **'Continue with Email'**
  String get continueEmail;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @validEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Valid email required'**
  String get validEmailRequired;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordLengthHelp.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordLengthHelp;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign In'**
  String get alreadyHaveAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign Up'**
  String get dontHaveAccount;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @borrowTab.
  ///
  /// In en, this message translates to:
  /// **'Borrow'**
  String get borrowTab;

  /// No description provided for @addNew.
  ///
  /// In en, this message translates to:
  /// **'Add New'**
  String get addNew;

  /// No description provided for @recordMoneySpent.
  ///
  /// In en, this message translates to:
  /// **'Record money spent'**
  String get recordMoneySpent;

  /// No description provided for @recordMoneyReceived.
  ///
  /// In en, this message translates to:
  /// **'Record money received'**
  String get recordMoneyReceived;

  /// No description provided for @trackWhoOwesWhom.
  ///
  /// In en, this message translates to:
  /// **'Track who owes whom'**
  String get trackWhoOwesWhom;

  /// No description provided for @languageCountry.
  ///
  /// In en, this message translates to:
  /// **'Language / Country'**
  String get languageCountry;

  /// No description provided for @searchLanguages.
  ///
  /// In en, this message translates to:
  /// **'Search languages...'**
  String get searchLanguages;

  /// No description provided for @noLanguagesFound.
  ///
  /// In en, this message translates to:
  /// **'No languages found.'**
  String get noLanguagesFound;

  /// No description provided for @currencyCountry.
  ///
  /// In en, this message translates to:
  /// **'Currency Symbol / Country'**
  String get currencyCountry;

  /// No description provided for @searchCurrencies.
  ///
  /// In en, this message translates to:
  /// **'Search currencies or countries...'**
  String get searchCurrencies;

  /// No description provided for @noCurrenciesFound.
  ///
  /// In en, this message translates to:
  /// **'No currencies found.'**
  String get noCurrenciesFound;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @deleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete your account? This action cannot be undone and all your data will be lost.'**
  String get deleteAccountConfirm;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @lentTab.
  ///
  /// In en, this message translates to:
  /// **'Lent'**
  String get lentTab;

  /// No description provided for @borrowedTab.
  ///
  /// In en, this message translates to:
  /// **'Borrowed'**
  String get borrowedTab;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// No description provided for @netBalanceThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Net Balance this month'**
  String get netBalanceThisMonth;

  /// No description provided for @tagGetStarted.
  ///
  /// In en, this message translates to:
  /// **'GET STARTED'**
  String get tagGetStarted;

  /// No description provided for @tagFastEntry.
  ///
  /// In en, this message translates to:
  /// **'FAST ENTRY'**
  String get tagFastEntry;

  /// No description provided for @tagVoiceEntry.
  ///
  /// In en, this message translates to:
  /// **'VOICE ENTRY'**
  String get tagVoiceEntry;

  /// No description provided for @tagBorrowLend.
  ///
  /// In en, this message translates to:
  /// **'BORROW & LEND'**
  String get tagBorrowLend;

  /// No description provided for @resetData.
  ///
  /// In en, this message translates to:
  /// **'Reset App Data'**
  String get resetData;

  /// No description provided for @resetDataConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all transactions, borrow/lend records, and reminders? This cannot be undone.'**
  String get resetDataConfirm;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @resetSuccessful.
  ///
  /// In en, this message translates to:
  /// **'All app data has been successfully reset.'**
  String get resetSuccessful;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get selectCurrency;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'it',
        'ja',
        'ko',
        'pt',
        'ru',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
