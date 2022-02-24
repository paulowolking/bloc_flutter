import 'package:bytebank/bloc/bloc_state.dart';
import 'package:bytebank/bloc/cubit/contact_list_cubit.dart';
import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact/list/contact_item.dart';
import 'package:bytebank/values/routes.dart';
import 'package:bytebank/values/translate_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContacstList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = TranslateI18n(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.transfer),
      ),
      body: BlocBuilder<ContactListCubit, BlocState>(builder: (context, state) {
        if (state is InitBlocState || state is LoadingBlocState) {
          return const Progress();
        }

        if (state is DoneBlocState) {
          final List<Contact> contacts = state.result;
          return ListView.builder(
            itemBuilder: (context, index) {
              return ContactItem(
                contacts[index],
                onClick: () => Navigator.of(context).pushNamed(AppRoutes.transactionForm, arguments: contacts[index]),
              );
            },
            itemCount: contacts.length,
          );
        }

        return Text(i18n.unknow_error);
      }),
      floatingActionButton: buildAddContactButton(context),
    );
  }

  FloatingActionButton buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.of(context).pushNamed(AppRoutes.contactForm);

        update(context);
      },
      child: const Icon(Icons.add),
    );
  }

  void update(BuildContext context) {
    context.read<ContactListCubit>().reload();
  }
}
