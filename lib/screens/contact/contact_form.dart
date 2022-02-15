import 'package:bytebank/bloc/cubit/contact_form_cubit.dart';
import 'package:bytebank/components/container.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc_state.dart';

class ContactFormContainer extends BlocContainer {
  @override
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
          child: _ContactFormState(),
        ));
  }
}

class _ContactFormState extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _accountNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full name'),
              style: const TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: _accountNumberController,
                decoration: const InputDecoration(labelText: 'Account Number'),
                style: const TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    final String name = _nameController.text;
                    final int? accountNumber =
                        int.tryParse(_accountNumberController.text);
                    debugPrint(accountNumber.toString());
                    final Contact newContact = Contact(0, name, accountNumber);
                    BlocProvider.of<ContactFormCubit>(context).save(newContact);
                  },
                  child: const Text('Create'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
