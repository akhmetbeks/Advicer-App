import 'package:advicer/1_domain/entities/advice_entities.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:advicer/2_application/pages/advice/cubit/advice_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceUsecases extends Mock implements AdviceUsecases {}

void main() {
  group('AdvicerCubit', () {
    group('should emit', () {
      MockAdviceUsecases mockAdviceUsecases = MockAdviceUsecases();
      blocTest('nothing when no emit is called',
          build: () => AdviceCubit(adviceUsecases: mockAdviceUsecases),
          expect: () => const <AdviceCubitState>[]);

      blocTest(
          '[AdviceStateLoading, AdviceStateLoaded] when adviceRequested is called',
          setUp: () => when(() => mockAdviceUsecases.getAdvice()).thenAnswer(
              (invocation) => Future.value(const Right<Failure, AdviceEntities>(
                  AdviceEntities(advice: 'advice', id: 2)))),
          build: () => AdviceCubit(adviceUsecases: mockAdviceUsecases),
          act: (cubit) => cubit.adviceRequested(),
          expect: () => const <AdviceCubitState>[
                AdviceStateLoading(),
                AdviceStateLoaded(advice: 'advice')
              ]);

      group(
          '[AdviceStateLoading, AdviceStateError] when adviceRequested is called',
          () {
        blocTest(
          'and a ServerFailure occurs',
          setUp: () => when(() => mockAdviceUsecases.getAdvice()).thenAnswer(
              (invocation) =>
                  Future.value(Left<Failure, AdviceEntities>(ServerFailure()))),
          build: () => AdviceCubit(adviceUsecases: mockAdviceUsecases),
          act: (cubit) => cubit.adviceRequested(),
          expect: () => const <AdviceCubitState>[
            AdviceStateLoading(),
            AdviceStateError(message: 'Ups, API Error. please try again!')
          ],
        );

        blocTest(
          'and a CacheFailure occurs',
          setUp: () => when(() => mockAdviceUsecases.getAdvice()).thenAnswer(
              (invocation) =>
                  Future.value(Left<Failure, AdviceEntities>(CacheFailure()))),
          build: () => AdviceCubit(adviceUsecases: mockAdviceUsecases),
          act: (cubit) => cubit.adviceRequested(),
          expect: () => const <AdviceCubitState>[
            AdviceStateLoading(),
            AdviceStateError(message: 'Ups, chache failed. Please try again!')
          ],
        );

        blocTest(
          'and a GeneralFailure occurs',
          setUp: () => when(() => mockAdviceUsecases.getAdvice()).thenAnswer(
              (invocation) =>
                  Future.value(Left<Failure, AdviceEntities>(GeneralFailure()))),
          build: () => AdviceCubit(adviceUsecases: mockAdviceUsecases),
          act: (cubit) => cubit.adviceRequested(),
          expect: () => const <AdviceCubitState>[
            AdviceStateLoading(),
            AdviceStateError(message: 'Ups, something gone wrong. Please try again!')
          ],
        );
      });
    });
  });
}
