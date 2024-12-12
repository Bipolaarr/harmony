import 'package:dartz/dartz.dart';
import 'package:harmony/core/usecase/usecase.dart';
import 'package:harmony/domain/entities/user/user.dart';
import 'package:harmony/domain/repositories/auth/auth.dart';

import 'package:harmony/service_locator.dart';

class BlockUserUseCase implements Usecase<Either<String, void>, UserEntity> {
  @override
  Future<Either<String, void>> call({UserEntity? params}) async {
    if (params == null) {
      return Left('User cannot be null');
    }

    try {
      await serviceLocator<AuthRepository>().blockUser(params); // Pass the UserEntity directly
      return const Right(null);
    } catch (e) {
      return Left('Failed to block/unblock user: ${e.toString()}');
    }
  }
}