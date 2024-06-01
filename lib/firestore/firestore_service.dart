import 'package:firebase_core/firebase_core.dart';
import 'package:crossplatform/firebase_options.dart';

class FirestoreService {
  static Future<FirebaseApp> initializeFirebase() async {
    final FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("\n\nConnected to Firebase App ${app.options.projectId}\n\n");
    return app;
  }
}