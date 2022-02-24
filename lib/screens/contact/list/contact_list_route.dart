import 'package:bytebank/bloc/cubit/contact_list_cubit.dart';
import 'package:bytebank/screens/contact/list/contacts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListRoute {
  Widget build(BuildContext context) {
    return BlocProvider<ContactListCubit>(
      create: (BuildContext context) {
        final cubit = ContactListCubit();
        cubit.reload();
        return cubit;
      },
      child: ContacstList(),
    );
  }
}
