// import 'package:flutter/material.dart';
// import 'data/temples.dart';

// void main() {
//   runApp(const OhenroApp());
// }

// class OhenroApp extends StatelessWidget {
//   const OhenroApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'お遍路アプリ',
//       theme: ThemeData(primarySwatch: Colors.green),
//       home: const TempleListPage(),
//     );
//   }
// }

// class TempleListPage extends StatefulWidget {
//   const TempleListPage({super.key});

//   @override
//   State<TempleListPage> createState() => _TempleListPageState();
// }

// class _TempleListPageState extends State<TempleListPage> {
//   const TempleListPage({super.key});
//   // サンプルデータ（本当は88箇所あるけど、まず3つだけ）
//   // final List<String> temples = [
//   //   '霊山寺 (1番札所)',
//   //   '極楽寺 (2番札所)',
//   //   '金泉寺 (3番札所)',
//   // ];

//   // チェック状態を管理するリスト
//   final List<bool> visited = [false, false, false];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('お遍路リスト')),
//       // 例：ListView.builder で表示
//       body:ListView.builder(
//           itemCount: temples.length,
//           itemBuilder: (context, i) {
//             final t = temples[i];
//             return ListTile(
//               title: Text(t)
//               // title: Text('${t.number}. ${t.name}'),
//               // subtitle: Text(t.prefecture),
//             );
//           },
//         )
//       // body: ListView.builder(
//       //   itemCount: temples.length,
//       //   itemBuilder: (context, index) {
//       //     return CheckboxListTile(
//       //       title: Text(temples[index]),
//       //       value: visited[index],
//       //       onChanged: (bool? value) {
//       //         setState(() {
//       //           visited[index] = value ?? false;
//       //         });
//       //       },
//       //     );
//       //   },
//       // ),
//     );
//   }
// }
