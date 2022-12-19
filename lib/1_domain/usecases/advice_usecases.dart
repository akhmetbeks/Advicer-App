import 'package:advicer/0_data/repositories/advice_repo_impl.dart';
import 'package:advicer/1_domain/entities/advice_entities.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/advice_repo.dart';

class AdviceUsecases {
  final AdviceRepo adviceRepo;
  AdviceUsecases({required this.adviceRepo});

  Future<Either<Failure, AdviceEntities>> getAdvice() async {
   return adviceRepo.getAdviceFromDatasource();
  }
}
