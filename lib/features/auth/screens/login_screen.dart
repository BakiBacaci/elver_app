import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form kontrolü için
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Şifre gizle/göster durumu
  bool _obscurePassword = true;

  @override
  void dispose() {
    // Hafıza sızıntısını önlemek için controller'ları temizliyoruz
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Şimdilik sadece print ediyoruz, Firebase bağlandığında buraya login fonksiyonu gelecek
      print("Giriş yapılıyor: ${_emailController.text}");
      
      // Giriş başarılı varsayıp ana sayfaya yönlendiriyoruz (Demo amaçlı)
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo veya Başlık
                  const Icon(Icons.handshake_rounded, size: 80, color: Color(0xFF3B82F6)),
                  const SizedBox(height: 16),
                  const Text(
                    'Elver\'e Hoş Geldiniz',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Destek olmak veya destek bulmak için giriş yapın.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 40),

                  // E-posta Alanı
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-posta',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Lütfen e-posta adresinizi girin';
                      if (!value.contains('@')) return 'Geçerli bir e-posta girin';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Şifre Alanı
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Lütfen şifrenizi girin';
                      if (value.length < 6) return 'Şifre en az 6 karakter olmalıdır';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Giriş Yap Butonu
                  FilledButton(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _handleLogin,
                    child: const Text('Giriş Yap', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 16),

                  // Kayıt Ol Yönlendirmesi
                  TextButton(
                    onPressed: () {
                      context.push('/register'); // go_router ile kayıt sayfasına geçiş
                    },
                    child: const Text('Hesabınız yok mu? Hemen kayıt olun.'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}