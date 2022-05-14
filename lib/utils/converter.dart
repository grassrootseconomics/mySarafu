import 'package:flutter/material.dart';

/// Utility class to easily convert amounts of Ether into different units of
/// quantities.

@immutable
class WeiConverter {
  const WeiConverter({required this.decimals});
  final int decimals;

  /// Gets the value of this amount in the specified unit. **WARNING**: Due to
  /// rounding errors, the return value of this function is not reliable,
  /// especially for larger amounts or smaller units. While it can be used to
  /// display the amount of ether in a human-readable format, it should not be
  /// used for anything else.
  String getUserFacingValue(BigInt value) {
    final factor = BigInt.from(10).pow(decimals);
    final _value = value ~/ factor;
    final remainder = value.remainder(factor);

    return (_value.toInt() + (remainder.toInt() / factor.toInt()))
        .toStringAsFixed(2);
  }

  @override
  String toString() {
    return 'Decimals: $decimals';
  }

  @override
  int get hashCode => decimals.hashCode;

  @override
  bool operator ==(dynamic other) =>
      other is WeiConverter && other.decimals == decimals;
}
