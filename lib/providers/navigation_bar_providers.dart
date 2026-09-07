import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationProvider = NotifierProvider<NavigationNotifier, int>(
  () => NavigationNotifier(),
);

class NavigationNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setIndex(int newIndex) {
    if (newIndex >= 0 && newIndex <= 3) {
      state = newIndex;
    }
  }
}
