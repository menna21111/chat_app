part of 'changes_cubit.dart';

@immutable
sealed class ChangesState {}

final class ChangesInitial extends ChangesState {}

class Changescuess extends ChangesState {
final  dynamic s;

  Changescuess({this.s});
}
