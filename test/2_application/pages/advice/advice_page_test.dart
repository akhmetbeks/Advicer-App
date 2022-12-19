import 'package:advicer/2_application/pages/advice/advice_page.dart';
import 'package:advicer/2_application/pages/advice/cubit/advice_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAdviceCubit extends MockCubit<AdviceCubitState>
    implements AdviceCubit {}

void main() {
  group('AdvicePage', () {
    late AdviceCubit mockAdviceCubit;
    setUp(() {
      mockAdviceCubit = MockAdviceCubit();
    });
    group('should return a Viewstate', () {
      testWidgets('Initial when cubit emits AdviceInitial()',
          (widgetTester) async {
        whenListen(
          mockAdviceCubit,
          Stream.fromIterable(const [AdviceInitial()]),
          initialState: const AdviceInitial(),
        );

        
      });
    });
  });
}
