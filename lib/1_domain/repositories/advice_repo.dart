import 'package:advicer/1_domain/entities/advice_entities.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AdviceRepo{
  Future<Either<Failure, AdviceEntities>> getAdviceFromDatasource();
}