import 'package:intl/intl.dart';

String formatDatebyDMMMYYYY(
  DateTime dateTime
){
  return DateFormat("d MMM,yyyy").format(dateTime);
}