import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';
import 'package:kubrs_app/stats/model/stat.dart';

class MeanStat extends Stat with EquatableMixin {
  MeanStat(this._value, this._nbSolves) : _dnf = false;
  MeanStat.empty(this._nbSolves)
      : _value = null,
        _dnf = false;
  MeanStat.dnf(this._nbSolves)
      : _value = null,
        _dnf = true;

  final int? _value;
  final int _nbSolves;
  final bool _dnf;

  @override
  int? get value {
    return _value;
  }

  @override
  bool get isDnf {
    return _dnf;
  }

  @override
  String get displayedName {
    return 'Mo$_nbSolves';
  }

  @override
  String get displayedValue {
    if (_dnf) return 'DNF';
    if (_value == null) return '-';
    final duration = Duration(milliseconds: _value!);
    return DurationFormatter.format(duration);
  }

  @override
  List<Object?> get props => [_nbSolves, _value, _dnf];
}
