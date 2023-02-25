
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../model/models.dart';
import '../../repository/repository.dart';

class SearchForChairsUseCase extends BaseUsecase {
  final BaseRepository baseRepository;

  SearchForChairsUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<Chair>>> call(parameters) async {
    return await baseRepository.searchForChair(parameters);
  }
}