part of 'vouchers_cubit.dart';

@immutable
abstract class VouchersState extends Equatable {
  const VouchersState({required this.vouchers, this.activeVoucherIdx});
  final List<Voucher> vouchers;
  final int? activeVoucherIdx;
}

class VouchersInitial extends VouchersState {
  const VouchersInitial(
      {required List<Voucher> vouchers, int? activeVoucherIdx})
      : super(vouchers: vouchers, activeVoucherIdx: activeVoucherIdx);

  @override
  List<Object?> get props {
    return [...vouchers];
  }
}

class VouchersLoaded extends VouchersState {
  const VouchersLoaded({required List<Voucher> vouchers, int? activeVoucherIdx})
      : super(vouchers: vouchers, activeVoucherIdx: activeVoucherIdx);

  @override
  List<Object?> get props {
    return [...vouchers, activeVoucherIdx];
  }

  VouchersLoaded copyWith({
    List<Voucher>? vouchers,
    int? activeVoucherIdx,
  }) {
    return VouchersLoaded(
      vouchers: vouchers ?? this.vouchers,
      activeVoucherIdx: activeVoucherIdx ?? this.activeVoucherIdx,
    );
  }
}

class VouchersError extends VouchersState {
  const VouchersError(
      List<Voucher> vouchers, int? activeVoucherIdx, this.message)
      : super(vouchers: vouchers, activeVoucherIdx: activeVoucherIdx);
  final String message;

  @override
  List<Object?> get props => [...vouchers, message, activeVoucherIdx];
}
