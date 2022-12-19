import 'package:advicer/0_data/datasources/advice_remote_datasources.dart';
import 'package:advicer/0_data/exceptions/exceptions.dart';
import 'package:advicer/0_data/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'advice_remote_datasources_test.mocks.dart' as mock;

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('AdviceRemoteDataSource', () {
    group('returns AdviceModel', () {
      test('when a Client response code is 200', () async {
        final mockClient = mock.MockClient();
        final adviceRemoteDatasourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);

        when(mockClient.get(
            Uri.parse(
              'https://api.flutter-community.com/api/v1/advice',
            ),
            headers: {
              'content-type': 'application/json',
            })).thenAnswer(
          (realInvocation) => Future.value(
            Response('{"advice" : "test advice", "advice_id": 1}', 200),
          ),
        );

        final result =
            await adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi();

        expect(result, AdviceModel(advice: "test advice", id: 1));
      });
    });

    group('throws a', () {
      test('ServerError when a response is not 200', () {
        final mockClient = mock.MockClient();
        final adviceRemoteDatasourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);

        when(mockClient.get(
            Uri.parse(
              'https://api.flutter-community.com/api/v1/advice',
            ),
            headers: {
              'content-type': 'application/json',
            })).thenAnswer(
          (realInvocation) => Future.value(
            Response('', 201),
          ),
        );

        expect(() => adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi(),
            throwsA(isA<ServerException>()));
      });

      test('TypeError when a response is 200 and data is not valid', () {
        final mockClient = mock.MockClient();
        final adviceRemoteDatasourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);

        when(mockClient.get(
            Uri.parse(
              'https://api.flutter-community.com/api/v1/advice',
            ),
            headers: {
              'content-type': 'application/json',
            })).thenAnswer(
          (realInvocation) => Future.value(
            Response('{"advice" : "test advice"}', 200),
          ),
        );

        expect(() => adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi(),
            throwsA(isA<TypeError>()));
      });
    });
  });
}
