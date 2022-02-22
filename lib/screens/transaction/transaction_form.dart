import 'package:bytebank/bloc/bloc_state.dart';
import 'package:bytebank/bloc/cubit/transaction_form_cubit.dart';
import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/error.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/values/translate_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class TransactionFormContainer extends BlocContainer {
  final Contact _contact;

  TransactionFormContainer(this._contact);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
        create: (buildContext) {
          return TransactionFormCubit();
        },
        child: BlocListener<TransactionFormCubit, BlocState>(
          listener: (context, state) {
            if (state is DoneBlocState) {
              Navigator.pop(context);
            }
          },
          child: _TransactionForm(_contact),
        ));
  }
}

class _TransactionForm extends StatelessWidget {
  final Contact contact;

  const _TransactionForm(this.contact);

  @override
  Widget build(BuildContext context) {
    final i18n = TranslateI18n(context);

    return BlocBuilder<TransactionFormCubit, BlocState>(builder: (context, state) {
      if (state is InitBlocState) {
        return _BasicForm(contact);
      }

      if (state is LoadingBlocState || state is DoneBlocState) {
        return const ProgressView();
      }

      if (state is ErrorBlocState) {
        return ErrorView(state.message);
      }

      return ErrorView(i18n.unknow_error);
    });
  }
}

class _BasicForm extends StatelessWidget {
  final Contact _contact;

  final TextEditingController _valueController = TextEditingController();
  final String transactionId = const Uuid().v4();

  _BasicForm(this._contact);

  @override
  Widget build(BuildContext context) {
    final i18n = TranslateI18n(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.new_transfer),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: i18n.value),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text(i18n.transfer),
                    onPressed: () {
                      final int? value = int.tryParse(_valueController.text);
                      if (value != null) {
                        if (!checkBalanceIsValid(context, i18n.no_has_balance)) {
                          return;
                        }

                        final transactionCreated = Transaction(transactionId, value, _contact);

                        showDialog(
                            context: context,
                            builder: (contextDialog) {
                              return TransactionAuthDialog(
                                onConfirm: (String password) {
                                  BlocProvider.of<TransactionFormCubit>(context)
                                      .save(transactionCreated, password, context);
                                },
                              );
                            });
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool checkBalanceIsValid(BuildContext context, String message) {
    final int? value = int.tryParse(_valueController.text);
    final cubit = context.read<TransactionFormCubit>();

    if (!cubit.validTransfer(context, value)) {
      showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog(message);
          });
      return false;
    }
    return true;
  }

// Future _showSuccessMessage(
//     Transaction? transaction, BuildContext context) async {
//   if (transaction != null) {
//     await showDialog(
//         context: context,
//         builder: (contextDialog) {
//           return SuccessDialog('successful transaction');
//         });
//
//     Navigator.pop(context);
//   }
// }
}
