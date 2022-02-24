import 'package:bytebank/bloc/cubit/name.dart';
import 'package:bytebank/screens/dashboard/balance_card.dart';
import 'package:bytebank/values/translate_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = TranslateI18n(context);

    // final name = context.read<NameCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(builder: (context, state) => Text('Welcome $state')),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 120,
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/bytebank_logo.png'),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: BalanceCard(),
            ),
            GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                _FeatureItem(i18n.deposit, Icons.monetization_on,
                    onClick: () => Navigator.of(context).pushNamed('deposit_form')),
                _FeatureItem(i18n.transfer, Icons.monetization_on,
                    onClick: () => Navigator.of(context).pushNamed('contacts_list')),
                _FeatureItem(i18n.transaction_feed, Icons.description,
                    onClick: () => Navigator.of(context).pushNamed('transaction_list')),
                _FeatureItem(i18n.change_name, Icons.person_outline,
                    onClick: () => Navigator.of(context).pushNamed('change_name')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  const _FeatureItem(this.name, this.icon, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 32,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
