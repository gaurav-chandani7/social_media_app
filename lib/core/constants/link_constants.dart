import 'package:graphql_flutter/graphql_flutter.dart';

const defaultDisplayPicture =
    "https://firebasestorage.googleapis.com/v0/b/social-media-project-112233.appspot.com/o/default-profile-pic.jpeg?alt=media&token=4a2b630c-a90b-49d2-9603-192fd013e299";

final HttpLink httpLink = HttpLink(
  'https://social-media-production-10b5.up.railway.app/',
);

