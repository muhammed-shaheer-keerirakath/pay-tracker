import 'package:intl/intl.dart';
import 'package:pay_tracker/constants/date_constants.dart';
import 'package:pay_tracker/screens/monthly_graph/monthly_graph_constants.dart';

List<String> getAllowedMonthYearList(String monthlyGraphRangeSelection) {
  List<String> dateFormat =
      DateFormat('MMM,y').format(DateTime.now()).split(',');
  String month = dateFormat[0];
  String year = dateFormat[1];
  String previousYear = (int.parse(year) - 1).toString();

  List<String> allowedMonthYearList = [];
  for (var monthElement in monthsMMMFormat) {
    allowedMonthYearList.add('$monthElement $previousYear');
  }
  for (var monthElement in monthsMMMFormat) {
    allowedMonthYearList.add('$monthElement $year');
    if (monthElement == month) break;
  }

  int numberOfMonths = 0;
  switch (monthlyGraphRangeSelection) {
    case MonthlyGraphConstants.past3Months:
      numberOfMonths = 3;
      break;
    case MonthlyGraphConstants.past6Months:
      numberOfMonths = 6;
      break;
    default:
      numberOfMonths = 0;
  }

  return allowedMonthYearList
      .sublist(allowedMonthYearList.length - numberOfMonths);
}
