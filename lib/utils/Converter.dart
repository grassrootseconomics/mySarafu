/// Utility class to easily convert amounts of Ether into different units of
/// quantities.
class WeiConverter {
  int decimals = 6;
  WeiConverter(int decimals) {
    this.decimals = decimals;
  }

  /// Gets the value of this amount in the specified unit as a whole number.
  /// **WARNING**: For all units except for [EtherUnit.wei], this method will
  /// discard the remainder occurring in the division, making it unsuitable for
  /// calculations or storage. You should store and process amounts of ether by
  /// using a BigInt storing the amount in wei.
  BigInt getValueInUnitBI(BigInt value) =>
      value ~/ BigInt.from(10).pow(decimals);

  /// Gets the value of this amount in the specified unit. **WARNING**: Due to
  /// rounding errors, the return value of this function is not reliable,
  /// especially for larger amounts or smaller units. While it can be used to
  /// display the amount of ether in a human-readable format, it should not be
  /// used for anything else.
  double getValueInUnit(BigInt value) {
    final factor = BigInt.from(10).pow(decimals);
    final _value = value ~/ factor;
    final remainder = value.remainder(factor);

    return _value.toInt() + (remainder.toInt() / factor.toInt());
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
