import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/timer/utils/ticker.dart';

void main() {
  group('Ticker', () {
    test('first value is not 0', () async {
      final stream = const Ticker().tick();
      await stream.first.then((value) => expect(value != 0, true));
    });
  });
}
