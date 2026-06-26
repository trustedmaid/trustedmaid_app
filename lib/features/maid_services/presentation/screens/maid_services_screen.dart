import 'package:flutter/material.dart';

import '../../../../resources/app_colors.dart';
import 'maid_service_detail_screen.dart';

/// Screen presenting the domestic help services catalog in a clean 2-column grid layout.
class MaidServicesScreen extends StatefulWidget {
  const MaidServicesScreen({super.key});

  @override
  State<MaidServicesScreen> createState() => _MaidServicesScreenState();
}

class _MaidServicesScreenState extends State<MaidServicesScreen> {

  // Statically mapped core services to align with screenshots and details indices
  final List<Map<String, dynamic>> _services = [
    {
      'emoji': '🧹',
      'title': 'House Maid',
      'desc': 'Daily sweeping, mopping, utensil cleaning, laundry & home organization',
      'index': 0,
      'image': 'assets/services/house_maid.webp',
      'inclusions': [
        'Daily sweeping & mopping',
        'Laundry & ironing',
        'Kitchen & utensil cleaning',
        'Bathroom sanitizing',
        'Dusting & organizing',
      ],
    },
    {
      'emoji': '🍳',
      'title': 'Cook for Home',
      'desc': 'Experienced home cooks who prepare hygienic, delicious meals to your taste.',
      'index': 1,
      'image': 'assets/services/cook.webp',
      'inclusions': [
        'Breakfast, lunch & dinner',
        'Regional & special cuisines',
        'Diet & health meal planning',
        'Grocery list management',
        'Clean cooking area',
      ],
    },
    {
      'emoji': '👶',
      'title': 'Baby Sitter',
      'desc': 'Safe, nurturing child care & custom toddler routines',
      'index': 2,
      'image': 'assets/services/baby_sitter.webp',
      'inclusions': [
        'Safe & nurturing care',
        'Play & learning activities',
        'Feeding & diaper routines',
        'Sleep scheduling',
        'Regular parent updates',
      ],
    },
    {
      'emoji': '🏥',
      'title': 'Patient Care',
      'desc': 'Vital medicine scheduling, mobility assistance & hospital recovery support',
      'index': 3,
      'image': 'assets/services/patient_care.webp',
      'inclusions': [
        'Medication reminders',
        'Mobility & hygiene support',
        'Doctor visit assistance',
        'Vital monitoring & notes',
        'Emotional companionship',
      ],
    },
    {
      'emoji': '🍼',
      'title': 'Japa Maid',
      'desc': 'Newborn bathing, baby massage & post-delivery recovery support',
      'index': 4,
      'image': 'assets/services/japa_maid.webp',
      'inclusions': [
        'Newborn bathing & massage',
        'Mother recovery care',
        'Breastfeeding support',
        'Night duty care',
        'Swaddle & feeding routines',
      ],
    },
    {
      'emoji': '👵',
      'title': 'Elderly Care',
      'desc': 'Daily living physical support & warm senior citizen companionship',
      'index': 5,
      'image': 'assets/services/elderly_care.webp',
      'inclusions': [
        'Daily living assistance',
        'Medication management',
        'Mobility & safety support',
        'Companionship',
        'Family coordination',
      ],
    },
    {
      'emoji': '👩',
      'title': 'Nanny',
      'desc': 'Toddler development routines, school support, and child safety',
      'index': 6,
      'image': 'assets/services/baby_sitter.webp',
      'inclusions': [
        'Structured daily routines',
        'Educational play',
        'School pick-up & drop',
        'Nutritious meals',
        'Child development focus',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Services',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subsection Header: "1 WHAT HELPER DO YOU NEED?"
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: AppColors.brandSoft,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'WHAT HELPER DO YOU NEED?',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Wrap of Services
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final columns = width > 900 ? 2 : 1;
                    final spacing = 20.0;
                    final itemWidth =
                        (width - (spacing * (columns - 1))) / columns;

                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: List.generate(_services.length, (index) {
                        final item = _services[index];
                        final badgeText = item['title'] == 'Cook for Home' ? 'Cook' : item['title'];
                        final inclusions = item['inclusions'] as List<String>;

                        return SizedBox(
                          width: itemWidth,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MaidServiceDetailScreen(
                                    serviceIndex: item['index'] as int,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: AppColors.line),
                                boxShadow: [
                                  BoxShadow(
                                    // ignore: deprecated_member_use
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Top cover image with overlay pills
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(23),
                                          topRight: Radius.circular(23),
                                        ),
                                        child: Image.asset(
                                          item['image'] as String,
                                          height: 180,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // Top-right "Details ->" badge
                                      Positioned(
                                        top: 14,
                                        right: 14,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                // ignore: deprecated_member_use
                                                color: Colors.black.withOpacity(0.08),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Details',
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.5,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Icon(
                                                Icons.arrow_forward_rounded,
                                                size: 13,
                                                color: AppColors.primary,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    // Bottom-left blue badge
                                    Positioned(
                                      bottom: 14,
                                      left: 14,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          badgeText as String,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Content body
                                Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Description
                                      Text(
                                        item['desc'] as String,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.darkTextSecondary,
                                          height: 1.45,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      // What's included box
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF3F7FF), // Brand soft highlight
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "WHAT'S INCLUDED",
                                              style: TextStyle(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                                letterSpacing: 0.6,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            ...List.generate(inclusions.length, (incIndex) {
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                      Icons.check_circle_outline_rounded,
                                                      color: Color(0xFF10B981), // Green outline check
                                                      size: 15,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        inclusions[incIndex],
                                                        style: const TextStyle(
                                                          color: Color(0xFF475569),
                                                          fontSize: 12.5,
                                                          height: 1.3,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                       ),
                                     ],
                                   ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
}
