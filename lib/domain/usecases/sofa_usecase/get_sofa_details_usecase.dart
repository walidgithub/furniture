import 'package:dartz/dartz.dart';
import 'package:furniture/core/error/failure.dart';
import 'package:furniture/core/usecase/base_usecase.dart';
import 'package:furniture/domain/model/models.dart';

import '../../repository/repository.dart';

class GetSofaDetailsUseCase extends BaseUsecase {
  final BaseRepository baseRepository;

  GetSofaDetailsUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<SofaDetails>>> call(parameters) async {
    return await baseRepository.getSofaDetails(parameters);
  }
}