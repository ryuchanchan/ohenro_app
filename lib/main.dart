import 'package:flutter/material.dart';
import 'data/temples_all.dart';
import 'pages/temple_detail_page.dart';

import 'package:shared_preferences/shared_preferences.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/map_page.dart';

import 'widgets/confetti_overlay.dart';

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
  bool showOnlyUnvisited = false;
  bool showCompleteMessage = false; // ← 🎉 100%演出用フラグ追加！
  bool completeTriggered = false; // ← 100%到達判定用フラグ追加

  @override
  void initState() {
    super.initState();
    visited = List.filled(allTemples.length, false);
    _loadVisited();
  }

  double get progress {
    if (visited.isEmpty) return 0;
    int done = visited.where((v) => v).length;
    return done / visited.length;
  }

  Color progressColor(double progress) {
    if (progress < 0.3) {
      return const Color(0xFF8A76A6); // 紫
    } else if (progress < 0.7) {
      return const Color(0xFFD44A2E); // 朱色
    } else {
      return const Color(0xFFD4AF37); // 金
    }
  }

  @override
  Widget build(BuildContext context) {
  // ✅ 100%達成時に一度だけメッセージを表示
  if (progress == 1.0 && !completeTriggered) {
      completeTriggered = true; // 一度だけ処理する
      showCompleteMessage = true;
      // 3秒後にメッセージを非表示
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            showCompleteMessage = false;
          });
        }
      });
    }

    final filteredTemples = showOnlyUnvisited
        ? allTemples.where((t) => !visited[allTemples.indexOf(t)]).toList()
        : allTemples;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3E9), // 和紙っぽい背景
      appBar: AppBar(
        title: Text(
        '四国８８か所お遍路リスト',
        style: GoogleFonts.zenMaruGothic(fontWeight: FontWeight.w900),
        ),
        backgroundColor: const Color(0xFF3A5F41),
        elevation: 0,
        actions: [//Gmap
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapPage(temples: allTemples),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [ 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF3EFE2), // 生成り色（和紙トーン）
                      foregroundColor: const Color(0xFF3A5F41), // 深緑（文字）
                      elevation: 1, // 静かめの影
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // 角は少しだけ丸める
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MapPage(temples: filteredTemples), // ← フィルタ後リストを渡す
                        ),
                      );
                    },
                    child: const Text(
                      '🗾 地図で見る',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600, // 少し凛とした文字
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // ✅ 表示切り替えボタン（すべて / 未参拝）
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showOnlyUnvisited = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(//追加！押したほうを分かりやすくするUI
                            backgroundColor: showOnlyUnvisited ? Colors.grey[300] : Colors.green,
                            foregroundColor: showOnlyUnvisited ? Colors.black : Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("すべて表示"),
                        ),
                      ),
                      const SizedBox(width: 12), // ← ボタンの間に余白
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showOnlyUnvisited = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(//追加！押したほうを分かりやすくするUI
                            backgroundColor: showOnlyUnvisited ? Colors.green : Colors.grey[300],
                            foregroundColor: showOnlyUnvisited ? Colors.white : Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("未参拝のみ"),
                        ),
                      ),
                    ],
                  ),
                  // ✅ 進捗バー
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // ClipRRect(// ← 角を丸める
                        //   borderRadius: BorderRadius.circular(12),
                        //   child: TweenAnimationBuilder<double>(
                        //     tween: Tween<double>(begin: 0, end: progress),
                        //     duration: const Duration(milliseconds: 600),
                        //     builder: (context, value, child) {
                        //       return LinearProgressIndicator(
                        //         value: value,
                        //         minHeight: 20,
                        //         backgroundColor: Colors.grey[300],
                        //         color: progressColor(value),
                        //       );
                        //     },
                        //   ),
                        // ),
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0, end: progress),
                            // duration: const Duration(milliseconds: 500),
                            duration: const Duration(milliseconds: 600),
                            builder: (context, value, child) {
                              return LinearProgressIndicator(
                                value: value,
                                minHeight: 20,
                                backgroundColor: Colors.grey[300],
                                // color: Colors.green,
                                color: progressColor(value),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          // Text('${(progress * 100).toStringAsFixed(1)}% 達成'),
                          Text(
                            '${(progress * 100).toInt()}% 達成',
                            style: GoogleFonts.notoSerifJp(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${visited.where((v) => v).length} / ${visited.length} 寺',
                            style: GoogleFonts.notoSerifJp(fontSize: 14, color: Colors.grey[700]),
                          ),
                       ],
                      ),
                    ),
                  ],
                ),
              ),      
              // ✅ チェックリスト
              Expanded(
                child: ListView.builder(
                  // itemCount: allTemples.length,
                  itemCount: filteredTemples.length,
                  itemBuilder: (context, index) {
                    final temple = filteredTemples[index];
                    final originalIndex = allTemples.indexOf(temple); // ← visitedにリンクさせるため必要

                    return Card(
                      color: const Color(0xFFF9F6EF),
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Color(0xFFD4A373), width: 1.4),
                      ),
                      child: ListTile(
                        title: Text('${temple.number}番 ${temple.name}'),
                        subtitle: Text(temple.prefecture),
                        trailing: Checkbox(
                          value: visited[originalIndex],
                          onChanged: (value) {
                            setState(() {
                              visited[originalIndex] = value ?? false;
                            });
                            _saveVisited();
                          },
                        ),
                        // leading: ClipRRect(
                        //   borderRadius: BorderRadius.circular(8),
                        //   child: Image.asset(
                        //     temple.imagePath,
                        //     width: 60,
                        //     height: 60,
                        //     fit: BoxFit.cover,
                        //     errorBuilder: (context, error, stackTrace) {
                        //       return const Icon(Icons.temple_buddhist, size: 40, color: Colors.grey);
                        //     },
                        //   ),
                        // ),
                        // title: Text('${temple.number}番 ${temple.name}',
                        // style: GoogleFonts.notoSerifJp(fontWeight: FontWeight.w600),
                        // ),
                        // subtitle: Text(temple.prefecture),
                        // trailing: Checkbox(
                        //   value: visited[index],
                        //   onChanged: (value) {
                        //     setState(() {
                        //       visited[index] = value ?? false;
                        //     });
                        //     _saveVisited();
                        //   },
                        // ),
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              // builder: (context) => TempleDetailPage(temple: temple, index: index),
                              builder: (context) => TempleDetailPage(temple: temple, index: originalIndex),
                            ),
                          );
                          if (result == true) {
                            _loadVisited(); // ← ✅ 参拝済み更新を反映
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          ConfettiOverlay(progress: progress),
          // 🎊 100%到達メッセージ
          if (showCompleteMessage)
            Center(
              child: AnimatedOpacity(
                opacity: showCompleteMessage ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    '✨ 完全制覇おめでとうございます！ ✨',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSerifJp(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _loadVisited() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('visitedList');
    if (savedList != null) {
      setState(() {
        visited = savedList.map((e) => e == 'true').toList();
      });
    }
  }

  Future<void> _saveVisited() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'visitedList',
      visited.map((e) => e.toString()).toList(),
    );
  }
}