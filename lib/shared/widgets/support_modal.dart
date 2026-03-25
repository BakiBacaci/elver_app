import 'package:flutter/material.dart';

class SupportModal extends StatefulWidget {
  final String postId; // Hangi ilana destek olunduğunu bilmek için
  
  const SupportModal({super.key, required this.postId});

  @override
  State<SupportModal> createState() => _SupportModalState();
}

class _SupportModalState extends State<SupportModal> {
  // Varsayılan olarak "Gönüllü Ol" seçili gelsin
  String _selectedType = 'Gönüllü Ol';
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // Şık Seçenek Butonlarımızı oluşturan yardımcı fonksiyon
  Widget _buildOption(String title, IconData icon) {
    final isSelected = _selectedType == title;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6).withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF3B82F6) : Colors.grey.shade600),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? const Color(0xFF3B82F6) : Colors.black87,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF3B82F6)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Klavyenin ekranı kapatmasını engellemek için Padding kullanıyoruz
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Klavye boyu kadar alttan it
        left: 24,
        right: 24,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Sadece içindeki elemanlar kadar yer kapla
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Üstteki küçük sürükleme çubuğu (Drag Handle)
            Center(
              child: Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            const Text(
              'Nasıl destek olmak istersin?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Seçenekler
            _buildOption('Gönüllü Ol', Icons.volunteer_activism),
            const SizedBox(height: 12),
            _buildOption('Bağış Yap', Icons.favorite_border),
            const SizedBox(height: 12),
            _buildOption('İletişime Geç', Icons.chat_bubble_outline),
            const SizedBox(height: 24),

            // Mesaj Kutusu
            TextField(
              controller: _messageController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'İletmek istediğin bir mesaj var mı? (İsteğe bağlı)',
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Gönder Butonu
            FilledButton(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                // Modalı kapat
                Navigator.pop(context);
                
                // Başarı mesajı göster
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Harikasın! "$_selectedType" talebin ilan sahibine iletildi.'),
                    backgroundColor: Colors.green.shade600,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Talebi Gönder', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 32), // En alta biraz nefes payı
          ],
        ),
      ),
    );
  }
}