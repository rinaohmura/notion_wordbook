// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:notion_wordbook/objects/models/notion_key.dart';

class WordbookInfoListViewModel extends StateNotifier<List<dynamic>> {
  WordbookInfoListViewModel() : super([]);

  Future<void> initState() async {
    await getWordbookList();
  }

  Future<void> getWordbookList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('wordbooks')) {
      return;
    }
    List storedData =
        json.decode(prefs.getString('wordbooks') ?? '')['wordbooks'];
    state = storedData;
    print(storedData);
  }
}

final wordbookInfoListProvider =
    StateNotifierProvider<WordbookInfoListViewModel, List<dynamic>>((ref) {
  return WordbookInfoListViewModel();
});

class WordbookInfoViewModel extends StateNotifier<WordbookInfo> {
  WordbookInfoViewModel() : super(const WordbookInfo('', '', ''));

  void setDBName(dbName) async {
    state = WordbookInfo(dbName, '', '');
  }

  void updateDBId(dbId) async {
    state = WordbookInfo(state.dbName, state.apiKey, dbId);
  }

  void updateAPIKey(apiKey) async {
    state = WordbookInfo(state.dbName, apiKey, state.dbName);
  }

  Future<void> setDBInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> dbInfo = {
      'db_name': state.dbName,
      'api_key': state.apiKey,
      'db_id': state.dbID
    };

    if (!prefs.containsKey('wordbooks')) {
      debugPrint('no wordbooks');
      String data = json.encode({
        'wordbooks': [dbInfo]
      });
      prefs.setString('wordbooks', data);
      return;
    }

    List storedData =
        json.decode(prefs.getString('wordbooks') ?? '')['wordbooks'];
    if (storedData
        .where((element) => element['db_name'] == state.dbName)
        .isNotEmpty) {
      return;
    }
    storedData.add(dbInfo);
    prefs.setString('wordbooks', json.encode({'wordbooks': storedData}));
  }
}

final wordbookInfoProvider =
    StateNotifierProvider<WordbookInfoViewModel, WordbookInfo>((ref) {
  return WordbookInfoViewModel();
});
