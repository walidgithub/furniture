
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../model/models.dart';
import '../../repository/repository.dart';

class SearchForSofasUseCase extends BaseUsecase {
  final BaseRepository baseRepository;

  SearchForSofasUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<Sofa>>> call(parameters) async {
    return await baseRepository.searchForSofa(parameters);
  }
}