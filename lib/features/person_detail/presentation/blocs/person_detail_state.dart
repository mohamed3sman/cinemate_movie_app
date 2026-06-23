import 'package:equatable/equatable.dart';
import '../../domain/entities/person_detail.dart';

abstract class PersonDetailState extends Equatable {
  const PersonDetailState();

  @override
  List<Object?> get props => [];
}

class PersonDetailInitial extends PersonDetailState {}

class PersonDetailLoading extends PersonDetailState {}

class PersonDetailLoaded extends PersonDetailState {
  final PersonDetail personDetail;

  const PersonDetailLoaded({required this.personDetail});

  @override
  List<Object?> get props => [personDetail];
}

class PersonDetailError extends PersonDetailState {
  final String message;

  const PersonDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
