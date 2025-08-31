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

  //追加
  double get progress {
    if (visited.isEmpty) return 0;
    int done = visited.where((v) => v).length;
    return done / visited.length;
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('お遍路リスト - ${ (progress * 100).toStringAsFixed(1) }% 達成'),//追加
  //     ),
  //     body: ListView.builder(
  //       itemCount: temples.length,
  //       itemBuilder: (context, index) {
  //         return CheckboxListTile(
  //           title: Text(temples[index].name),
  //           value: visited[index],
  //           onChanged: (bool? value) {
  //             setState(() {
  //               visited[index] = value ?? false;
  //             });
  //             _saveVisited();
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('お遍路リスト'),
      ),
      body: Column(
        children: [
          // ✅ 進捗バーと数値
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Column(
          //     children: [
          //       LinearProgressIndicator(
          //         value: progress,
          //         minHeight: 20,
          //         backgroundColor: Colors.grey[300],
          //         color: Colors.green,
          //       ),
          //       SizedBox(height: 8),
          //       Text('${(progress * 100).toStringAsFixed(1)}% 達成'),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: progress),
                  duration: const Duration(milliseconds: 500), // 0.5秒かけて変化
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      value: value,
                      minHeight: 20,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text('${(progress * 100).toStringAsFixed(1)}% 達成'),
              ],
            ),
          ),

        
          // ✅ チェックリスト
          Expanded(
            child: ListView.builder(
              itemCount: temples.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text('${temples[index].number}. ${temples[index].name}'),
                  subtitle: Text(temples[index].prefecture),
                  value: visited[index],
                  onChanged: (bool? value) {
                    setState(() {
                      visited[index] = value ?? false;
                    });
                    _saveVisited();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
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
}