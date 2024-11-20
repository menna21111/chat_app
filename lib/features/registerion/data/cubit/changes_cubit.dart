import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'changes_state.dart';

class ChangesCubit extends Cubit<ChangesState> {
  ChangesCubit() : super(ChangesInitial());

  void changestate(dynamic S, dynamic w) {
    S = w;
    emit(Changescuess(s: S)); 
  }
}
