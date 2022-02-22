import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/localization_cubit.dart';

class TranslateI18n extends ViewI18N {
  TranslateI18n(BuildContext context) : super(context);

  String get deposit => localize({
        "pt-br": "Depositar",
        "en": "Deposit",
      });

  String get transfer => localize({
        "pt-br": "Transferir",
        "en": "Transfer",
      });

  String get transaction_feed => localize({
        "pt-br": "Transações",
        "en": "Transaction",
      });

  String get change_name => localize({
        "pt-br": "Alterar nome",
        "en": "Change name",
      });

  String get confirm => localize({
        "pt-br": "Confirmar",
        "en": "Confirm",
      });

  String get value => localize({
        "pt-br": "Valor",
        "en": "Value",
      });

  String get new_transfer => localize({
        "pt-br": "Nova Transação",
        "en": "New transaction",
      });

  String get placeholder_value => localize({
        "pt-br": "0.00",
        "en": "0.00",
      });

  String get title_new_deposit => localize({
        "pt-br": "Novo depósito",
        "en": "New deposit",
      });

  String get title_new_contact => localize({
        "pt-br": "Novo contato",
        "en": "New contact",
      });

  String get full_name => localize({
        "pt-br": "Nome completo",
        "en": "Full name",
      });

  String get account_number => localize({
        "pt-br": "Número da conta",
        "en": "Account number",
      });

  String get create => localize({
        "pt-br": "Criar",
        "en": "Create",
      });

  String get unknow_error => localize({
        "pt-br": "Algum erro",
        "en": "Unknown error",
      });

  String get your_balance => localize({
        "pt-br": "Seu saldo",
        "en": "Your balance",
      });

  String get no_has_balance => localize({
        "pt-br": "Saldo insuficiente",
        "en": "No has balance",
      });

  String get no_transaction_found => localize({
        "pt-br": "Nenhuma transação encontrada",
        "en": "No transaction found",
      });

  String get desired_name => localize({
        "pt-br": "Novo nome",
        "en": "Desired name",
      });

  String get change => localize({
        "pt-br": "Alterar",
        "en": "Change",
      });
}

class ViewI18N {
  String? _language;

  ViewI18N(BuildContext context) {
    _language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  String localize(Map<String, String> values) {
    return values[_language] ?? '';
  }
}
