import 'package:dartz/dartz.dart';
import 'package:furniture/core/error/failure.dart';
import 'package:furniture/core/usecase/base_usecase.dart';
import 'package:furniture/domain/model/models.dart';

import '../../repository/repository.dart';

class GetAllSofasUseCase extends BaseUsecase<List<Sofa>, NoParameters> {
  final BaseRepository baseRepository;

  GetAllSofasUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<Sofa>>> call(NoParameters parameters) async {
    return await baseRepository.getAllSofas();
  }
}
