import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:furniture/core/error/failure.dart';
import 'package:furniture/core/usecase/base_usecase.dart';
import 'package:furniture/domain/model/models.dart';

import '../../repository/repository.dart';

class GetTopChairUseCase extends BaseUsecase<List<Chair>, NoParameters> {
  final BaseRepository baseRepository;

  GetTopChairUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<Chair>>> call(NoParameters parameters) async {
    return await baseRepository.getChair();
  }
}
