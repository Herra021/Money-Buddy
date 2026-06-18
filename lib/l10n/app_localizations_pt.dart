// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Money Buddy';

  @override
  String get dashboard => 'Painel';

  @override
  String get transactions => 'Transações';

  @override
  String get addExpense => 'Adicionar Despesa';

  @override
  String get addIncome => 'Adicionar Receita';

  @override
  String get borrowLend => 'Empréstimos';

  @override
  String get reminders => 'Lembretes';

  @override
  String get settings => 'Configurações';

  @override
  String get netBalance => 'Saldo Líquido';

  @override
  String get recentTransactions => 'Transações Recentes';

  @override
  String get income => 'Receita';

  @override
  String get expense => 'Despesa';

  @override
  String get save => 'Salvar';

  @override
  String get amount => 'Valor';

  @override
  String get note => 'Nota';

  @override
  String get date => 'Data';

  @override
  String goodMorning(String userName) {
    return 'Bom Dia, $userName 👋';
  }

  @override
  String goodAfternoon(String userName) {
    return 'Boa Tarde, $userName 👋';
  }

  @override
  String goodEvening(String userName) {
    return 'Boa Noite, $userName 👋';
  }

  @override
  String get last6Months => 'Últimos 6 Meses';

  @override
  String get incomeVsExpense => 'Receitas vs Despesas';

  @override
  String get thisMonth => 'Este mês';

  @override
  String get seeAll => 'Ver Tudo';

  @override
  String get noTransactionsYet => 'Nenhuma transação ainda';

  @override
  String get tapPlusToAdd =>
      'Toque no botão + para adicionar sua primeira receita ou despesa';

  @override
  String get noChartDataYet => 'Ainda não há dados do gráfico';

  @override
  String get pleaseEnterAmountAndCategory =>
      'Por favor, insira o valor e selecione uma categoria';

  @override
  String get pleaseEnterAmountAndSource =>
      'Por favor, insira o valor e selecione uma fonte';

  @override
  String get pleaseEnterValidAmount => 'Por favor, insira um valor válido';

  @override
  String get expenseAdded => 'Despesa adicionada!';

  @override
  String get incomeAdded => 'Receita adicionada!';

  @override
  String get category => 'Categoria';

  @override
  String get incomeSource => 'Fonte de Receita';

  @override
  String get couldNotLoadCategories =>
      'Não foi possível carregar as categorias';

  @override
  String get noteOptional => 'Nota (opcional)';

  @override
  String get saveExpense => 'Salvar Despesa';

  @override
  String get saveIncome => 'Salvar Receita';

  @override
  String get personNameAndAmountRequired =>
      'Nome da pessoa e valor são obrigatórios';

  @override
  String get recordAdded => 'Registro adicionado!';

  @override
  String get addBorrowLend => 'Adicionar Empréstimo';

  @override
  String get iLent => '↗ Emprestei';

  @override
  String get iBorrowed => '↙ Peguei Emprestado';

  @override
  String get amountLent => 'Valor Emprestado';

  @override
  String get amountBorrowed => 'Valor Pegado Emprestado';

  @override
  String get lentToPerson => 'Emprestado para (Nome)';

  @override
  String get borrowedFromPerson => 'Emprestado por (Nome)';

  @override
  String get dueDateOptional => 'Data de vencimento (opcional)';

  @override
  String get tapToSetDueDate => 'Toque para definir data';

  @override
  String get saveLendRecord => 'Salvar Empréstimo';

  @override
  String get saveBorrowRecord => 'Salvar Dívida';

  @override
  String get noMoneyLentYet => 'Nenhum dinheiro emprestado ainda';

  @override
  String get noBorrowedMoney => 'Nenhum dinheiro pegado emprestado';

  @override
  String get addLentRecords =>
      'Adicione registros de dinheiro que você emprestou';

  @override
  String get addBorrowedRecords =>
      'Adicione registros de dinheiro que pegou emprestado';

  @override
  String get addRecord => 'Adicionar Registro';

  @override
  String get paid => 'Pago';

  @override
  String get overdue => 'Atrasado';

  @override
  String get pending => 'Pendente';

  @override
  String get due => 'Vence';

  @override
  String get markPaid => 'Marcar como Pago';

  @override
  String get searchTransactions => 'Buscar transações...';

  @override
  String get all => 'Tudo';

  @override
  String get noTransactionsFound => 'Nenhuma transação encontrada';

  @override
  String get adjustFilterOrSearch => 'Tente ajustar o filtro ou busca';

  @override
  String get deleteTransaction => 'Excluir Transação';

  @override
  String get areYouSure => 'Você tem certeza?';

  @override
  String get areYouSureDeleteTxn => 'Deseja realmente excluir esta transação?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get noRemindersYet => 'Nenhum lembrete ainda';

  @override
  String get addRemindersHelp =>
      'Adicione lembretes de pagamento e nós o notificaremos';

  @override
  String get addReminder => 'Adicionar Lembrete';

  @override
  String get deleteReminder => 'Excluir Lembrete';

  @override
  String get overdueTag => 'ATRASADO';

  @override
  String get todayTag => 'HOJE';

  @override
  String get done => 'Concluído';

  @override
  String get pleaseEnterTitle => 'Por favor, insira um título';

  @override
  String get newReminder => 'Novo Lembrete';

  @override
  String get reminderTitle => 'Título do Lembrete';

  @override
  String get amountOptional => 'Valor (opcional)';

  @override
  String get dueDate => 'Data de Vencimento';

  @override
  String get saveReminder => 'Salvar Lembrete';

  @override
  String get welcomeTitle => 'Bem-vindo ao\nMoney Buddy';

  @override
  String get welcomeSubtitle =>
      'Seu companheiro de finanças pessoais. Monitore receitas, despesas e controle seu dinheiro.';

  @override
  String get fastEntryTitle => 'Monitore cada despesa sem esforço.';

  @override
  String get fastEntrySubtitle =>
      'Registre gastos em menos de 5 segundos. Simples para iniciantes, poderoso para especialistas.';

  @override
  String get voiceEntryTitle => 'Registre despesas com sua voz.';

  @override
  String get voiceEntrySubtitle =>
      'Basta dizer \"Gastei 200 em comida\" e nós cuidamos do resto. Controle financeiro viva-voz.';

  @override
  String get borrowLendTitle => 'Nunca perca o controle das dívidas.';

  @override
  String get borrowLendSubtitle =>
      'Monitore a quem emprestou dinheiro e quem lhe deve. Seja notificado no vencimento.';

  @override
  String get getStarted => 'Começar';

  @override
  String get next => 'Avançar';

  @override
  String get skip => 'PULAR';

  @override
  String get appleSignInComingSoon => 'Login com Apple em breve';

  @override
  String get welcomeBack => 'Bem-vindo de volta';

  @override
  String get signIn => 'Entrar';

  @override
  String get continuePreferredAccount => 'Continuar com sua conta preferida';

  @override
  String get continueGoogle => 'Continuar com Google';

  @override
  String get continueApple => 'Continuar com Apple';

  @override
  String get continueEmail => 'Continuar com E-mail';

  @override
  String get signUp => 'Cadastrar-se';

  @override
  String get email => 'E-mail';

  @override
  String get validEmailRequired => 'E-mail válido obrigatório';

  @override
  String get password => 'Senha';

  @override
  String get passwordLengthHelp => 'A senha deve ter pelo menos 6 caracteres';

  @override
  String get createAccount => 'Criar Conta';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta? Entrar';

  @override
  String get dontHaveAccount => 'Não tem uma conta? Cadastre-se';

  @override
  String get home => 'Início';

  @override
  String get history => 'Histórico';

  @override
  String get borrowTab => 'Empréstimos';

  @override
  String get addNew => 'Adicionar Novo';

  @override
  String get recordMoneySpent => 'Registrar dinheiro gasto';

  @override
  String get recordMoneyReceived => 'Registrar dinheiro recebido';

  @override
  String get trackWhoOwesWhom => 'Monitore quem deve a quem';

  @override
  String get languageCountry => 'Idioma / País';

  @override
  String get searchLanguages => 'Buscar idiomas...';

  @override
  String get noLanguagesFound => 'Nenhum idioma encontrado.';

  @override
  String get currencyCountry => 'Símbolo de Moeda / País';

  @override
  String get searchCurrencies => 'Buscar moedas ou países...';

  @override
  String get noCurrenciesFound => 'Nenhuma moeda encontrada.';

  @override
  String get account => 'Conta';

  @override
  String get logout => 'Sair';

  @override
  String get deleteAccountConfirm =>
      'Tem certeza de que deseja excluir permanentemente sua conta? Esta ação não pode ser desfeita e todos os seus dados serão perdidos.';

  @override
  String get deleteAccount => 'Excluir conta';

  @override
  String get lentTab => 'Emprestado';

  @override
  String get borrowedTab => 'Emprestado';

  @override
  String get transactionHistory => 'Histórico de transações';

  @override
  String get netBalanceThisMonth => 'Saldo líquido deste mês';

  @override
  String get tagGetStarted => 'COMEÇAR';

  @override
  String get tagFastEntry => 'ENTRADA RÁPIDA';

  @override
  String get tagVoiceEntry => 'ENTRADA DE VOZ';

  @override
  String get tagBorrowLend => 'EMPRÉSTIMOS';

  @override
  String get resetData => 'Redefinir dados do aplicativo';

  @override
  String get resetDataConfirm =>
      'Tem certeza de que deseja excluir todas as transações, registros de empréstimos e lembretes? Esta ação não pode ser desfeita.';

  @override
  String get reset => 'Redefinir';

  @override
  String get resetSuccessful =>
      'Todos os dados do aplicativo foram redefinidos com sucesso.';

  @override
  String get selectLanguage => 'Selecionar idioma';

  @override
  String get selectCurrency => 'Selecionar moeda';

  @override
  String get profile => 'Perfil';

  @override
  String get guest => 'Convidado';
}
