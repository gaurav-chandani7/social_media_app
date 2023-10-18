import 'package:graphql_flutter/graphql_flutter.dart';

const followerListTabIndex = 0;
const followingListTabIndex = 1;

final defaultGraphQlPolicy = DefaultPolicies(
    query: Policies(
        fetch: FetchPolicy.noCache, cacheReread: CacheRereadPolicy.ignoreAll));