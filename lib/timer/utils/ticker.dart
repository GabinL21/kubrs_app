class Ticker {
  const Ticker();

  Stream<int> tick() {
    return Stream.periodic(
      const Duration(milliseconds: 10),
      (x) => (x + 1) * 10, // x + 1 since the first event is 0 not 1
    );
  }
}
