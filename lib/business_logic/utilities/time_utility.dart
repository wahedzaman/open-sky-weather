import 'package:intl/intl.dart';

String convertTimeStampToHumanHour(dynamic timeStamp) {
  final dateToTimeStamp =
      DateTime.fromMillisecondsSinceEpoch(int.parse("$timeStamp") * 1000);
  return DateFormat('hh:mm a').format(dateToTimeStamp);
}
