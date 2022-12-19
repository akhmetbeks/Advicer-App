import 'package:advicer/1_domain/entities/advice_entities.dart';
import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:advicer/2_application/pages/advice/bloc/advice_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:advicer/1_domain/failures/failures.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceCubitState> {
  final AdviceUsecases adviceUsecases;
  AdviceCubit({required this.adviceUsecases}) : super(const AdviceInitial());

  void adviceRequested() async {
    emit(const AdviceStateLoading());
    final failureOrAdvice = await adviceUsecases.getAdvice();
    failureOrAdvice.fold(
      (failure) =>
          emit(AdviceStateError(message: _mapFailureToMessage(failure))),
      (advice) => emit(AdviceStateLoaded(advice: advice.advice)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Ups, API Error. please try again!';
      case CacheFailure:
        return 'Ups, chache failed. Please try again!';
      default:
        return 'Ups, something gone wrong. Please try again!';
    }
  }
}
