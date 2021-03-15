import 'dart:async';

// Used for delaying repetitive calls eg: Network calls while filtering / searching
Timer? _debounce;
makeTimerDebounce({
  required Function fun,
  int delayInMilli = 1000,
}) {
  if (_debounce?.isActive ?? false) _debounce!.cancel();
  _debounce = Timer(Duration(milliseconds: delayInMilli), () {
    fun();
  });
}
