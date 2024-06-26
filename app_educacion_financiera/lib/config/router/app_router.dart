import 'package:app_educacion_financiera/app/screens/challenge_page.dart';
import 'package:app_educacion_financiera/app/screens/chatbot.dart';
import 'package:app_educacion_financiera/app/screens/competencia_amigo.dart';
import 'package:app_educacion_financiera/app/screens/contenido_page.dart';
import 'package:app_educacion_financiera/app/screens/lecciones_page.dart';
import 'package:app_educacion_financiera/app/screens/lesson_page.dart';
import 'package:app_educacion_financiera/app/screens/login_page.dart';
import 'package:app_educacion_financiera/app/screens/main_page.dart';
import 'package:app_educacion_financiera/app/screens/ranking.dart';
import 'package:app_educacion_financiera/app/screens/register_page.dart';
import 'package:app_educacion_financiera/app/screens/savings_plan.dart';
import 'package:app_educacion_financiera/app/screens/savings_plan_list.dart';
import 'package:app_educacion_financiera/app/widgets/preguntas_test.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/main',
       builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path:'/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(path: '/learning',
       builder: (context, state) => LearningTopics()
    ),
    GoRoute(path: '/ranking',
       builder: (context, state) => RankingPage()
    ),
    GoRoute(
      path:'/chatbot',
      builder: (context, state) =>const  Home()
    ),
    GoRoute(
      path: '/challenge',
      builder: (context, state) => const ChallengePage(),
    ),
     GoRoute(
      path: '/challengeFriend',
      builder: (context, state) => const FinancialChallengeModule(),
    ),
    GoRoute(
      path: '/savingsplan',
      builder: (context, state) => SavingsPlanListScreen(),
    ),
     GoRoute(
      path: '/leccion/:idTema',
      builder: (context, state) {
        final idTemaString = state.pathParameters['idTema'];
        final idTema = int.tryParse(idTemaString ?? '') ?? 0;
      return LearningCourse(idTema: idTema);
      },

    ),
    GoRoute(
      path: '/contenidoAprendizaje/:idLeccion/:title',
      builder: (context, state) {
        final idLeccionString = state.pathParameters['idLeccion'];
        final title = state.pathParameters['title'] ?? '';
        final idLeccion = int.tryParse(idLeccionString ?? '') ?? 0;
        return LessonPage(idLeccion: idLeccion,title: title);
      },
    ),
     GoRoute(
      path: '/cuestionario/:idLeccion',
      builder: (context, state) {
        final idTemaString = state.pathParameters['idLeccion'];
        final idTema = int.tryParse(idTemaString ?? '') ?? 0;
      return QuestionnaireScreen(idLeccion: idTema);
      },
    ),


  ],
);