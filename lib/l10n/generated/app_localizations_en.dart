// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'VBC-WS';

  @override
  String get navHome => 'Home';

  @override
  String get navEvents => 'Calendar';

  @override
  String get navDiscipleship => 'Discipleship';

  @override
  String get navPrayer => 'Prayer';

  @override
  String get navGiving => 'Contact';

  @override
  String get pageEventsTitle => 'Group Calendar';

  @override
  String get pageDiscipleshipTitle => 'Discipleship';

  @override
  String get pagePrayerTitle => 'Prayer Requests';

  @override
  String get pageGivingTitle => 'Contact';
}
