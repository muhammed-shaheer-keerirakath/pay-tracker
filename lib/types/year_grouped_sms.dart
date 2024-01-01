import 'package:pay_tracker/types/date_grouped_sms.dart';

class YearGroupedSms {
  /// eg: ["2023", "2024"]
  late List<String> yearsList;

  /// eg: ["Jan 2023", "Mar 2024"]
  late List<String> monthsList;

  YearGroupedSms(List<DateGroupedSms> dateGroupedmessages) {
    Set<String> yearListSet = {};
    Set<String> monthListSet = {};
    for (var dateGroupedSms in dateGroupedmessages) {
      yearListSet.add(dateGroupedSms.year);
      monthListSet.add('${dateGroupedSms.month} ${dateGroupedSms.year}');
    }
    yearsList = yearListSet.toList(growable: false);
    monthsList = monthListSet.toList(growable: false);
  }
}
