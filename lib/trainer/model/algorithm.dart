import 'package:equatable/equatable.dart';
import 'package:kubrs_app/trainer/model/cube_pattern.dart';

class Algorithm extends Equatable {
  const Algorithm({
    required this.id,
    required this.name,
    required this.solution,
    required this.pattern,
    required this.scrambles,
  });

  final int id;
  final String name;
  final String solution;
  final CubePattern pattern;
  final List<String> scrambles;

  @override
  List<Object?> get props {
    return [id];
  }
}
