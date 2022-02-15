import 'package:bytebank/bloc/bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../models/notifiers/balance.dart';

class DepositCubit extends Cubit<BlocState> {
  DepositCubit() : super(const InitBlocState());

  void createDeposit(context, String valueDeposit) {
    emit(const LoadingBlocState());
    final double? value = double.tryParse(valueDeposit);
    if (_validDeposit(value)) {
      _updateState(context, value);
      emit(const DoneBlocState(null));
    }
  }

  bool _validDeposit(value) {
    return value != null;
  }

  void _updateState(context, value) {
    Provider.of<Balance>(context, listen: false).add(value);
  }
}
