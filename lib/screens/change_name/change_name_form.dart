import 'package:bytebank/bloc/cubit/name.dart';
import 'package:bytebank/components/container.dart';
import 'package:bytebank/values/translate_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final i18n = TranslateI18n(context);

    _nameController.text = context.read<NameCubit>().state;

    return Scaffold(
        appBar: AppBar(
          title: Text(i18n.change_name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: i18n.desired_name,
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
                      child: Text(i18n.change)),
                ),
              )
            ],
          ),
        ));
  }
}
