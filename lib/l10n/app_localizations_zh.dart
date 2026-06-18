// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Money Buddy';

  @override
  String get dashboard => '仪表板';

  @override
  String get transactions => '交易记录';

  @override
  String get addExpense => '添加支出';

  @override
  String get addIncome => '添加收入';

  @override
  String get borrowLend => '借贷管理';

  @override
  String get reminders => '账单提醒';

  @override
  String get settings => '设置';

  @override
  String get netBalance => '净余额';

  @override
  String get recentTransactions => '最近交易';

  @override
  String get income => '收入';

  @override
  String get expense => '支出';

  @override
  String get save => '保存';

  @override
  String get amount => '金额';

  @override
  String get note => '备注';

  @override
  String get date => '日期';

  @override
  String goodMorning(String userName) {
    return '早上好，$userName 👋';
  }

  @override
  String goodAfternoon(String userName) {
    return '下午好，$userName 👋';
  }

  @override
  String goodEvening(String userName) {
    return '晚上好，$userName 👋';
  }

  @override
  String get last6Months => '最近6个月';

  @override
  String get incomeVsExpense => '收入 vs 支出';

  @override
  String get thisMonth => '本月';

  @override
  String get seeAll => '查看全部';

  @override
  String get noTransactionsYet => '暂无交易记录';

  @override
  String get tapPlusToAdd => '点击“+”按钮添加您的第一笔收入或支出';

  @override
  String get noChartDataYet => '暂无图表数据';

  @override
  String get pleaseEnterAmountAndCategory => '请输入金额并选择类别';

  @override
  String get pleaseEnterAmountAndSource => '请输入金额并选择来源';

  @override
  String get pleaseEnterValidAmount => '请输入有效的金额';

  @override
  String get expenseAdded => '已添加支出！';

  @override
  String get incomeAdded => '已添加收入！';

  @override
  String get category => '类别';

  @override
  String get incomeSource => '收入来源';

  @override
  String get couldNotLoadCategories => '无法加载类别';

  @override
  String get noteOptional => '备注（选填）';

  @override
  String get saveExpense => '保存支出';

  @override
  String get saveIncome => '保存收入';

  @override
  String get personNameAndAmountRequired => '联系人姓名和金额是必填项';

  @override
  String get recordAdded => '记录已添加！';

  @override
  String get addBorrowLend => '添加借还款';

  @override
  String get iLent => '↗ 我借出';

  @override
  String get iBorrowed => '↙ 我借入';

  @override
  String get amountLent => '借出金额';

  @override
  String get amountBorrowed => '借入金额';

  @override
  String get lentToPerson => '借给（联系人姓名）';

  @override
  String get borrowedFromPerson => '借自（联系人姓名）';

  @override
  String get dueDateOptional => '到期日（选填）';

  @override
  String get tapToSetDueDate => '点击设置到期日';

  @override
  String get saveLendRecord => '保存借出记录';

  @override
  String get saveBorrowRecord => '保存借入记录';

  @override
  String get noMoneyLentYet => '暂无借出资金记录';

  @override
  String get noBorrowedMoney => '暂无借入资金记录';

  @override
  String get addLentRecords => '添加您借给别人的资金记录';

  @override
  String get addBorrowedRecords => '添加您向别人借入的资金记录';

  @override
  String get addRecord => '添加记录';

  @override
  String get paid => '已付清';

  @override
  String get overdue => '已逾期';

  @override
  String get pending => '待处理';

  @override
  String get due => '到期';

  @override
  String get markPaid => '标记为已付清';

  @override
  String get searchTransactions => '搜索交易...';

  @override
  String get all => '全部';

  @override
  String get noTransactionsFound => '未找到交易记录';

  @override
  String get adjustFilterOrSearch => '请尝试调整过滤器或搜索词';

  @override
  String get deleteTransaction => '删除交易';

  @override
  String get areYouSure => '确定要删除吗？';

  @override
  String get areYouSureDeleteTxn => '您确定要删除这笔交易记录吗？';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get noRemindersYet => '暂无提醒';

  @override
  String get addRemindersHelp => '添加付款提醒，我们将在到期时通知您';

  @override
  String get addReminder => '添加提醒';

  @override
  String get deleteReminder => '删除提醒';

  @override
  String get overdueTag => '已逾期';

  @override
  String get todayTag => '今天';

  @override
  String get done => '完成';

  @override
  String get pleaseEnterTitle => '请输入标题';

  @override
  String get newReminder => '新建提醒';

  @override
  String get reminderTitle => '提醒标题';

  @override
  String get amountOptional => '金额（选填）';

  @override
  String get dueDate => '到期日期';

  @override
  String get saveReminder => '保存提醒';

  @override
  String get welcomeTitle => '欢迎使用\nMoney Buddy';

  @override
  String get welcomeSubtitle => '您的个人理财助手。轻松追踪收支，掌控您的财务。';

  @override
  String get fastEntryTitle => '轻松追踪每笔支出。';

  @override
  String get fastEntrySubtitle => '5秒内快速记录账单。对新手而言极简，对专家而言强大。';

  @override
  String get voiceEntryTitle => '语音记录支出。';

  @override
  String get voiceEntrySubtitle => '只需说“吃饭花了200元”，剩下的交给我们。解放双手的财务追踪。';

  @override
  String get borrowLendTitle => '绝不忘记借还款。';

  @override
  String get borrowLendSubtitle => '追踪借给别人的资金和欠别人的款项。在到期前获得通知提醒。';

  @override
  String get getStarted => '立即开始';

  @override
  String get next => '下一步';

  @override
  String get skip => '跳过';

  @override
  String get appleSignInComingSoon => 'Apple 登录即将推出';

  @override
  String get welcomeBack => '欢迎回来';

  @override
  String get signIn => '登录';

  @override
  String get continuePreferredAccount => '使用您的首选账户继续';

  @override
  String get continueGoogle => '继续使用 Google';

  @override
  String get continueApple => '继续使用 Apple';

  @override
  String get continueEmail => '继续使用邮箱';

  @override
  String get signUp => '注册';

  @override
  String get email => '邮箱';

  @override
  String get validEmailRequired => '请输入有效的电子邮箱';

  @override
  String get password => '密码';

  @override
  String get passwordLengthHelp => '密码长度必须至少为6位字符';

  @override
  String get createAccount => '创建账户';

  @override
  String get alreadyHaveAccount => '已有账户？去登录';

  @override
  String get dontHaveAccount => '没有账户？去注册';

  @override
  String get home => '首页';

  @override
  String get history => '历史';

  @override
  String get borrowTab => '借贷';

  @override
  String get addNew => '新增';

  @override
  String get recordMoneySpent => '记录支出的资金';

  @override
  String get recordMoneyReceived => '记录收入的资金';

  @override
  String get trackWhoOwesWhom => '记录人际借贷往来';

  @override
  String get languageCountry => '语言 / 国家';

  @override
  String get searchLanguages => '搜索语言...';

  @override
  String get noLanguagesFound => '未找到相关语言。';

  @override
  String get currencyCountry => '货币符号 / 国家';

  @override
  String get searchCurrencies => '搜索货币或国家...';

  @override
  String get noCurrenciesFound => '未找到相关货币。';

  @override
  String get account => '账户';

  @override
  String get logout => '退出登录';

  @override
  String get deleteAccountConfirm => '您确定要永久删除您的账户吗？此操作无法撤销，您的所有数据都将丢失。';

  @override
  String get deleteAccount => '删除账户';

  @override
  String get lentTab => '已借出';

  @override
  String get borrowedTab => '已借入';

  @override
  String get transactionHistory => '交易历史';

  @override
  String get netBalanceThisMonth => '本月净余额';

  @override
  String get tagGetStarted => '立即开始';

  @override
  String get tagFastEntry => '快速记账';

  @override
  String get tagVoiceEntry => '语音记账';

  @override
  String get tagBorrowLend => '借贷管理';
}
