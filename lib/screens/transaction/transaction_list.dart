import 'package:bytebank/bloc/bloc_state.dart';
import 'package:bytebank/bloc/cubit/transaction_list_cubit.dart';
import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/values/translate_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionListContainer extends StatelessWidget {
  const TransactionListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionListCubit>(
      create: (BuildContext context) {
        final cubit = TransactionListCubit();
        cubit.reload();
        return cubit;
      },
      child: _TransactionsList(),
    );
  }
}

class _TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = TranslateI18n(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.transaction_feed),
      ),
      body: BlocBuilder<TransactionListCubit, BlocState>(builder: (context, state) {
        if (state is LoadingBlocState) {
          return const Progress();
        }

        if (state is DoneBlocState) {
          List<Transaction> transactions = state.result;
          if (transactions.isEmpty) {
            return CenteredMessage(
              i18n.no_transaction_found,
              icon: Icons.warning,
            );
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              final Transaction transaction = transactions[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.monetization_on),
                  title: Text(
                    transaction.value.toString(),
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    transaction.contact.accountNumber.toString(),
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
        }

        if (state is ErrorBlocState) {
          return CenteredMessage(
            i18n.unknow_error,
            icon: Icons.warning,
          );
        }

        return CenteredMessage(
          i18n.unknow_error,
          icon: Icons.warning,
        );
      }),
    );
  }
}
