import 'package:deuvox/data/model/base_response.dart';
import 'package:deuvox/data/model/login_model.dart';
import 'package:deuvox/data/model/user_model.dart';
import 'package:deuvox/data/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  group('Login User', () {
    test('Login User Success', () async {
      final userRepository = MockUserRepository();
      LoginModel loginModel =
          LoginModel(username: 'ichsanachmad', password: '123456');

      when(userRepository.login(loginModel)).thenAnswer(
          (realInvocation) => Future.value(BaseResponse<UserSessionModel>(
                message: "",
                statusCode: "200",
                result: UserSessionModel(
                  id: 5,
                  accessToken: "123",
                  tokenType: "Bearer",
                  username: "aws",
                ),
              )));

      var res = await userRepository.login(loginModel);

      expect(res.statusCode, "200");
    });
  });

  group('Get User Test', () {
    test('Test Get User (Success Scenario)', () async {
      final userRepository = MockUserRepository();
      int id = 1;
      when(userRepository.getUserProfile(id))
          .thenAnswer((realInvocation) => Future.value(UserModel(
                id: id,
                name: 'Achmad Ichsan',
                authtoken: 'AuthCode001',
                fcmToken: 'FcmCode001',
              )));

      var res = await userRepository.getUserProfile(id);

      expect(res.id, id);
      expect(res.id, isA<int>());
      expect(res.authtoken, isNotEmpty);
      expect(res.fcmToken, isNotEmpty);
    });

    test('Test Get User (User Not Found Scenario)', () async {
      final userRepository = MockUserRepository();
      int id = 2;
      when(userRepository.getUserProfile(id))
          .thenAnswer((realInvocation) => Future.value(UserModel(id: id)));

      expect((await userRepository.getUserProfile(id)).name, isNull);
      expect((await userRepository.getUserProfile(id)).authtoken, isNull);
      expect((await userRepository.getUserProfile(id)).fcmToken, isNull);
    });
  });
}
