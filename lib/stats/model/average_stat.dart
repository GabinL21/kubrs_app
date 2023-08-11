import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';
import 'package:kubrs_app/stats/model/stat.dart';

class AverageStat extends Stat with EquatableMixin {
  AverageStat(this._value, this._nbSolves) : _dnf = false;
  AverageStat.empty(this._nbSolves)
      : _value = null,
        _dnf = false;
  AverageStat.dnf(this._nbSolves)
      : _value = null,
        _dnf = true;

  final int? _value;
  final int _nbSolves;
  final bool _dnf;

  @override
  String get displayedName {
    return 'Ao$_nbSolves';
  }

  @override
  String get displayedValue {
    if (_dnf) return 'DNF';
    if (_value == null) return '-';
    final duration = Duration(milliseconds: _value!);
    return DurationFormatter.format(duration);
  }

  @override
  List<Object?> get props => [_nbSolves, _value];
}
