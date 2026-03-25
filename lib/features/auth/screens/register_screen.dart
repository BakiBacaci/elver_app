import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  String? _selectedCity;
  bool _obscurePassword = true;

  // Şimdilik temel şehirleri ekliyoruz, ileride locations dosyasından çekeceğiz
  final List<String> _cities = [
    'İstanbul', 'Ankara', 'İzmir', 'Bursa', 'Antalya', 'Adana', 'Konya', 'Ordu'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      print("Kayıt yapılıyor: ${_emailController.text}, Şehir: $_selectedCity");
      // Kayıt başarılı varsayıp ana sayfaya yönlendiriyoruz
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(), // Geri dönme butonu
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Hesap Oluştur',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Topluluğumuza katılın ve destek olmaya başlayın.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 32),

                // Ad Soyad Alanı
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Ad Soyad',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) => value!.isEmpty ? 'Lütfen adınızı girin' : null,
                ),
                const SizedBox(height: 16),

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

                // Şehir Seçimi (Dropdown)
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Yaşadığınız Şehir',
                    prefixIcon: const Icon(Icons.location_city_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  value: _selectedCity,
                  items: _cities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCity = newValue;
                    });
                  },
                  validator: (value) => value == null ? 'Lütfen bir şehir seçin' : null,
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
                  validator: (value) => value != null && value.length < 6 ? 'Şifre en az 6 karakter olmalıdır' : null,
                ),
                const SizedBox(height: 32),

                // Kayıt Ol Butonu
                FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _handleRegister,
                  child: const Text('Kayıt Ol', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}