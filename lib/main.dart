import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'data/temples.dart';
import 'data/temples_all.dart';
import 'pages/temple_detail_page.dart';

import 'package:shared_preferences/shared_preferences.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


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
    visited = List.filled(allTemples.length, false);
    _loadVisited();
  }

  double get progress {
    if (visited.isEmpty) return 0;
    int done = visited.where((v) => v).length;
    return done / visited.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3E9), // 和紙っぽい背景
      appBar: AppBar(
        title: Text(
        '四国８８か所お遍路リスト',
        style: GoogleFonts.zenMaruGothic(fontWeight: FontWeight.w900),
        ),
        backgroundColor: const Color(0xFF3A5F41),
        elevation: 0,
      ),
      body: Column(
        children: [
          // ✅ 進捗バー
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: progress),
                  duration: const Duration(milliseconds: 500),
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
              itemCount: allTemples.length,
              itemBuilder: (context, index) {
                final temple = allTemples[index];
                return Card(
                  color: const Color(0xFFF9F6EF),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color(0xFFD4A373), width: 1.4),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        temple.imagePath,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.temple_buddhist, size: 40, color: Colors.grey);
                        },
                      ),
                    ),
                    title: Text('${temple.number}番 ${temple.name}',
                    style: GoogleFonts.notoSerifJp(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(temple.prefecture),
                    trailing: Checkbox(
                      value: visited[index],
                      onChanged: (value) {
                        setState(() {
                          visited[index] = value ?? false;
                        });
                        _saveVisited();
                      },
                    ),
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => TempleDetailPage(temple: temple),
                    //     ),
                    //   );
                    // },
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TempleDetailPage(temple: temple, index: index),
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