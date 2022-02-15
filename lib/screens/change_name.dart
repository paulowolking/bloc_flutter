import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/container.dart';
import '../bloc/cubit/name.dart';

class NameContainer extends BlocContainer {
  const NameContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _NameView();
  }
}

class _NameView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = context.read<NameCubit>().state;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Change name'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Desired name: ',
                ),
                style: const TextStyle(fontSize: 24),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () {
                        final name = _nameController.text;
                        context.read<NameCubit>().change(name);
                      },
                      child: const Text('Change')),
                ),
              )
            ],
          ),
        ));
  }
}
