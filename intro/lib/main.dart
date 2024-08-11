import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intro/pages/hotel_list_page.dart';

Future<void> main() async {
  // main 메소드에서 비동기로 데이터를 다루는 상황이 있을 때 반드시 최초에 호출해줘야 함
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

// Riverpod에 의해 노출되는 StatelessWidget 대신 ConsumerWidget을 확장합니다.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Dart Data Class Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HotelListPage(),
              ),
            );
          },
          child: const Text('Go to Hotel List Page'),
        ),
      ),
    );
  }
}
