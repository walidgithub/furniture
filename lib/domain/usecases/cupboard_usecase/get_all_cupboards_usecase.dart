import 'package:dartz/dartz.dart';
import 'package:furniture/core/error/failure.dart';
import 'package:furniture/core/usecase/base_usecase.dart';
import 'package:furniture/domain/model/models.dart';

import '../../repository/repository.dart';

class GetAllCupboardsUseCase extends BaseUsecase<List<Cupboard>, NoParameters> {
  final BaseRepository baseRepository;

  GetAllCupboardsUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<Cupboard>>> call(NoParameters parameters) async {
    return await baseRepository.getAllCupboards();
  }
}
