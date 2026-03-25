import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart'; // EKLENDİ
import 'firebase_options.dart'; // FLUTTERFIRE'IN BİZİM İÇİN ÜRETTİĞİ DOSYA
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';

// main fonksiyonumuzu "async" yapıyoruz çünkü Firebase'in uyanmasını bekleyeceğiz
void main() async {
  // Flutter'ın çekirdek motorunu çalışmaya hazır hale getiriyoruz
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase'i uygulamamıza bağlıyoruz
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Elver App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B82F6)),
        useMaterial3: true,
        textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
      ),
      routerConfig: router,
    );
  }
}