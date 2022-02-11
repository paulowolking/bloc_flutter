import 'package:bytebank/bloc/bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../http/webclients/transaction_webclient.dart';

class TransactionListCubit extends Cubit<BlocState> {
  TransactionListCubit() : super(const InitBlocState());

  void reload() async {
    emit(const LoadingBlocState());
    await TransactionWebClient()
        .findAll()
        .then((transactions) => emit(DoneBlocState(transactions)))
        .catchError((onError) {
      emit(ErrorBlocState(onError.toString()));
    });
  }
}
