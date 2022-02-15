import 'package:bytebank/bloc/bloc_state.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/dao/contact_dao.dart';

class ContactFormCubit extends Cubit<BlocState> {
  ContactFormCubit() : super(const InitBlocState());

  final ContactDao _contactDao = ContactDao();

  void save(Contact contact) async {
    emit(const LoadingBlocState());
    await _contactDao.save(contact).then((result) {
      emit(DoneBlocState(result));
    }).catchError((onError) {
      emit(ErrorBlocState(onError.toString()));
    });
  }
}
