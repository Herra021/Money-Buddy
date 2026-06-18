// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Money Buddy';

  @override
  String get dashboard => 'Tableau de bord';

  @override
  String get transactions => 'Transactions';

  @override
  String get addExpense => 'Ajouter une dépense';

  @override
  String get addIncome => 'Ajouter un revenu';

  @override
  String get borrowLend => 'Emprunts/Prêts';

  @override
  String get reminders => 'Rappels';

  @override
  String get settings => 'Paramètres';

  @override
  String get netBalance => 'Solde net';

  @override
  String get recentTransactions => 'Transactions récentes';

  @override
  String get income => 'Revenu';

  @override
  String get expense => 'Dépense';

  @override
  String get save => 'Enregistrer';

  @override
  String get amount => 'Montant';

  @override
  String get note => 'Note';

  @override
  String get date => 'Date';

  @override
  String goodMorning(String userName) {
    return 'Bon matin, $userName 👋';
  }

  @override
  String goodAfternoon(String userName) {
    return 'Bon après-midi, $userName 👋';
  }

  @override
  String goodEvening(String userName) {
    return 'Bonsoir, $userName 👋';
  }

  @override
  String get last6Months => '6 derniers mois';

  @override
  String get incomeVsExpense => 'Revenus vs Dépenses';

  @override
  String get thisMonth => 'Ce mois-ci';

  @override
  String get seeAll => 'Voir tout';

  @override
  String get noTransactionsYet => 'Aucune transaction pour le moment';

  @override
  String get tapPlusToAdd =>
      'Appuyez sur le bouton + pour ajouter votre premier revenu ou dépense';

  @override
  String get noChartDataYet => 'Aucune donnée de graphique pour le moment';

  @override
  String get pleaseEnterAmountAndCategory =>
      'Veuillez entrer un montant et sélectionner une catégorie';

  @override
  String get pleaseEnterAmountAndSource =>
      'Veuillez entrer un montant et sélectionner une source';

  @override
  String get pleaseEnterValidAmount => 'Veuillez entrer un montant valide';

  @override
  String get expenseAdded => 'Dépense ajoutée !';

  @override
  String get incomeAdded => 'Revenu ajouté !';

  @override
  String get category => 'Catégorie';

  @override
  String get incomeSource => 'Source de revenu';

  @override
  String get couldNotLoadCategories => 'Impossible de charger les catégories';

  @override
  String get noteOptional => 'Note (facultatif)';

  @override
  String get saveExpense => 'Enregistrer la dépense';

  @override
  String get saveIncome => 'Enregistrer le revenu';

  @override
  String get personNameAndAmountRequired =>
      'Le nom de la personne et le montant sont requis';

  @override
  String get recordAdded => 'Enregistrement ajouté !';

  @override
  String get addBorrowLend => 'Ajouter Emprunt / Prêt';

  @override
  String get iLent => '↗ J\'ai prêté';

  @override
  String get iBorrowed => '↙ J\'ai emprunté';

  @override
  String get amountLent => 'Montant prêté';

  @override
  String get amountBorrowed => 'Montant emprunté';

  @override
  String get lentToPerson => 'Prêté à (Nom de la personne)';

  @override
  String get borrowedFromPerson => 'Emprunté à (Nom de la personne)';

  @override
  String get dueDateOptional => 'Date d\'échéance (facultatif)';

  @override
  String get tapToSetDueDate => 'Appuyer pour définir l\'échéance';

  @override
  String get saveLendRecord => 'Enregistrer le prêt';

  @override
  String get saveBorrowRecord => 'Enregistrer l\'emprunt';

  @override
  String get noMoneyLentYet => 'Aucun argent prêté pour le moment';

  @override
  String get noBorrowedMoney => 'Aucun argent emprunté';

  @override
  String get addLentRecords =>
      'Ajoutez des enregistrements de l\'argent que vous avez prêté aux autres';

  @override
  String get addBorrowedRecords =>
      'Ajoutez des enregistrements de l\'argent que vous avez emprunté aux autres';

  @override
  String get addRecord => 'Ajouter un enregistrement';

  @override
  String get paid => 'Payé';

  @override
  String get overdue => 'En retard';

  @override
  String get pending => 'En attente';

  @override
  String get due => 'Dû';

  @override
  String get markPaid => 'Marquer comme payé';

  @override
  String get searchTransactions => 'Rechercher des transactions...';

  @override
  String get all => 'Tout';

  @override
  String get noTransactionsFound => 'Aucune transaction trouvée';

  @override
  String get adjustFilterOrSearch =>
      'Essayez d\'ajuster votre filtre ou requête';

  @override
  String get deleteTransaction => 'Supprimer la transaction';

  @override
  String get areYouSure => 'Êtes-vous sûr ?';

  @override
  String get areYouSureDeleteTxn =>
      'Voulez-vous vraiment supprimer cette transaction ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get noRemindersYet => 'Aucun rappel pour le moment';

  @override
  String get addRemindersHelp =>
      'Ajoutez des rappels de paiement et nous vous informerons à l\'échéance';

  @override
  String get addReminder => 'Ajouter un rappel';

  @override
  String get deleteReminder => 'Supprimer le rappel';

  @override
  String get overdueTag => 'EN RETARD';

  @override
  String get todayTag => 'AUJOURD\'HUI';

  @override
  String get done => 'Terminé';

  @override
  String get pleaseEnterTitle => 'Veuillez entrer un titre';

  @override
  String get newReminder => 'Nouveau rappel';

  @override
  String get reminderTitle => 'Titre du rappel';

  @override
  String get amountOptional => 'Montant (facultatif)';

  @override
  String get dueDate => 'Date d\'échéance';

  @override
  String get saveReminder => 'Enregistrer le rappel';

  @override
  String get welcomeTitle => 'Bienvenue sur\nMoney Buddy';

  @override
  String get welcomeSubtitle =>
      'Votre compagnon financier personnel. Suivez vos revenus, vos dépenses et prenez le contrôle de votre argent.';

  @override
  String get fastEntryTitle => 'Suivez chaque dépense sans effort.';

  @override
  String get fastEntrySubtitle =>
      'Enregistrez vos dépenses en moins de 5 secondes. Simple pour les débutants, puissant pour les experts.';

  @override
  String get voiceEntryTitle => 'Enregistrez vos dépenses par la voix.';

  @override
  String get voiceEntrySubtitle =>
      'Dites simplement « Dépensé 200 pour la nourriture » et nous ferons le reste. Suivi financier mains libres.';

  @override
  String get borrowLendTitle => 'Ne perdez jamais la trace des dettes.';

  @override
  String get borrowLendSubtitle =>
      'Suivez à qui vous avez prêté de l\'argent et qui vous doit. Recevez des notifications à l\'échéance.';

  @override
  String get getStarted => 'Commencer';

  @override
  String get next => 'Suivant';

  @override
  String get skip => 'PASSER';

  @override
  String get appleSignInComingSoon => 'Connexion Apple bientôt disponible';

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get signIn => 'Se connecter';

  @override
  String get continuePreferredAccount => 'Continuer avec votre compte préféré';

  @override
  String get continueGoogle => 'Continuer avec Google';

  @override
  String get continueApple => 'Continuer avec Apple';

  @override
  String get continueEmail => 'Continuer avec l\'e-mail';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get email => 'E-mail';

  @override
  String get validEmailRequired => 'E-mail valide requis';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordLengthHelp =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ? Se connecter';

  @override
  String get dontHaveAccount => 'Vous n\'avez pas de compte ? S\'inscrire';

  @override
  String get home => 'Accueil';

  @override
  String get history => 'Historique';

  @override
  String get borrowTab => 'Emprunter';

  @override
  String get addNew => 'Ajouter';

  @override
  String get recordMoneySpent => 'Enregistrer l\'argent dépensé';

  @override
  String get recordMoneyReceived => 'Enregistrer l\'argent reçu';

  @override
  String get trackWhoOwesWhom => 'Suivre qui doit à qui';

  @override
  String get languageCountry => 'Langue / Pays';

  @override
  String get searchLanguages => 'Rechercher des langues...';

  @override
  String get noLanguagesFound => 'Aucune langue trouvée.';

  @override
  String get currencyCountry => 'Symbole de devise / Pays';

  @override
  String get searchCurrencies => 'Rechercher des devises ou pays...';

  @override
  String get noCurrenciesFound => 'Aucune devise trouvée.';

  @override
  String get account => 'Compte';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get deleteAccountConfirm =>
      'Êtes-vous sûr de vouloir supprimer définitivement votre compte ? Cette action est irréversible et toutes vos données seront perdues.';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get lentTab => 'Prêté';

  @override
  String get borrowedTab => 'Emprunté';

  @override
  String get transactionHistory => 'Historique des transactions';

  @override
  String get netBalanceThisMonth => 'Solde net ce mois-ci';

  @override
  String get tagGetStarted => 'COMMENCER';

  @override
  String get tagFastEntry => 'SAISIE RAPIDE';

  @override
  String get tagVoiceEntry => 'SAISIE VOCALE';

  @override
  String get tagBorrowLend => 'EMPRUNTER & PRÊTER';
}
