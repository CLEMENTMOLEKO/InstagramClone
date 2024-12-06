import 'package:get_it/get_it.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import '../authentication/sign_up_page_test.dart';

final dependencyInjection = GetIt.instance;
void setupDependencyInjection(
    MockSignUpBloc mockSignUpBloc,
    MockAuthenticationService mockAuthenticationService,
    MockUserRepository mockUserRepository,
    MockConnectionChecker mockConnectionChecker,
    MockEmailService mockEmailService,
    MockAuthenticationBloc mockAuthenticationBloc) {
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

void tearDownDependencyInjection() {
  dependencyInjection.unregister<SignUpBloc>();
  dependencyInjection.unregister<AuthenticationBloc>();
  dependencyInjection.unregister<AuthenticationService>();
  dependencyInjection.unregister<UserRepository>();
  dependencyInjection.unregister<ConnectionChecker>();
  dependencyInjection.unregister<EmailService>();
}
