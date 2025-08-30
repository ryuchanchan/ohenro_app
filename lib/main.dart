import 'package:flutter/material.dart';
import 'data/temples.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const OhenroApp());
}

class OhenroApp extends StatelessWidget {
  const OhenroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'お遍路アプリ',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const TempleListPage(),
    );
  }
}

class TempleListPage extends StatefulWidget {
  const TempleListPage({super.key});

  @override
  State<TempleListPage> createState() => _TempleListPageState();
}

class _TempleListPageState extends State<TempleListPage> {
  List<bool> visited = [];

  @override
  void initState() {
    super.initState();
    visited = List.filled(temples.length, false); // 初期化
    _loadVisited(); // 保存済みデータを読み込み
  }

  // ✅ 保存されているチェック状態を読み込み
  Future<void> _loadVisited() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('visitedList');

    if (savedList != null) {
      // print("復元しました: $savedList");
      setState(() {
        visited = savedList.map((e) => e == 'true').toList();
      });
    }
  }

  // ✅ チェック状態を保存
  Future<void> _saveVisited() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'visitedList',
      visited.map((e) => e.toString()).toList(),
    );
    print("保存しました: $visited");
    // 保存直後に確認
    // final check = prefs.getStringList('visitedList');
    // print("保存直後に読み出し: $check");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("お遍路リスト"),
      ),
      body: ListView.builder(
        itemCount: temples.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(temples[index].name),
            value: visited[index],
            onChanged: (bool? value) {
              setState(() {
                visited[index] = value ?? false;
              });
              _saveVisited(); // ✅ チェックしたら保存
            },
          );
        },
      ),
    );
  }
}