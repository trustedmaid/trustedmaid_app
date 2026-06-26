import 'package:flutter/material.dart';

import '../../../../resources/app_colors.dart';
import '../../../../utils/extensions.dart';
import 'locality_search_screen.dart';
import 'pro_profile_screen.dart';

/// Screen exhibiting details of a specific domestic helper service.
class MaidServiceDetailScreen extends StatefulWidget {
  final int serviceIndex;

  const MaidServiceDetailScreen({super.key, required this.serviceIndex});

  @override
  State<MaidServiceDetailScreen> createState() =>
      _MaidServiceDetailScreenState();
}

class _MaidServiceDetailScreenState extends State<MaidServiceDetailScreen> {
  bool _showFullDesc = false;
  int _openFAQIndex = -1;

  // Hardcoded services structure mapped to prototype details
  final List<Map<String, dynamic>> _detailServices = [
    {
      'title': 'House Maid',
      'icon': Icons.cleaning_services_rounded,
      'description':
          'Daily sweeping, mopping, utensil cleaning, laundry & home organization',
      'inclusions': [
        'Daily sweeping & mopping',
        'Laundry & ironing',
        'Kitchen & utensil cleaning',
        'Bathroom sanitizing',
        'Dusting & organizing',
      ],
    },
    {
      'title': 'Cook for Home',
      'icon': Icons.restaurant_rounded,
      'description':
          'Hygienic, tasty meal preparations according to your custom preferences',
      'inclusions': [
        'Breakfast, lunch & dinner',
        'Regional & special cuisines',
        'Diet & health meal planning',
        'Grocery list management',
        'Clean cooking area',
      ],
    },
    {
      'title': 'Baby Sitter',
      'icon': Icons.child_friendly_rounded,
      'description': 'Safe, nurturing child care & custom toddler routines',
      'inclusions': [
        'Safe & nurturing care',
        'Play & learning activities',
        'Feeding & diaper routines',
        'Sleep scheduling',
        'Regular parent updates',
      ],
    },
    {
      'title': 'Patient Care',
      'icon': Icons.health_and_safety_rounded,
      'description':
          'Vital medicine scheduling, mobility assistance & hospital recovery support',
      'inclusions': [
        'Medication reminders',
        'Mobility & hygiene support',
        'Doctor visit assistance',
        'Vital monitoring & notes',
        'Emotional companionship',
      ],
    },
    {
      'title': 'Japa Maid',
      'icon': Icons.pregnant_woman_rounded,
      'description':
          'Newborn bathing, baby massage & post-delivery recovery support',
      'inclusions': [
        'Newborn bathing & massage',
        'Mother recovery care',
        'Breastfeeding support',
        'Night duty care',
        'Swaddle & feeding routines',
      ],
    },
    {
      'title': 'Elderly Care',
      'icon': Icons.elderly_rounded,
      'description':
          'Daily living physical support & warm senior citizen companionship',
      'inclusions': [
        'Daily living assistance',
        'Medication management',
        'Mobility & safety support',
        'Companionship',
        'Family coordination',
      ],
    },
    {
      'title': 'Nanny',
      'icon': Icons.escalator_warning_rounded,
      'description':
          'Toddler development routines, school support, and child safety',
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
    // Graceful check for array bounds
    final service = widget.serviceIndex < _detailServices.length
        ? _detailServices[widget.serviceIndex]
        : _detailServices[0];

    final inclusions = service['inclusions'] as List<String>;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Area with Background Image & Gradient overlay
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          _getServiceImagePath(service['title'] as String),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      // ignore: deprecated_member_use
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: AppColors.secondary,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Service title area
                  Transform.translate(
                    offset: const Offset(18, -32),
                    child: Container(
                      width: 64,
                      height: 64,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          _getServiceImagePath(service['title'] as String),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service['title'] as String,
                          style: context.textTheme.headlineMedium?.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.amber[700],
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '4.8',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '· 540 reviews',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.verified_rounded,
                                    color: Colors.green,
                                    size: 12,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Verified Pros',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${service['description']}. Flexible part-time, full-time & live-in arrangements with free replacement support.',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (service['title'] == 'House Maid') ...[
                    _buildHouseMaidDetailedView(context, service),
                  ] else if (service['title'] == 'Cook for Home') ...[
                    _buildCookDetailedView(context, service),
                  ] else if (service['title'] == 'Baby Sitter') ...[
                    _buildBabySitterDetailedView(context, service),
                  ] else if (service['title'] == 'Nanny') ...[
                    _buildNannyDetailedView(context, service),
                  ] else if (service['title'] == 'Patient Care') ...[
                    _buildPatientCareDetailedView(context, service),
                  ] else if (service['title'] == 'Japa Maid') ...[
                    _buildJapaMaidDetailedView(context, service),
                  ] else if (service['title'] == 'Elderly Care') ...[
                    _buildElderlyCareDetailedView(context, service),
                  ] else ...[
                    // Inclusions
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      child: Text(
                        "What's included",
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      itemCount: inclusions.length,
                      itemBuilder: (context, idx) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: Colors.green.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check_rounded,
                                  color: Colors.green,
                                  size: 13,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                inclusions[idx],
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],

                  /*
                  // Meet a verified pro
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    child: Text(
                      'Meet a verified pro',
                      style: TextStyle(color: AppColors.secondary, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 104,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      children: [
                        _buildProDetailCard(context, 'SK', 'Sunita K.', '6 yrs exp · Powai', '4.9 · 120 homes'),
                        _buildProDetailCard(context, 'MD', 'Meena D.', '4 yrs exp · Andheri', '4.7 · 70 homes'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  */
                ],
              ),
            ),
          ),

          // Bottom sticky bar for checking estimated salary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LocalitySearchScreen(service: service),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Check Estimated Salary',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _buildProDetailCard(
    BuildContext context,
    String initials,
    String name,
    String details,
    String rating,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProProfileScreen()),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.brand2, AppColors.primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                      color: AppColors.secondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.verified_rounded,
                  color: AppColors.primary,
                  size: 14,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              details,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(Icons.star_rounded, color: Colors.amber[700], size: 14),
                const SizedBox(width: 2),
                Text(
                  rating,
                  style: TextStyle(
                    color: Colors.amber[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getServiceImagePath(String title) {
    switch (title) {
      case 'House Maid':
        return 'assets/services/house_maid.webp';
      case 'Cook for Home':
        return 'assets/services/cook.webp';
      case 'Baby Sitter':
      case 'Nanny':
        return 'assets/services/baby_sitter.webp';
      case 'Patient Care':
        return 'assets/services/patient_care.webp';
      case 'Japa Maid':
        return 'assets/services/japa_maid.webp';
      case 'Elderly Care':
        return 'assets/services/elderly_care.webp';
      default:
        return 'assets/services/house_maid.webp';
    }
  }

  Widget _buildHouseMaidDetailedView(
    BuildContext context,
    Map<String, dynamic> service,
  ) {
    final features = [
      'Background-verified & identity-checked professionals',
      'Full-time, part-time, hourly & 24-hour live-in arrangements',
      'Expert daily cleaning, mopping & dusting',
      'Laundry, vessel washing & kitchen upkeep',
      'Prompt replacement if needed — no gaps in service',
      'Affordable & transparent pricing, no hidden charges',
    ];

    final facts = [
      {
        'title': 'What is this service?',
        'desc':
            'Trusted Maid connects you with professional, background-verified house maids in Mumbai tailored to your specific household needs.',
      },
      {
        'title': 'Areas Served',
        'desc':
            'We provide house maid services across all major localities in Mumbai, Thane, and Navi Mumbai.',
      },
      {
        'title': 'Core Duties',
        'desc':
            'Trusted Maid connects you with background-verified, trained house maids to keep your home clean, organized, and completely stress-free. Whether you need full-time help managing a large household or a part-time maid for daily chores, we match you with the right professional based on your specific requirements, schedule, and location across Mumbai.',
      },
      {
        'title': 'Placement Speed',
        'desc':
            'Families are typically matched with a shortlisted house maid within 24 to 48 hours.',
      },
      {
        'title': 'Strict Verification',
        'desc':
            '100% of our house maids undergo rigorous identity (Aadhaar), address, and police background checks before placement.',
      },
      {
        'title': 'Our Guarantee',
        'desc':
            'We offer a seamless free replacement policy if the provided house maid is not the perfect fit for your family.',
      },
    ];

    final tasks = [
      {
        'title': 'Daily Sweeping & Mopping',
        'desc':
            'Complete floor cleaning of all rooms including bathrooms and kitchen using appropriate products for each surface type.',
      },
      {
        'title': 'Kitchen & Vessel Cleaning',
        'desc':
            'Thorough cleaning of kitchen counters, stovetop, sink, and all utensils to maintain hygiene and freshness.',
      },
      {
        'title': 'Laundry & Ironing',
        'desc':
            'Washing, drying, folding, and ironing of clothes as per your household\'s schedule and preferences.',
      },
      {
        'title': 'Dusting & Surface Wipe-down',
        'desc':
            'Regular dusting of furniture, shelves, fans, and all surfaces to keep dust and allergens at bay.',
      },
      {
        'title': 'Bathroom & Toilet Cleaning',
        'desc':
            'Deep cleaning of bathrooms including tiles, fixtures, and floors to maintain sanitation throughout the week.',
      },
      {
        'title': 'Grocery & Errand Assistance',
        'desc':
            'Help with basic household errands and grocery runs when required, subject to arrangement.',
      },
    ];

    final steps = [
      {
        'step': 'Step 01',
        'title': 'Share Your Needs',
        'desc':
            'Tell us your home size, preferred timing, and the specific tasks you need help with.',
      },
      {
        'step': 'Step 02',
        'title': 'We Find Your Match',
        'desc':
            'We shortlist verified maids from your area who match your requirements and schedule.',
      },
      {
        'step': 'Step 03',
        'title': 'Trial Period',
        'desc':
            'Meet the candidate and run a short trial to ensure you\'re fully satisfied before confirming.',
      },
      {
        'step': 'Step 04',
        'title': 'Ongoing Support',
        'desc':
            'We stay available throughout the placement for any feedback, adjustments, or replacement needs.',
      },
    ];

    final faqs = [
      {
        'q': 'How do I hire a verified house maid in Mumbai?',
        'a':
            'Fill our online booking form or call +91 7718003880. We shortlist background-verified maids matching your schedule and budget within 24–48 hours.',
      },
      {
        'q': 'Are your house maids police verified?',
        'a':
            'Yes. Every maid undergoes identity verification, address verification, and a police background check before placement with any family.',
      },
      {
        'q': 'Can I hire a part-time house maid?',
        'a':
            'Yes, we offer part-time (4–5 hours/day), full-time (8 hours/day), and live-in options tailored to your household\'s needs.',
      },
      {
        'q': 'What tasks does a house maid from Trusted Maid perform?',
        'a':
            'Daily sweeping, mopping, dusting, kitchen cleaning, utensil washing, laundry, ironing, and general home organisation.',
      },
      {
        'q': 'Which areas in Mumbai do you serve for house maid services?',
        'a':
            'We currently serve Andheri, Bandra, Bhandup, Borivali, Chembur, Goregaon, Malad, Powai, and surrounding localities.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Detailed Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trusted House Maid Services in Mumbai',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Trusted Maid connects you with background-verified, trained house maids to keep your home clean, organized, and completely stress-free. Whether you need full-time help managing a large household or a part-time maid for daily chores, we match you with the right professional based on your specific requirements, schedule, and location across Mumbai.',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              if (_showFullDesc) ...[
                const SizedBox(height: 12),
                Text(
                  'A clean home is not just about appearances — it directly affects your physical health, mental well-being, and the quality of daily life for your entire family. Yet in Mumbai’s fast-paced environment, maintaining a consistently clean home on your own is simply not realistic. Our house maids take over the daily burden so you can focus on what matters most — your family, your work, and your rest. Every house maid placed by Trusted Maid has gone through identity verification, address confirmation, and a personal interview before being introduced to any family. We assess both skill and character, because the person entering your home every day must be someone you can genuinely trust.',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showFullDesc = !_showFullDesc;
                  });
                },
                child: Text(
                  _showFullDesc ? 'Show Less' : '...more',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Features Grid
        _buildFeaturesGrid(features),

        // 3. Quick Facts
        _buildQuickFactsCard('Quick Facts About Our House Maid Service', facts),

        // 4. Task Breakdown
        _buildTaskBreakdown(
          'A complete breakdown of everything our verified house maid professionals handle for your household.',
          tasks,
        ),

        // 5. How Placement Works
        _buildPlacementWorks(
          'How Our House Maid Placement Works',
          'Simple, transparent steps from your first enquiry to a reliable professional at your door.',
          steps,
        ),

        // 6. FAQs
        _buildFAQAccordion(faqs),

        const SizedBox(height: 18),
      ],
    );
  }

  Widget _buildCookDetailedView(
    BuildContext context,
    Map<String, dynamic> service,
  ) {
    final features = [
      'Freshly prepared breakfast, lunch & dinner daily',
      'Customized to your family’s cuisine & taste',
      'Trained in hygiene, food safety & kitchen cleanliness',
      'Handles special diets: diabetic, low-sodium, Jain, vegan',
      'Background-verified with cooking skill assessment',
      'Maharashtrian, Gujarati, Jain & Pure Veg specialists',
      'Flexible timings to fit your household schedule',
    ];

    final facts = [
      {
        'title': 'What is this service?',
        'desc':
            'Trusted Maid connects you with professional, background-verified cooks in Mumbai tailored to your specific household needs.',
      },
      {
        'title': 'Core Duties:',
        'desc':
            'Enjoy fresh, home-cooked meals every day without the effort. Trusted Maid connects you with experienced, background-verified home cooks who prepare breakfast, lunch, and dinner tailored exactly to your family’s taste, dietary needs, and daily schedule — so you never have to rely on outside food again.',
      },
      {
        'title': 'Strict Verification:',
        'desc':
            '100% of our cooks undergo rigorous identity (Aadhaar), address, and police background checks before placement.',
      },
      {
        'title': 'Areas Served:',
        'desc':
            'We provide cook services across all major localities in Mumbai, Thane, and Navi Mumbai.',
      },
      {
        'title': 'Placement Speed:',
        'desc':
            'Families are typically matched with a shortlisted cook within 24 to 48 hours.',
      },
      {
        'title': 'Our Guarantee:',
        'desc':
            'We offer a seamless free replacement policy if the provided cook is not the perfect fit for your family.',
      },
    ];

    final tasks = [
      {
        'title': 'Daily Meal Preparation',
        'desc':
            'Fresh breakfast, lunch, and dinner prepared daily using your ingredients and your family\'s preferred recipes.',
      },
      {
        'title': 'Special Diet Cooking',
        'desc':
            'Expert preparation of diabetic-friendly, low-sodium, Jain, vegan, or any specific dietary requirement your family follows.',
      },
      {
        'title': 'Traditional Indian Cuisine',
        'desc':
            'Skilled in regional Indian cuisines including Punjabi, South Indian, Gujarati, Maharashtrian, and more.',
      },
      {
        'title': 'Tiffin Preparation',
        'desc':
            'Morning tiffin boxes for school or office prepared efficiently before your family leaves for the day.',
      },
      {
        'title': 'Kitchen Cleanliness',
        'desc':
            'Responsible for keeping the kitchen clean, organized, and hygienic throughout their working hours.',
      },
      {
        'title': 'Grocery Coordination',
        'desc':
            'Helps plan daily ingredients list so you always have fresh produce available for meals.',
      },
    ];

    final steps = [
      {
        'step': 'Step 01',
        'title': 'Share Your Preferences',
        'desc':
            'Tell us your cuisine preferences, meal timings, family size, and any dietary requirements.',
      },
      {
        'step': 'Step 02',
        'title': 'Cook Matching',
        'desc':
            'We shortlist verified cooks experienced in your preferred cuisine from your area.',
      },
      {
        'step': 'Step 03',
        'title': 'Cooking Trial',
        'desc':
            'The cook prepares a full trial meal so you can assess taste, hygiene, and kitchen conduct firsthand.',
      },
      {
        'step': 'Step 04',
        'title': 'Placement & Support',
        'desc':
            'Once confirmed, your cook joins and we remain available for any feedback or adjustments.',
      },
    ];

    final faqs = [
      {
        'q': 'What types of food can your home cook prepare?',
        'a':
            'Our cooks prepare Indian regional cuisines, continental dishes, diet-specific meals (diabetic, Jain, low-sodium), and daily family meals.',
      },
      {
        'q': 'Can I hire a cook for only 2 hours a day?',
        'a':
            'Yes, we offer flexible part-time cooking options starting from 2 hours a day for single meal preparation up to full-time arrangements.',
      },
      {
        'q': 'Are your cooks trained in food hygiene?',
        'a':
            'Yes, all cooks are trained in kitchen hygiene, food safety, and proper storage practices before placement.',
      },
      {
        'q': 'Do your cooks assist with grocery management?',
        'a':
            'Yes, many of our cooks help plan the grocery list and coordinate purchases according to your dietary preferences.',
      },
      {
        'q':
            'What if the cook\'s taste does not match our family\'s preference?',
        'a':
            'We coordinate a replacement cook at no extra charge to ensure you get the right taste and compatibility for your household.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Detailed Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enjoy Professional Cooking Services at Home in Mumbai',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Enjoy fresh, home-cooked meals every day without the effort. Trusted Maid connects you with experienced, background-verified home cooks who prepare breakfast, lunch, and dinner tailored exactly to your family’s taste, dietary needs, and daily schedule — so you never have to rely on outside food again.',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              if (_showFullDesc) ...[
                const SizedBox(height: 12),
                Text(
                  'Food is the foundation of a healthy, happy home. But in Mumbai, where time is always short and daily demands are relentless, cooking fresh meals every day is a challenge most families cannot consistently meet. A professional home cook changes that entirely. Our cooks learn your family’s cuisine preferences, dietary requirements, and meal timings over the first few days, and then maintain a consistent, high-quality cooking routine that genuinely feels like home cooking — because it is. Every cook placed by Trusted Maid is verified, reference-checked, and assessed for cooking skills before placement. We offer specialized cooking services including traditional Maharashtrian, Gujarati, Jain, North Indian, and South Indian cuisines, as well as pure vegetarian specialists.',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showFullDesc = !_showFullDesc;
                  });
                },
                child: Text(
                  _showFullDesc ? 'Show Less' : '...more',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Features Grid
        _buildFeaturesGrid(features),

        // 3. Quick Facts
        _buildQuickFactsCard(
          'Quick Facts About Our Cook Service',
          facts,
          isTwoColumn: true,
        ),

        // 4. Task Breakdown
        _buildTaskBreakdown(
          "What's Included in Our Cook Service",
          tasks,
          subtitle:
              'A complete breakdown of everything our verified cook professionals handle for your household.',
          isThreeColumn: true,
        ),

        // 5. How Placement Works
        _buildPlacementWorks(
          'How Our Cook Placement Works',
          'Simple, transparent steps from your first enquiry to a reliable professional at your door.',
          steps,
          isHorizontal: true,
        ),

        // 6. FAQs
        _buildFAQAccordion(faqs),

        const SizedBox(height: 18),
      ],
    );
  }

  Widget _buildFeaturesGrid(List<String> features) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = (constraints.maxWidth - 10) / 2;
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: features.map((feature) {
              return Container(
                width: width,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.line),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildQuickFactsCard(
    String cardTitle,
    List<Map<String, String>> facts, {
    bool isTwoColumn = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: AppColors.brandSoft.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.brandSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('✨', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Text(
                cardTitle,
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (isTwoColumn)
            LayoutBuilder(
              builder: (context, constraints) {
                final leftFacts = <Map<String, String>>[];
                final rightFacts = <Map<String, String>>[];
                for (int i = 0; i < facts.length; i++) {
                  if (i % 2 == 0) {
                    leftFacts.add(facts[i]);
                  } else {
                    rightFacts.add(facts[i]);
                  }
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: leftFacts.map(_buildFactItem).toList(),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: rightFacts.map(_buildFactItem).toList(),
                      ),
                    ),
                  ],
                );
              },
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: facts.map(_buildFactItem).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildFactItem(Map<String, String> fact) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fact['title']!,
            style: const TextStyle(
              color: AppColors.secondary,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            fact['desc']!,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskBreakdown(
    String breakdownTitle,
    List<Map<String, String>> tasks, {
    String? subtitle,
    bool isThreeColumn = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (subtitle != null) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 24, 18, 4),
            child: Text(
              breakdownTitle,
              style: const TextStyle(
                color: AppColors.secondary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ] else ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Text(
              breakdownTitle,
              style: const TextStyle(
                color: AppColors.secondary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),
        ],
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final colCount = isThreeColumn ? 3 : 2;
              final finalColCount =
                  (isThreeColumn && constraints.maxWidth < 480) ? 2 : colCount;
              final spacing = 10.0;
              final width =
                  (constraints.maxWidth - (spacing * (finalColCount - 1))) /
                  finalColCount;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: tasks.map((task) {
                  return Container(
                    width: width,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.line),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          color: AppColors.primary,
                          size: 18,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          task['title']!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          task['desc']!,
                          style: TextStyle(
                            fontSize: 10.5,
                            color: Colors.grey[600],
                            height: 1.3,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlacementWorks(
    String sectionTitle,
    String sectionSubtitle,
    List<Map<String, String>> steps, {
    bool isHorizontal = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 24, 18, 4),
          child: Text(
            sectionTitle,
            style: const TextStyle(
              color: AppColors.secondary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            sectionSubtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        const SizedBox(height: 14),
        if (isHorizontal)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final colCount = constraints.maxWidth < 600 ? 1 : 4;
                final spacing = 12.0;
                final width =
                    (constraints.maxWidth - (spacing * (colCount - 1))) /
                    colCount;
                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: steps.map((step) {
                    return Container(
                      width: width,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.line),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange[800],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              step['step']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            step['title']!,
                            style: const TextStyle(
                              color: AppColors.secondary,
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            step['desc']!,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 18),
            itemCount: steps.length,
            itemBuilder: (context, idx) {
              final step = steps[idx];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.line),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange[800],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        step['step']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      step['title']!,
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step['desc']!,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildFAQLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, color: Colors.amber[700]),
        const SizedBox(width: 2),
        Container(width: 8, height: 8, color: AppColors.primary),
      ],
    );
  }

  Widget _buildFAQAccordion(List<Map<String, String>> faqs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFAQLogo(),
            const SizedBox(width: 8),
            const Text(
              'F A Q S',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 11,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Frequently Asked Questions',
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          itemCount: faqs.length,
          itemBuilder: (context, idx) {
            final faq = faqs[idx];
            final isOpen = _openFAQIndex == idx;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.line),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.015),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _openFAQIndex = isOpen ? -1 : idx;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                faq['q']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              isOpen ? Icons.close_rounded : Icons.add_rounded,
                              color: Colors.orange[800],
                              size: 18,
                            ),
                          ],
                        ),
                        if (isOpen) ...[
                          const SizedBox(height: 10),
                          Text(
                            faq['a']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBabySitterDetailedView(
    BuildContext context,
    Map<String, dynamic> service,
  ) {
    final features = [
      'Trained in infant & toddler care with verified experience',
      'Establishes safe daily feeding & sleep routines',
      'Age-appropriate play & developmental activities',
      'First aid awareness for infant emergencies',
      'Background-verified with childcare references',
      'Available for full-day, part-time & overnight care',
    ];

    final facts = [
      {
        'title': 'What is this service?',
        'desc':
            'Trusted Maid connects you with professional, background-verified baby sitters in Mumbai tailored to your specific household needs.',
      },
      {
        'title': 'Areas Served:',
        'desc':
            'We provide baby sitter services across all major localities in Mumbai, Thane, and Navi Mumbai.',
      },
      {
        'title': 'Core Duties:',
        'desc':
            'Your child’s safety and happiness are everything. Trusted Maid connects you with trained, background-verified baby sitters who bring genuine warmth, structured routines, and experienced childcare to your home — giving you complete peace of mind whether you are at work or simply need a reliable break.',
      },
      {
        'title': 'Placement Speed:',
        'desc':
            'Families are typically matched with a shortlisted baby sitter within 24 to 48 hours.',
      },
      {
        'title': 'Strict Verification:',
        'desc':
            '100% of our baby sitters undergo rigorous identity (Aadhaar), address, and police background checks before placement.',
      },
      {
        'title': 'Our Guarantee:',
        'desc':
            'We offer a seamless free replacement policy if the provided baby sitter is not the perfect fit for your family.',
      },
    ];

    final tasks = [
      {
        'title': 'Infant & Newborn Care',
        'desc':
            'Experienced handling of newborns including feeding support, safe bathing, cord care, and sleep positioning.',
      },
      {
        'title': 'Toddler Supervision',
        'desc':
            'Attentive supervision of toddlers with structured play, meals, naps, and safe indoor and outdoor activity.',
      },
      {
        'title': 'Daily Routine Management',
        'desc':
            'Establishing and maintaining consistent feeding, sleeping, and activity schedules that children thrive on.',
      },
      {
        'title': 'Educational Play',
        'desc':
            'Age-appropriate activities including reading, drawing, sensory play, and learning games that support early development.',
      },
      {
        'title': 'School Pick-up & Drop',
        'desc':
            'Safe pick-up and drop from nearby schools as part of the daily routine when required.',
      },
      {
        'title': 'Light Meal Preparation',
        'desc':
            'Preparing and serving appropriate, nutritious snacks and meals for the child throughout the day.',
      },
    ];

    final steps = [
      {
        'step': 'Step 01',
        'title': 'Tell Us About Your Child',
        'desc':
            'Share your child’s age, daily routine, specific care needs, and your working schedule.',
      },
      {
        'step': 'Step 02',
        'title': 'Candidate Shortlisting',
        'desc':
            'We identify baby sitters with relevant age-group experience from your area.',
      },
      {
        'step': 'Step 03',
        'title': 'Home Interview & Trial',
        'desc':
            'Meet the candidate at home and observe their interaction with your child before deciding.',
      },
      {
        'step': 'Step 04',
        'title': 'Placement & Monitoring',
        'desc':
            'We support the placement and remain available for ongoing feedback and any changes needed.',
      },
    ];

    final faqs = [
      {
        'q': 'How do you check the background of babysitters?',
        'a':
            'Every babysitter undergoes multi-layered verification: government identity (Aadhaar) check, address verification, reference check from past employers, and police verification.',
      },
      {
        'q': 'Can I hire a babysitter for newborn baby care?',
        'a':
            'Yes. We match you with babysitters who specialize in infant care, handling tasks like massage, feeding, sanitization, and newborn sleep monitoring.',
      },
      {
        'q': 'Are your babysitters trained in child engagement?',
        'a':
            'Yes. Our babysitters are experienced in age-appropriate child interaction, reading, playing, and organizing educational games to reduce screen time.',
      },
      {
        'q': 'What happens if my child is uncomfortable with the babysitter?',
        'a':
            'Child comfort is our highest priority. We will organize interactions with alternative candidates to find the perfect compatible match at no extra cost.',
      },
      {
        'q': 'Do they cook meals for the children?',
        'a':
            'Yes, our babysitters can prepare simple healthy meals specifically for the child, warm baby food, and sterilize feeding bottles.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Detailed Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Professional Baby Sitter & Nanny Services in Mumbai',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your child’s safety and happiness are everything. Trusted Maid connects you with trained, background-verified baby sitters who bring genuine warmth, structured routines, and experienced childcare to your home — giving you complete peace of mind whether you are at work or simply need a reliable break.',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              if (_showFullDesc) ...[
                const SizedBox(height: 12),
                Text(
                  'The early years of a child’s life are the most formative, and the quality of care they receive during these years has lasting impact. Our baby sitters are not just helpers — they are experienced childcare professionals who understand infant and toddler needs, know how to establish safe daily routines, and engage children in age-appropriate activities that support their development. Every baby sitter placed by Trusted Maid is thoroughly screened, reference-checked from previous childcare placements, and interviewed specifically for experience with children of your child’s age group.',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showFullDesc = !_showFullDesc;
                  });
                },
                child: Text(
                  _showFullDesc ? 'Show Less' : '...more',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Features Grid
        _buildFeaturesGrid(features),

        // 3. Quick Facts
        _buildQuickFactsCard(
          'Quick Facts About Our Baby Sitter Service',
          facts,
          isTwoColumn: true,
        ),

        // 4. Task Breakdown
        _buildTaskBreakdown(
          "What's Included in Our Baby Sitter Service",
          tasks,
          subtitle:
              'A complete breakdown of everything our verified baby sitter professionals handle for your household.',
          isThreeColumn: true,
        ),

        // 5. How Placement Works
        _buildPlacementWorks(
          'How Our Baby Sitter Placement Works',
          'Simple, transparent steps from your first enquiry to a reliable professional at your door.',
          steps,
          isHorizontal: true,
        ),

        // 6. FAQs
        _buildFAQAccordion(faqs),

        const SizedBox(height: 18),
      ],
    );
  }

  Widget _buildPatientCareDetailedView(
    BuildContext context,
    Map<String, dynamic> service,
  ) {
    final features = [
      'Trained in mobility support, hygiene & medication management',
      'Available for 8hr, 12hr & 24-hour live-in arrangements',
      'Matched to specific diagnosis & recovery requirements',
      'Compassionate, patient-first approach to daily care',
      'Background-verified with prior patient care experience',
      'Regular communication with family throughout placement',
    ];

    final facts = [
      {
        'title': 'What is this service?',
        'desc':
            'Trusted Maid connects you with professional, background-verified patient cares in Mumbai tailored to your specific household needs.',
      },
      {
        'title': 'Areas Served:',
        'desc':
            'We provide patient care services across all major localities in Mumbai, Thane, and Navi Mumbai.',
      },
      {
        'title': 'Core Duties:',
        'desc':
            'Recovery is faster and more comfortable at home. Trusted Maid provides trained, compassionate patient care attendants who assist with mobility, personal hygiene, medication schedules, nutrition, and emotional support — giving your loved one the attentive, dignified care they deserve without requiring hospitalization.',
      },
      {
        'title': 'Placement Speed:',
        'desc':
            'Families are typically matched with a shortlisted patient care within 24 to 48 hours.',
      },
      {
        'title': 'Strict Verification:',
        'desc':
            '100% of our patient cares undergo rigorous identity (Aadhaar), address, and police background checks before placement.',
      },
      {
        'title': 'Our Guarantee:',
        'desc':
            'We offer a seamless free replacement policy if the provided patient care is not the perfect fit for your family.',
      },
    ];

    final tasks = [
      {
        'title': 'Mobility & Transfer Assistance',
        'desc':
            'Safe assistance with moving from bed to chair, walking, using the toilet, and performing physiotherapy exercises.',
      },
      {
        'title': 'Personal Hygiene Care',
        'desc':
            'Assistance with bathing, grooming, oral care, dressing, and all personal hygiene tasks with dignity and respect.',
      },
      {
        'title': 'Medication Management',
        'desc':
            'Ensuring medications are taken on time, in the correct dose, and monitoring for side effects to report to the family.',
      },
      {
        'title': 'Nutritional Support',
        'desc':
            'Preparing and serving appropriate meals and ensuring adequate hydration throughout the day for faster recovery.',
      },
      {
        'title': 'Vital Sign Monitoring',
        'desc':
            'Basic monitoring of temperature, pulse, and general condition with prompt reporting of any concerns to the family.',
      },
      {
        'title': 'Companionship & Emotional Support',
        'desc':
            'Providing warm, consistent human presence that reduces isolation and supports the patient\'s mental wellbeing during recovery.',
      },
    ];

    final steps = [
      {
        'step': 'Step 01',
        'title': 'Share Patient Details',
        'desc':
            'Tell us about the diagnosis, current medical situation, daily routine, and specific care needs.',
      },
      {
        'step': 'Step 02',
        'title': 'Matched Attendant',
        'desc':
            'We identify an attendant with relevant experience in your loved one\'s specific condition or recovery type.',
      },
      {
        'step': 'Step 03',
        'title': 'Introduction & Briefing',
        'desc':
            'The attendant meets the patient and family, understands the care plan, and begins placement.',
      },
      {
        'step': 'Step 04',
        'title': 'Ongoing Support',
        'desc':
            'We stay in contact throughout the placement to ensure care quality and address any concerns promptly.',
      },
    ];

    final faqs = [
      {
        'q': 'Do your attendants perform medical tasks (e.g. injections)?',
        'a':
            'Our attendants are non-medical caregivers. They assist with daily living, monitoring vitals, hygiene, and medications, but do not administer injections, IV lines, or wound dressing.',
      },
      {
        'q': 'How do you verify the background of patient care attendants?',
        'a':
            'Each attendant undergoes identity checks (Aadhaar), address verification, reference check from previous placements, and police background check.',
      },
      {
        'q': 'Can I hire an attendant for 24-hour live-in care?',
        'a':
            'Yes. We offer 12-hour day shifts, 12-hour night shifts, and 24-hour live-in care where attendants stay at your home.',
      },
      {
        'q': 'What if the attendant is not a good fit for my family member?',
        'a':
            'Compatibility and trust are essential. If you feel the caregiver is not the right fit, we coordinate a replacement at no extra charge.',
      },
      {
        'q': 'Do they help with household work?',
        'a':
            'No. Patient care attendants focus exclusively on patient needs, hygiene, vitals, patient meals, and patient area cleanliness.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Detailed Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Professional Patient Care Attendant Services in Mumbai',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Recovery is faster and more comfortable at home. Trusted Maid provides trained, compassionate patient care attendants who assist with mobility, personal hygiene, medication schedules, nutrition, and emotional support — giving your loved one the attentive, dignified care they deserve without requiring hospitalization.',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              if (_showFullDesc) ...[
                const SizedBox(height: 12),
                Text(
                  'When a family member is recovering from surgery, managing a serious illness, or dealing with reduced mobility, the daily demands of care can quickly exceed what family members can safely provide alone. Our patient care attendants are trained to fill this gap with professional skill and genuine compassion. They bring structure to the patient’s day, ensure medication and nutrition schedules are followed, assist with safe mobility and personal hygiene, and provide the consistent human presence that supports both physical recovery and emotional wellbeing. Every attendant is background-verified and matched specifically to your loved one’s medical condition and care requirements.',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showFullDesc = !_showFullDesc;
                  });
                },
                child: Text(
                  _showFullDesc ? 'Show Less' : '...more',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Features Grid
        _buildFeaturesGrid(features),

        // 3. Quick Facts
        _buildQuickFactsCard(
          'Quick Facts About Our Patient Care Service',
          facts,
          isTwoColumn: true,
        ),

        // 4. Task Breakdown
        _buildTaskBreakdown(
          "What's Included in Our Patient Care Service",
          tasks,
          subtitle:
              'A complete breakdown of everything our verified patient care professionals handle for your household.',
          isThreeColumn: true,
        ),

        // 5. How Placement Works
        _buildPlacementWorks(
          'How Our Patient Care Placement Works',
          'Simple, transparent steps from your first enquiry to a reliable professional at your door.',
          steps,
          isHorizontal: true,
        ),

        // 6. FAQs
        _buildFAQAccordion(faqs),

        const SizedBox(height: 18),
      ],
    );
  }

  Widget _buildJapaMaidDetailedView(
    BuildContext context,
    Map<String, dynamic> service,
  ) {
    final features = [
      'Traditional postpartum cooking for healing & lactation',
      'Daily newborn bath, oil massage & cord care',
      'Breastfeeding support & feeding schedule management',
      'Night care for baby so the mother can sleep',
      'Background-verified with postpartum care experience',
      'Available from day 1 after delivery — plan in advance',
    ];

    final facts = [
      {
        'title': 'What is this service?',
        'desc':
            'Trusted Maid connects you with professional, background-verified japa maids in Mumbai tailored to your specific household needs.',
      },
      {
        'title': 'Areas Served:',
        'desc':
            'We provide japa maid services across all major localities in Mumbai, Thane, and Navi Mumbai.',
      },
      {
        'title': 'Core Duties:',
        'desc':
            'The weeks after delivery are the most demanding of a new mother’s life. Trusted Maid’s experienced Japa Maids take complete care of both mother and newborn — managing traditional postpartum cooking, daily baby massage and bath, feeding support, night care, and household management so the new mother can focus entirely on rest and recovery.',
      },
      {
        'title': 'Placement Speed:',
        'desc':
            'Families are typically matched with a shortlisted japa maid within 24 to 48 hours.',
      },
      {
        'title': 'Strict Verification:',
        'desc':
            '100% of our japa maids undergo rigorous identity (Aadhaar), address, and police background checks before placement.',
      },
      {
        'title': 'Our Guarantee:',
        'desc':
            'We offer a seamless free replacement policy if the provided japa maid is not the perfect fit for your family.',
      },
    ];

    final tasks = [
      {
        'title': 'Traditional Postpartum Cooking',
        'desc':
            'Preparation of healing postpartum foods including ajwain rotis, methi laddoos, panjiri, and ghee-rich dal to aid recovery and support milk production.',
      },
      {
        'title': 'Newborn Bath & Massage',
        'desc':
            'Daily oil massage and safe bathing of the newborn using traditional techniques that support healthy skin, muscle tone, and sleep.',
      },
      {
        'title': 'Breastfeeding Support',
        'desc':
            'Practical assistance with positioning, latch, and feeding schedules during the challenging early days of breastfeeding.',
      },
      {
        'title': 'Night Care & Baby Settling',
        'desc':
            'Managing night feeds, nappy changes, and baby settling to allow the mother to sleep in extended, restorative stretches.',
      },
      {
        'title': 'Mother’s Personal Care',
        'desc':
            'Assistance with the mother’s bathing, postnatal exercises as recommended, and ensuring she eats and rests adequately.',
      },
      {
        'title': 'Household Management',
        'desc':
            'Handling the basic household routine so the family can focus entirely on the mother and newborn during the recovery period.',
      },
    ];

    final steps = [
      {
        'step': 'Step 01',
        'title': 'Plan Before Delivery',
        'desc':
            'Contact us 4–6 weeks before your due date to discuss requirements and confirm the placement in advance.',
      },
      {
        'step': 'Step 02',
        'title': 'Japa Maid Matching',
        'desc':
            'We match you with an experienced Japa Maid based on your delivery type, preferences, and location.',
      },
      {
        'step': 'Step 03',
        'title': 'Pre-Delivery Introduction',
        'desc':
            'Meet the Japa Maid before your due date so everything is set and familiar from the moment you come home.',
      },
      {
        'step': 'Step 04',
        'title': 'Extended Support',
        'desc':
            'The Japa Maid remains available to extend the contract if needed as your recovery continues.',
      },
    ];

    final faqs = [
      {
        'q': 'What is a Japa Maid and what do they do?',
        'a':
            'A Japa Maid is a trained postnatal caregiver who provides newborn care (bathing, massage, feeding support) and helps the mother with recovery, diet, and rest during the postpartum period.',
      },
      {
        'q': 'How soon after delivery can I hire a Japa Maid?',
        'a':
            'Ideally, book before delivery. We can arrange placement from the day of hospital discharge so care begins immediately.',
      },
      {
        'q': 'How long does a Japa Maid typically stay?',
        'a':
            'The standard Japa Maid period is 40 days (chatti), but duration can be extended based on the mother\'s recovery needs.',
      },
      {
        'q': 'Does the Japa Maid provide night duty care for the newborn?',
        'a':
            'Yes, many of our Japa Maids provide round-the-clock care, handling night feeds, newborn settling, and letting the mother rest.',
      },
      {
        'q': 'Which areas in Mumbai do you provide Japa Maid services?',
        'a':
            'We provide Japa Maid services in Andheri, Bandra, Thane, Navi Mumbai, and nearby localities.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Detailed Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trusted Japa Maid Services in Mumbai',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'The weeks after delivery are the most demanding of a new mother’s life. Trusted Maid’s experienced Japa Maids take complete care of both mother and newborn — managing traditional postpartum cooking, daily baby massage and bath, feeding support, night care, and household management so the new mother can focus entirely on rest and recovery.',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              if (_showFullDesc) ...[
                const SizedBox(height: 12),
                Text(
                  'In Indian tradition, the postpartum period has always been treated as a time of complete rest and recovery for the new mother, supported by experienced women who handle everything else. Today, with nuclear families and extended family unavailable, a professional Japa Maid fills this essential role. Our Japa Maids bring years of experience in postpartum mother care and newborn handling. They prepare the specific traditional foods that support healing and milk production, manage the baby’s daily bath and oil massage, assist with breastfeeding positioning, handle night feeds when the mother needs extended rest, and keep the household running smoothly throughout the recovery period.',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showFullDesc = !_showFullDesc;
                  });
                },
                child: Text(
                  _showFullDesc ? 'Show Less' : '...more',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Features Grid
        _buildFeaturesGrid(features),

        // 3. Quick Facts
        _buildQuickFactsCard(
          'Quick Facts About Our Japa Maid Service',
          facts,
          isTwoColumn: true,
        ),

        // 4. Task Breakdown
        _buildTaskBreakdown(
          "What's Included in Our Japa Maid Service",
          tasks,
          subtitle:
              'A complete breakdown of postpartum care services provided for mother and newborn baby.',
          isThreeColumn: true,
        ),

        // 5. How Placement Works
        _buildPlacementWorks(
          'How Our Japa Maid Placement Works',
          'Simple, planned steps to ensure you have trusted care right when your baby arrives.',
          steps,
          isHorizontal: true,
        ),

        // 6. FAQs
        _buildFAQAccordion(faqs),

        const SizedBox(height: 18),
      ],
    );
  }

  Widget _buildElderlyCareDetailedView(
    BuildContext context,
    Map<String, dynamic> service,
  ) {
    final features = [
      'Trained in fall prevention, mobility & personal care',
      'Manages complex medication schedules accurately',
      'Nutritious meal preparation for senior dietary needs',
      'Warm companionship that reduces loneliness & isolation',
      'Available for part-time, full-day & 24-hour live-in care',
      'Background-verified with elder-specific care experience',
    ];

    final facts = [
      {
        'title': 'What is this service?',
        'desc':
            'Trusted Maid connects you with professional, background-verified elderly cares in Mumbai tailored to your specific household needs.',
      },
      {
        'title': 'Areas Served:',
        'desc':
            'We provide elderly care services across all major localities in Mumbai, Thane, and Navi Mumbai.',
      },
      {
        'title': 'Core Duties:',
        'desc':
            'Your aging parents deserve the best care in the comfort of their own home. Trusted Maid provides trained, compassionate elder care professionals who assist seniors with daily activities, mobility, medication management, nutrition, and companionship — ensuring your loved one’s dignity, safety, and quality of life every single day.',
      },
      {
        'title': 'Placement Speed:',
        'desc':
            'Families are typically matched with a shortlisted elderly care within 24 to 48 hours.',
      },
      {
        'title': 'Strict Verification:',
        'desc':
            '100% of our elderly cares undergo rigorous identity (Aadhaar), address, and police background checks before placement.',
      },
      {
        'title': 'Our Guarantee:',
        'desc':
            'We offer a seamless free replacement policy if the provided elderly care is not the perfect fit for your family.',
      },
    ];

    final tasks = [
      {
        'title': 'Daily Personal Care',
        'desc':
            'Assistance with bathing, grooming, dressing, and all personal hygiene tasks with full respect for the senior’s dignity.',
      },
      {
        'title': 'Mobility & Fall Prevention',
        'desc':
            'Safe assistance with walking, transfers, using stairs, and all movements that carry fall risk in the home.',
      },
      {
        'title': 'Medication Management',
        'desc':
            'Precise management of daily medication schedules, monitoring for side effects, and prompt reporting to the family.',
      },
      {
        'title': 'Nutritional Meal Preparation',
        'desc':
            'Preparing meals suited to the senior’s dietary requirements, appetite, and any medical restrictions they follow.',
      },
      {
        'title': 'Companionship & Mental Engagement',
        'desc':
            'Conversation, shared activities, and genuine presence that combats loneliness and supports cognitive wellbeing.',
      },
      {
        'title': 'Doctor Visit Accompaniment',
        'desc':
            'Accompanying the senior to medical appointments, maintaining a record of health updates, and communicating with the family.',
      },
    ];

    final steps = [
      {
        'step': 'Step 01',
        'title': 'Assess Care Needs',
        'desc':
            'Tell us about your parent’s health condition, daily routine, mobility level, and the type of care required.',
      },
      {
        'step': 'Step 02',
        'title': 'Caregiver Matching',
        'desc':
            'We identify an experienced elder care professional whose skills and personality match your parent’s needs.',
      },
      {
        'step': 'Step 03',
        'title': 'Introduction at Home',
        'desc':
            'The caregiver meets your parent at home, builds rapport, and establishes a comfortable daily routine.',
      },
      {
        'step': 'Step 04',
        'title': 'Continuous Family Updates',
        'desc':
            'We maintain regular communication with the family and support the placement throughout its duration.',
      },
    ];

    final faqs = [
      {
        'q': 'Do your caregivers perform medical tasks?',
        'a':
            'Our caregivers assist with daily living, mobility, medication reminders, and general monitoring, but they are not certified nurses and do not perform medical procedures.',
      },
      {
        'q': 'What is your replacement policy?',
        'a':
            'If you or your parents feel the caregiver is not the right fit, we coordinate a replacement at no extra charge.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Detailed Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Professional Elderly Care Services in Mumbai',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your aging parents deserve the best care in the comfort of their own home. Trusted Maid provides trained, compassionate elder care professionals who assist seniors with daily activities, mobility, medication management, nutrition, and companionship — ensuring your loved one’s dignity, safety, and quality of life every single day.',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              if (_showFullDesc) ...[
                const SizedBox(height: 12),
                Text(
                  'As parents age, their daily care needs grow beyond what working family members can consistently provide without risk of burnout or safety compromises. Our elder care professionals are specifically trained for the physical and emotional demands of senior care — they understand fall prevention, safe mobility assistance, the complexity of managing multiple medications, and most importantly, how to build the kind of warm, trusting relationship that makes a real difference to an older person’s daily life. Whether your parent needs a few hours of support each day or full-time live-in care, we match them with someone who is not only skilled but genuinely good company.',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showFullDesc = !_showFullDesc;
                  });
                },
                child: Text(
                  _showFullDesc ? 'Show Less' : '...more',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Features Grid
        _buildFeaturesGrid(features),

        // 3. Quick Facts
        _buildQuickFactsCard(
          'Quick Facts About Our Elderly Care Service',
          facts,
          isTwoColumn: true,
        ),

        // 4. Task Breakdown
        _buildTaskBreakdown(
          "What's Included in Our Elderly Care Service",
          tasks,
          subtitle:
              'A complete breakdown of activities and support provided for your aging parents.',
          isThreeColumn: true,
        ),

        // 5. How Placement Works
        _buildPlacementWorks(
          'How Our Elderly Care Placement Works',
          'Simple, transparent steps to connect your parents with a compassionate caregiver.',
          steps,
          isHorizontal: true,
        ),

        // 6. FAQs
        _buildFAQAccordion(faqs),

        const SizedBox(height: 18),
      ],
    );
  }

  Widget _buildNannyDetailedView(
    BuildContext context,
    Map<String, dynamic> service,
  ) {
    final features = [
      'Trained in child development & age-appropriate care',
      'Consistent daily routines for security & better behavior',
      'Educational play, reading & early learning activities',
      'Safe infant handling & first aid awareness',
      'Background-verified with child-specific references',
      'Available as live-in, full-day & part-time nanny',
    ];

    final facts = [
      {
        'title': 'What is this service?',
        'desc':
            'Trusted Maid connects you with professional, background-verified nannys in Mumbai tailored to your specific household needs.',
      },
      {
        'title': 'Areas Served:',
        'desc':
            'We provide nanny services across all major localities in Mumbai, Thane, and Navi Mumbai.',
      },
      {
        'title': 'Core Duties:',
        'desc':
            'Give your child the best start in life with a professional, verified nanny from Trusted Maid. Our nannies go beyond basic childcare — they bring structure, stimulation, and genuine warmth to your child’s day, supporting developmental milestones and creating the kind of safe, nurturing environment that shapes confident, happy children.',
      },
      {
        'title': 'Placement Speed:',
        'desc':
            'Families are typically matched with a shortlisted nanny within 24 to 48 hours.',
      },
      {
        'title': 'Strict Verification:',
        'desc':
            '100% of our nannys undergo rigorous identity (Aadhaar), address, and police background checks before placement.',
      },
      {
        'title': 'Our Guarantee:',
        'desc':
            'We offer a seamless free replacement policy if the provided nanny is not the perfect fit for your family.',
      },
    ];

    final tasks = [
      {
        'title': 'Infant & Baby Care',
        'desc':
            'Expert care for babies including feeding routines, safe sleep practices, daily hygiene, and responsive, attentive nurturing.',
      },
      {
        'title': 'Toddler Development Activities',
        'desc':
            'Age-appropriate games, creative play, reading, and sensory activities that actively support developmental milestones.',
      },
      {
        'title': 'School-Age Child Support',
        'desc':
            'Homework assistance, school pick-up and drop, after-school routines, and educational activities for older children.',
      },
      {
        'title': 'Daily Routine Management',
        'desc':
            'Establishing and maintaining predictable schedules for meals, naps, play, and bedtime that children thrive on.',
      },
      {
        'title': 'Nutrition & Meal Preparation',
        'desc':
            'Preparing and serving healthy, age-appropriate meals and snacks throughout the day based on the child\'s needs.',
      },
      {
        'title': 'Outdoor & Social Activities',
        'desc':
            'Safe outdoor play, park visits, and age-appropriate social activities that support physical development and confidence.',
      },
    ];

    final steps = [
      {
        'step': 'Step 01',
        'title': 'Share Child Details',
        'desc':
            'Tell us your child’s age, current routine, specific needs, and what qualities you are looking for in a nanny.',
      },
      {
        'step': 'Step 02',
        'title': 'Nanny Shortlisting',
        'desc':
            'We identify nannies with the right age-group experience, temperament, and availability in your area.',
      },
      {
        'step': 'Step 03',
        'title': 'Home Interview & Trial',
        'desc':
            'Meet shortlisted nannies at home, observe their interaction with your child, and conduct a short trial period.',
      },
      {
        'step': 'Step 04',
        'title': 'Long-Term Placement',
        'desc':
            'We focus on making durable matches and remain available throughout the placement for support and adjustments.',
      },
    ];

    final faqs = [
      {
        'q':
            'What is the difference between a nanny and a baby sitter from Trusted Maid?',
        'a':
            'A nanny provides structured, long-term child development-focused care (often full-time), while a baby sitter provides flexible short-term supervision.',
      },
      {
        'q': 'Do your nannies help with school pick-up and drop?',
        'a':
            'Yes, many of our nannies assist with school commute, homework supervision, and after-school routines as part of their daily schedule.',
      },
      {
        'q': 'Are your nannies trained in child development?',
        'a':
            'Yes, our nannies are experienced in age-appropriate learning activities, early education support, and structured daily routines that help children thrive.',
      },
      {
        'q': 'Can a nanny also prepare light meals for my child?',
        'a':
            'Yes, our nannies can prepare nutritious, child-friendly meals and snacks as part of their daily care routine.',
      },
      {
        'q': 'Which areas in Mumbai do you place nannies?',
        'a':
            'We place nannies in Bandra, Juhu, Powai, Vile Parle, and nearby localities in Mumbai.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Detailed Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Professional Nanny Services in Mumbai',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Give your child the best start in life with a professional, verified nanny from Trusted Maid. Our nannies go beyond basic childcare — they bring structure, stimulation, and genuine warmth to your child’s day, supporting developmental milestones and creating the kind of safe, nurturing environment that shapes confident, happy children.',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              if (_showFullDesc) ...[
                const SizedBox(height: 12),
                Text(
                  'A nanny is one of the most important people in your young child’s life. She is present during the hours that matter most — the hours when you are at work and your child is learning, growing, and forming their earliest understanding of the world. Our nannies are carefully selected for their genuine experience with children, their warmth and patience, and their understanding of child development. They are not simply babysitters — they are trained caregivers who maintain consistent routines, engage children in educational activities, and build the kind of secure, trusting relationship that supports your child’s emotional and cognitive development throughout their early years.',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showFullDesc = !_showFullDesc;
                  });
                },
                child: Text(
                  _showFullDesc ? 'Show Less' : '...more',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Features Grid
        _buildFeaturesGrid(features),

        // 3. Quick Facts
        _buildQuickFactsCard(
          'Quick Facts About Our Nanny Service',
          facts,
          isTwoColumn: true,
        ),

        // 4. Task Breakdown
        _buildTaskBreakdown(
          "What's Included in Our Nanny Service",
          tasks,
          subtitle:
              'A complete breakdown of activities and support provided for your child.',
          isThreeColumn: true,
        ),

        // 5. How Placement Works
        _buildPlacementWorks(
          'How Our Nanny Placement Works',
          'Simple, transparent steps to connect your child with a professional nanny.',
          steps,
          isHorizontal: true,
        ),

        // 6. FAQs
        _buildFAQAccordion(faqs),

        const SizedBox(height: 18),
      ],
    );
  }
}
