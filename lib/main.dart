import 'package:flutter/material.dart';
import 'data/temples.dart';

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
  // 訪問済みフラグ（88個分）
  final List<bool> visited = List.generate(temples.length, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('お遍路リスト')),
      body: ListView.builder(
        itemCount: temples.length,
        itemBuilder: (context, i) {
          final t = temples[i];
          return CheckboxListTile(
            title: Text('${t.number}. ${t.name}'),
            subtitle: Text(t.prefecture),
            value: visited[i],
            onChanged: (bool? value) {
              setState(() {
                visited[i] = value ?? false;
              });
            },
          );
        },
      ),
    );
  }
}
