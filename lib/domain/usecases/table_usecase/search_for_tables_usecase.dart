
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../model/models.dart';
import '../../repository/repository.dart';

class SearchForTablesUseCase extends BaseUsecase {
  final BaseRepository baseRepository;

  SearchForTablesUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<Dining>>> call(parameters) async {
    return await baseRepository.searchForTable(parameters);
  }
}