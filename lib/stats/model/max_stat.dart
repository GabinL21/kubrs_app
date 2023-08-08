import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';
import 'package:kubrs_app/stats/model/stat.dart';

class BestStat extends Stat with EquatableMixin {
  BestStat(this._value);

  final int _value;

  @override
  String getDisplayedName() {
    return 'Best';
  }

  @override
  String getDisplayedScore() {
    return DurationFormatter.format(Duration(milliseconds: _value));
  }

  @override
  List<Object?> get props => [_value];
}
