// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Money Buddy';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get transactions => 'Transactions';

  @override
  String get addExpense => 'Add Expense';

  @override
  String get addIncome => 'Add Income';

  @override
  String get borrowLend => 'Borrow/Lend';

  @override
  String get reminders => 'Reminders';

  @override
  String get settings => 'Settings';

  @override
  String get netBalance => 'Net Balance';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get income => 'Income';

  @override
  String get expense => 'Expense';

  @override
  String get save => 'Save';

  @override
  String get amount => 'Amount';

  @override
  String get note => 'Note';

  @override
  String get date => 'Date';

  @override
  String goodMorning(String userName) {
    return 'Good Morning, $userName 👋';
  }

  @override
  String goodAfternoon(String userName) {
    return 'Good Afternoon, $userName 👋';
  }

  @override
  String goodEvening(String userName) {
    return 'Good Evening, $userName 👋';
  }

  @override
  String get last6Months => 'Last 6 Months';

  @override
  String get incomeVsExpense => 'Income vs Expense';

  @override
  String get thisMonth => 'This month';

  @override
  String get seeAll => 'See All';

  @override
  String get noTransactionsYet => 'No transactions yet';

  @override
  String get tapPlusToAdd =>
      'Tap the + button to add your first expense or income';

  @override
  String get noChartDataYet => 'No chart data yet';

  @override
  String get pleaseEnterAmountAndCategory =>
      'Please enter amount and select a category';

  @override
  String get pleaseEnterAmountAndSource =>
      'Please enter amount and select a source';

  @override
  String get pleaseEnterValidAmount => 'Please enter a valid amount';

  @override
  String get expenseAdded => 'Expense added!';

  @override
  String get incomeAdded => 'Income added!';

  @override
  String get category => 'Category';

  @override
  String get incomeSource => 'Income Source';

  @override
  String get couldNotLoadCategories => 'Could not load categories';

  @override
  String get noteOptional => 'Note (optional)';

  @override
  String get saveExpense => 'Save Expense';

  @override
  String get saveIncome => 'Save Income';

  @override
  String get personNameAndAmountRequired =>
      'Person name and amount are required';

  @override
  String get recordAdded => 'Record added!';

  @override
  String get addBorrowLend => 'Add Borrow / Lend';

  @override
  String get iLent => '↗ I Lent';

  @override
  String get iBorrowed => '↙ I Borrowed';

  @override
  String get amountLent => 'Amount Lent';

  @override
  String get amountBorrowed => 'Amount Borrowed';

  @override
  String get lentToPerson => 'Lent to (Person name)';

  @override
  String get borrowedFromPerson => 'Borrowed from (Person name)';

  @override
  String get dueDateOptional => 'Due Date (optional)';

  @override
  String get tapToSetDueDate => 'Tap to set due date';

  @override
  String get saveLendRecord => 'Save Lend Record';

  @override
  String get saveBorrowRecord => 'Save Borrow Record';

  @override
  String get noMoneyLentYet => 'No money lent yet';

  @override
  String get noBorrowedMoney => 'No borrowed money';

  @override
  String get addLentRecords => 'Add records of money you\'ve lent to others';

  @override
  String get addBorrowedRecords =>
      'Add records of money you\'ve borrowed from others';

  @override
  String get addRecord => 'Add Record';

  @override
  String get paid => 'Paid';

  @override
  String get overdue => 'Overdue';

  @override
  String get pending => 'Pending';

  @override
  String get due => 'Due';

  @override
  String get markPaid => 'Mark Paid';

  @override
  String get searchTransactions => 'Search transactions...';

  @override
  String get all => 'All';

  @override
  String get noTransactionsFound => 'No transactions found';

  @override
  String get adjustFilterOrSearch =>
      'Try adjusting your filter or search query';

  @override
  String get deleteTransaction => 'Delete Transaction';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String get areYouSureDeleteTxn =>
      'Are you sure you want to delete this transaction?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get noRemindersYet => 'No reminders yet';

  @override
  String get addRemindersHelp =>
      'Add payment reminders and we\'ll notify you when they\'re due';

  @override
  String get addReminder => 'Add Reminder';

  @override
  String get deleteReminder => 'Delete Reminder';

  @override
  String get overdueTag => 'OVERDUE';

  @override
  String get todayTag => 'TODAY';

  @override
  String get done => 'Done';

  @override
  String get pleaseEnterTitle => 'Please enter a title';

  @override
  String get newReminder => 'New Reminder';

  @override
  String get reminderTitle => 'Reminder Title';

  @override
  String get amountOptional => 'Amount (optional)';

  @override
  String get dueDate => 'Due Date';

  @override
  String get saveReminder => 'Save Reminder';

  @override
  String get welcomeTitle => 'Welcome to\nMoney Buddy';

  @override
  String get welcomeSubtitle =>
      'Your personal finance companion. Track income, expenses, and take control of your money.';

  @override
  String get fastEntryTitle => 'Track every expense effortlessly.';

  @override
  String get fastEntrySubtitle =>
      'Record spending in less than 5 seconds. Simple enough for beginners, powerful enough for experts.';

  @override
  String get voiceEntryTitle => 'Log expenses with your voice.';

  @override
  String get voiceEntrySubtitle =>
      'Just say \"Spent 200 on food\" and we\'ll handle the rest. Hands-free finance tracking.';

  @override
  String get borrowLendTitle => 'Never lose track of IOUs.';

  @override
  String get borrowLendSubtitle =>
      'Track who you\'ve lent money to and who owes you. Get notified when dues are coming up.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get next => 'Next';

  @override
  String get skip => 'SKIP';

  @override
  String get appleSignInComingSoon => 'Apple Sign In coming soon';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get signIn => 'Sign In';

  @override
  String get continuePreferredAccount => 'Continue with your preferred account';

  @override
  String get continueGoogle => 'Continue with Google';

  @override
  String get continueApple => 'Continue with Apple';

  @override
  String get continueEmail => 'Continue with Email';

  @override
  String get signUp => 'Sign Up';

  @override
  String get email => 'Email';

  @override
  String get validEmailRequired => 'Valid email required';

  @override
  String get password => 'Password';

  @override
  String get passwordLengthHelp => 'Password must be at least 6 characters';

  @override
  String get createAccount => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account? Sign In';

  @override
  String get dontHaveAccount => 'Don\'t have an account? Sign Up';

  @override
  String get home => 'Home';

  @override
  String get history => 'History';

  @override
  String get borrowTab => 'Borrow';

  @override
  String get addNew => 'Add New';

  @override
  String get recordMoneySpent => 'Record money spent';

  @override
  String get recordMoneyReceived => 'Record money received';

  @override
  String get trackWhoOwesWhom => 'Track who owes whom';

  @override
  String get languageCountry => 'Language / Country';

  @override
  String get searchLanguages => 'Search languages...';

  @override
  String get noLanguagesFound => 'No languages found.';

  @override
  String get currencyCountry => 'Currency Symbol / Country';

  @override
  String get searchCurrencies => 'Search currencies or countries...';

  @override
  String get noCurrenciesFound => 'No currencies found.';

  @override
  String get account => 'Account';

  @override
  String get logout => 'Logout';

  @override
  String get deleteAccountConfirm =>
      'Are you sure you want to permanently delete your account? This action cannot be undone and all your data will be lost.';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get lentTab => 'Lent';

  @override
  String get borrowedTab => 'Borrowed';

  @override
  String get transactionHistory => 'Transaction History';

  @override
  String get netBalanceThisMonth => 'Net Balance this month';

  @override
  String get tagGetStarted => 'GET STARTED';

  @override
  String get tagFastEntry => 'FAST ENTRY';

  @override
  String get tagVoiceEntry => 'VOICE ENTRY';

  @override
  String get tagBorrowLend => 'BORROW & LEND';

  @override
  String get resetData => 'Reset App Data';

  @override
  String get resetDataConfirm =>
      'Are you sure you want to delete all transactions, borrow/lend records, and reminders? This cannot be undone.';

  @override
  String get reset => 'Reset';

  @override
  String get resetSuccessful => 'All app data has been successfully reset.';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get selectCurrency => 'Select Currency';

  @override
  String get profile => 'Profile';

  @override
  String get guest => 'Guest';
}
