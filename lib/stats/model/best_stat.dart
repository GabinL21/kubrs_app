import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';
import 'package:kubrs_app/stats/model/stat.dart';

class BestStat extends Stat with EquatableMixin {
  BestStat(this._value) : _dnf = false;
  BestStat.empty()
      : _value = null,
        _dnf = false;
  BestStat.dnf()
      : _value = null,
        _dnf = true;

  final int? _value;
  final bool _dnf;

  @override
  String get displayedName {
    return 'Best';
  }

  @override
  String get displayedValue {
    if (_dnf) return 'DNF';
    if (_value == null) return '-';
    final duration = Duration(milliseconds: _value!);
    return DurationFormatter.format(duration);
  }

  @override
  List<Object?> get props => [_value];
}
