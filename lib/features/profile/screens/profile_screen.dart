import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Gereksinim dokümanındaki standart diyet listesi (FR-PROF-001)
  final List<String> _dietOptions = [
    'Standart',
    'Vejetaryen',
    'Vegan',
    'Glutensiz',
    'Ketojenik',
    'Protein Ağırlıklı'
  ];

  // Gereksinim dokümanındaki standart alerjen listesi (FR-PROF-002)
  final List<String> _allergyOptions = [
    'Gluten',
    'Laktoz',
    'Yer Fıstığı',
    'Deniz Ürünleri',
    'Soya',
    'Yumurta'
  ];

  // Gereksinim dokümanındaki standart kalori hedefleri (FR-PROF-003)
  final List<int> _calorieOptions = [1500, 1800, 2000, 2500];

  // Kullanıcının seçtiği anlık durumlar (Mock Veri başlangıcı)
  String _selectedDiet = 'Standart';
  final List<String> _selectedAllergies = [];
  int _selectedCalorieGoal = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBackground,
      appBar: AppBar(
        title: const Text(
          'Profil ve Hedefler',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryOrange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Giriş Bilgilendirme Kartı
            _buildSectionHeader('Kişiselleştirme Merkezi', Icons.auto_awesome),
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0, left: 4.0),
              child: Text(
                'Seçtiğiniz diyet, alerji ve kalori hedefleri yapay zeka yemek önerilerini doğrudan etkiler.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),

            // 1. DİYET TERCİHLERİ BÖLÜMÜ (FR-PROF-001)
            _buildCardContainer(
              title: 'Diyet Tercihi',
              icon: Icons.restaurant_menu,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: _dietOptions.map((diet) {
                  final isSelected = _selectedDiet == diet;
                  return ChoiceChip(
                    label: Text(diet),
                    selected: isSelected,
                    selectedColor: AppColors.healthGreen.withOpacity(0.2),
                    checkmarkColor: AppColors.healthGreen,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.healthGreen : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedDiet = diet);
                      }
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // 2. ALERJİ BİLGİLERİ BÖLÜMÜ (FR-PROF-002)
            _buildCardContainer(
              title: 'Alerjen Uyarıları',
              icon: Icons.warning_amber_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: _allergyOptions.map((allergy) {
                      final isSelected = _selectedAllergies.contains(allergy);
                      return FilterChip(
                        label: Text(allergy),
                        selected: isSelected,
                        selectedColor: Colors.red.withOpacity(0.1),
                        checkmarkColor: Colors.red,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.red : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedAllergies.add(allergy);
                            } else {
                              _selectedAllergies.remove(allergy);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 3. KALORİ HEDEFİ BÖLÜMÜ (FR-PROF-003)
            _buildCardContainer(
              title: 'Günlük Kalori Hedefi',
              icon: Icons.local_fire_department_rounded,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _calorieOptions.map((calorie) {
                  final isSelected = _selectedCalorieGoal == calorie;
                  return ChoiceChip(
                    label: Text('$calorie kcal'),
                    selected: isSelected,
                    selectedColor: AppColors.partnerBlue.withOpacity(0.1),
                    checkmarkColor: AppColors.partnerBlue,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.partnerBlue : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedCalorieGoal = calorie);
                      }
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),

            // KAYDET BUTONU (CTA)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // İleride burası Bloc/Repository katmanına bağlanıp veritabanına (toJson) pushlanacak.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Tercihleriniz kaydedildi! Diyet: $_selectedDiet, Kalori: $_selectedCalorieGoal kcal',
                      ),
                      backgroundColor: AppColors.healthGreen,
                    ),
                  );
                },
                child: const Text(
                  'Tercihleri Kaydet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Ortak şık kart tasarımı bileseni
  Widget _buildCardContainer({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryOrange, size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Divider(height: 24, thickness: 0.8),
          child,
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54, size: 20),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}