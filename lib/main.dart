import 'dart:async';

import 'package:bytebank/components/theme.dart';
import 'package:bytebank/models/notifiers/balance.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/notifiers/transfers.dart';
import 'package:bytebank/screens/contact/contact_form.dart';
import 'package:bytebank/screens/contact/contacts_list.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:bytebank/screens/deposit/deposit_form.dart';
import 'package:bytebank/screens/change_name.dart';
import 'package:bytebank/screens/transaction/transaction_form.dart';
import 'package:bytebank/screens/transaction/transaction_list.dart';
import 'package:bytebank/values/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/cubit/name.dart';
import 'bloc/cubit/localization_cubit.dart';

//Apenas em debug.
class LogObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print("${bloc.runtimeType} > $change");
    super.onChange(bloc, change);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FirebaseCrashlytics.instance.setUserIdentifier('Paulo Henrique');
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  // Apenas em debug o LogObserver.
  BlocOverrides.runZoned(() {
    runZonedGuarded<Future<void>>(() async {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => Balance(0)),
            ChangeNotifierProvider(create: (context) => Tranfers()),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<NameCubit>(
                create: (BuildContext context) => NameCubit('Paulo'),
              ),
              BlocProvider<CurrentLocaleCubit>(
                create: (BuildContext context) => CurrentLocaleCubit('en'),
              ),
            ],
            child: const ByteBankApp(),
          ),
        ),
      );
    },
        (error, stack) =>
            FirebaseCrashlytics.instance.recordError(error, stack));
  }, blocObserver: LogObserver());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: byteBankTheme,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          final arguments = settings.arguments;

          switch (settings.name) {
            case AppRoutes.home:
              return MaterialPageRoute(builder: (context) {
                return DashboardContainer();
              });
            case AppRoutes.contactsList:
              return MaterialPageRoute(builder: (context) {
                return const ContactListContainer();
              });
            case AppRoutes.contactForm:
              return MaterialPageRoute(builder: (context) {
                return ContactFormContainer();
              });
            case AppRoutes.transactionsList:
              return MaterialPageRoute(builder: (context) {
                return const TransactionListContainer();
              });
            case AppRoutes.transactionForm:
              return MaterialPageRoute(builder: (context) {
                return TransactionFormContainer(arguments as Contact);
              });
            case AppRoutes.depositForm:
              return MaterialPageRoute(builder: (context) {
                return const DepositContainer();
              });
            case AppRoutes.changeName:
              return MaterialPageRoute(builder: (context) {
                return const NameContainer();
              });
            default:
              return null;
          }
        });
  }
}
