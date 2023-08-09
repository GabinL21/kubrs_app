import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';
import 'package:kubrs_app/stats/model/stat.dart';

class AverageStat extends Stat with EquatableMixin {
  AverageStat(this._value, this._nbSolves);
  AverageStat.empty(this._nbSolves) : _value = null;

  final int? _value;
  final int _nbSolves;

  @override
  String getDisplayedName() {
    return 'Ao$_nbSolves';
  }

  @override
  String getDisplayedValue() {
    if (_value == null) return '-';
    final duration = Duration(milliseconds: _value!);
    return DurationFormatter.format(duration);
  }

  @override
  List<Object?> get props => [_nbSolves, _value];
}
