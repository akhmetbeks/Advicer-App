import 'package:advicer/0_data/datasources/advice_remote_datasources.dart';
import 'package:advicer/0_data/exceptions/exceptions.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/entities/advice_entities.dart';
import 'package:advicer/1_domain/repositories/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceRepoImpl implements AdviceRepo {
  final AdviceRemoteDataSource adviceRemoteDataSourceImpl;
  AdviceRepoImpl({required this.adviceRemoteDataSourceImpl});

  @override
  Future<Either<Failure, AdviceEntities>> getAdviceFromDatasource() async {
    try {
      final result = await adviceRemoteDataSourceImpl.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }
}
