import 'package:advicer/2_application/pages/advice/widgets/advice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest(String text) {
    return MaterialApp(
      home: AdviceField(advice: text),
    );
  }

  group('AdviceField ', () {
    group('should be displayed correctly', () {
      testWidgets('when a short text is given', (widgetTester) async {
        const adviceText = 'a';
        await widgetTester.pumpWidget(widgetUnderTest(adviceText));
        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.textContaining('a');

        expect(adviceFieldFinder, findsOneWidget);
      });

      testWidgets('when no text is given', (widgetTester) async{
        const text = '';

        await widgetTester.pumpWidget(widgetUnderTest(text));
        await widgetTester.pumpAndSettle();
        
        final adviceFieldFinder = find.text(AdviceField.emptyAdvice);
        final adviceText = widgetTester.widget<AdviceField>(find.byType(AdviceField)).advice;

        expect(adviceFieldFinder, findsOneWidget);
        expect(adviceText, '');
      });
    });
  });
}
