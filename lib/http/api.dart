class Api {
  ///static String baseUrl = "http://47.111.64.183:8080/";
  static String baseUrl = "https://fengw1.utools.club/";
  static String userCener = "https://fengwan.utools.club/";

  ///获取分享信息
  static String getShareInfo = baseUrl + 'share/list';
  ///模糊搜搜
  static String search = baseUrl + 'share/keywords';

  ///登录
  static String login = userCener + 'user/login';
}
