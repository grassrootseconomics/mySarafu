import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/logic/cubit/settings/settings_cubit.dart';
import 'package:my_sarafu/logic/cubit/tokens/token_cubit.dart';
import 'package:my_sarafu/logic/data/meta_repository.dart';
import 'package:my_sarafu/logic/data/model/token.dart';
import 'package:my_sarafu/presentation/widgets/bottom_nav/view/bottom_nav.dart';
import 'package:my_sarafu/presentation/widgets/icon.dart';

class TokenDetailedView extends StatelessWidget {
  const TokenDetailedView({required this.token, Key? key}) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(key: Key('bottomNavBar')),
      body: BlocProvider(
        create: (context) => TokenCubit(
          token: token,
          metaRespository: MetaRepository(
            metaUrl: context.read<SettingsCubit>().state.metaUrl,
          ),
        )..fetchMeta(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              BlocConsumer<TokenCubit, TokenState>(
                listener: (context, state) {
                  if (state is TokenError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is TokenInitial) {
                    return TokenDetailedWidget(token: state.token);
                  } else if (state is TokenLoaded) {
                    return TokenDetailedWidget(
                      token: state.token,
                      meta: state.meta,
                      proof: state.proof,
                    );
                  } else if (state is TokenLoading) {
                    return TokenDetailedWidget(
                      token: state.token,
                      meta: state.meta,
                      proof: state.proof,
                      loading: true,
                    );
                  } else {
                    // (state is WeatherError)
                    return TokenDetailedWidget(
                      token: state.token,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TokenDetailedWidget extends StatelessWidget {
  const TokenDetailedWidget({
    Key? key,
    required this.token,
    this.meta,
    this.proof,
    this.loading = false,
  }) : super(key: key);

  final Token token;
  final VoucherIssuer? meta;
  final VoucherProof? proof;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: IconWidget(),
            ),
            Text(
              'Name: ${token.name}',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              '${token.userFacingBalance} ${token.symbol}',
              textAlign: TextAlign.end,
            ),
            Text(
              'Decimals: ${token.decimals}',
              textAlign: TextAlign.end,
            ),
            Text(
              'Meta Name: ${meta?.name}',
              textAlign: TextAlign.end,
            ),
            Text(
              'Location: ${meta?.location}',
              textAlign: TextAlign.end,
            ),
            Text(
              'Country: ${meta?.countryCode}',
              textAlign: TextAlign.end,
            ),
            Text(
              'Email: ${meta?.contact.email}',
              textAlign: TextAlign.end,
            ),
            Text(
              'Phone:  ${meta?.contact.phone}',
              textAlign: TextAlign.end,
            ),
            Text(
              'Description: ${proof?.description}',
              textAlign: TextAlign.end,
            ),
            Text(
              'Issuer: ${proof?.issuer}',
              textAlign: TextAlign.end,
            ),
            Text(
              'Namespace:  ${proof?.namespace}',
              textAlign: TextAlign.end,
            ),
            Text(
              'Version: ${proof?.version}',
              textAlign: TextAlign.end,
            ),
            Text(
              'Proofs: ${proof?.proofs}',
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
