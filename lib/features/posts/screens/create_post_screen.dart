import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:elver_app/core/constants/categories.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  CategoryType? _selectedCategory;
  String? _selectedCity;
  XFile? _imageFile;

  // Şehir listesi (Kayıt ekranındakiyle aynı şimdilik)
  final List<String> _cities = [
    'İstanbul', 'Ankara', 'İzmir', 'Bursa', 'Antalya', 'Adana', 'Konya', 'Ordu'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Fotoğraf Seçme Fonksiyonu
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Galeriden fotoğraf seçtiriyoruz
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_imageFile == null) {
        // Fotoğraf seçilmemişse uyarı ver (Toast / SnackBar)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lütfen ilan için bir fotoğraf seçin.')),
        );
        return;
      }
      
      print("İlan Başlığı: ${_titleController.text}");
      print("Kategori: ${_selectedCategory?.name}");
      
      // Başarılı olursa formu temizle ve Ana Sayfaya dön
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('İlanınız başarıyla oluşturuldu! (Demo)')),
      );
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Yeni İlan Ver', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Fotoğraf Seçme Alanı
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: _imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(File(_imageFile!.path), fit: BoxFit.cover),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo_outlined, size: 48, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('Fotoğraf Ekle', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // Başlık Alanı
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'İlan Başlığı',
                  hintText: 'Örn: Tekerlekli Sandalye İhtiyacı',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value!.isEmpty ? 'Lütfen bir başlık girin' : null,
              ),
              const SizedBox(height: 16),

              // Kategori Seçimi (appCategories sabitimizden çekiyoruz)
              DropdownButtonFormField<CategoryType>(
                decoration: InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                value: _selectedCategory,
                items: appCategories.values.map((CategoryItem category) {
                  return DropdownMenuItem<CategoryType>(
                    value: appCategories.keys.firstWhere((k) => appCategories[k] == category),
                    child: Row(
                      children: [
                        Text(category.icon),
                        const SizedBox(width: 8),
                        Text(category.label),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (CategoryType? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) => value == null ? 'Lütfen bir kategori seçin' : null,
              ),
              const SizedBox(height: 16),

              // Şehir Seçimi
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Şehir',
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
                validator: (value) => value == null ? 'Lütfen şehir seçin' : null,
              ),
              const SizedBox(height: 16),

              // Açıklama Alanı (Çok satırlı)
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'İlan Detayları',
                  alignLabelWithHint: true,
                  hintText: 'Durumu ve nasıl bir destek aradığınızı detaylıca anlatın...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value!.isEmpty ? 'Lütfen detayları yazın' : null,
              ),
              const SizedBox(height: 32),

              // Yayınla Butonu
              FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _handleSubmit,
                child: const Text('İlanı Yayınla', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 24), // Alt menü boşluğu
            ],
          ),
        ),
      ),
    );
  }
}