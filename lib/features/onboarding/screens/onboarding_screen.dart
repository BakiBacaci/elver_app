import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Karşılama ekranlarımızın içeriği
  final List<Map<String, String>> _pages = [
    {
      'title': 'Elver\'e Hoş Geldin',
      'desc': 'İhtiyaç sahipleriyle, onlara el uzatmak isteyen gönüllüleri buluşturan iyilik köprüsüne adım attın.',
      'icon': '🤝',
    },
    {
      'title': 'Kolayca İlan Ver',
      'desc': 'Sağlık, eğitim, sokak hayvanları veya diğer konulardaki destek taleplerini saniyeler içinde paylaş.',
      'icon': '📢',
    },
    {
      'title': 'Birlikte Güçlüyüz',
      'desc': 'Tek bir dokunuşla destek ol, mesaj gönder veya gönüllü ağına katıl. İyilik paylaştıkça çoğalır!',
      'icon': '💙',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Üst kısımdaki "Geç" butonu
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => context.go('/login'), // Direkt Login'e atla
                child: const Text('Geç', style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
            ),
            
            // Kaydırmalı Sayfalar (PageView)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Dev Emoji İkonu
                        Text(
                          _pages[index]['icon']!,
                          style: const TextStyle(fontSize: 100),
                        ),
                        const SizedBox(height: 48),
                        
                        // Başlık
                        Text(
                          _pages[index]['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF3B82F6), // Elver Mavisi
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Açıklama
                        Text(
                          _pages[index]['desc']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Alt Kısım: Noktalar ve Buton
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  // Sayfa göstergesi (Noktalar)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? const Color(0xFF3B82F6) : Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // İleri veya Başla Butonu
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: const Color(0xFF3B82F6),
                      ),
                      onPressed: () {
                        if (_currentPage == _pages.length - 1) {
                          // Son sayfadaysak Login'e git
                          context.go('/login');
                        } else {
                          // Değilsek bir sonraki sayfaya kaydır
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Text(
                        _currentPage == _pages.length - 1 ? 'Hemen Başla' : 'İleri',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}