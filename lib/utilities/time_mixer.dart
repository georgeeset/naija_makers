class TimeMixer {
  String makeDayAtTime(DateTime input) {
    DateTime timeNow = DateTime.now();
    Duration difference = timeNow.difference(input);
    String amPm = input.hour > 12 ? 'PM' : 'AM';
    bool amNow = timeNow.hour < 12;
    // in the morning you get true, so  you can get coreect day description
    // if message sent 10pm, by 8am , it shows as yesterday 10pm...

    if (difference.inMinutes < 5 && difference.inHours == 0) {
      return 'Just now';
    }

    if (difference.inDays == 1 || (amNow != input.hour > 12)) {
      return 'Yesterday at ${timeHMAMPM(input, amPm)}';
    }

    if (difference.inDays == 0) {
      return 'Today at ${timeHMAMPM(input, amPm)}';
    }

    if (difference.inDays == 7) {
      return '1 Wk ago at ${timeHMAMPM(input, amPm)}';
    }

    return '${monthCode(input.month)} ${input.day} at ${timeHMAMPM(input, amPm)}';
  }

  String timeHMAMPM(DateTime input, String amPm) {
    return '${input.hour % 12}:${input.minute} $amPm';
  }

  String monthCode(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '$month';
    }
  }
}
