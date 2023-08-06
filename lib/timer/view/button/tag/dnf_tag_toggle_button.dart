import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/timer/view/button/tag/tag_toggle_button.dart';

class DNFTagToggleButton extends TagToggleButton {
  const DNFTagToggleButton({super.key});

  @override
  String getButtonText() {
    return 'DNF';
  }

  @override
  SolveEvent getSolveEvent(Solve solve) {
    return ToggleDNFTag(solve: solve);
  }

  @override
  bool isButtonActivated(Solve solve) {
    return solve.dnf;
  }
}
