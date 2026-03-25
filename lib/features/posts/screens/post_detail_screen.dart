import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/support_modal.dart'; // Az önce yaptığımız modal!

class PostDetailScreen extends StatelessWidget {
  final String postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(), // Geri dönme
        ),
        title: const Text('İlan Detayı', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // İlan Görseli
            // İlan Görseli - HERO ANIMASYONU EKLENDİ
            Hero(
              tag: 'post_image_$postId', // Birebir aynı sihirli etiket!
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.image_outlined, size: 64, color: Colors.grey),
              ),
            ),
            // Kategori ve Şehir
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '❤️ Sağlık', 
                    style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.bold),
                  ),
                ),
                const Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text('Ordu', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // İlan Başlığı
            Text(
              'Örnek İlan Başlığı (ID: $postId)', 
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black87),
            ),
            const SizedBox(height: 12),

            // İlanı Açan Kişi
            Row(
              children: [
                CircleAvatar(
                  radius: 18, 
                  backgroundColor: Colors.blue.shade50, 
                  child: const Icon(Icons.person, size: 18, color: Color(0xFF3B82F6)),
                ),
                const SizedBox(width: 12),
                const Text('Ahmet Y.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Spacer(),
                const Text('2 gün önce', style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(height: 1),
            ),

            // Detaylı Açıklama
            const Text(
              'Bu kısımda ilanın detaylı açıklaması yer alacak. Yardıma ihtiyacı olan kişi veya kurum, durumunu ve ne tür bir desteğe ihtiyacı olduğunu burada detaylıca anlatabilir. Biz şimdilik demo verisi gösteriyoruz.',
              style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
            ),
            const SizedBox(height: 32),

            // Destek Sayısı Bilgi Kutusu
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50, 
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Row(
                children: [
                  Icon(Icons.volunteer_activism, color: Color(0xFF3B82F6), size: 28),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Şu ana kadar 12 kişi destek oldu. Sen de onlara katıl!', 
                      style: TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Büyük "Destek Ol" Butonu ve MODAL BAĞLANTISI
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  backgroundColor: const Color(0xFF3B82F6),
                ),
                onPressed: () {
                  // İŞTE SİHİR BURADA: Butona basınca o şık menü açılacak!
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // Klavyenin itmesi için
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                    ),
                    builder: (context) => SupportModal(postId: postId),
                  );
                },
                child: const Text('Destek Ol', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}