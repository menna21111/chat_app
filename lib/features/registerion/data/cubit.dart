import 'package:chatsapp/features/registerion/data/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Changee extends Cubit<State> {
  Changee() : super(Initial());

  void changestate(dynamic S, dynamic w) {
    S = w;
    emit(Changestate(s: S));
  }
}
