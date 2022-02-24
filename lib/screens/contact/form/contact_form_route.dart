import 'package:bytebank/bloc/bloc_state.dart';
import 'package:bytebank/bloc/cubit/contact_form_cubit.dart';
import 'package:bytebank/screens/contact/form/contact_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactFormRoute {
  Widget build(BuildContext context) {
    return BlocProvider<ContactFormCubit>(
        create: (buildContext) {
          return ContactFormCubit();
        },
        child: BlocListener<ContactFormCubit, BlocState>(
          listener: (context, state) {
            if (state is DoneBlocState) {
              Navigator.pop(context);
            }
          },
          child: ContactFormState(),
        ));
  }
}
