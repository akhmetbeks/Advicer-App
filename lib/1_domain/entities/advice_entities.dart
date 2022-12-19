import 'package:equatable/equatable.dart';

class AdviceEntities extends Equatable {
  final String advice;
  final int id;

  const AdviceEntities({required this.advice, required this.id});

  @override
  List<Object?> get props => [advice, id];
}
