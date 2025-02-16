import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/trainer/model/algorithm_group.dart';
import 'package:kubrs_app/trainer/utils/algorithm_loader.dart';

part 'algorithms_event.dart';
part 'algorithms_state.dart';

class AlgorithmsBloc extends Bloc<AlgorithmsEvent, AlgorithmsState> {
  AlgorithmsBloc() : super(const AlgorithmsInitial()) {
    on<LoadAlgorithms>(
      (event, emit) async {
        emit(const AlgorithmsLoading());
        final algorithmsGroup = await AlgorithmLoader.loadAlgorithmGroups();
        emit(AlgorithmsLoaded(algorithmsGroup));
      },
    );
    add(LoadAlgorithms());
  }
}
