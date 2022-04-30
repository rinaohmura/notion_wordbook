// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:notion_wordbook/viewmodels/word_list_controller.dart';

class MaxPageNotifier extends StateNotifier<int> {
  MaxPageNotifier(this.ref) : super(1);
  Ref ref;

  getListLength() async {
    final wordMap = ref.watch(wordListStateProvider);
    state = wordMap.length;
  }
}

final maxPageProvider = StateNotifierProvider<MaxPageNotifier, int>((ref) {
  return MaxPageNotifier(ref);
});

class CurrentPageNotifier extends StateNotifier<int> {
  CurrentPageNotifier() : super(1);

  void increasePage() => state++;
}

final currentPageProvider =
    StateNotifierProvider<CurrentPageNotifier, int>((ref) {
  return CurrentPageNotifier();
});