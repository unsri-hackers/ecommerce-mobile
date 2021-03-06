import 'package:deuvox/data/model/user_model.dart';
import 'package:deuvox/data/repository/user_repository.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  group('Get User Test', () {
    test('Test Get User (Success Scenario)', () async {
      final userRepository = MockUserRepository();
      int id = 1;
      when(userRepository.getUser(id))
          .thenAnswer((realInvocation) => successGetUser(id));

      var res = await userRepository.getUser(id);

      expect(res.id, id);
      expect(res.id, isA<int>());
      expect(res.authtoken, isNotEmpty);
      expect(res.fcmToken, isNotEmpty);
    });

    test('Test Get User (User Not Found Scenario)', () async {
      final userRepository = MockUserRepository();
      int id = 2;
      when(userRepository.getUser(id))
          .thenAnswer((realInvocation) => failedGetUser(id));

      expect((await userRepository.getUser(id)).name, isNull);
      expect((await userRepository.getUser(id)).authtoken, isNull);
      expect((await userRepository.getUser(id)).fcmToken, isNull);
    });
  });
}

Future<UserModel> successGetUser(int id) async {
  return UserModel(
    id: id,
    name: 'Achmad Ichsan',
    authtoken: 'AuthCode001',
    fcmToken: 'FcmCode001',
  );
}

Future<UserModel> failedGetUser(int id) async {
  return UserModel(id: id);
}
