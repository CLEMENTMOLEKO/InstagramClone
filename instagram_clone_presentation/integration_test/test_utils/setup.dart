import 'package:get_it/get_it.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import '../authentication/sign_up_page_test.dart';

void setupDependencyInjection(
    MockSignUpBloc mockSignUpBloc,
    MockAuthenticationService mockAuthenticationService,
    MockUserRepository mockUserRepository,
    MockConnectionChecker mockConnectionChecker,
    MockEmailService mockEmailService,
    MockAuthenticationBloc mockAuthenticationBloc) {
  final dependencyInjection = GetIt.instance;
  dependencyInjection.registerFactory<SignUpBloc>(() => mockSignUpBloc);
  dependencyInjection
      .registerFactory<AuthenticationService>(() => mockAuthenticationService);
  dependencyInjection.registerFactory<UserRepository>(() => mockUserRepository);
  dependencyInjection
      .registerFactory<ConnectionChecker>(() => mockConnectionChecker);
  dependencyInjection.registerFactory<EmailService>(() => mockEmailService);
  dependencyInjection
      .registerFactory<AuthenticationBloc>(() => mockAuthenticationBloc);
}
