import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mysarafu/model/voucher.dart';
import 'package:mysarafu/repository/vouchers_repository.dart';
import 'package:mysarafu/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

part 'vouchers_state.dart';

// TODO(william): Auto fetch all vouchers on first load
class VouchersCubit extends HydratedCubit<VouchersState> {
  VouchersCubit(this._voucherRepository) : super(const VouchersEmpty());
  final VoucherRepository _voucherRepository;

  Future<void> fetchAllVouchers(EthereumAddress address) async {
    log.d('Getting vouchers for $address');
    final vouchers = await _voucherRepository.getAllVouchers(address);
    log.d('${vouchers.length} Vouchers loaded');
    emit(
      VouchersLoaded(
        vouchers: vouchers,
        activeVoucherIdx: state.activeVoucherIdx ?? 0,
      ),
    );
  }

  Voucher? get activeVoucher {
    if (state.activeVoucherIdx is int &&
        state.vouchers.length > state.activeVoucherIdx!) {
      return state.vouchers[state.activeVoucherIdx!];
    }
    return null;
  }

  Future<void> updateBalances(EthereumAddress address) async {
    log.d(
      'Updating balances for $address for ${state.vouchers.length} Vouchers',
    );
    final updated =
        await _voucherRepository.updateBalances(address, state.vouchers);
    log.d('Updated Balances for ${updated.length} Vouchers');
    emit(
      VouchersLoaded(
        vouchers: updated,
        activeVoucherIdx: state.activeVoucherIdx,
      ),
    );
  }

  @override
  VouchersState fromJson(Map<String, dynamic> json) {
    try {
      final vouchers = <Voucher>[];
      for (final dVoucher in json['vouchers']) {
        final voucher = Voucher.fromJson(dVoucher as Map<String, dynamic>);
        vouchers.add(voucher);
      }
      vouchers.sort((a, b) => a.name.compareTo(b.name));
      final activeVoucherIdx = json['activeVoucherIdx'] != null
          ? json['activeVoucherIdx'] as int
          : 0;
      if (vouchers.isEmpty) {
        return const VouchersEmpty();
      }
      return VouchersLoaded(
        vouchers: vouchers,
        activeVoucherIdx: activeVoucherIdx,
      );
    } catch (e) {
      log.e(e);
    }

    return const VouchersEmpty();
  }

  @override
  Map<String, Object> toJson(VouchersState state) {
    final data = {
      'vouchers': state.vouchers.isEmpty
          ? <String>[]
          : state.vouchers
              .map<Map<String, String>>((voucher) => voucher.toJson())
              .toList(),
      'activeVoucherIdx': 0,
    };
    return data;
  }
}
