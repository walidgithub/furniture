
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../model/models.dart';
import '../../repository/repository.dart';

class SearchForCupboardsUseCase extends BaseUsecase {
  final BaseRepository baseRepository;

  SearchForCupboardsUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<Cupboard>>> call(parameters) async {
    return await baseRepository.searchForCupboard(parameters);
  }
}