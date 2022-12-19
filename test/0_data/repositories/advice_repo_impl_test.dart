import 'dart:io';

import 'package:advicer/0_data/datasources/advice_remote_datasources.dart';
import 'package:advicer/0_data/exceptions/exceptions.dart';
import 'package:advicer/0_data/models/advice_model.dart';
import 'package:advicer/0_data/repositories/advice_repo_impl.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'advice_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDataSourceImpl>()])
void main() {
  group('AdviceRepoImpl', () {
    group('should return AdviceEntities', () {
      test('when AdviceRemoteDatasource returns AdviceModel', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDataSourceImpl();
        final adviceRepoImplUnderTest = AdviceRepoImpl(
            adviceRemoteDataSourceImpl: mockAdviceRemoteDatasource);

        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi()).thenAnswer(
            (realInvocation) =>
                Future.value(AdviceModel(advice: 'test advice', id: 13)));

        final result = await adviceRepoImplUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
            result,
            Right<Failure, AdviceModel>(
                AdviceModel(advice: 'test advice', id: 13)));
        verify(mockAdviceRemoteDatasource.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockAdviceRemoteDatasource);
      });
    });

    group('should throw', () {
      test('ServerFailure when a ServerException occurs', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDataSourceImpl();
        final adviceRepoImplUnderTest = AdviceRepoImpl(
            adviceRemoteDataSourceImpl: mockAdviceRemoteDatasource);

        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi())
            .thenThrow(ServerException());

        final result = await adviceRepoImplUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceModel>(ServerFailure()));
      });

      test('GeneralFailure when a GeneralException occurs', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDataSourceImpl();
        final adviceRepoImplUnderTest = AdviceRepoImpl(
            adviceRemoteDataSourceImpl: mockAdviceRemoteDatasource);

        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi())
            .thenThrow(const SocketException('test'));

        final result = await adviceRepoImplUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceModel>(GeneralFailure()));
      });
    });
  });
}
