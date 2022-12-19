import 'dart:math';

import 'package:advicer/0_data/repositories/advice_repo_impl.dart';
import 'package:advicer/1_domain/entities/advice_entities.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'advice_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepoImpl>()])
void main() {
  group('AdviceUsecases', () {
    group('should return AdviceEntities', () {
      test('when AdviceRepoImpl returns a AdviceModel', () async{
        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        final adviceUsecasesUnderTest = AdviceUsecases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromDatasource()).thenAnswer(
            (realInvocation) => Future.value(
                const Right(AdviceEntities(advice: 'test', id: 19))));

        final result = await adviceUsecasesUnderTest.getAdvice();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(result, const Right<Failure, AdviceEntities>(AdviceEntities(advice: 'test', id: 19)));
        verify(mockAdviceRepoImpl.getAdviceFromDatasource()).called(1);
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });
    });

    group('should return left with', () {
      test('a ServerFailure', () async{
        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        final adviceUsecasesUnderTest = AdviceUsecases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromDatasource()).thenAnswer(
            (realInvocation) => Future.value(Left(ServerFailure())));

        final result = await adviceUsecasesUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntities>(ServerFailure()));
        verify(mockAdviceRepoImpl.getAdviceFromDatasource()).called(1);
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });

      test('a GeneralFailure', () async{
        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        final adviceUsecasesUnderTest = AdviceUsecases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromDatasource()).thenAnswer(
            (realInvocation) => Future.value(Left(GeneralFailure())));

        final result = await adviceUsecasesUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntities>(GeneralFailure()));
        verify(mockAdviceRepoImpl.getAdviceFromDatasource()).called(1);
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });
    });
  });
}
