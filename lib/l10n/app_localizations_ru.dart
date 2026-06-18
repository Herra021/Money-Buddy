// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Money Buddy';

  @override
  String get dashboard => 'Панель управления';

  @override
  String get transactions => 'Транзакции';

  @override
  String get addExpense => 'Добавить расход';

  @override
  String get addIncome => 'Добавить доход';

  @override
  String get borrowLend => 'Долги';

  @override
  String get reminders => 'Напоминания';

  @override
  String get settings => 'Настройки';

  @override
  String get netBalance => 'Чистый баланс';

  @override
  String get recentTransactions => 'Последние транзакции';

  @override
  String get income => 'Доходы';

  @override
  String get expense => 'Расходы';

  @override
  String get save => 'Сохранить';

  @override
  String get amount => 'Сумма';

  @override
  String get note => 'Заметка';

  @override
  String get date => 'Дата';

  @override
  String goodMorning(String userName) {
    return 'Доброе утро, $userName 👋';
  }

  @override
  String goodAfternoon(String userName) {
    return 'Добрый день, $userName 👋';
  }

  @override
  String goodEvening(String userName) {
    return 'Добрый вечер, $userName 👋';
  }

  @override
  String get last6Months => 'Последние 6 месяцев';

  @override
  String get incomeVsExpense => 'Доходы и расходы';

  @override
  String get thisMonth => 'В этом месяце';

  @override
  String get seeAll => 'Посмотреть все';

  @override
  String get noTransactionsYet => 'Нет транзакций';

  @override
  String get tapPlusToAdd =>
      'Нажмите кнопку +, чтобы добавить свой первый расход или доход';

  @override
  String get noChartDataYet => 'Нет данных для графика';

  @override
  String get pleaseEnterAmountAndCategory =>
      'Пожалуйста, введите сумму и выберите категорию';

  @override
  String get pleaseEnterAmountAndSource =>
      'Пожалуйста, введите сумму и выберите источник';

  @override
  String get pleaseEnterValidAmount => 'Пожалуйста, введите корректную сумму';

  @override
  String get expenseAdded => 'Расход добавлен!';

  @override
  String get incomeAdded => 'Доход добавлен!';

  @override
  String get category => 'Категория';

  @override
  String get incomeSource => 'Источник дохода';

  @override
  String get couldNotLoadCategories => 'Не удалось загрузить категории';

  @override
  String get noteOptional => 'Заметка (необязательно)';

  @override
  String get saveExpense => 'Сохранить расход';

  @override
  String get saveIncome => 'Сохранить доход';

  @override
  String get personNameAndAmountRequired =>
      'Имя человека и сумма обязательны для заполнения';

  @override
  String get recordAdded => 'Запись добавлена!';

  @override
  String get addBorrowLend => 'Добавить долг';

  @override
  String get iLent => '↗ Я одолжил(а)';

  @override
  String get iBorrowed => '↙ Я занял(а)';

  @override
  String get amountLent => 'Сумма долга';

  @override
  String get amountBorrowed => 'Сумма займа';

  @override
  String get lentToPerson => 'Одолжено (Имя человека)';

  @override
  String get borrowedFromPerson => 'Занято у (Имя человека)';

  @override
  String get dueDateOptional => 'Срок оплаты (необязательно)';

  @override
  String get tapToSetDueDate => 'Нажмите, чтобы установить срок';

  @override
  String get saveLendRecord => 'Сохранить запись о долге';

  @override
  String get saveBorrowRecord => 'Сохранить запись о займе';

  @override
  String get noMoneyLentYet => 'Вы еще никому не одалживали деньги';

  @override
  String get noBorrowedMoney => 'Вы еще ни у кого не занимали деньги';

  @override
  String get addLentRecords =>
      'Добавляйте записи о деньгах, которые вы одолжили другим';

  @override
  String get addBorrowedRecords =>
      'Добавляйте записи о деньгах, которые вы заняли у других';

  @override
  String get addRecord => 'Добавить запись';

  @override
  String get paid => 'Оплачено';

  @override
  String get overdue => 'Просрочено';

  @override
  String get pending => 'Ожидает';

  @override
  String get due => 'Срок';

  @override
  String get markPaid => 'Отметить оплаченным';

  @override
  String get searchTransactions => 'Поиск транзакций...';

  @override
  String get all => 'Все';

  @override
  String get noTransactionsFound => 'Транзакции не найдены';

  @override
  String get adjustFilterOrSearch =>
      'Попробуйте изменить фильтр или поисковый запрос';

  @override
  String get deleteTransaction => 'Удалить транзакцию';

  @override
  String get areYouSure => 'Вы уверены?';

  @override
  String get areYouSureDeleteTxn =>
      'Вы действительно хотите удалить эту транзакцию?';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get noRemindersYet => 'Нет напоминаний';

  @override
  String get addRemindersHelp =>
      'Добавьте напоминания о платежах, и мы сообщим вам, когда подойдет срок';

  @override
  String get addReminder => 'Добавить напоминание';

  @override
  String get deleteReminder => 'Удалить напоминание';

  @override
  String get overdueTag => 'ПРОСРОЧЕНО';

  @override
  String get todayTag => 'СЕГОДНЯ';

  @override
  String get done => 'Готово';

  @override
  String get pleaseEnterTitle => 'Пожалуйста, введите название';

  @override
  String get newReminder => 'Новое напоминание';

  @override
  String get reminderTitle => 'Название напоминания';

  @override
  String get amountOptional => 'Сумма (необязательно)';

  @override
  String get dueDate => 'Срок оплаты';

  @override
  String get saveReminder => 'Сохранить напоминание';

  @override
  String get welcomeTitle => 'Добро пожаловать в\nMoney Buddy';

  @override
  String get welcomeSubtitle =>
      'Ваш личный финансовый помощник. Отслеживайте доходы, расходы и контролируйте свой бюджет.';

  @override
  String get fastEntryTitle => 'Отслеживайте расходы без усилий.';

  @override
  String get fastEntrySubtitle =>
      'Записывайте траты менее чем за 5 секунд. Просто для новичков, функционально для профессионалов.';

  @override
  String get voiceEntryTitle => 'Голосовой ввод расходов.';

  @override
  String get voiceEntrySubtitle =>
      'Просто скажите: «Потратил 200 на еду», и мы сделаем все остальное. Удобный контроль финансов.';

  @override
  String get borrowLendTitle => 'Никогда не теряйте из виду долги.';

  @override
  String get borrowLendSubtitle =>
      'Отслеживайте, кому вы одолжили деньги и сколько должны вам. Получайте уведомления о приближении сроков.';

  @override
  String get getStarted => 'Начать';

  @override
  String get next => 'Далее';

  @override
  String get skip => 'ПРОПУСТИТЬ';

  @override
  String get appleSignInComingSoon => 'Вход через Apple будет доступен скоро';

  @override
  String get welcomeBack => 'С возвращением';

  @override
  String get signIn => 'Войти';

  @override
  String get continuePreferredAccount =>
      'Продолжить с помощью удобного аккаунта';

  @override
  String get continueGoogle => 'Войти через Google';

  @override
  String get continueApple => 'Войти через Apple';

  @override
  String get continueEmail => 'Войти через Email';

  @override
  String get signUp => 'Зарегистрироваться';

  @override
  String get email => 'Электронная почта';

  @override
  String get validEmailRequired => 'Требуется корректный адрес эл. почты';

  @override
  String get password => 'Пароль';

  @override
  String get passwordLengthHelp =>
      'Пароль должен состоять минимум из 6 символов';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт? Войти';

  @override
  String get dontHaveAccount => 'Нет аккаунта? Зарегистрироваться';

  @override
  String get home => 'Главная';

  @override
  String get history => 'История';

  @override
  String get borrowTab => 'Долги';

  @override
  String get addNew => 'Добавить';

  @override
  String get recordMoneySpent => 'Записать потраченные деньги';

  @override
  String get recordMoneyReceived => 'Записать полученные деньги';

  @override
  String get trackWhoOwesWhom => 'Отслеживать взаимные долги';

  @override
  String get languageCountry => 'Язык / Страна';

  @override
  String get searchLanguages => 'Поиск языков...';

  @override
  String get noLanguagesFound => 'Языки не найдены.';

  @override
  String get currencyCountry => 'Символ валюты / Страна';

  @override
  String get searchCurrencies => 'Поиск валют или стран...';

  @override
  String get noCurrenciesFound => 'Валюты не найдены.';

  @override
  String get account => 'Аккаунт';

  @override
  String get logout => 'Выйти';

  @override
  String get deleteAccountConfirm =>
      'Вы уверены, что хотите навсегда удалить свой аккаунт? Это действие нельзя отменить, и все ваши данные будут безвозвратно удалены.';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get lentTab => 'Одолжено';

  @override
  String get borrowedTab => 'Занято';

  @override
  String get transactionHistory => 'История транзакций';

  @override
  String get netBalanceThisMonth => 'Чистый баланс за этот месяц';

  @override
  String get tagGetStarted => 'НАЧАТЬ';

  @override
  String get tagFastEntry => 'БЫСТРЫЙ ВВОД';

  @override
  String get tagVoiceEntry => 'ГОЛОСОВОЙ ВВОД';

  @override
  String get tagBorrowLend => 'ДОЛГИ';

  @override
  String get resetData => 'Сбросить данные приложения';

  @override
  String get resetDataConfirm =>
      'Вы уверены, что хотите удалить все транзакции, записи о займах и напоминания? Это действие нельзя отменить.';

  @override
  String get reset => 'Сбросить';

  @override
  String get resetSuccessful => 'Все данные приложения успешно сброшены.';

  @override
  String get selectLanguage => 'Выбрать язык';

  @override
  String get selectCurrency => 'Выбрать валюту';

  @override
  String get profile => 'Профиль';

  @override
  String get guest => 'Гость';
}
