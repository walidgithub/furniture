import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:furniture/core/error/failure.dart';
import 'package:furniture/core/usecase/base_usecase.dart';
import 'package:furniture/domain/model/models.dart';

import '../../repository/repository.dart';

class GetCupboardDetailsUseCase extends BaseUsecase {
  final BaseRepository baseRepository;

  GetCupboardDetailsUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<CupboardDetails>>> call(parameters) async {
    return await baseRepository.getCupboardDetails(parameters);
  }
}