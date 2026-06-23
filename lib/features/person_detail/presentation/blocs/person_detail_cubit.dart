import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_person_detail.dart';
import 'person_detail_state.dart';

class PersonDetailCubit extends Cubit<PersonDetailState> {
  final GetPersonDetailUseCase getPersonDetailUseCase;

  PersonDetailCubit({required this.getPersonDetailUseCase})
      : super(PersonDetailInitial());

  Future<void> loadPersonDetail(int id) async {
    emit(PersonDetailLoading());
    final result = await getPersonDetailUseCase(id);
    result.fold(
      (failure) => emit(PersonDetailError(failure)),
      (personDetail) => emit(PersonDetailLoaded(personDetail: personDetail)),
    );
  }
}
