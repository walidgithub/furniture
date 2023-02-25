import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:furniture/core/error/failure.dart';
import 'package:furniture/core/usecase/base_usecase.dart';
import 'package:furniture/domain/model/models.dart';

import '../repository/repository.dart';

class GetAllCartsUseCase extends BaseUsecase<List<Carts>, NoParameters> {
  final BaseRepository baseRepository;

  GetAllCartsUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<Carts>>> call(NoParameters parameters) async {
    return await baseRepository.getAllCarts();
  }
}
