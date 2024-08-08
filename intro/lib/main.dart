import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intro/pages/person_page.dart';
import 'package:intro/widgets/custom_button.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'main.g.dart';

Future<void> main() async {
  // main 메소드에서 비동기로 데이터를 다루는 상황이 있을 때 반드시 최초에 호출해줘야 함
  WidgetsFlutterBinding.ensureInitialized();

  // init supabase
  await Supabase.initialize(
    url: 'https://fnpeucnejzwsbcczaohr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZucGV1Y25lanp3c2JjY3phb2hyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI0ODg1NTgsImV4cCI6MjAzODA2NDU1OH0.R0Cb8hYmpAwLzeB-F43qpfdTPaNZSTRlD_VxNVmPxHs',
  );

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
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: const [
            CustomButton(
              title: 'Person',
              child: PersonPage(),
            )
          ],
        ),
      ),
    );
  }
}
