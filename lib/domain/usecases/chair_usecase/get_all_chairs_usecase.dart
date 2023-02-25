import 'package:dartz/dartz.dart';
import 'package:furniture/core/error/failure.dart';
import 'package:furniture/core/usecase/base_usecase.dart';
import 'package:furniture/domain/model/models.dart';

import '../../repository/repository.dart';

class GetAllChairsUseCase extends BaseUsecase<List<Chair>, NoParameters> {
  final BaseRepository baseRepository;

  GetAllChairsUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<Chair>>> call(NoParameters parameters) async {
    return await baseRepository.getAllChairs();
  }
}
