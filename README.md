# AjioClone
IDE used - Android Studio

Download flutter SDK from https://flutter.dev/development?gad_source=1&gclid=CjwKCAiA_tuuBhAUEiwAvxkgTg4-0uM-hioK-ZF63TEXFXvUHhGfXmM2eZYT5cqrTxVWsD7TZ4yNrxoCXmoQAvD_BwE&gclsrc=aw.ds

- CLone the repository
- In terminal run $flutter pub get
- To run the app $flutter run
- For Firebase Connection:
    1. Go to the Firebase console: https://console.firebase.google.com/
    2. Create Android app
    3. Check $firebase login in cmd if firebase is not found Install Flutter CLI if yes then skip step 4
    4. Follow firebase documentation: https://firebase.google.com/docs/flutter/setup?platform=ios 
    5. Run $firebase projects:list select project you want configure
    6. Then run $firebase configure
    7. This will create firebase_options.dart in lib
    8. Now you are done with firebase connection

