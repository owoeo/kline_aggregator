library kline_aggregator;

class Trade {
  final DateTime timestamp;
  final double price;
  final double amount;

  Trade({required this.timestamp, required this.price, required this.amount});
}

class KLine {
  final DateTime openTime;
  double open;
  double high;
  double low;
  double close;
  double volume;

  KLine({
    required this.openTime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });
}

List<KLine> aggregateToKlines(List<Trade> trades, Duration interval) {
  trades.sort((a, b) => a.timestamp.compareTo(b.timestamp));

  final List<KLine> result = [];
  if (trades.isEmpty) return result;

  DateTime currentStart = DateTime.fromMillisecondsSinceEpoch(
    (trades.first.timestamp.millisecondsSinceEpoch ~/ interval.inMilliseconds) *
        interval.inMilliseconds,
  );
  List<Trade> bucket = [];

  for (var trade in trades) {
    final bucketStart = DateTime.fromMillisecondsSinceEpoch(
      (trade.timestamp.millisecondsSinceEpoch ~/ interval.inMilliseconds) *
          interval.inMilliseconds,
    );

    if (bucketStart != currentStart) {
      if (bucket.isNotEmpty) {
        result.add(_generateKLine(currentStart, bucket));
      }
      currentStart = bucketStart;
      bucket = [];
    }

    bucket.add(trade);
  }

  if (bucket.isNotEmpty) {
    result.add(_generateKLine(currentStart, bucket));
  }

  return result;
}

KLine _generateKLine(DateTime time, List<Trade> trades) {
  final open = trades.first.price;
  final close = trades.last.price;
  final high = trades.map((t) => t.price).reduce((a, b) => a > b ? a : b);
  final low = trades.map((t) => t.price).reduce((a, b) => a < b ? a : b);
  final volume = trades.map((t) => t.amount).reduce((a, b) => a + b);

  return KLine(
    openTime: time,
    open: open,
    high: high,
    low: low,
    close: close,
    volume: volume,
  );
}
