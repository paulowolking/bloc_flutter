import 'package:bytebank/bloc/cubit/transaction_list_cubit.dart';
import 'package:bytebank/screens/transaction/list/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionListRoute {
  Widget build(BuildContext context) {
    return BlocProvider<TransactionListCubit>(
      create: (BuildContext context) {
        final cubit = TransactionListCubit();
        cubit.reload();
        return cubit;
      },
      child: TransactionsList(),
    );
  }
}
