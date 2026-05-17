import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Simüle edilmiş kullanıcı durumu
  final bool _isNewUser = false; 

  // Gereksinim dokümanına uygun Mock Yapay Zeka Öneri Listesi
  // NOT: Tip güvenliği ve const hatası almamak için renkleri burada doğrudan atıyoruz
  final List<Map<String, dynamic>> _aiSuggestions = [
    {
      'id': 'p1',
      'title': 'Fit Tavuk Bowl',
      'restaurant': 'Sağlıklı Mutfak',
      'calorie': 520,
      'minPrice': 189.0,
      'description': 'Son tercihlerine göre protein ağırlıklı öneri.',
      'tag': 'AI Öneri',
      'tagColor': AppColors.primaryOrange,
    },
    {
      'id': 'p2',
      'title': 'Vegan Noodle',
      'restaurant': 'Asia Box',
      'calorie': 430,
      'minPrice': 164.0,
      'description': '90 günlük ortalamaya göre fiyat avantajı var.',
      'tag': 'Gerçek İndirim',
      'tagColor': AppColors.healthGreen,
    },
    {
      'id': 'p3',
      'title': 'Mercimek Çorbası & Gözleme',
      'restaurant': 'Yöresel Ev Yemekleri',
      'calorie': 610,
      'minPrice': 112.0,
      'description': 'Öğle saati için bütçe ve kalori dostu geleneksel menü.',
      'tag': 'Partnerde Var',
      'tagColor': AppColors.partnerBlue,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBackground,
      appBar: AppBar(
        title: const Text(
          'NeYesem',
          style: TextStyle(
            color: AppColors.primaryOrange,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: AppColors.surfaceLight,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: _isNewUser ? _buildColdStartBody() : _buildNormalBody(),
    );
  }

  // 1. SENARYO: NORMAL AKIŞ
  Widget _buildNormalBody() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Bugün ne yesem?',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 4),
        const Text(
          'Damak tadına, saatine ve hedeflerine göre öneriler',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        
        // Öneri Kartları Listesi - UYARI DÜZELTİLDİ: .toList() kaldırıldı
        ..._aiSuggestions.map((item) => _buildSuggestionCard(item)),

        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ['Vegan', 'Düşük Kalori', 'Gerçek İndirim', 'Popüler']
                .map((filter) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Chip(
                        label: Text(filter),
                        backgroundColor: AppColors.surfaceLight,
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }

  // 2. SENARYO: COLD START AKIŞI
  Widget _buildColdStartBody() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_rounded, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 24),
          const Text(
            'Sizi Henüz Tanımıyoruz',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Kişisel geçmiş veriniz az olduğu için size özel yapay zeka önerileri üretemiyoruz. Lütfen diyet ve alerji tercihlerinizi seçin.',
            style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              icon: const Icon(Icons.settings_accessibility, color: Colors.white),
              label: const Text(
                'Tercihlerimi Belirle',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // YAPAY ZEKA ÖNERİ KART BİLEŞENİ
  Widget _buildSuggestionCard(Map<String, dynamic> item) {
    // Tip dönüşümünü güvenli bir şekilde yapıyoruz
    final tagColor = item['tagColor'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // UYARI DÜZELTİLDİ: withOpacity yerine .withValues kullanıldı
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst Etiket Satırı
            Row(
              // HATA DÜZELTİLDİ: MainAxisAlignment.between -> spaceBetween yapıldı
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    // UYARI DÜZELTİLDİ: withOpacity yerine .withValues kullanıldı
                    color: tagColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item['tag'].toString(),
                    style: TextStyle(
                      color: tagColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${item['calorie']} kcal',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Başlık ve Fiyat Satırı
            Row(
              // HATA DÜZELTİLDİ: MainAxisAlignment.between -> spaceBetween yapıldı
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'].toString(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['restaurant'].toString(),
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${(item['minPrice'] as double).toStringAsFixed(0)} TL',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryOrange),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Açıklama Metni
            Text(
              item['description'].toString(),
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.3),
            ),
            const Divider(height: 24, thickness: 0.5),
            
            // BEĞEN / BEĞENME BUTONLARI
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_down_alt_outlined, size: 18, color: Colors.grey),
                  label: const Text('Beğenme', style: TextStyle(color: Colors.grey, fontSize: 13)),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up_alt_rounded, size: 18, color: AppColors.healthGreen),
                  label: const Text('Beğen', style: TextStyle(color: AppColors.healthGreen, fontSize: 13)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}