import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/logic/cubit/accounts/accounts_cubit.dart';
import 'package:my_sarafu/logic/cubit/vouchers/vouchers_cubit.dart';
import 'package:my_sarafu/logic/data/model/voucher.dart';
import 'package:my_sarafu/presentation/widgets/bottom_nav/view/bottom_nav.dart';
import 'package:my_sarafu/presentation/widgets/voucher/voucher_list_item.dart';

class VouchersView extends StatelessWidget {
  const VouchersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(key: Key('bottomNavBar')),
      body: SafeArea(
        child: Column(
          children: [
            BlocConsumer<VouchersCubit, VouchersState>(
              listener: (context, state) {
                if (state is VouchersError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is VouchersInitial) {
                  return buildInitialInput(context);
                } else if (state is VouchersLoaded) {
                  return buildVoucherList(context, state.vouchers);
                } else {
                  // (state is WeatherError)
                  return buildInitialInput(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildInitialInput(BuildContext context) {
  final account = context.read<AccountsCubit>().activeAccount;
  if (account == null) {
    return const Center(
      child: Text('No account selected'),
    );
  }
  return Center(
    child: TextButton(
      onPressed: () =>
          context.read<VouchersCubit>().fetchAllVouchers(account.address),
      child: const Text(
        'Fetch All Vouchers',
        style: TextStyle(color: Colors.black),
      ),
    ),
  );
}

Widget buildVoucherList(BuildContext context, List<Voucher> vouchers) {
  final voucherCubit = context.read<VouchersCubit>();
  final account = context.read<AccountsCubit>().activeAccount;
  if (account == null) {
    return const Center(
      child: Text('No account selected'),
    );
  }

  return Expanded(
    child: Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => voucherCubit.fetchAllVouchers(account.address),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: ListView.builder(
                // Providing a restorationId allows the ListView to restore the
                // scroll position when a user leaves and returns to the app after it
                // has been killed while running in the background.
                restorationId: 'vouchersListView',
                itemCount: vouchers.length,
                itemBuilder: (BuildContext context, int index) {
                  final voucher = vouchers[index];
                  return VoucherListItemWidget(voucher: voucher);
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
