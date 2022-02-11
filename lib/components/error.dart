import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String _message;

  const ErrorView(this._message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Erro'),
      ),
      body: Text(_message),
    );
  }
}
