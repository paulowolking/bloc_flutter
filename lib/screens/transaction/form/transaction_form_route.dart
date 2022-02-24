import 'package:bytebank/bloc/bloc_state.dart';
import 'package:bytebank/bloc/cubit/transaction_form_cubit.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/transaction/form/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionFormRoute {
  final Contact _contact;

  TransactionFormRoute(this._contact);

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
          child: TransactionForm(_contact),
        ));
  }
}
