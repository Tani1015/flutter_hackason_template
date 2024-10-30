import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';

ValueNotifier<GraphQLClient> graphCLClientInit({
  required String url,
  required String anonKey,
}) {
  return ValueNotifier(
    GraphQLClient(
      link: HttpLink(
        '$url/graphql/v1',
        httpClient: ApiKeyClient(
          Client(),
          anonKey: anonKey,
        ),
      ),
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    ),
  );
}

class ApiKeyClient extends BaseClient {
  ApiKeyClient(
    this.client, {
    required this.anonKey,
  });
  final Client client;
  final String anonKey;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    if (anonKey.isNotEmpty) {
      request.headers['apiKey'] = anonKey;
    }

    return client.send(request);
  }
}
