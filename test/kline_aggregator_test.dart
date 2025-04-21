import 'package:flutter_test/flutter_test.dart';

import 'package:kline_aggregator/kline_aggregator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  test('aggregateToKlines', () async {
    final response = await http.get(Uri.parse(
        'https://api.binance.com/api/v3/trades?symbol=ETHUSDT&limit=1000'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final trades = data.map((e) {
        return Trade(
          timestamp: DateTime.fromMillisecondsSinceEpoch(e['time']),
          price: double.parse(e['price']),
          amount: double.parse(e['qty']),
        );
      }).toList();
      final klines = aggregateToKlines(trades, Duration(seconds: 5));
      expect(klines, isA<List<KLine>>());
    } else {
      throw Exception("Failed to load trade data");
    }
  });
}
