import 'package:bytebank/bloc/bloc_state.dart';
import 'package:bytebank/bloc/cubit/deposit_cubit.dart';
import 'package:bytebank/screens/deposit/deposit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepositFormRoute {
  Widget build(BuildContext context) {
    return BlocProvider<DepositCubit>(
        create: (buildContext) {
          return DepositCubit();
        },
        child: BlocListener<DepositCubit, BlocState>(
          listener: (context, state) {
            if (state is DoneBlocState) {
              Navigator.pop(context);
            }
          },
          child: DepositForm(),
        ));
  }
}
