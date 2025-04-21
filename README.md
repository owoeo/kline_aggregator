<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Kline Aggregator

A Flutter package for aggregating trade data into K-line (candlestick) charts. This package provides functionality to convert raw trade data into K-line data with customizable time intervals.

## Features

- Convert trade data into K-line (candlestick) data
- Support for customizable time intervals
- Simple and efficient data aggregation
- Type-safe data models for trades and K-lines

## Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  kline_aggregator: ^0.0.1
```

## Usage

Here's a simple example of how to use the package:

```dart
import 'package:kline_aggregator/kline_aggregator.dart';

void main() {
  // Create a list of trades
  final trades = [
    Trade(
      timestamp: DateTime.now(),
      price: 100.0,
      amount: 1.0,
    ),
    // Add more trades...
  ];

  // Aggregate trades into 1-minute K-lines
  final klines = aggregateToKlines(trades, Duration(minutes: 1));

  // Use the K-line data for charting or analysis
  for (var kline in klines) {
    print('Time: ${kline.openTime}');
    print('Open: ${kline.open}');
    print('High: ${kline.high}');
    print('Low: ${kline.low}');
    print('Close: ${kline.close}');
    print('Volume: ${kline.volume}');
  }
}
```

## Data Models

### Trade
Represents a single trade with:
- timestamp: When the trade occurred
- price: The price of the trade
- amount: The volume/amount of the trade

### KLine
Represents a candlestick/K-line with:
- openTime: Start time of the K-line period
- open: Opening price
- high: Highest price
- low: Lowest price
- close: Closing price
- volume: Total volume during the period

## Additional information

This package is designed to be simple and efficient for aggregating trade data into K-line format. It's particularly useful for:
- Financial charting applications
- Trading analysis tools
- Market data visualization

For more information or to contribute, please visit the project's GitHub repository.
