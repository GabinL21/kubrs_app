import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';
import 'package:kubrs_app/stats/model/stat.dart';

class BestStat extends Stat with EquatableMixin {
  BestStat(this._value);
  BestStat.empty() : _value = null;

  final int? _value;

  @override
  String getDisplayedName() {
    return 'Best';
  }

  @override
  String getDisplayedValue() {
    if (_value == null) return '-';
    final duration = Duration(milliseconds: _value!);
    return DurationFormatter.format(duration);
  }

  @override
  List<Object?> get props => [_value];
}
