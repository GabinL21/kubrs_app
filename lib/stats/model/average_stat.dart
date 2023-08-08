import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';
import 'package:kubrs_app/stats/model/stat.dart';

class AverageStat extends Stat with EquatableMixin {
  AverageStat(this._nbSolves, this._value);

  final int _nbSolves;
  final int _value;

  @override
  String getDisplayedName() {
    return 'Ao$_nbSolves';
  }

  @override
  String getDisplayedScore() {
    return DurationFormatter.format(Duration(milliseconds: _value));
  }

  @override
  List<Object?> get props => [_nbSolves, _value];
}
