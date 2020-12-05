import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
  // DateTime date = DateTime.parse(dateString);
  // final DateTime date1 = DateFormat.yMMMMEEEEd().format(dateString);
  DateTime notificationDate = DateFormat("dd-MM-yyyy h:mma").parse(dateString);
  final date2 = DateTime.now();
  final difference = date2.difference(notificationDate);

  if ((difference.inDays / 365).floor() >= 2) {
    return '${(difference.inDays / 365).floor()} years ago';
  } else if ((difference.inDays / 365).floor() >= 1) {
    return (numericDates) ? '1y' : 'Last year';
  } else if ((difference.inDays / 30).floor() >= 2) {
    return '${(difference.inDays / 365).floor()} months ago';
  } else if ((difference.inDays / 30).floor() >= 1) {
    return (numericDates) ? '1m' : 'Last month';
  } else if ((difference.inDays / 7).floor() >= 2) {
    return '${(difference.inDays / 7).floor()} weeks ago';
  } else if ((difference.inDays / 7).floor() >= 1) {
    return (numericDates) ? '1w' : 'Last week';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays >= 1) {
    return (numericDates) ? '1d' : 'Yesterday';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} hours';
  } else if (difference.inHours >= 1) {
    return (numericDates) ? '1h' : 'An hour ago';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} minutes';
  } else if (difference.inMinutes >= 1) {
    return (numericDates) ? '1m' : 'A minute ago';
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} seconds';
  } else {
    return 'now';
  }
}

String spreadList({String date, String item}) {
  List<String> list = [];

  list = date.split(" ");
  int index = list.indexOf(item);

  return list[index - 1];
}

// return instagram time
String timefromNow({DateTime time}) {
  String date = Jiffy(time).fromNow();

  if (date.contains("seconds")) {
    return "now";
  }
  if (date.contains("minute")) {
    // String numb = spreadList(date: date, item: "minutes");
    return "1m";
  }
  if (date.contains("minutes")) {
    String numb = spreadList(date: date, item: "minutes");
    return "${numb}m";
  }
  if (date.contains("hours")) {
    String numb = spreadList(date: date, item: "hours");
    return "${numb}h";
  }
  if (date.contains("hour")) {
    return "1h";
  }

  if (date.contains("days")) {
    String numb = spreadList(date: date, item: "days");
    return "${numb}d";
  }
  if (date.contains("day")) {
    // String numb = spreadList(date: date, item: "days");
    return "1d";
  }
  if (date.contains("months")) {
    String numb = spreadList(date: date, item: "months");
    return "${numb}M";
  }
  if (date.contains("month")) {
    return "1M";
  }
  if (date.contains("years")) {
    String numb = spreadList(date: date, item: "years");
    return "${numb}y";
  }
  if (date.contains("year")) {
    return "1y";
  }
  print(date);
  return "week";
}

// strin datatime
String timefromNowString({String date}) {
  if (date.contains("seconds")) {
    return "now";
  }
  if (date.contains("minutes")) {
    String numb = spreadList(date: date, item: "minutes");
    return "${numb}m";
  }
  if (date.contains("minute")) {
    // String numb = spreadList(date: date, item: "minutes");
    return "1m";
  }

  if (date.contains("hours")) {
    String numb = spreadList(date: date, item: "hours");
    return "${numb}h";
  }
  if (date.contains("hour")) {
    return "1h";
  }

  if (date.contains("days")) {
    String numb = spreadList(date: date, item: "days");
    return "${numb}d";
  }
  if (date.contains("day")) {
    // String numb = spreadList(date: date, item: "days");
    return "1d";
  }
  if (date.contains("months")) {
    String numb = spreadList(date: date, item: "months");
    return "${numb}M";
  }
  if (date.contains("month")) {
    return "1M";
  }
  if (date.contains("years")) {
    String numb = spreadList(date: date, item: "years");
    return "${numb}y";
  }
  if (date.contains("year")) {
    return "1y";
  }
  return date;
}
