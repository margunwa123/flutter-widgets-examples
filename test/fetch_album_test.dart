import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:page_route_animation/network/album.dart' as X;
import 'package:page_route_animation/testing/mockito.dart';

import 'fetch_album_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetch album', () {
    test('returns an album when http calls succeed', () async {
      final client = MockClient();

      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'))
      ).thenAnswer((realInvocation) async => http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      expect(await fetchAlbum(client), isA<X.Album>());
    });
    test('throws an exception if http calls give error', () async {
      final client = MockClient();

      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'))
      ).thenAnswer((realInvocation) async => http.Response('Not found', 404));

      expect(fetchAlbum(client), throwsException);
    });

  });
}
