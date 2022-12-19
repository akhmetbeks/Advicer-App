import 'package:advicer/2_application/pages/advice/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class onCustomButtonTap {
  void call();
}

class MockOnCustomButtonTap extends Mock implements onCustomButtonTap {}

void main() {
  Widget widgetUnderTest({Function()? callback}) {
    return MaterialApp(
      home: Scaffold(
          body: CustomButton(
        onCalled: callback,
      )),
    );
  }

  group('CustomButton', () {
    group('should handle button rendering correctly', () {
      testWidgets('when sb taps on a button', (widgetTester) async {
        final mockOnCustomButtonTap = MockOnCustomButtonTap();
        await widgetTester
            .pumpWidget(widgetUnderTest(callback: mockOnCustomButtonTap));

        final customButtonFinder = find.byType(CustomButton);

        await widgetTester.tap(customButtonFinder);
        verify(mockOnCustomButtonTap()).called(1);
      });
    });
  });
}
