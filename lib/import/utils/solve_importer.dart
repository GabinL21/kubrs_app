import 'package:kubrs_app/solve/model/solve.dart';

abstract class SolveImporter {
  List<Solve> convertRawDataToSolves(String rawData);
}
