part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class GetFirstHistory extends HistoryEvent {
  const GetFirstHistory();
}

class GetNextHistory extends HistoryEvent {
  const GetNextHistory();
}
