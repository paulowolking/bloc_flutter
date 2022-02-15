import 'package:bytebank/bloc/bloc_state.dart';
import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubit/contact_list_cubit.dart';
import 'contact_item.dart';

class ContactListContainer extends BlocContainer {
  const ContactListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactListCubit>(
      create: (BuildContext context) {
        final cubit = ContactListCubit();
        cubit.reload();
        return cubit;
      },
      child: _ContacstList(),
    );
  }
}

class _ContacstList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tranfer'),
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
                onClick: () => Navigator.of(context)
                    .pushNamed('transaction_form', arguments: contacts[index]),
              );
            },
            itemCount: contacts.length,
          );
        }

        return const Text('Unknown error');
      }),
      floatingActionButton: buildAddContactButton(context),
    );
  }

  FloatingActionButton buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.of(context).pushNamed('contact_form');

        update(context);
      },
      child: const Icon(Icons.add),
    );
  }

  void update(BuildContext context) {
    context.read<ContactListCubit>().reload();
  }
}
