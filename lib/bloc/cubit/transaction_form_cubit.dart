import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../http/webclients/transaction_webclient.dart';
import '../../models/notifiers/balance.dart';
import '../../models/transaction.dart';
import '../../models/notifiers/transfers.dart';
import '../bloc_state.dart';

class TransactionFormCubit extends Cubit<BlocState> {
  TransactionFormCubit() : super(const InitBlocState());

  bool validTransfer(context, value) {
    //Busca o provider de saldo e verifica se pode transferir.
    final balance = Provider.of<Balance>(context, listen: false);
    return value <= balance.value;
  }

  void save(Transaction transactionCreated, String password,
      BuildContext context) async {
    emit(const LoadingBlocState());
    _send(transactionCreated, password, context);
  }

  void _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    await TransactionWebClient()
        .save(context, transactionCreated, password)
        .then((transaction) {
      emit(const DoneBlocState(null));
      //Salvando no provider declarado na main.
      if (transaction != null) {
        //TODO: Não tá atualizando no provider.
        Provider.of<Tranfers>(context, listen: false).add(transaction);
        Provider.of<Balance>(context, listen: false)
            .remove(double.tryParse(transaction.value.toString()) ?? 0.0);
      }
    }).catchError((onError) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance
            .setCustomKey('exception', onError.toString());
        FirebaseCrashlytics.instance
            .setCustomKey('http_body', transactionCreated.toString());
        FirebaseCrashlytics.instance.recordError(onError, null);
      }

      emit(ErrorBlocState(onError.toString()));
    }, test: (e) => e is TimeoutException).catchError((onError) {
      emit(ErrorBlocState(onError.toString()));
    }, test: (e) => e is Exception).catchError((onError) {
      emit(ErrorBlocState(onError.toString()));
    });
  }
}
