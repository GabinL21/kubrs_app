import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/timer/view/tags/tag_toggle_button.dart';

class PlusTwoTagToggleButton extends TagToggleButton {
  const PlusTwoTagToggleButton({super.key});

  @override
  String getButtonText() {
    return '+2';
  }

  @override
  SolveEvent getSolveEvent(Solve solve) {
    return TogglePlusTwoTag(solve: solve);
  }

  @override
  bool isButtonActivated(Solve solve) {
    return solve.plusTwo;
  }
}
