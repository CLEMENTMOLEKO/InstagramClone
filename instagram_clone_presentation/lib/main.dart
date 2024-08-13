import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_infrastructure/instagram_clone_infrastructure.dart';
import 'package:instagram_clone_presentation/app.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //DependencyInjection
  configureInfrastructureDependencies();
  runApp(const App());
}
