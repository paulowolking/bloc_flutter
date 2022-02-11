import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/dao/contact_dao.dart';
import '../bloc_state.dart';

class ContactListCubit extends Cubit<BlocState> {
  final ContactDao _contactDao = ContactDao();

  ContactListCubit() : super(const InitBlocState());

  void reload() async {
    emit(const LoadingBlocState());
    _contactDao.findAll().then((value) => emit(
          DoneBlocState(value),
        ));
  }
}
