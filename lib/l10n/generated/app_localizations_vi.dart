// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'VBC-WS';

  @override
  String get navHome => 'Home';

  @override
  String get navEvents => 'Lịch';

  @override
  String get navDiscipleship => 'Môn Đồ Hóa';

  @override
  String get navPrayer => 'Cầu Nguyện';

  @override
  String get navGiving => 'Liên Hệ';

  @override
  String get pageEventsTitle => 'Lịch Nhóm';

  @override
  String get pageDiscipleshipTitle => 'Môn Đồ Hóa';

  @override
  String get pagePrayerTitle => 'Cầu Nguyện';

  @override
  String get pageGivingTitle => 'Liên Hệ';

  @override
  String get buttonShare => 'Chia Sẻ';

  @override
  String get buttonAddToCalendar => 'Thêm vào Lịch';

  @override
  String get buttonCancel => 'Hủy';

  @override
  String get buttonSave => 'Lưu';

  @override
  String get buttonDelete => 'Xóa';

  @override
  String get sectionLocation => 'Địa Điểm';

  @override
  String get sectionNotes => 'Ghi Chú';

  @override
  String get sectionClasses => 'Các Lớp Học';

  @override
  String get emptyNoEvents => 'Chưa có sự kiện nào';

  @override
  String get emptyNoCourses => 'Chưa có khóa học nào';

  @override
  String get contentComingSoon => 'Nội dung sắp có';

  @override
  String get errorGeneric => 'Đã xảy ra lỗi';

  @override
  String get errorTryAgain => 'Vui lòng thử lại';

  @override
  String get errorNoInternet =>
      'Không thể tải dữ liệu. Vui lòng kiểm tra kết nối mạng.';

  @override
  String errorCannotOpen(String contact) {
    return 'Không thể mở $contact';
  }

  @override
  String errorUnknown(String message) {
    return 'Lỗi: $message';
  }
}
