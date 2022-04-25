part of 'voucher_cubit.dart';

@immutable
abstract class VoucherState extends Equatable {
  const VoucherState({required this.voucher});
  final Voucher voucher;
}

class VoucherInitial extends VoucherState {
  const VoucherInitial({required Voucher voucher}) : super(voucher: voucher);

  @override
  List<Object?> get props {
    return [voucher];
  }
}

class VoucherLoading extends VoucherState {
  const VoucherLoading({
    required Voucher voucher,
    this.meta,
    this.proof,
  }) : super(voucher: voucher);

  final VoucherIssuer? meta;
  final VoucherProof? proof;

  @override
  List<Object?> get props {
    return [meta, proof, voucher];
  }
}

class VoucherLoaded extends VoucherState {
  const VoucherLoaded({
    required Voucher voucher,
    required this.meta,
    required this.proof,
  }) : super(voucher: voucher);
  final VoucherIssuer meta;
  final VoucherProof proof;

  @override
  List<Object?> get props {
    return [meta, proof, voucher];
  }

  VoucherLoaded copyWith({
    Voucher? voucher,
    VoucherIssuer? meta,
    VoucherProof? proof,
  }) {
    return VoucherLoaded(
      voucher: voucher ?? this.voucher,
      meta: meta ?? this.meta,
      proof: proof ?? this.proof,
    );
  }
}

class VoucherError extends VoucherState {
  const VoucherError(Voucher voucher, this.message) : super(voucher: voucher);
  final String message;

  @override
  List<Object?> get props => [voucher, message];
}
