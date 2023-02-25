import 'package:dartz/dartz.dart';
import 'package:furniture/core/error/failure.dart';
import 'package:furniture/core/usecase/base_usecase.dart';
import 'package:furniture/domain/model/models.dart';

import '../../repository/repository.dart';

class GetAllTablesUseCase extends BaseUsecase<List<Dining>, NoParameters> {
  final BaseRepository baseRepository;

  GetAllTablesUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<Dining>>> call(NoParameters parameters) async {
    return await baseRepository.getAllTables();
  }
}
