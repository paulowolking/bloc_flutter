import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit(String language) : super(language);
}
