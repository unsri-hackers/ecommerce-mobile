import 'package:deuvox/data/domain/user_domain.dart';
import 'package:deuvox/data/model/login_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_domain_test.mocks.dart';


@GenerateMocks([UserDomain])
void main() {
  group('Login Domain Test', () {
    test('Login (Success Scenario)', () async {
      UserDomain userDomain = MockUserDomain();
      LoginModel loginModel = LoginModel(
        username: 'ichsanachmad',
        password: 'heybro!',
      );

      when(userDomain.login(loginModel))
          .thenAnswer((realInvocation) => Future.value(true));

      var res = await userDomain.login(loginModel);

      expect(res, true);
    });

    test('Login (Failed [Wrong Username / Password] Scenario)', () async {
      UserDomain userDomain = MockUserDomain();
      LoginModel loginModel = LoginModel(
        username: 'ichsanachmad',
        password: 'xds!',
      );

      when(userDomain.login(loginModel))
          .thenAnswer((realInvocation) => Future.value(false));

      var res = await userDomain.login(loginModel);

      expect(res, false);
    });
  });
}
