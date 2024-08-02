import 'package:flutter/material.dart';
import 'package:intro/screen/login_screen.dart';

// 시작 화면
// 플러터 statefulWidget 생명주기,
// createState -> initState -> didchangeDependencies -> build
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  // StatefulWidget을 상속하는 클래스는 반드시 createState() 메서드를 구현해야 합니다.
  // 이 메서드는 상태를 관리하는 State 객체를 반환하는 데 사용됩니다
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // initState는 최초 한번만 실행된다.
  @override
  void initState() {
    super.initState();
    _navigateToLoginScreen(); // 메서드 이름 앞에 _를 붙이면 private
  }

  void _navigateToLoginScreen() {
    Future.delayed(
      const Duration(milliseconds: 2000),
      () => {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              const curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve),
              );

              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration:
                const Duration(milliseconds: 1000), // 전환 애니메이션 시간
          ),
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/app_logo.png', width: 120, height: 120),
          const SizedBox(height: 46),
          const Text(
            'Food PICK',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ));
  }
}
