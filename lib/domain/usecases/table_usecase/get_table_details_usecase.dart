import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:furniture/core/error/failure.dart';
import 'package:furniture/core/usecase/base_usecase.dart';
import 'package:furniture/domain/model/models.dart';

import '../../repository/repository.dart';

class GetTableDetailsUseCase extends BaseUsecase {
  final BaseRepository baseRepository;

  GetTableDetailsUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<TableDetails>>> call(parameters) async {
    return await baseRepository.getTableDetails(parameters);
  }
}