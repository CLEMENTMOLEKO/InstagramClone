import 'package:get_it/get_it.dart';
import 'package:instagram_clone_application/system/allow_access_service.dart';

final dependencyInjection = GetIt.instance;
void setupDependencyInjection(
  AllowAccessService mockAllowAccessService,
) {
  dependencyInjection
      .registerFactory<AllowAccessService>(() => mockAllowAccessService);
}
