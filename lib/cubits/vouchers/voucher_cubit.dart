import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/data/meta_repository.dart';
import 'package:my_sarafu/data/model/voucher.dart';
import 'package:my_sarafu/utils/logger.dart';

part 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  VoucherCubit({required this.metaRepository, required this.voucher})
      : super(VoucherInitial(voucher: voucher));
  final MetaRepository metaRepository;
  final Voucher voucher;

  Future<void> fetchMeta() async {
    log.d('Getting Meta for ${voucher.symbol}');

    if (state is VoucherLoaded) {
      emit(
        VoucherLoading(
          voucher: voucher,
          meta: (state as VoucherLoaded).meta,
          proof: (state as VoucherLoaded).proof,
        ),
      );
    }
    if (state is VoucherLoading) {
      return;
    }
    if (state is VoucherInitial) {
      emit(VoucherLoading(voucher: voucher));
    }

    final voucherInfo =
        await metaRepository.getVoucherMetaFromSymbol(voucher.symbol);

    final proofs =
        await metaRepository.getVoucherProofFromSymbol(voucher.symbol);
    emit(
      VoucherLoaded(voucher: voucher, meta: voucherInfo, proof: proofs),
    );
  }
}
