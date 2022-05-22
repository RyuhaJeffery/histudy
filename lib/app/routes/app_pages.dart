import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';
import '../modules/home/admin/bindings/admin_binding.dart';
import '../modules/home/admin/group_add/bindings/group_add_binding.dart';
import '../modules/home/admin/group_add/views/group_add_view.dart';
import '../modules/home/admin/group_del/bindings/group_del_binding.dart';
import '../modules/home/admin/group_del/views/group_del_view.dart';
import '../modules/home/admin/student_list/bindings/student_list_binding.dart';
import '../modules/home/admin/student_list/views/student_list_view.dart';
import '../modules/home/admin/views/admin_view.dart';
import '../modules/home/announce/bindings/announce_binding.dart';
import '../modules/home/announce/views/announce_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/group_info/bindings/group_info_binding.dart';
import '../modules/home/group_info/views/group_info_view.dart';
import '../modules/home/guideline/bindings/guideline_binding.dart';
import '../modules/home/guideline/views/guideline_view.dart';
import '../modules/home/home2/bindings/home2_binding.dart';
import '../modules/home/home2/views/home2_view.dart';
import '../modules/home/login/bindings/login_binding.dart';
import '../modules/home/login/views/login_view.dart';
import '../modules/home/my_page/bindings/my_page_binding.dart';
import '../modules/home/my_page/views/my_page_view.dart';
import '../modules/home/question/bindings/question_binding.dart';
import '../modules/home/question/question_detail/bindings/question_detail_binding.dart';
import '../modules/home/question/question_detail/views/question_detail_view.dart';
import '../modules/home/question/question_write/bindings/question_write_binding.dart';
import '../modules/home/question/question_write/views/question_write_view.dart';
import '../modules/home/question/views/question_view.dart';
import '../modules/home/rank/bindings/rank_binding.dart';
import '../modules/home/rank/views/rank_view.dart';
import '../modules/home/register/bindings/register_binding.dart';
import '../modules/home/register/views/register_view.dart';
import '../modules/home/report_list/bindings/report_list_binding.dart';
import '../modules/home/report_list/report_detail/bindings/report_detail_binding.dart';
import '../modules/home/report_list/report_detail/views/report_detail_view.dart';
import '../modules/home/report_list/report_write/bindings/report_write_binding.dart';
import '../modules/home/report_list/report_write/views/report_write_view.dart';
import '../modules/home/report_list/views/report_list_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/sign_up/views/sign_up_view.dart';
import '../modules/home/sign_up/bindings/sign_up_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      participatesInRootNavigator: true,
      middlewares: [
        EnsureAuthMiddleware(),
      ],
      children: [
        GetPage(
          name: _Paths.LOGIN,
          page: () => LoginView(),
          binding: LoginBinding(),
          participatesInRootNavigator: true,
        ),
        GetPage(
          name: _Paths.GUIDELINE,
          page: () => GuidelineView(),
          binding: GuidelineBinding(),
          participatesInRootNavigator: true,
          middlewares: [
            EnsureAuthMiddleware(),
          ],
        ),
        GetPage(
          name: _Paths.RANK,
          page: () => RankView(),
          binding: RankBinding(),
          participatesInRootNavigator: true,
          middlewares: [
            EnsureAuthMiddleware(),
          ],
        ),
        GetPage(
          name: _Paths.REPORT_LIST,
          page: () => ReportListView(),
          binding: ReportListBinding(),
          participatesInRootNavigator: true,
          middlewares: [
            EnsureAuthMiddleware(),
          ],
          children: [
            GetPage(
              name: _Paths.REPORT_DETAIL,
              page: () => ReportDetailView(),
              binding: ReportDetailBinding(),
              participatesInRootNavigator: true,
              middlewares: [
                EnsureAuthMiddleware()
              ]
            ),
            GetPage(
              name: _Paths.REPORT_WRITE,
              page: () => ReportWriteView(),
              binding: ReportWriteBinding(),
              participatesInRootNavigator: true,
              middlewares: [
                EnsureAuthMiddleware()
              ]
            ),
          ],
        ),
        
        GetPage(
          name: _Paths.ANNOUNCE,
          page: () => AnnounceView(),
          binding: AnnounceBinding(),
          participatesInRootNavigator: true,
          middlewares: [
            EnsureAuthMiddleware()
          ]
        ),
        GetPage(
          name: _Paths.GROUP_INFO,
          page: () => GroupInfoView(),
          binding: GroupInfoBinding(),
          participatesInRootNavigator: true,
          middlewares: [
            EnsureAuthMiddleware()
          ]
        ),
        GetPage(
          name: _Paths.REGISTER,
          page: () => RegisterView(),
          binding: RegisterBinding(),
          participatesInRootNavigator: true,
        ),
        GetPage(
          name: _Paths.QUESTION,
          page: () => QuestionView(),
          binding: QuestionBinding(),
          participatesInRootNavigator: true,
          middlewares: [
            EnsureAuthMiddleware()
          ],
          children: [
            GetPage(
              name: _Paths.QUESTION_WRITE,
              page: () => QuestionWriteView(),
              binding: QuestionWriteBinding(),
              participatesInRootNavigator: true,
              middlewares: [
                EnsureAuthMiddleware()
              ]
            ),
            GetPage(
              name: _Paths.QUESTION_DETAIL,
              page: () => QuestionDetailView(),
              binding: QuestionDetailBinding(),
              participatesInRootNavigator: true,
              middlewares: [
                EnsureAuthMiddleware()
              ]
            ),
          ],
        ),
        GetPage(
          name: _Paths.MY_PAGE,
          page: () => MyPageView(),
          binding: MyPageBinding(),
          participatesInRootNavigator: true,
          middlewares: [
            EnsureAuthMiddleware()
          ]
        ),
        GetPage(
          name: _Paths.ADMIN,
          page: () => AdminView(),
          binding: AdminBinding(),
          participatesInRootNavigator: true,
          middlewares:[
            EnsureAdminMiddleware(),
          ],
          children: [
            GetPage(
              name: _Paths.STUDENT_LIST,
              page: () => StudentListView(),
              binding: StudentListBinding(),
              participatesInRootNavigator: true,
            ),
            GetPage(
              name: _Paths.GROUP_ADD,
              page: () => GroupAddView(),
              binding: GroupAddBinding(),
              participatesInRootNavigator: true,
            ),
            GetPage(
              name: _Paths.GROUP_DEL,
              page: () => GroupDelView(),
              binding: GroupDelBinding(),
              participatesInRootNavigator: true,
            ),
          ],
        ),
        GetPage(
          name: _Paths.HOME2,
          page: () => Home2View(),
          binding: Home2Binding(),
          participatesInRootNavigator: true,
        ),
        GetPage(
          name: _Paths.SIGN_UP,
          page: () => SignUpView(),
          binding: SignUpBinding(),
          participatesInRootNavigator: true,
        ),
      ],
    ),
  ];
}
