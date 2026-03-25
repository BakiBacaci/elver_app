import 'package:elver_app/features/posts/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/posts/screens/create_post_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../../shared/widgets/support_modal.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
// Sayfa importlarımız
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/home/screens/home_screen.dart';
import 'layout/main_layout.dart'; // 2. seçeneği seçtiğiniz için dosya yolumuz bu şekilde

// Riverpod ile router'ımızı tüm uygulamaya sunuyoruz
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
  initialLocation: '/onboarding', // açılış sayfamız burası!
    routes: [

      // KARŞILAMA EKRANI
   GoRoute(
     path: '/onboarding',
     builder: (context, state) => const OnboardingScreen(),
   ),
      // AUTH SAYFALARI
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // ALT MENÜLÜ SAYFALAR (ShellRoute)
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child); // Alt menü iskeletimiz
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(), // Yeni tasarladığımız Ana Sayfa
          ),
          GoRoute(
            path: '/create',
            builder: (context, state) => const CreatePostScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      
      // İLAN DETAY SAYFASI
      GoRoute(
        path: '/post/:id',
        builder: (context, state) {
         // Eğer id bulamazsan varsayılan olarak '0' kabul et (?? '0' kısmı bunu yapıyor)
final postId = state.pathParameters['id'] ?? '0'; 
return PostDetailScreen(postId: postId);
        },
      ),
    ],
  );
});

// Henüz yapmadığımız sayfalar için geçici ekran
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('$title yapım aşamasında...')),
    );
  }
}