// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Money Buddy';

  @override
  String get dashboard => 'ダッシュボード';

  @override
  String get transactions => '取引履歴';

  @override
  String get addExpense => '支出を追加';

  @override
  String get addIncome => '収入を追加';

  @override
  String get borrowLend => '貸し借り';

  @override
  String get reminders => 'リマインダー';

  @override
  String get settings => '設定';

  @override
  String get netBalance => '純残高';

  @override
  String get recentTransactions => '最近の取引';

  @override
  String get income => '収入';

  @override
  String get expense => '支出';

  @override
  String get save => '保存';

  @override
  String get amount => '金額';

  @override
  String get note => 'メモ';

  @override
  String get date => '日付';

  @override
  String goodMorning(String userName) {
    return 'おはようございます、$userName 👋';
  }

  @override
  String goodAfternoon(String userName) {
    return 'こんにちは、$userName 👋';
  }

  @override
  String goodEvening(String userName) {
    return 'こんばんは、$userName 👋';
  }

  @override
  String get last6Months => '過去6ヶ月';

  @override
  String get incomeVsExpense => '収入 vs 支出';

  @override
  String get thisMonth => '今月';

  @override
  String get seeAll => 'すべて表示';

  @override
  String get noTransactionsYet => '取引履歴がありません';

  @override
  String get tapPlusToAdd => '「+」ボタンをタップして、最初の収入または支出を追加してください';

  @override
  String get noChartDataYet => 'グラフデータがありません';

  @override
  String get pleaseEnterAmountAndCategory => '金額を入力し、カテゴリを選択してください';

  @override
  String get pleaseEnterAmountAndSource => '金額を入力し、収入源を選択してください';

  @override
  String get pleaseEnterValidAmount => '有効な金額を入力してください';

  @override
  String get expenseAdded => '支出を追加しました！';

  @override
  String get incomeAdded => '収入を追加しました！';

  @override
  String get category => 'カテゴリ';

  @override
  String get incomeSource => '収入源';

  @override
  String get couldNotLoadCategories => 'カテゴリを読み込めませんでした';

  @override
  String get noteOptional => 'メモ（任意）';

  @override
  String get saveExpense => '支出を保存';

  @override
  String get saveIncome => '収入を保存';

  @override
  String get personNameAndAmountRequired => '名前と金額は必須です';

  @override
  String get recordAdded => '記録を追加しました！';

  @override
  String get addBorrowLend => '貸し借りを追加';

  @override
  String get iLent => '↗ 貸した';

  @override
  String get iBorrowed => '↙ 借りた';

  @override
  String get amountLent => '貸出額';

  @override
  String get amountBorrowed => '借入額';

  @override
  String get lentToPerson => '貸し先（氏名）';

  @override
  String get borrowedFromPerson => '借り先（氏名）';

  @override
  String get dueDateOptional => '期日（任意）';

  @override
  String get tapToSetDueDate => '期日を設定';

  @override
  String get saveLendRecord => '貸出記録を保存';

  @override
  String get saveBorrowRecord => '借入記録を保存';

  @override
  String get noMoneyLentYet => '貸したお金はありません';

  @override
  String get noBorrowedMoney => '借りたお金はありません';

  @override
  String get addLentRecords => '他人に貸したお金の記録を追加します';

  @override
  String get addBorrowedRecords => '他人から借りたお金の記録を追加します';

  @override
  String get addRecord => '記録を追加';

  @override
  String get paid => '支払済';

  @override
  String get overdue => '期限切れ';

  @override
  String get pending => '保留中';

  @override
  String get due => '期限';

  @override
  String get markPaid => '支払済にする';

  @override
  String get searchTransactions => '取引を検索...';

  @override
  String get all => 'すべて';

  @override
  String get noTransactionsFound => '取引が見つかりません';

  @override
  String get adjustFilterOrSearch => 'フィルターまたは検索条件を調整してください';

  @override
  String get deleteTransaction => '取引を削除';

  @override
  String get areYouSure => '本当によろしいですか？';

  @override
  String get areYouSureDeleteTxn => 'この取引を削除してもよろしいですか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get noRemindersYet => 'リマインダーはありません';

  @override
  String get addRemindersHelp => '支払リマインダーを追加すると、期日に通知します';

  @override
  String get addReminder => 'リマインダーを追加';

  @override
  String get deleteReminder => 'リマインダーを削除';

  @override
  String get overdueTag => '期限切れ';

  @override
  String get todayTag => '今日';

  @override
  String get done => '完了';

  @override
  String get pleaseEnterTitle => 'タイトルを入力してください';

  @override
  String get newReminder => '新規リマインダー';

  @override
  String get reminderTitle => 'リマインダーのタイトル';

  @override
  String get amountOptional => '金額（任意）';

  @override
  String get dueDate => '期日';

  @override
  String get saveReminder => 'リマインダーを保存';

  @override
  String get welcomeTitle => 'マネーバディへ\nようこそ';

  @override
  String get welcomeSubtitle => 'あなただけの個人財務パートナー。収入や支出を追跡し、賢くお金を管理しましょう。';

  @override
  String get fastEntryTitle => '支出を簡単に記録。';

  @override
  String get fastEntrySubtitle => '5秒以内に支出を記録。初心者にはシンプルに、エキスパートには強力に。';

  @override
  String get voiceEntryTitle => '音声で支出を記録。';

  @override
  String get voiceEntrySubtitle => '「食費に200円使った」と話しかけるだけ。ハンズフリーで支出を追跡。';

  @override
  String get borrowLendTitle => '貸し借りを忘れない。';

  @override
  String get borrowLendSubtitle => '誰に貸したか、誰から借りたかを記録。期日が近づくと通知を受け取れます。';

  @override
  String get getStarted => '始める';

  @override
  String get next => '次へ';

  @override
  String get skip => 'スキップ';

  @override
  String get appleSignInComingSoon => 'Appleでサインインは間もなく利用可能になります';

  @override
  String get welcomeBack => 'おかえりなさい';

  @override
  String get signIn => 'サインイン';

  @override
  String get continuePreferredAccount => 'お好みのアカウントで続行';

  @override
  String get continueGoogle => 'Googleで続行';

  @override
  String get continueApple => 'Appleで続行';

  @override
  String get continueEmail => 'メールアドレスで続行';

  @override
  String get signUp => '新規登録';

  @override
  String get email => 'メールアドレス';

  @override
  String get validEmailRequired => '有効なメールアドレスを入力してください';

  @override
  String get password => 'パスワード';

  @override
  String get passwordLengthHelp => 'パスワードは6文字以上で入力してください';

  @override
  String get createAccount => 'アカウントを作成';

  @override
  String get alreadyHaveAccount => '既にアカウントをお持ちですか？サインイン';

  @override
  String get dontHaveAccount => 'アカウントをお持ちでないですか？新規登録';

  @override
  String get home => 'ホーム';

  @override
  String get history => '履歴';

  @override
  String get borrowTab => '貸し借り';

  @override
  String get addNew => '新規追加';

  @override
  String get recordMoneySpent => '使ったお金を記録';

  @override
  String get recordMoneyReceived => '受け取ったお金を記録';

  @override
  String get trackWhoOwesWhom => '誰が誰に借りているかを記録';

  @override
  String get languageCountry => '言語 / 国';

  @override
  String get searchLanguages => '言語を検索...';

  @override
  String get noLanguagesFound => '言語が見つかりません。';

  @override
  String get currencyCountry => '通貨記号 / 国';

  @override
  String get searchCurrencies => '通貨または国を検索...';

  @override
  String get noCurrenciesFound => '通貨が見つかりません。';

  @override
  String get account => 'アカウント';

  @override
  String get logout => 'ログアウト';

  @override
  String get deleteAccountConfirm =>
      'アカウントを完全に削除してもよろしいですか？この操作は取り消すことができず、すべてのデータが失われます。';

  @override
  String get deleteAccount => 'アカウントを削除';

  @override
  String get lentTab => '貸した';

  @override
  String get borrowedTab => '借りた';

  @override
  String get transactionHistory => '取引履歴';

  @override
  String get netBalanceThisMonth => '今月の純残高';

  @override
  String get tagGetStarted => 'スタート';

  @override
  String get tagFastEntry => 'かんたん入力';

  @override
  String get tagVoiceEntry => '音声入力';

  @override
  String get tagBorrowLend => '貸し借り';

  @override
  String get resetData => 'アプリデータをリセット';

  @override
  String get resetDataConfirm =>
      'すべての取引、貸し借り記録、およびリマインダーを削除してもよろしいですか？この操作は取り消せません。';

  @override
  String get reset => 'リセット';

  @override
  String get resetSuccessful => 'すべてのアプリデータが正常にリセットされました。';

  @override
  String get selectLanguage => '言語を選択';

  @override
  String get selectCurrency => '通貨を選択';

  @override
  String get profile => 'プロフィール';

  @override
  String get guest => 'ゲスト';
}
