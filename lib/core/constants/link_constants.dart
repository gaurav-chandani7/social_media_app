import 'package:graphql_flutter/graphql_flutter.dart';

const defaultDisplayPicture =
    "https://firebasestorage.googleapis.com/v0/b/social-media-project-112233.appspot.com/o/default-profile-pic.jpeg?alt=media&token=4a2b630c-a90b-49d2-9603-192fd013e299";

final HttpLink httpLink = HttpLink(
  'https://social-media-production-10b5.up.railway.app/',
);

final defaultGraphQlPolicy = DefaultPolicies(
    query: Policies(
        fetch: FetchPolicy.noCache, cacheReread: CacheRereadPolicy.ignoreAll));

const List<String> staticImages = [
  "https://media.istockphoto.com/id/173682323/photo/says.jpg?s=612x612&w=0&k=20&c=7jnXQrYzUWNTnLhjPgimxHIbjsaHvZmAMALGVzYNARQ=",
  "https://images.unsplash.com/photo-1493612276216-ee3925520721?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tfGVufDB8fDB8fHww&w=1000&q=80",
  "https://lh3.googleusercontent.com/hwau7OVWx96XaME5KpRuJ0I_MscrerK6SbRH1UwYHYaxIDQQtn7RZK02LDSfBzCreidFgDsJeXyqDct6EZiH6vsV=w640-h400-e365-rj-sc0x00ffffff"
];
