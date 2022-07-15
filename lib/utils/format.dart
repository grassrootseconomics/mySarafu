class Seconds {
  static int get inMinute => 60;
  static int get inHour => 3600;
}

String formatCountDown(int seconds) {
  if (seconds < Seconds.inMinute) {
    // Less that 60 seconds only
    final secondsStr = seconds.toString().padLeft(2, '0');
    return '00:$secondsStr';
  } else if (seconds >= Seconds.inMinute && seconds < Seconds.inHour) {
    //  Minutes:Seconds
    final minutes = seconds ~/ Seconds.inMinute;
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsRemainder = seconds % Seconds.inMinute;
    final secondsStr = secondsRemainder.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  } else {
    // Hours:Minutes:Seconds

    final hours = seconds ~/ Seconds.inHour;
    final hoursStr = hours.toString().padLeft(2, '0');

    final secondsLeft = seconds % Seconds.inHour;
    final minutes = secondsLeft ~/ Seconds.inMinute;
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsRemainder = secondsLeft % Seconds.inMinute;
    final secondsStr = secondsRemainder.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }
}
