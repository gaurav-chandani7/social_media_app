import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

import 'package:social_media_app/features/news-feed/domain/entities/create_post/create_post_item.dart';
import 'package:social_media_app/features/news-feed/domain/usecases/create_post/create_post_usecase.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc(
    this._createPostUseCase,
  ) : super(CreatePostInitial()) {
    on<PublishPost>((event, emit) async {
      emit(PublishLoading(urls: state.urls));
      event.createPostItemParams.filePaths = state.urls ?? [];
      final data = await _createPostUseCase(event.createPostItemParams);
      data.fold((l) => log("error | $l"), (r) {
        log("success | $r");
        emit(PublishSuccess(urls: state.urls));
      });
    });
    on<PickImages>((event, emit) async {
      try {
        var res = await FilePicker.platform
            .pickFiles(type: FileType.image, allowMultiple: true);
        if (res != null) {
          log(res.files.length.toString());
          emit(ImagesAttached(urls: res.files.map((e) => e.path!).toList()));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
  final CreatePostUseCase _createPostUseCase;
}
