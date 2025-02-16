import 'package:equatable/equatable.dart';
import 'package:kubrs_app/trainer/model/algorithm.dart';

class AlgorithmGroup extends Equatable {
  const AlgorithmGroup({
    required this.id,
    required this.name,
    required this.algorithms,
  });

  final int id;
  final String name;
  final List<Algorithm> algorithms;

  @override
  List<Object?> get props {
    return [id];
  }
}
