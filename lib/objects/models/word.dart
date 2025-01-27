// 🌎 Project imports:
import 'package:notion_wordbook/objects/enums/word_tag.dart';

class Word {
  final String spelling;
  final String? meaning, exampleSentence, link;
  // 正誤判定はAPIのJSON構造から必ず存在する
  final bool correct;
  final List<WordTag>? tags;
  const Word(
    this.spelling,
    this.correct,
    this.meaning,
    this.tags,
    this.exampleSentence,
    this.link,
  );
}
