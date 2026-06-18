// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Money Buddy';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get transactions => 'Transaktionen';

  @override
  String get addExpense => 'Ausgabe hinzufügen';

  @override
  String get addIncome => 'Einnahme hinzufügen';

  @override
  String get borrowLend => 'Leihen/Verleihen';

  @override
  String get reminders => 'Erinnerungen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get netBalance => 'Nettosaldo';

  @override
  String get recentTransactions => 'Letzte Transaktionen';

  @override
  String get income => 'Einnahmen';

  @override
  String get expense => 'Ausgaben';

  @override
  String get save => 'Speichern';

  @override
  String get amount => 'Betrag';

  @override
  String get note => 'Notiz';

  @override
  String get date => 'Datum';

  @override
  String goodMorning(String userName) {
    return 'Guten Morgen, $userName 👋';
  }

  @override
  String goodAfternoon(String userName) {
    return 'Guten Tag, $userName 👋';
  }

  @override
  String goodEvening(String userName) {
    return 'Guten Abend, $userName 👋';
  }

  @override
  String get last6Months => 'Letzte 6 Monate';

  @override
  String get incomeVsExpense => 'Einnahmen vs. Ausgaben';

  @override
  String get thisMonth => 'Diesen Monat';

  @override
  String get seeAll => 'Alle ansehen';

  @override
  String get noTransactionsYet => 'Noch keine Transaktionen';

  @override
  String get tapPlusToAdd =>
      'Tippe auf das Plus-Symbol, um deine erste Einnahme oder Ausgabe hinzuzufügen';

  @override
  String get noChartDataYet => 'Noch keine Diagrammdaten';

  @override
  String get pleaseEnterAmountAndCategory =>
      'Bitte Betrag eingeben und Kategorie auswählen';

  @override
  String get pleaseEnterAmountAndSource =>
      'Bitte Betrag eingeben und Quelle auswählen';

  @override
  String get pleaseEnterValidAmount => 'Bitte einen gültigen Betrag eingeben';

  @override
  String get expenseAdded => 'Ausgabe hinzugefügt!';

  @override
  String get incomeAdded => 'Einnahme hinzugefügt!';

  @override
  String get category => 'Kategorie';

  @override
  String get incomeSource => 'Einnahmequelle';

  @override
  String get couldNotLoadCategories =>
      'Kategorien konnten nicht geladen werden';

  @override
  String get noteOptional => 'Notiz (optional)';

  @override
  String get saveExpense => 'Ausgabe speichern';

  @override
  String get saveIncome => 'Einnahme speichern';

  @override
  String get personNameAndAmountRequired => 'Name und Betrag sind erforderlich';

  @override
  String get recordAdded => 'Eintrag hinzugefügt!';

  @override
  String get addBorrowLend => 'Leihen / Verleihen hinzufügen';

  @override
  String get iLent => '↗ Ich habe geliehen';

  @override
  String get iBorrowed => '↙ Ich habe geborgt';

  @override
  String get amountLent => 'Geliehener Betrag';

  @override
  String get amountBorrowed => 'Geborgter Betrag';

  @override
  String get lentToPerson => 'Geliehen an (Name)';

  @override
  String get borrowedFromPerson => 'Geborgt von (Name)';

  @override
  String get dueDateOptional => 'Fälligkeitsdatum (optional)';

  @override
  String get tapToSetDueDate => 'Fälligkeitsdatum festlegen';

  @override
  String get saveLendRecord => 'Verleih-Eintrag speichern';

  @override
  String get saveBorrowRecord => 'Leih-Eintrag speichern';

  @override
  String get noMoneyLentYet => 'Noch kein Geld verliehen';

  @override
  String get noBorrowedMoney => 'Kein Geld geborgt';

  @override
  String get addLentRecords =>
      'Füge Einträge für Geld hinzu, das du anderen geliehen hast';

  @override
  String get addBorrowedRecords =>
      'Füge Einträge für Geld hinzu, das du dir von anderen geborgt hast';

  @override
  String get addRecord => 'Eintrag hinzufügen';

  @override
  String get paid => 'Bezahlt';

  @override
  String get overdue => 'Überfällig';

  @override
  String get pending => 'Ausstehend';

  @override
  String get due => 'Fällig';

  @override
  String get markPaid => 'Als bezahlt markieren';

  @override
  String get searchTransactions => 'Transaktionen suchen...';

  @override
  String get all => 'Alle';

  @override
  String get noTransactionsFound => 'Keine Transaktionen gefunden';

  @override
  String get adjustFilterOrSearch => 'Passe deinen Filter oder Suchbegriff an';

  @override
  String get deleteTransaction => 'Transaktion löschen';

  @override
  String get areYouSure => 'Bist du sicher?';

  @override
  String get areYouSureDeleteTxn =>
      'Möchtest du diese Transaktion wirklich löschen?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get noRemindersYet => 'Noch keine Erinnerungen';

  @override
  String get addRemindersHelp =>
      'Zahlungserinnerungen hinzufügen und wir benachrichtigen dich bei Fälligkeit';

  @override
  String get addReminder => 'Erinnerung hinzufügen';

  @override
  String get deleteReminder => 'Erinnerung löschen';

  @override
  String get overdueTag => 'ÜBERFÄLLIG';

  @override
  String get todayTag => 'HEUTE';

  @override
  String get done => 'Fertig';

  @override
  String get pleaseEnterTitle => 'Bitte einen Titel eingeben';

  @override
  String get newReminder => 'Neue Erinnerung';

  @override
  String get reminderTitle => 'Titel der Erinnerung';

  @override
  String get amountOptional => 'Betrag (optional)';

  @override
  String get dueDate => 'Fälligkeitsdatum';

  @override
  String get saveReminder => 'Erinnerung speichern';

  @override
  String get welcomeTitle => 'Willkommen bei\nMoney Buddy';

  @override
  String get welcomeSubtitle =>
      'Dein persönlicher Finanzbegleiter. Verfolge Einnahmen, Ausgaben und behalte die Kontrolle über dein Geld.';

  @override
  String get fastEntryTitle => 'Ausgaben mühelos verfolgen.';

  @override
  String get fastEntrySubtitle =>
      'Erfasse Ausgaben in unter 5 Sekunden. Einfach für Anfänger, mächtig für Experten.';

  @override
  String get voiceEntryTitle => 'Ausgaben per Sprache protokollieren.';

  @override
  String get voiceEntrySubtitle =>
      'Sage einfach \"200 für Essen ausgegeben\" und wir erledigen den Rest. Freihändige Finanzverwaltung.';

  @override
  String get borrowLendTitle => 'Nie den Überblick über Schulden verlieren.';

  @override
  String get borrowLendSubtitle =>
      'Verfolge, wem du Geld geliehen hast und wer dir Geld schuldet. Erhalte Benachrichtigungen bei Fälligkeit.';

  @override
  String get getStarted => 'Loslegen';

  @override
  String get next => 'Weiter';

  @override
  String get skip => 'ÜBERSPRINGEN';

  @override
  String get appleSignInComingSoon => 'Apple Sign-In demnächst verfügbar';

  @override
  String get welcomeBack => 'Willkommen zurück';

  @override
  String get signIn => 'Einloggen';

  @override
  String get continuePreferredAccount => 'Mit bevorzugtem Konto fortfahren';

  @override
  String get continueGoogle => 'Mit Google fortfahren';

  @override
  String get continueApple => 'Mit Apple fortfahren';

  @override
  String get continueEmail => 'Mit E-Mail fortfahren';

  @override
  String get signUp => 'Registrieren';

  @override
  String get email => 'E-Mail';

  @override
  String get validEmailRequired => 'Gültige E-Mail erforderlich';

  @override
  String get password => 'Passwort';

  @override
  String get passwordLengthHelp =>
      'Das Passwort muss mindestens 6 Zeichen lang sein';

  @override
  String get createAccount => 'Konto erstellen';

  @override
  String get alreadyHaveAccount => 'Bereits ein Konto? Einloggen';

  @override
  String get dontHaveAccount => 'Noch kein Konto? Registrieren';

  @override
  String get home => 'Startseite';

  @override
  String get history => 'Verlauf';

  @override
  String get borrowTab => 'Borgen';

  @override
  String get addNew => 'Neu hinzufügen';

  @override
  String get recordMoneySpent => 'Ausgaben erfassen';

  @override
  String get recordMoneyReceived => 'Einnahmen erfassen';

  @override
  String get trackWhoOwesWhom => 'Verfolgen, wer wem schuldet';

  @override
  String get languageCountry => 'Sprache / Land';

  @override
  String get searchLanguages => 'Sprachen suchen...';

  @override
  String get noLanguagesFound => 'Keine Sprachen gefunden.';

  @override
  String get currencyCountry => 'Währungssymbol / Land';

  @override
  String get searchCurrencies => 'Währungen oder Länder suchen...';

  @override
  String get noCurrenciesFound => 'Keine Währungen gefunden.';

  @override
  String get account => 'Konto';

  @override
  String get logout => 'Abmelden';

  @override
  String get deleteAccountConfirm =>
      'Bist du sicher, dass du dein Konto dauerhaft löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden und alle deine Daten gehen verloren.';

  @override
  String get deleteAccount => 'Konto löschen';

  @override
  String get lentTab => 'Verliehen';

  @override
  String get borrowedTab => 'Geliehen';

  @override
  String get transactionHistory => 'Transaktionsverlauf';

  @override
  String get netBalanceThisMonth => 'Nettosaldo in diesem Monat';

  @override
  String get tagGetStarted => 'LOSLEGEN';

  @override
  String get tagFastEntry => 'SCHNELLEINGABE';

  @override
  String get tagVoiceEntry => 'SPRACHEINGABE';

  @override
  String get tagBorrowLend => 'LEIHEN & VERLEIHEN';

  @override
  String get resetData => 'App-Daten zurücksetzen';

  @override
  String get resetDataConfirm =>
      'Sind Sie sicher, dass Sie alle Transaktionen, Leih-/Ausleihdatensätze und Erinnerungen löschen möchten? Dies kann nicht rückgängig gemacht werden.';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get resetSuccessful =>
      'Alle App-Daten wurden erfolgreich zurückgesetzt.';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get selectCurrency => 'Währung auswählen';

  @override
  String get profile => 'Profil';

  @override
  String get guest => 'Gast';
}
