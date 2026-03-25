import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Hafif gri arkaplan
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profilim',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          // Çıkış Yap Butonu
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () {
              // İleride Firebase Auth signout buraya gelecek
              print("Çıkış yapılıyor...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Üst Kısım: Profil Bilgileri
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(Icons.person, size: 40, color: Color(0xFF3B82F6)),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gönüllü Kullanıcı',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: Colors.grey),
                            SizedBox(width: 4),
                            // Demo profilimizde konum bilgisini örnek olarak giriyoruz
                            Text('Ünye, Ordu', style: TextStyle(color: Colors.grey, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Kendi İlanlarım Başlığı
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Benim İlanlarım',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Kendi İlanlarım Listesi (Şimdilik 2 tane örnek ilan)
            ListView.builder(
              shrinkWrap: true, // Liste içinde liste kaymasını önlemek için
              physics: const NeverScrollableScrollPhysics(), 
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 2,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.image_outlined, color: Colors.grey),
                    ),
                    title: Text('Açtığım İlan ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Aktif • 5 Destekçi', style: TextStyle(color: Color(0xFF3B82F6))),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit_outlined, color: Colors.black54),
                      onPressed: () {
                        // İlan düzenleme özelliği buraya eklenecek
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}