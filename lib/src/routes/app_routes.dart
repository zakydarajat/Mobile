part of 'app_pages.dart';

abstract class Routes {
  static const SIGNUP = _Paths.SIGNUP;
  static const LOGIN = _Paths.LOGIN;
  static const HOME = _Paths.HOME;
  static const PROFILE = _Paths.PROFILE;
  //static const HTTP = _Paths.HTTP;
  //static const WEBVIEW = _Paths.WEBVIEW;
}

abstract class _Paths {
  static const SIGNUP = '/signup';
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const PROFILE = '/profile';
  //static const HTTP = '/http_view';
  //static const WEBVIEW = '/web_view';
}
