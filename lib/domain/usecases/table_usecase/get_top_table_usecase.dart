import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:furniture/core/error/failure.dart';
import 'package:furniture/core/usecase/base_usecase.dart';
import 'package:furniture/domain/model/models.dart';

import '../../repository/repository.dart';

class GetTopTableUseCase extends BaseUsecase<List<Dining>, NoParameters> {
  final BaseRepository baseRepository;

  GetTopTableUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<Dining>>> call(NoParameters parameters) async {
    return await baseRepository.getTable();
  }
}
