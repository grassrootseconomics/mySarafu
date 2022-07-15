import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysarafu/cubits/settings/settings_cubit.dart';
import 'package:mysarafu/cubits/vouchers/voucher_cubit.dart';
import 'package:mysarafu/model/voucher.dart';
import 'package:mysarafu/repository/meta_repository.dart';
import 'package:mysarafu/widgets/bottom_nav/view/bottom_nav.dart';

class VoucherDetailedView extends StatelessWidget {
  const VoucherDetailedView({required this.voucher, Key? key})
      : super(key: key);

  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(key: Key('bottomNavBar')),
      body: BlocProvider(
        create: (context) => VoucherCubit(
          voucher: voucher,
          metaRepository: MetaRepository(
            metaUrl: context.read<SettingsCubit>().state.metaUrl,
          ),
        )..fetchMeta(),
        child: SafeArea(
          child: BlocConsumer<VoucherCubit, VoucherState>(
            listener: (context, state) {
              if (state is VoucherError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is VoucherInitial) {
                return VoucherDetailedWidget(voucher: state.voucher);
              } else if (state is VoucherLoaded) {
                return VoucherDetailedWidget(
                  voucher: state.voucher,
                  meta: state.meta,
                  proof: state.proof,
                );
              } else if (state is VoucherLoading) {
                return VoucherDetailedWidget(
                  voucher: state.voucher,
                  meta: state.meta,
                  proof: state.proof,
                  loading: true,
                );
              } else {
                // (state is WeatherError)
                return VoucherDetailedWidget(
                  voucher: state.voucher,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class VoucherDetailedWidget extends StatelessWidget {
  const VoucherDetailedWidget({
    Key? key,
    required this.voucher,
    this.meta,
    this.proof,
    this.loading = false,
  }) : super(key: key);

  final Voucher voucher;
  final VoucherIssuer? meta;
  final VoucherProof? proof;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  voucher.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  width: 35,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  'assets/images/sarafu_logo.png',
                  height: 80,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              voucher.address.hexEip55,
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Description'),
                    subtitle: Text(proof?.description ?? 'None'),
                  ),
                  ListTile(
                    title: const Text('Location'),
                    trailing: Text(meta?.location ?? ''),
                  ),
                  ListTile(
                    title: const Text('Country'),
                    trailing: Text(meta?.countryCode ?? ''),
                  ),
                  ListTile(
                    title: const Text('Phone'),
                    trailing: Text(meta?.contact.phone ?? ''),
                  ),
                  ListTile(
                    title: const Text('Email'),
                    trailing: Text(meta?.contact.email ?? ''),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
