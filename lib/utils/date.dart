import 'package:intl/intl.dart';

class DateFormatter{
  
  static String simpleFormat(DateTime date) =>
    DateFormat('dd/MM/yyyy').format(date);

}