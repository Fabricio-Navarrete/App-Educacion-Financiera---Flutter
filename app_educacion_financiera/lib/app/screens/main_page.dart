import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:app_educacion_financiera/config/Models/Estudiante.dart';
import 'package:app_educacion_financiera/config/Provider/estudiante_provider.dart';
import 'package:app_educacion_financiera/config/router/app_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey keyAppBar = GlobalKey();
  GlobalKey keyAsistenteVirtual = GlobalKey();
  GlobalKey keyAprendizaje = GlobalKey();
  GlobalKey keyDesafio = GlobalKey();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, checkTutorial);
  }

  void checkTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isTutorialShown = prefs.getBool('isTutorialShown') ?? false;

    if (!isTutorialShown) {
      showTutorial();
      prefs.setBool('isTutorialShown', true);
    }
  }
  void cancelTutorial() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isTutorialShown', false);
  }
  void showTutorial() {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      textSkip: "SALTAR",
      paddingFocus: 5,
      opacityShadow: 0.8,
    )..show(context: context);
  }

  void initTargets() {
    targets.add(
      TargetFocus(
        identify: "AsistenteVirtual",
        keyTarget: keyAsistenteVirtual,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: const Text(
              "Usa el Asistente Virtual para obtener ayuda.",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Aprendizaje",
        keyTarget: keyAprendizaje,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const Text(
              "Accede a lecciones y material educativo.",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Desafio",
        keyTarget: keyDesafio,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const Text(
              "Participa en desafíos para ganar puntos.",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Estudiante? estudiante = Provider.of<EstudianteModel>(context).estudiante;
    String user = '';
    double puntaje = 0.0;
    int nivel = 0;
    if (estudiante != null) {
      user = estudiante.nombreUsuario;
      puntaje = estudiante.puntaje;
      nivel = estudiante.nivel;
    }
    return Scaffold(
      appBar: AppBar(
        key: keyAppBar,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                user,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  border: Border.all(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: SizedBox(
                        height: 20,
                        child: LinearProgressIndicator(
                          value: puntaje,
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          'Nivel $nivel',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              appRouter.go('/');
              cancelTutorial();
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: _buildButton(
                      key: keyAsistenteVirtual,
                      icon: Image.asset(
                        'assets/Imagenes/chatbot.png',
                        width: 100,
                        height: 100,
                      ),
                      text: 'Asistente Virtual',
                      onPressed: () {
                        appRouter.go('/chatbot', extra: estudiante);
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: _buildButton(
                      key: keyAprendizaje,
                      icon: Image.asset(
                        'assets/Imagenes/leccion.png',
                        width: 100,
                        height: 100,
                      ),
                      text: 'Aprendizaje',
                      onPressed: () {
                        appRouter.go('/learning', extra: estudiante);
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: _buildButton(
                      key: keyDesafio,
                      icon: Image.asset(
                        'assets/Imagenes/desafio.png',
                        width: 100,
                        height: 100,
                      ),
                      text: 'Desafío',
                      onPressed: () {
                        appRouter.go('/challenge', extra: estudiante);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required Key key,
    required Image icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Card(
      key: key,
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(height: 10.0),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLevelUpDialog(BuildContext context, int level) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Subiste de nivel!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow[600],
                size: 100.0,
              ),
              Text(
                '$level',
                style: const TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
