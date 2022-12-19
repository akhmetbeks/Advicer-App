import 'package:advicer/2_application/pages/advice/bloc/advice_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('AdvicerBloc', () {
    group('should emit', () {
      blocTest<AdviceBloc, AdviceState>(
        'nothing when no event is added',
        build: () => AdviceBloc(),
        expect: () => const <AdviceState>[],
      );

      blocTest(
        '[AdviceStateLoading, AdviceStateError] when AdviceRequestedEvent is added',
        build: () => AdviceBloc(),
        act: (bloc) => bloc.add(AdviceRequestedEvent()),
        wait: const Duration(seconds: 3),
        expect: () => <AdviceState>[
          AdviceStateLoading(),
          AdviceStateError(message: 'fake error')
        ],
      );
    });
  });
}
