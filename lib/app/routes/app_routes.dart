part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const LOGIN = _Paths.LOGIN;
  static const HOME = _Paths.LOGIN + _Paths.HOME;
  static const GUIDELINE = _Paths.LOGIN + _Paths.GUIDELINE;
  static const RANK = _Paths.LOGIN + _Paths.RANK;
  static const REPORT_LIST = _Paths.LOGIN + _Paths.REPORT_LIST;
  static const ANNOUNCE = _Paths.LOGIN + _Paths.ANNOUNCE;
  static const GROUP_INFO = _Paths.LOGIN + _Paths.GROUP_INFO;
  static const REPORT_WRITE =
      _Paths.LOGIN + _Paths.REPORT_LIST + _Paths.REPORT_WRITE;
  static const REPORT_DETAILE =
      _Paths.LOGIN + _Paths.REPORT_LIST + _Paths.REPORT_DETAIL;
  static const REGISTER = _Paths.LOGIN + _Paths.REGISTER;
  static const QUESTION = _Paths.LOGIN + _Paths.QUESTION;
  static const QUESTION_WRITE =
      _Paths.LOGIN + _Paths.QUESTION + _Paths.QUESTION_WRITE;
  static const QUESTION_DETAIL =
      _Paths.HOME + _Paths.QUESTION + _Paths.QUESTION_DETAIL;
  static const MY_PAGE = _Paths.HOME + _Paths.MY_PAGE;
  static const ADMIN = _Paths.HOME + _Paths.ADMIN;
  static const STUDENT_LIST = _Paths.HOME + _Paths.ADMIN + _Paths.STUDENT_LIST;
  static const GROUP_ADD = _Paths.HOME + _Paths.ADMIN + _Paths.GROUP_ADD;
  static const GROUP_DEL = _Paths.HOME + _Paths.ADMIN + _Paths.GROUP_DEL;
  static const HOME2 = _Paths.HOME + _Paths.HOME2;
  static const SIGN_UP = _Paths.HOME + _Paths.SIGN_UP;

  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '$HOME?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';

  static String SIGNUP_THEN(String afterSuccessfulSignUp) =>
      '$SIGN_UP?then=${Uri.encodeQueryComponent(afterSuccessfulSignUp)}';
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const GUIDELINE = '/guideline';
  static const RANK = '/rank';
  static const REPORT_LIST = '/report-list';
  static const ANNOUNCE = '/announce';
  static const GROUP_INFO = '/group-info';
  static const REPORT_WRITE = '/report-write';
  static const REPORT_DETAIL = '/retort-detail';
  static const REGISTER = '/register';
  static const QUESTION = '/question';
  static const QUESTION_WRITE = '/question-write';
  static const QUESTION_DETAIL = '/question-detail';
  static const MY_PAGE = '/my-page';
  static const ADMIN = '/admin';
  static const STUDENT_LIST = '/student-list';
  static const GROUP_ADD = '/group-add';
  static const GROUP_DEL = '/group-del';
  static const HOME2 = '/home2';
  static const SIGN_UP = '/sign-up';
}
