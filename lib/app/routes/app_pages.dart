import 'package:get/get.dart';

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
import '../modules/home/sign_up/bindings/sign_up_binding.dart';
import '../modules/home/sign_up/views/sign_up_view.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.LOGIN,
          page: () => LoginView(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: _Paths.GUIDELINE,
          page: () => GuidelineView(),
          binding: GuidelineBinding(),
        ),
        GetPage(
          name: _Paths.RANK,
          page: () => RankView(),
          binding: RankBinding(),
        ),
        GetPage(
          name: _Paths.REPORT_LIST,
          page: () => ReportListView(),
          binding: ReportListBinding(),
          children: [
            GetPage(
              name: _Paths.REPORT_WRITE,
              page: () => ReportWriteView(),
              binding: ReportWriteBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.REPORT_LIST,
          page: () => ReportListView(),
          binding: ReportListBinding(),
          children: [
            GetPage(
              name: _Paths.REPORT_DETAIL,
              page: () => ReportDetailView(),
              binding: ReportDetailBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.ANNOUNCE,
          page: () => AnnounceView(),
          binding: AnnounceBinding(),
        ),
        GetPage(
          name: _Paths.GROUP_INFO,
          page: () => GroupInfoView(),
          binding: GroupInfoBinding(),
        ),
        GetPage(
          name: _Paths.REGISTER,
          page: () => RegisterView(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: _Paths.QUESTION,
          page: () => QuestionView(),
          binding: QuestionBinding(),
        ),
        GetPage(
          name: _Paths.QUESTION,
          page: () => QuestionView(),
          binding: QuestionBinding(),
          children: [
            GetPage(
              name: _Paths.QUESTION_WRITE,
              page: () => QuestionWriteView(),
              binding: QuestionWriteBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.QUESTION,
          page: () => QuestionView(),
          binding: QuestionBinding(),
          children: [
            GetPage(
              name: _Paths.QUESTION_DETAIL,
              page: () => QuestionDetailView(),
              binding: QuestionDetailBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.MY_PAGE,
          page: () => MyPageView(),
          binding: MyPageBinding(),
        ),
        GetPage(
          name: _Paths.ADMIN,
          page: () => AdminView(),
          binding: AdminBinding(),
          children: [
            GetPage(
              name: _Paths.STUDENT_LIST,
              page: () => StudentListView(),
              binding: StudentListBinding(),
            ),
            GetPage(
              name: _Paths.GROUP_ADD,
              page: () => GroupAddView(),
              binding: GroupAddBinding(),
            ),
            GetPage(
              name: _Paths.GROUP_DEL,
              page: () => GroupDelView(),
              binding: GroupDelBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.HOME2,
          page: () => Home2View(),
          binding: Home2Binding(),
        ),
        GetPage(
          name: _Paths.SIGN_UP,
          page: () => SignUpView(),
          binding: SignUpBinding(),
        ),
      ],
    ),
  ];
}
