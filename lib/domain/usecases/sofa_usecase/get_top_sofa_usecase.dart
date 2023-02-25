import 'package:dartz/dartz.dart';
import 'package:furniture/core/error/failure.dart';
import 'package:furniture/core/usecase/base_usecase.dart';
import 'package:furniture/domain/model/models.dart';

import '../../repository/repository.dart';

class GetTopSofaUseCase extends BaseUsecase<List<Sofa>, NoParameters> {
  final BaseRepository baseRepository;

  GetTopSofaUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<Sofa>>> call(NoParameters parameters) async {
    return await baseRepository.getSofa();
  }
}
