import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Filtrelemeye tıkladığımızda ekranın yenilenmesi için StatefulWidget kullanıyoruz
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Hangi filtrenin seçili olduğunu tutan değişkenimiz (Varsayılan: Tümü)
  String _selectedFilter = 'Tümü';

  // Gerçekçi görünmesi için kategorilere ayrılmış Demo İlan Listemiz
  final List<Map<String, dynamic>> _demoPosts = [
    {
      'id': 1,
      'title': 'Tekerlekli Sandalye İhtiyacı',
      'desc': '8 yaşındaki oğlum için akülü tekerlekli sandalye desteği arıyoruz...',
      'category': 'Sağlık',
      'color': const Color(0xFFEF4444),
      'icon': '❤️',
      'city': 'Ordu',
      'author': 'Ayşe B.',
      'supportCount': 12,
    },
    {
      'id': 2,
      'title': 'Köy Okuluna Kitap Kampanyası',
      'desc': 'Okulumuzun kütüphanesi için okuma kitaplarına ve kırtasiye malzemesine ihtiyacımız var.',
      'category': 'Eğitim',
      'color': const Color(0xFF3B82F6),
      'icon': '📚',
      'city': 'Van',
      'author': 'Ali Öğretmen',
      'supportCount': 45,
    },
    {
      'id': 3,
      'title': 'Barınak İçin Mama Desteği',
      'desc': 'Havalar soğudu, can dostlarımız için acil kuru mama desteği bekliyoruz.',
      'category': 'Hayvanlar',
      'color': const Color(0xFFF59E0B),
      'icon': '🐾',
      'city': 'İstanbul',
      'author': 'Can Y.',
      'supportCount': 89,
    },
    {
      'id': 4,
      'title': 'Lösemi Tedavisi İçin Destek',
      'desc': 'Kızımın tedavisi için maddi ve manevi desteğe ihtiyacımız var. Kan vermek isteyenler ulaşabilir.',
      'category': 'Sağlık',
      'color': const Color(0xFFEF4444),
      'icon': '❤️',
      'city': 'İzmir',
      'author': 'Mehmet T.',
      'supportCount': 156,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Sadece seçili kategoriye ait olan ilanları filtreleyen liste
    final filteredPosts = _selectedFilter == 'Tümü'
        ? _demoPosts
        : _demoPosts.where((post) => post['category'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Elver',
          style: TextStyle(
            color: Color(0xFF3B82F6),
            fontWeight: FontWeight.w900, // Yazı tipimiz değiştiği için biraz daha kalın yaptık
            fontSize: 26,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.black87), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_none_rounded, color: Colors.black87), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Karşılama ve Dinamik Filtre Alanı
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bugün kime el vereceksin?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Tümü', ''),
                      _buildFilterChip('Sağlık', '❤️'),
                      _buildFilterChip('Eğitim', '📚'),
                      _buildFilterChip('Hayvanlar', '🐾'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Filtrelenmiş İlan Listesi
          Expanded(
            child: filteredPosts.isEmpty
                ? const Center(
                    child: Text('Bu kategoride henüz ilan yok.', style: TextStyle(color: Colors.grey)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) {
                      final post = filteredPosts[index]; // O anki ilan verisi
                      
                      return GestureDetector(
                        onTap: () {
                          context.push('/post/${post['id']}');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // İlan Görseli
                              // İlan Görseli - HERO ANIMASYONU EKLENDİ
                              Hero(
                                tag: 'post_image_${post['id']}', // Sihirli etiketimiz
                                child: Container(
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.image_outlined, size: 48, color: Colors.grey),
                                  ),
                                ),
                              ),
                              
                              // İlan İçeriği
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Dinamik Kategori ve Şehir
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: post['color'].withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            '${post['icon']} ${post['category']}',
                                            style: TextStyle(color: post['color'], fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on, size: 14, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Text(post['city'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    
                                    // Dinamik Başlık ve Açıklama
                                    Text(
                                      post['title'],
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      post['desc'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.black54, height: 1.4),
                                    ),
                                    const SizedBox(height: 16),
                                    
                                    // Alt Kısım
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 14,
                                              backgroundColor: Colors.blue.shade50,
                                              child: const Icon(Icons.person, size: 14, color: Colors.blue),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(post['author'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.volunteer_activism, size: 16, color: Color(0xFF3B82F6)),
                                            const SizedBox(width: 4),
                                            Text('${post['supportCount']} Destek', style: const TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.bold)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Tıklanabilir Filtre Butonu Widget'ı
  Widget _buildFilterChip(String label, String icon) {
    bool isSelected = _selectedFilter == label; // Bu buton mu seçili kontrolü
    
    return GestureDetector(
      onTap: () {
        // Tıklandığında ekranı güncelliyoruz (State değişiyor)
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? const Color(0xFF3B82F6) : Colors.grey[300]!),
        ),
        child: Text(
          icon.isEmpty ? label : '$icon $label',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}