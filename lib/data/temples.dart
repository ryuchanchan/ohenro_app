// lib/data/temples.dart
// 四国八十八ヶ所（札所1〜88）のシンプルなデータ定義
// 最低限：番号と寺名、所属都道府県（範囲で固定）
// 1–23: 徳島県 / 24–39: 高知県 / 40–65: 愛媛県 / 66–88: 香川県

class Temple {
  final int number; // 1..88
  final String name; // 寺名（日本語）
  final String prefecture; // 都道府県
  const Temple({required this.number, required this.name, required this.prefecture});
}

String _prefOf(int n) {
  if (n >= 1 && n <= 23) return '徳島県';
  if (n >= 24 && n <= 39) return '高知県';
  if (n >= 40 && n <= 65) return '愛媛県';
  return '香川県'; // 66–88
}

/// 全88ヶ所（番号順）
const List<Temple> temples = [
  // 1–23 徳島
  Temple(number: 1, name: '霊山寺', prefecture: '徳島県'),
  Temple(number: 2, name: '極楽寺', prefecture: '徳島県'),
  Temple(number: 3, name: '金泉寺', prefecture: '徳島県'),
  Temple(number: 4, name: '大日寺', prefecture: '徳島県'),
  Temple(number: 5, name: '地蔵寺', prefecture: '徳島県'),
  Temple(number: 6, name: '安楽寺', prefecture: '徳島県'),
  Temple(number: 7, name: '十楽寺', prefecture: '徳島県'),
  Temple(number: 8, name: '熊谷寺', prefecture: '徳島県'),
  Temple(number: 9, name: '法輪寺', prefecture: '徳島県'),
  Temple(number: 10, name: '切幡寺', prefecture: '徳島県'),
  Temple(number: 11, name: '藤井寺', prefecture: '徳島県'),
  Temple(number: 12, name: '焼山寺', prefecture: '徳島県'),
  Temple(number: 13, name: '大日寺', prefecture: '徳島県'),
  Temple(number: 14, name: '常楽寺', prefecture: '徳島県'),
  Temple(number: 15, name: '阿波国分寺', prefecture: '徳島県'),
  Temple(number: 16, name: '観音寺', prefecture: '徳島県'),
  Temple(number: 17, name: '井戸寺', prefecture: '徳島県'),
  Temple(number: 18, name: '恩山寺', prefecture: '徳島県'),
  Temple(number: 19, name: '立江寺', prefecture: '徳島県'),
  Temple(number: 20, name: '鶴林寺', prefecture: '徳島県'),
  Temple(number: 21, name: '太龍寺', prefecture: '徳島県'),
  Temple(number: 22, name: '平等寺', prefecture: '徳島県'),
  Temple(number: 23, name: '薬王寺', prefecture: '徳島県'),

  // 24–39 高知
  Temple(number: 24, name: '最御崎寺', prefecture: '高知県'),
  Temple(number: 25, name: '津照寺', prefecture: '高知県'),
  Temple(number: 26, name: '金剛頂寺', prefecture: '高知県'),
  Temple(number: 27, name: '神峰寺', prefecture: '高知県'),
  Temple(number: 28, name: '大日寺', prefecture: '高知県'),
  Temple(number: 29, name: '土佐国分寺', prefecture: '高知県'),
  Temple(number: 30, name: '善楽寺', prefecture: '高知県'),
  Temple(number: 31, name: '竹林寺', prefecture: '高知県'),
  Temple(number: 32, name: '禅師峰寺', prefecture: '高知県'),
  Temple(number: 33, name: '雪蹊寺', prefecture: '高知県'),
  Temple(number: 34, name: '種間寺', prefecture: '高知県'),
  Temple(number: 35, name: '清滝寺', prefecture: '高知県'),
  Temple(number: 36, name: '青龍寺', prefecture: '高知県'),
  Temple(number: 37, name: '岩本寺', prefecture: '高知県'),
  Temple(number: 38, name: '金剛福寺', prefecture: '高知県'),
  Temple(number: 39, name: '延光寺', prefecture: '高知県'),

  // 40–65 愛媛
  Temple(number: 40, name: '観自在寺', prefecture: '愛媛県'),
  Temple(number: 41, name: '龍光寺', prefecture: '愛媛県'),
  Temple(number: 42, name: '佛木寺', prefecture: '愛媛県'),
  Temple(number: 43, name: '明石寺', prefecture: '愛媛県'),
  Temple(number: 44, name: '大寶寺', prefecture: '愛媛県'), // 大宝寺
  Temple(number: 45, name: '岩屋寺', prefecture: '愛媛県'),
  Temple(number: 46, name: '浄瑠璃寺', prefecture: '愛媛県'),
  Temple(number: 47, name: '八坂寺', prefecture: '愛媛県'),
  Temple(number: 48, name: '西林寺', prefecture: '愛媛県'),
  Temple(number: 49, name: '浄土寺', prefecture: '愛媛県'),
  Temple(number: 50, name: '繁多寺', prefecture: '愛媛県'),
  Temple(number: 51, name: '石手寺', prefecture: '愛媛県'),
  Temple(number: 52, name: '太山寺', prefecture: '愛媛県'),
  Temple(number: 53, name: '圓明寺', prefecture: '愛媛県'), // 円明寺
  Temple(number: 54, name: '延命寺', prefecture: '愛媛県'),
  Temple(number: 55, name: '南光坊', prefecture: '愛媛県'),
  Temple(number: 56, name: '泰山寺', prefecture: '愛媛県'),
  Temple(number: 57, name: '栄福寺', prefecture: '愛媛県'),
  Temple(number: 58, name: '仙遊寺', prefecture: '愛媛県'),
  Temple(number: 59, name: '伊予国分寺', prefecture: '愛媛県'),
  Temple(number: 60, name: '横峰寺', prefecture: '愛媛県'),
  Temple(number: 61, name: '香園寺', prefecture: '愛媛県'),
  Temple(number: 62, name: '宝寿寺', prefecture: '愛媛県'),
  Temple(number: 63, name: '吉祥寺', prefecture: '愛媛県'),
  Temple(number: 64, name: '前神寺', prefecture: '愛媛県'),
  Temple(number: 65, name: '三角寺', prefecture: '愛媛県'),

  // 66–88 香川
  Temple(number: 66, name: '雲辺寺', prefecture: '香川県'),
  Temple(number: 67, name: '大興寺', prefecture: '香川県'),
  Temple(number: 68, name: '神恵院', prefecture: '香川県'),
  Temple(number: 69, name: '観音寺', prefecture: '香川県'),
  Temple(number: 70, name: '本山寺', prefecture: '香川県'),
  Temple(number: 71, name: '弥谷寺', prefecture: '香川県'),
  Temple(number: 72, name: '曼荼羅寺', prefecture: '香川県'),
  Temple(number: 73, name: '出釈迦寺', prefecture: '香川県'),
  Temple(number: 74, name: '甲山寺', prefecture: '香川県'),
  Temple(number: 75, name: '善通寺', prefecture: '香川県'),
  Temple(number: 76, name: '金倉寺', prefecture: '香川県'),
  Temple(number: 77, name: '道隆寺', prefecture: '香川県'),
  Temple(number: 78, name: '郷照寺', prefecture: '香川県'),
  Temple(number: 79, name: '天皇寺', prefecture: '香川県'),
  Temple(number: 80, name: '讃岐国分寺', prefecture: '香川県'),
  Temple(number: 81, name: '白峯寺', prefecture: '香川県'),
  Temple(number: 82, name: '根香寺', prefecture: '香川県'),
  Temple(number: 83, name: '一宮寺', prefecture: '香川県'),
  Temple(number: 84, name: '屋島寺', prefecture: '香川県'),
  Temple(number: 85, name: '八栗寺', prefecture: '香川県'),
  Temple(number: 86, name: '志度寺', prefecture: '香川県'),
  Temple(number: 87, name: '長尾寺', prefecture: '香川県'),
  Temple(number: 88, name: '大窪寺', prefecture: '香川県'),
];

/// 追加で市区町村や緯度経度が必要になったら、
/// Temple にフィールドを増やしていきましょう（後方互換も保ちやすいです）。
