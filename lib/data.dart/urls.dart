import 'package:greenway_lms/others/constants.dart';

String apiKey = 'b7174c64-15f7-4db4-8938-15bc7c6ac796';

class URLS {
  static String sliderimage = '$baseurl/slider_image';
  static String loginurl = '$baseurl/user_login';
  static String loginalready =
      '$baseurl/get_table_sin_row?tname=student&where=student_id&value=';
  static String feestatus = '$baseurl/check_fee_status?user_id=';
  static String getallcourse = '$baseurl/course_list';
  static String allcategorycourse = '$baseurl/category_couse';
  static String getcoursedetails = '$baseurl/progress_bar';
  static String getsearchresult = '$baseurl/search_course';
  static String randomCourse = '$baseurl/randomCourse';
  static String coursecategory = '$baseurl/course_category';
  static String getonecourse = '$baseurl/course_details/';
  static String getsubjects =
      '$baseurl/get_table_muti_row?tname=subject&where=class_id&value=';
  static String getsubject2 = '&return_table_count=topic&t_where=subject_id';

  static String gettopicendpoint2 =
      '&return_table_count=audio&t_where=topic_id';
  static String gettopic =
      '$baseurl/get_table_muti_row?tname=topic&where=subject_id&value=';
  static String getallvideos =
      '$baseurl/get_table_muti_row?tname=video&where=topic_id&value=';
  static String getallpdf =
      '$baseurl/get_table_muti_row?tname=notes&where=topic_id&value=';
  static String getallaudio =
      '$baseurl/get_table_muti_row?tname=audio&where=topic_id&value=';
  static String getsecuremod =
      '$baseurl/get_table_sin_row?tname=admin_profile&where=profile_id&value=1';
  static String deviceidupdate = '$baseurl/store_device_id';
  static String getallexam = '$baseurl/view_exam_list';
  static String viewexam = '$baseurl/exam_result';
  static String startexam = '$baseurl/exam_start';
  static String nextquestion = '$baseurl/next_question';
  static String examcomplete = '$baseurl/exam_complete';
  static String deviceid = '$baseurl/store_device_id';
  static String videoseenupdate = '$baseurl/set_video_seen';
  static String audioseenupdate = '$baseurl/set_audio_seen';
  static String noteseenupdate = '$baseurl/set_audio_seen';
  static String coursesearch = '$baseurl/course_autocomplete';
  static String blockornot =
      '$baseurl/get_table_sin_row?tname=admin&where=admin_id&value=';
  static String invoicelist =
      '$baseurl/get_table_muti_row?tname=invoice&where=user_id&value=';
  static String checkversion = '$baseurl/check_version?version=';
  static String clearexamdata = "$baseurl/exam_reset";
}
