// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Money Buddy';

  @override
  String get dashboard => '대시보드';

  @override
  String get transactions => '거래 내역';

  @override
  String get addExpense => '지출 추가';

  @override
  String get addIncome => '수입 추가';

  @override
  String get borrowLend => '빌림/빌려줌';

  @override
  String get reminders => '알림';

  @override
  String get settings => '설정';

  @override
  String get netBalance => '순자산';

  @override
  String get recentTransactions => '최근 거래';

  @override
  String get income => '수입';

  @override
  String get expense => '지출';

  @override
  String get save => '저장';

  @override
  String get amount => '금액';

  @override
  String get note => '메모';

  @override
  String get date => '날짜';

  @override
  String goodMorning(String userName) {
    return '좋은 아침입니다, $userName 👋';
  }

  @override
  String goodAfternoon(String userName) {
    return '좋은 오후입니다, $userName 👋';
  }

  @override
  String goodEvening(String userName) {
    return '좋은 저녁입니다, $userName 👋';
  }

  @override
  String get last6Months => '최근 6개월';

  @override
  String get incomeVsExpense => '수입 vs 지출';

  @override
  String get thisMonth => '이번 달';

  @override
  String get seeAll => '전체 보기';

  @override
  String get noTransactionsYet => '거래 내역이 없습니다';

  @override
  String get tapPlusToAdd => '+ 버튼을 눌러 첫 수입 또는 지출을 추가해 보세요';

  @override
  String get noChartDataYet => '차트 데이터가 없습니다';

  @override
  String get pleaseEnterAmountAndCategory => '금액을 입력하고 카테고리를 선택해 주세요';

  @override
  String get pleaseEnterAmountAndSource => '금액을 입력하고 수입원을 선택해 주세요';

  @override
  String get pleaseEnterValidAmount => '올바른 금액을 입력해 주세요';

  @override
  String get expenseAdded => '지출이 추가되었습니다!';

  @override
  String get incomeAdded => '수입이 추가되었습니다!';

  @override
  String get category => '카테고리';

  @override
  String get incomeSource => '수입원';

  @override
  String get couldNotLoadCategories => '카테고리를 불러올 수 없습니다';

  @override
  String get noteOptional => '메모 (선택)';

  @override
  String get saveExpense => '지출 저장';

  @override
  String get saveIncome => '수입 저장';

  @override
  String get personNameAndAmountRequired => '이름과 금액은 필수 입력 항목입니다';

  @override
  String get recordAdded => '기록이 추가되었습니다!';

  @override
  String get addBorrowLend => '빌림 / 빌려줌 추가';

  @override
  String get iLent => '↗ 빌려줌';

  @override
  String get iBorrowed => '↙ 빌림';

  @override
  String get amountLent => '빌려준 금액';

  @override
  String get amountBorrowed => '빌린 금액';

  @override
  String get lentToPerson => '빌려준 사람 (이름)';

  @override
  String get borrowedFromPerson => '빌린 사람 (이름)';

  @override
  String get dueDateOptional => '만기일 (선택)';

  @override
  String get tapToSetDueDate => '만기일 설정';

  @override
  String get saveLendRecord => '빌려준 기록 저장';

  @override
  String get saveBorrowRecord => '빌린 기록 저장';

  @override
  String get noMoneyLentYet => '빌려준 돈이 없습니다';

  @override
  String get noBorrowedMoney => '빌린 돈이 없습니다';

  @override
  String get addLentRecords => '다른 사람에게 빌려준 돈의 기록을 추가해 보세요';

  @override
  String get addBorrowedRecords => '다른 사람에게 빌린 돈의 기록을 추가해 보세요';

  @override
  String get addRecord => '기록 추가';

  @override
  String get paid => '상환 완료';

  @override
  String get overdue => '연체됨';

  @override
  String get pending => '대기 중';

  @override
  String get due => '만기';

  @override
  String get markPaid => '상환 완료로 표시';

  @override
  String get searchTransactions => '거래 검색...';

  @override
  String get all => '전체';

  @override
  String get noTransactionsFound => '검색된 거래가 없습니다';

  @override
  String get adjustFilterOrSearch => '필터 또는 검색어를 변경해 보세요';

  @override
  String get deleteTransaction => '거래 삭제';

  @override
  String get areYouSure => '정말 삭제하시겠습니까?';

  @override
  String get areYouSureDeleteTxn => '이 거래 내역을 정말로 삭제하시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get noRemindersYet => '등록된 알림이 없습니다';

  @override
  String get addRemindersHelp => '결제 알림을 추가해 주시면 만기일에 알려 드립니다';

  @override
  String get addReminder => '알림 추가';

  @override
  String get deleteReminder => '알림 삭제';

  @override
  String get overdueTag => '연체됨';

  @override
  String get todayTag => '오늘';

  @override
  String get done => '완료';

  @override
  String get pleaseEnterTitle => '제목을 입력해 주세요';

  @override
  String get newReminder => '새 알림';

  @override
  String get reminderTitle => '알림 제목';

  @override
  String get amountOptional => '금액 (선택)';

  @override
  String get dueDate => '만기일';

  @override
  String get saveReminder => '알림 저장';

  @override
  String get welcomeTitle => '머니버디에 오신 것을\n환영합니다';

  @override
  String get welcomeSubtitle => '나만의 개인 재정 도우미. 수입, 지출을 추적하고 현명하게 돈을 관리해 보세요.';

  @override
  String get fastEntryTitle => '지출을 쉽고 간편하게 기록하세요.';

  @override
  String get fastEntrySubtitle =>
      '5초 이내에 지출을 기록할 수 있습니다. 초보자에게는 간편하게, 전문가에게는 강력하게.';

  @override
  String get voiceEntryTitle => '음성으로 지출을 기록하세요.';

  @override
  String get voiceEntrySubtitle =>
      '“식비로 2만원 썼어”라고 말하면 자동으로 등록됩니다. 간편한 핸즈프리 자산 관리.';

  @override
  String get borrowLendTitle => '빌려주고 빌린 돈을 잊지 마세요.';

  @override
  String get borrowLendSubtitle =>
      '누구에게 빌려주었는지, 누구에게 빌렸는지 기록하세요. 만기일이 다가오면 알려 드립니다.';

  @override
  String get getStarted => '시작하기';

  @override
  String get next => '다음';

  @override
  String get skip => '건너뛰기';

  @override
  String get appleSignInComingSoon => 'Apple 로그인 준비 중';

  @override
  String get welcomeBack => '다시 만나서 반가워요';

  @override
  String get signIn => '로그인';

  @override
  String get continuePreferredAccount => '원하시는 계정으로 계속하기';

  @override
  String get continueGoogle => 'Google으로 계속하기';

  @override
  String get continueApple => 'Apple로 계속하기';

  @override
  String get continueEmail => '이메일로 계속하기';

  @override
  String get signUp => '회원가입';

  @override
  String get email => '이메일';

  @override
  String get validEmailRequired => '유효한 이메일을 입력해 주세요';

  @override
  String get password => '비밀번호';

  @override
  String get passwordLengthHelp => '비밀번호는 최소 6자 이상이어야 합니다';

  @override
  String get createAccount => '계정 만들기';

  @override
  String get alreadyHaveAccount => '이미 계정이 있으신가요? 로그인';

  @override
  String get dontHaveAccount => '계정이 없으신가요? 회원가입';

  @override
  String get home => '홈';

  @override
  String get history => '내역';

  @override
  String get borrowTab => '빌림';

  @override
  String get addNew => '새로 추가';

  @override
  String get recordMoneySpent => '지출한 돈 기록';

  @override
  String get recordMoneyReceived => '받은 돈 기록';

  @override
  String get trackWhoOwesWhom => '돈을 빌려주고 빌린 거래 추적';

  @override
  String get languageCountry => '언어 / 국가';

  @override
  String get searchLanguages => '언어 검색...';

  @override
  String get noLanguagesFound => '검색된 언어가 없습니다.';

  @override
  String get currencyCountry => '통화 기호 / 국가';

  @override
  String get searchCurrencies => '통화 또는 국가 검색...';

  @override
  String get noCurrenciesFound => '검색된 통화가 없습니다.';

  @override
  String get account => '계정';

  @override
  String get logout => '로그아웃';

  @override
  String get deleteAccountConfirm =>
      '정말로 계정을 영구적으로 삭제하시겠습니까? 이 작업은 되돌릴 수 없으며 모든 데이터가 삭제됩니다.';

  @override
  String get deleteAccount => '계정 삭제';

  @override
  String get lentTab => '빌려줌';

  @override
  String get borrowedTab => '빌림';

  @override
  String get transactionHistory => '거래 내역';

  @override
  String get netBalanceThisMonth => '이번 달 순자산';

  @override
  String get tagGetStarted => '시작하기';

  @override
  String get tagFastEntry => '빠른 입력';

  @override
  String get tagVoiceEntry => '음성 입력';

  @override
  String get tagBorrowLend => '빌림 & 빌려줌';
}
