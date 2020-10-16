class Api {
  ///static String baseUrl = "http://47.111.64.183:8080/";
  static String baseUrl = "https://fengw2.utools.club/";
  static String userCener = "https://fengwang.utools.club/";

  ///获取分享信息
  static String getShareInfo = baseUrl + 'share/list';

  ///获取兑换信息
  static String getExchangeShareInfo = baseUrl + 'share/exchange/shares';

  ///模糊搜搜
  static String search = baseUrl + 'share/keywords';

  ///我的发帖
  static String myContribution = baseUrl + 'share/my';

  ///帖子详情
  static String shareDetail = baseUrl + 'share/detail';
  
  ///兑换接口
  static String exchange = baseUrl + 'share/exchange/shareInfo';
  

  ///登录
  static String login = userCener + 'user/login';

  ///查询积分
  static String bonusDetail = userCener + 'user/bonus/my';
}
