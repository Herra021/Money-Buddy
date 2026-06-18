// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Money Buddy';

  @override
  String get dashboard => 'Bacheca';

  @override
  String get transactions => 'Transazioni';

  @override
  String get addExpense => 'Aggiungi Spesa';

  @override
  String get addIncome => 'Aggiungi Entrata';

  @override
  String get borrowLend => 'Prestiti/Debiti';

  @override
  String get reminders => 'Promemoria';

  @override
  String get settings => 'Impostazioni';

  @override
  String get netBalance => 'Saldo Netto';

  @override
  String get recentTransactions => 'Transazioni Recenti';

  @override
  String get income => 'Entrate';

  @override
  String get expense => 'Spese';

  @override
  String get save => 'Salva';

  @override
  String get amount => 'Importo';

  @override
  String get note => 'Nota';

  @override
  String get date => 'Data';

  @override
  String goodMorning(String userName) {
    return 'Buongiorno, $userName 👋';
  }

  @override
  String goodAfternoon(String userName) {
    return 'Buon pomeriggio, $userName 👋';
  }

  @override
  String goodEvening(String userName) {
    return 'Buonasera, $userName 👋';
  }

  @override
  String get last6Months => 'Ultimi 6 Mesi';

  @override
  String get incomeVsExpense => 'Entrate vs Spese';

  @override
  String get thisMonth => 'Questo mese';

  @override
  String get seeAll => 'Vedi Tutti';

  @override
  String get noTransactionsYet => 'Nessuna transazione ancora';

  @override
  String get tapPlusToAdd =>
      'Tocca il pulsante + per aggiungere la tua prima entrata o spesa';

  @override
  String get noChartDataYet => 'Nessun dato del grafico ancora';

  @override
  String get pleaseEnterAmountAndCategory =>
      'Inserisci un importo e seleziona una categoria';

  @override
  String get pleaseEnterAmountAndSource =>
      'Inserisci un importo e seleziona una fonte';

  @override
  String get pleaseEnterValidAmount => 'Inserisci un importo valido';

  @override
  String get expenseAdded => 'Spesa aggiunta!';

  @override
  String get incomeAdded => 'Entrata aggiunta!';

  @override
  String get category => 'Categoria';

  @override
  String get incomeSource => 'Fonte di Entrata';

  @override
  String get couldNotLoadCategories => 'Impossibile caricare le categorie';

  @override
  String get noteOptional => 'Nota (facoltativa)';

  @override
  String get saveExpense => 'Salva Spesa';

  @override
  String get saveIncome => 'Salva Entrata';

  @override
  String get personNameAndAmountRequired =>
      'Il nome della persona e l\'importo sono obbligatori';

  @override
  String get recordAdded => 'Record aggiunto!';

  @override
  String get addBorrowLend => 'Aggiungi Prestito / Debito';

  @override
  String get iLent => '↗ Ho Prestato';

  @override
  String get iBorrowed => '↙ Ho Preso in Prestito';

  @override
  String get amountLent => 'Importo Prestato';

  @override
  String get amountBorrowed => 'Importo Preso in Prestito';

  @override
  String get lentToPerson => 'Prestato a (Nome persona)';

  @override
  String get borrowedFromPerson => 'Preso in prestito da (Nome persona)';

  @override
  String get dueDateOptional => 'Data di scadenza (facoltativa)';

  @override
  String get tapToSetDueDate => 'Tocca per impostare la scadenza';

  @override
  String get saveLendRecord => 'Salva Record Prestito';

  @override
  String get saveBorrowRecord => 'Salva Record Debito';

  @override
  String get noMoneyLentYet => 'Nessun denaro prestato ancora';

  @override
  String get noBorrowedMoney => 'Nessun denaro preso in prestito';

  @override
  String get addLentRecords =>
      'Aggiungi record di denaro che hai prestato ad altri';

  @override
  String get addBorrowedRecords =>
      'Aggiungi record di denaro che hai preso in prestito';

  @override
  String get addRecord => 'Aggiungi Record';

  @override
  String get paid => 'Pagato';

  @override
  String get overdue => 'Scaduto';

  @override
  String get pending => 'In attesa';

  @override
  String get due => 'Scade il';

  @override
  String get markPaid => 'Segna come Pagato';

  @override
  String get searchTransactions => 'Cerca transazioni...';

  @override
  String get all => 'Tutti';

  @override
  String get noTransactionsFound => 'Nessuna transazione trovata';

  @override
  String get adjustFilterOrSearch => 'Prova a regolare il filtro o la ricerca';

  @override
  String get deleteTransaction => 'Elimina Transazione';

  @override
  String get areYouSure => 'Sei sicuro?';

  @override
  String get areYouSureDeleteTxn =>
      'Sei sicuro di voler eliminare questa transazione?';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get noRemindersYet => 'Nessun promemoria ancora';

  @override
  String get addRemindersHelp =>
      'Aggiungi promemoria di pagamento e ti avviseremo alla scadenza';

  @override
  String get addReminder => 'Aggiungi Promemoria';

  @override
  String get deleteReminder => 'Elimina Promemoria';

  @override
  String get overdueTag => 'SCADUTO';

  @override
  String get todayTag => 'OGGI';

  @override
  String get done => 'Fatto';

  @override
  String get pleaseEnterTitle => 'Inserisci un titolo';

  @override
  String get newReminder => 'Nuovo Promemoria';

  @override
  String get reminderTitle => 'Titolo Promemoria';

  @override
  String get amountOptional => 'Importo (facoltativo)';

  @override
  String get dueDate => 'Data di Scadenza';

  @override
  String get saveReminder => 'Salva Promemoria';

  @override
  String get welcomeTitle => 'Benvenuto in\nMoney Buddy';

  @override
  String get welcomeSubtitle =>
      'Il tuo compagno per le finanze personali. Traccia entrate, spese e prendi il controllo del tuo denaro.';

  @override
  String get fastEntryTitle => 'Traccia ogni spesa senza sforzo.';

  @override
  String get fastEntrySubtitle =>
      'Registra le spese in meno di 5 secondi. Semplice per i principianti, potente per gli esperti.';

  @override
  String get voiceEntryTitle => 'Registra le spese con la voce.';

  @override
  String get voiceEntrySubtitle =>
      'Basta dire \'Speso 200 per cibo\' e noi faremo il resto. Tracciamento finanziario a mani libere.';

  @override
  String get borrowLendTitle => 'Non perdere mai traccia dei debiti.';

  @override
  String get borrowLendSubtitle =>
      'Traccia a chi hai prestato denaro e chi ti deve. Ricevi notifiche all\'avvicinarsi delle scadenze.';

  @override
  String get getStarted => 'Inizia';

  @override
  String get next => 'Avanti';

  @override
  String get skip => 'SALTA';

  @override
  String get appleSignInComingSoon => 'Accedi con Apple in arrivo';

  @override
  String get welcomeBack => 'Bentornato';

  @override
  String get signIn => 'Accedi';

  @override
  String get continuePreferredAccount =>
      'Continua con il tuo account preferito';

  @override
  String get continueGoogle => 'Continua con Google';

  @override
  String get continueApple => 'Continua con Apple';

  @override
  String get continueEmail => 'Continua con Email';

  @override
  String get signUp => 'Registrati';

  @override
  String get email => 'Email';

  @override
  String get validEmailRequired => 'Email valida richiesta';

  @override
  String get password => 'Password';

  @override
  String get passwordLengthHelp =>
      'La password deve contenere almeno 6 caratteri';

  @override
  String get createAccount => 'Crea Account';

  @override
  String get alreadyHaveAccount => 'Hai già un account? Accedi';

  @override
  String get dontHaveAccount => 'Non hai un account? Registrati';

  @override
  String get home => 'Home';

  @override
  String get history => 'Cronologia';

  @override
  String get borrowTab => 'Prestiti';

  @override
  String get addNew => 'Aggiungi Nuovo';

  @override
  String get recordMoneySpent => 'Registra denaro speso';

  @override
  String get recordMoneyReceived => 'Registra denaro ricevuto';

  @override
  String get trackWhoOwesWhom => 'Traccia chi deve a chi';

  @override
  String get languageCountry => 'Lingua / Paese';

  @override
  String get searchLanguages => 'Cerca lingue...';

  @override
  String get noLanguagesFound => 'Nessuna lingua trovata.';

  @override
  String get currencyCountry => 'Simbolo Valuta / Paese';

  @override
  String get searchCurrencies => 'Cerca valute o paesi...';

  @override
  String get noCurrenciesFound => 'Nessuna valuta trovata.';

  @override
  String get account => 'Account';

  @override
  String get logout => 'Disconnetti';

  @override
  String get deleteAccountConfirm =>
      'Sei sicuro di voler eliminare definitivamente il tuo account? Questa azione non può essere annullata e tutti i tuoi dati andranno persi.';

  @override
  String get deleteAccount => 'Elimina account';

  @override
  String get lentTab => 'Prestato';

  @override
  String get borrowedTab => 'Preso in prestito';

  @override
  String get transactionHistory => 'Cronologia transazioni';

  @override
  String get netBalanceThisMonth => 'Saldo netto di questo mese';

  @override
  String get tagGetStarted => 'INIZIA';

  @override
  String get tagFastEntry => 'INSERIMENTO RAPIDO';

  @override
  String get tagVoiceEntry => 'INSERIMENTO VOCALE';

  @override
  String get tagBorrowLend => 'PRESTITI E DEBITI';

  @override
  String get resetData => 'Reimposta dati applicazione';

  @override
  String get resetDataConfirm =>
      'Sei sicuro di voler eliminare tutte le transazioni, i record di prestito/debito e i promemoria? Questa azione non può essere annullata.';

  @override
  String get reset => 'Reimposta';

  @override
  String get resetSuccessful =>
      'Tutti i dati dell\'applicazione sono stati reimpostati con successo.';

  @override
  String get selectLanguage => 'Seleziona lingua';

  @override
  String get selectCurrency => 'Seleziona valuta';

  @override
  String get profile => 'Profilo';

  @override
  String get guest => 'Ospite';
}
