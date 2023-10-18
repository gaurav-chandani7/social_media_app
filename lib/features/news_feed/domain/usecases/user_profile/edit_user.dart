import 'package:dartz/dartz.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/news_feed/domain/entities/user_action/edit_user_params.dart';
import 'package:social_media_app/features/news_feed/domain/repository/repository.dart';

class EditUserUseCase extends UseCase<bool, EditUserParams> {
  final PostRepository _repo;

  EditUserUseCase(this._repo);
  @override
  Future<Either<Failure, bool>> call(EditUserParams params) => _repo.editUser(
      userId: params.userId,
      displayPicturePath: params.displayPicturePath,
      editUserEntity: params);
}
