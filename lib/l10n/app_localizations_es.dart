// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Money Buddy';

  @override
  String get dashboard => 'Tablero';

  @override
  String get transactions => 'Transacciones';

  @override
  String get addExpense => 'Añadir Gasto';

  @override
  String get addIncome => 'Añadir Ingreso';

  @override
  String get borrowLend => 'Prestar/Pedir';

  @override
  String get reminders => 'Recordatorios';

  @override
  String get settings => 'Configuración';

  @override
  String get netBalance => 'Saldo Neto';

  @override
  String get recentTransactions => 'Transacciones Recientes';

  @override
  String get income => 'Ingreso';

  @override
  String get expense => 'Gasto';

  @override
  String get save => 'Guardar';

  @override
  String get amount => 'Cantidad';

  @override
  String get note => 'Nota';

  @override
  String get date => 'Fecha';

  @override
  String goodMorning(String userName) {
    return 'Buenos Días, $userName 👋';
  }

  @override
  String goodAfternoon(String userName) {
    return 'Buenas Tardes, $userName 👋';
  }

  @override
  String goodEvening(String userName) {
    return 'Buenas Noches, $userName 👋';
  }

  @override
  String get last6Months => 'Últimos 6 Meses';

  @override
  String get incomeVsExpense => 'Ingresos vs Gastos';

  @override
  String get thisMonth => 'Este mes';

  @override
  String get seeAll => 'Ver Todo';

  @override
  String get noTransactionsYet => 'Aún no hay transacciones';

  @override
  String get tapPlusToAdd =>
      'Toca el botón + para añadir tu primer ingreso o gasto';

  @override
  String get noChartDataYet => 'Aún no hay datos de gráfico';

  @override
  String get pleaseEnterAmountAndCategory =>
      'Por favor, introduce una cantidad y selecciona una categoría';

  @override
  String get pleaseEnterAmountAndSource =>
      'Por favor, introduce una cantidad y selecciona una fuente';

  @override
  String get pleaseEnterValidAmount =>
      'Por favor, introduce una cantidad válida';

  @override
  String get expenseAdded => '¡Gasto añadido!';

  @override
  String get incomeAdded => '¡Ingreso añadido!';

  @override
  String get category => 'Categoría';

  @override
  String get incomeSource => 'Fuente de Ingresos';

  @override
  String get couldNotLoadCategories => 'No se pudieron cargar las categorías';

  @override
  String get noteOptional => 'Nota (opcional)';

  @override
  String get saveExpense => 'Guardar Gasto';

  @override
  String get saveIncome => 'Guardar Ingreso';

  @override
  String get personNameAndAmountRequired =>
      'El nombre de la persona y la cantidad son obligatorios';

  @override
  String get recordAdded => '¡Registro añadido!';

  @override
  String get addBorrowLend => 'Añadir Prestado / Prestado';

  @override
  String get iLent => '↗ Presté';

  @override
  String get iBorrowed => '↙ Pedí Prestado';

  @override
  String get amountLent => 'Cantidad Prestada';

  @override
  String get amountBorrowed => 'Cantidad Prestada';

  @override
  String get lentToPerson => 'Prestado a (Nombre de persona)';

  @override
  String get borrowedFromPerson => 'Prestado por (Nombre de persona)';

  @override
  String get dueDateOptional => 'Fecha de vencimiento (opcional)';

  @override
  String get tapToSetDueDate => 'Toca para fijar fecha';

  @override
  String get saveLendRecord => 'Guardar Registro de Préstamo';

  @override
  String get saveBorrowRecord => 'Guardar Registro de Deuda';

  @override
  String get noMoneyLentYet => 'Aún no has prestado dinero';

  @override
  String get noBorrowedMoney => 'No hay dinero prestado';

  @override
  String get addLentRecords =>
      'Añade registros de dinero que has prestado a otros';

  @override
  String get addBorrowedRecords =>
      'Añade registros de dinero que has pedido prestado';

  @override
  String get addRecord => 'Añadir Registro';

  @override
  String get paid => 'Pagado';

  @override
  String get overdue => 'Atrasado';

  @override
  String get pending => 'Pendiente';

  @override
  String get due => 'Vence';

  @override
  String get markPaid => 'Marcar Pagado';

  @override
  String get searchTransactions => 'Buscar transacciones...';

  @override
  String get all => 'Todo';

  @override
  String get noTransactionsFound => 'No se encontraron transacciones';

  @override
  String get adjustFilterOrSearch =>
      'Intenta ajustar tu filtro o consulta de búsqueda';

  @override
  String get deleteTransaction => 'Eliminar Transacción';

  @override
  String get areYouSure => '¿Estás seguro?';

  @override
  String get areYouSureDeleteTxn =>
      '¿Realmente deseas eliminar esta transacción?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get noRemindersYet => 'Aún no hay recordatorios';

  @override
  String get addRemindersHelp =>
      'Añade recordatorios de pago y te notificaremos cuando venzan';

  @override
  String get addReminder => 'Añadir Recordatorio';

  @override
  String get deleteReminder => 'Eliminar Recordatorio';

  @override
  String get overdueTag => 'ATRASADO';

  @override
  String get todayTag => 'HOY';

  @override
  String get done => 'Hecho';

  @override
  String get pleaseEnterTitle => 'Por favor, introduce un título';

  @override
  String get newReminder => 'Nuevo Recordatorio';

  @override
  String get reminderTitle => 'Título del Recordatorio';

  @override
  String get amountOptional => 'Cantidad (opcional)';

  @override
  String get dueDate => 'Fecha de Vencimiento';

  @override
  String get saveReminder => 'Guardar Recordatorio';

  @override
  String get welcomeTitle => 'Bienvenido a\nMoney Buddy';

  @override
  String get welcomeSubtitle =>
      'Tu compañero de finanzas personales. Sigue tus ingresos, gastos y toma el control de tu dinero.';

  @override
  String get fastEntryTitle => 'Sigue cada gasto sin esfuerzo.';

  @override
  String get fastEntrySubtitle =>
      'Registra gastos en menos de 5 segundos. Simple para principiantes, potente para expertos.';

  @override
  String get voiceEntryTitle => 'Registra gastos con tu voz.';

  @override
  String get voiceEntrySubtitle =>
      'Solo di \'Gasté 200 en comida\' y nosotros haremos el resto. Seguimiento de finanzas sin manos.';

  @override
  String get borrowLendTitle => 'Nunca pierdas el control de las deudas.';

  @override
  String get borrowLendSubtitle =>
      'Sigue a quién has prestado dinero y quién te debe. Recibe notificaciones de vencimientos.';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get next => 'Siguiente';

  @override
  String get skip => 'OMITIR';

  @override
  String get appleSignInComingSoon => 'Inicio de sesión de Apple próximamente';

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get signIn => 'Iniciar Sesión';

  @override
  String get continuePreferredAccount => 'Continuar con tu cuenta preferida';

  @override
  String get continueGoogle => 'Continuar con Google';

  @override
  String get continueApple => 'Continuar con Apple';

  @override
  String get continueEmail => 'Continuar con Correo';

  @override
  String get signUp => 'Registrarse';

  @override
  String get email => 'Correo electrónico';

  @override
  String get validEmailRequired => 'Se requiere un correo válido';

  @override
  String get password => 'Contraseña';

  @override
  String get passwordLengthHelp =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get createAccount => 'Crear Cuenta';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta? Inicia sesión';

  @override
  String get dontHaveAccount => '¿No tienes una cuenta? Regístrate';

  @override
  String get home => 'Inicio';

  @override
  String get history => 'Historial';

  @override
  String get borrowTab => 'Préstamos';

  @override
  String get addNew => 'Añadir Nuevo';

  @override
  String get recordMoneySpent => 'Registrar dinero gastado';

  @override
  String get recordMoneyReceived => 'Registrar dinero recibido';

  @override
  String get trackWhoOwesWhom => 'Saber quién debe a quién';

  @override
  String get languageCountry => 'Idioma / País';

  @override
  String get searchLanguages => 'Buscar idiomas...';

  @override
  String get noLanguagesFound => 'No se encontraron idiomas.';

  @override
  String get currencyCountry => 'Símbolo de Moneda / País';

  @override
  String get searchCurrencies => 'Buscar monedas o países...';

  @override
  String get noCurrenciesFound => 'No se encontraron monedas.';

  @override
  String get account => 'Cuenta';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get deleteAccountConfirm =>
      '¿Estás seguro de que deseas eliminar permanentemente tu cuenta? Esta acción no se puede deshacer y se perderán todos tus datos.';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get lentTab => 'Prestado';

  @override
  String get borrowedTab => 'Prestado';

  @override
  String get transactionHistory => 'Historial de transacciones';

  @override
  String get netBalanceThisMonth => 'Saldo neto de este mes';

  @override
  String get tagGetStarted => 'EMPEZAR';

  @override
  String get tagFastEntry => 'ENTRADA RÁPIDA';

  @override
  String get tagVoiceEntry => 'ENTRADA DE VOZ';

  @override
  String get tagBorrowLend => 'PRESTAR Y PEDIR';
}
