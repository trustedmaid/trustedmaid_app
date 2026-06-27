import 'package:flutter/material.dart';

import '../../../../resources/app_colors.dart';
import '../../../maid_services/presentation/screens/maid_service_detail_screen.dart';
import '../../../maid_services/presentation/screens/maid_services_screen.dart';

/// App dashboard displaying location checks, service categories, and verified pros.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _openFAQIndex = -1;
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final show = _scrollController.offset > 300;
      if (show != _showScrollToTop) {
        setState(() {
          _showScrollToTop = show;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Statically mapped core services to align with screenshots and details indices
  final List<Map<String, dynamic>> _services = [
    {
      'emoji': '🧹',
      'title': 'House Maid',
      'desc':
          'Daily sweeping, mopping, utensil cleaning, laundry & home organization',
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
      'desc':
          'Experienced home cooks who prepare hygienic, delicious meals to your taste.',
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
      'desc':
          'Vital medicine scheduling, mobility assistance & hospital recovery support',
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
      'desc':
          'Daily living physical support & warm senior citizen companionship',
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

  final List<Map<String, String>> _problemSolutionPairs = [
    {
      'problem': 'Maid stopped coming without notice',
      'solution':
          'Immediate replacement guaranteed — your home is never left without help.',
    },
    {
      'problem': "Hired through a neighbour, can't verify background",
      'solution':
          'Every professional is identity-verified and reference-checked before placement.',
    },
    {
      'problem': 'Spent hours on WhatsApp groups with no results',
      'solution':
          'Share your requirements once — we do all the searching and shortlisting.',
    },
    {
      'problem': 'Maid works well for 2 weeks then standards drop',
      'solution':
          'We set clear expectations upfront and support the placement throughout.',
    },
    {
      'problem': 'Worried about safety with an unknown person at home',
      'solution':
          'Full background check including address proof and prior employer references.',
    },
    {
      'problem': 'Previous agency took advance money and disappeared',
      'solution':
          'Registered company, transparent process — you pay only after you\'re satisfied.',
    },
  ];

  final List<Map<String, String>> _comparisonData = [
    {
      'other': 'Charge advance payment before showing candidates',
      'trusted': 'Pay only after you meet & approve the professional',
    },
    {
      'other': 'Most are unregistered with no accountability',
      'trusted': 'Registered company — fully transparent & traceable',
    },
    {
      'other': 'Disappear after placement — no follow-up support',
      'trusted': 'Dedicated support team available throughout your service',
    },
    {
      'other': 'Limited pool of 20–30 unverified profiles',
      'trusted': '2,000+ background-verified professionals in Mumbai',
    },
    {
      'other': 'Place the same maid with multiple clients',
      'trusted': 'Ethical, exclusive placements for every client',
    },
    {
      'other': 'Background check is only claimed, never done',
      'trusted': 'Document & identity verification for every professional',
    },
    {
      'other': 'Single-person operations with no backup',
      'trusted': 'Professional team always ready to assist you',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Premium Mobile Header Area
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF070B19), // Extra Deep Navy
                        Color(0xFF0F172A), // Deep Slate Navy
                        Color(0xFF1E3A8A), // Rich Royal Blue
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                    child: Stack(
                      children: [
                        // Glowing background visual elements for premium aesthetic
                        Positioned(
                          right: -80,
                          top: -80,
                          child: Container(
                            width: 240,
                            height: 240,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // ignore: deprecated_member_use
                              color: const Color(0xFF2563EB).withOpacity(0.18),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -50,
                          bottom: -50,
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // ignore: deprecated_member_use
                              color: const Color(0xFF60A5FA).withOpacity(0.10),
                            ),
                          ),
                        ),

                        // Content Padding
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 50, 20, 36),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Sparkle Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: Colors.white.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(30),
                                  // ignore: deprecated_member_use
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/icons/sec-title-shape-1-1.png',
                                      height: 10,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'RELIABLE DOMESTIC HELP AT YOUR DOORSTEP',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8.5,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),

                              // Website Inspired Headline
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    height: 1.25,
                                  ),
                                  children: [
                                    TextSpan(text: 'Verified '),
                                    TextSpan(
                                      text: 'Maid Services',
                                      style: TextStyle(
                                        color: Color(0xFF60A5FA),
                                      ),
                                    ),
                                    TextSpan(text: ' in Mumbai'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Website Subtitle
                              const Text(
                                'Background-verified maids, cooks, nannies & caregivers — placed within 24–48 hours.',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  height: 1.45,
                                ),
                              ),
                              const SizedBox(height: 18),

                              // Trust Badges Row (Inspired by stars & stats on website)
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildHeroTrustBadge(
                                      Icons.star_rounded,
                                      const Color(0xFFFBBF24),
                                      '4.6/5 Rated',
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _buildHeroTrustBadge(
                                      Icons.people_alt_rounded,
                                      const Color(0xFF34D399),
                                      '1.1k Placed',
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _buildHeroTrustBadge(
                                      Icons.verified_user_rounded,
                                      const Color(0xFF60A5FA),
                                      '100% Verified',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Overlapping Search Bar
            Transform.translate(
              offset: const Offset(0, -18),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const Scaffold(body: MaidServicesScreen()),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: AppColors.darkTextSecondary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Search maid, cook, nanny, caregiver...',
                            style: TextStyle(
                              color: AppColors.darkTextSecondary.withOpacity(
                                0.7,
                              ),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [AppColors.primary, AppColors.secondary],
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Booking urgent banner
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Scaffold(body: MaidServicesScreen()),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(8, 0, 18, 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF1E3A8A), // Royal Blue
                      Color(0xFF0F172A), // Dark Slate Navy
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.amber.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.bolt_rounded,
                        color: Colors.amber,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Need help urgently?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Get matched with a verified pro in 24–48 hrs',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF0F172A),
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Services Grid Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Our Services',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const Scaffold(body: MaidServicesScreen()),
                        ),
                      );
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Services Wrap (Responsive Cover Image Layout)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final columns = width > 1100 ? 4 : (width > 700 ? 3 : 2);
                  final spacing = 12.0;
                  final itemWidth =
                      (width - (spacing * (columns - 1))) / columns;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: List.generate(_services.length, (index) {
                      final item = _services[index];

                      return SizedBox(
                        width: itemWidth,
                        child: GestureDetector(
                          onTap: () {
                            final navigator = Navigator.of(context);
                            // Smooth navigation delay to show selection highlight
                            Future.delayed(
                              const Duration(milliseconds: 150),
                              () {
                                navigator.push(
                                  MaterialPageRoute(
                                    builder: (_) => MaidServiceDetailScreen(
                                      serviceIndex: item['index'] as int,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: AppColors.line,
                                width: 1.0,
                              ),
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
                                // Top cover image
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(23),
                                    topRight: Radius.circular(23),
                                  ),
                                  child: Image.asset(
                                    item['image'] as String,
                                    height: itemWidth * 0.65,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Content body
                                Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title'] as String,
                                        style: const TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      // Description
                                      Text(
                                        item['desc'] as String,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.darkTextSecondary,
                                          height: 1.35,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
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
            const SizedBox(height: 20),

            // Problem/Solution section
            Container(
              width: double.infinity,
              color: const Color(
                0xFF101729,
              ), // Ink background matching screenshots
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Sub-header Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // ignore: deprecated_member_use
                      border: Border.all(color: Colors.white.withOpacity(0.12)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/sec-title-shape-1-1.png',
                          height: 12,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'RELIABLE DOMESTIC HELP AT YOUR DOORSTEP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Finding reliable domestic help in Mumbai',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const Text(
                    "shouldn't be this hard.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF3B82F6), // Bright neon/sky blue accent
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "If any of these sound familiar, you're in the right place. Trusted Maid was built specifically to solve every one of these problems.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final columns = width > 900 ? 3 : (width > 600 ? 2 : 1);
                      final spacing = 16.0;
                      final itemWidth =
                          (width - (spacing * (columns - 1))) / columns;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: List.generate(_problemSolutionPairs.length, (
                          index,
                        ) {
                          final pair = _problemSolutionPairs[index];
                          return SizedBox(
                            width: itemWidth,
                            child: _buildComparisonCard(
                              pair['problem']!,
                              pair['solution']!,
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Get help in 3 easy steps section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Sub-header Pill
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/sec-title-shape-1-1.png',
                        height: 12,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'SIMPLE PROCESS',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Title
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: 'Get help in '),
                        TextSpan(
                          text: '3 easy steps',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Responsive Steps Grid/Stack
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final columns = width > 750 ? 3 : 1;
                      final spacing = 16.0;

                      final steps = [
                        {
                          'step': 'Step 01',
                          'icon': Icons.group_outlined,
                          'title': 'Share Your Requirement',
                          'desc':
                              'Tell us what kind of help you need and your preferred schedule.',
                        },
                        {
                          'step': 'Step 02',
                          'icon': Icons.shield_outlined,
                          'title': 'We Match & Verify',
                          'desc':
                              'We shortlist background-verified professionals suited to your needs.',
                        },
                        {
                          'step': 'Step 03',
                          'icon': Icons.check_circle_outline_rounded,
                          'title': 'Start Your Service',
                          'desc':
                              'Meet your matched professional and begin with full confidence.',
                        },
                      ];

                      if (columns == 3) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(steps.length, (idx) {
                            final s = steps[idx];
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: idx == steps.length - 1 ? 0 : spacing,
                                ),
                                child: _buildStepCard(
                                  s['step'] as String,
                                  s['icon'] as IconData,
                                  s['title'] as String,
                                  s['desc'] as String,
                                ),
                              ),
                            );
                          }),
                        );
                      } else {
                        return Column(
                          children: steps.map((s) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: _buildStepCard(
                                s['step'] as String,
                                s['icon'] as IconData,
                                s['title'] as String,
                                s['desc'] as String,
                              ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Comparison Table Section
            Container(
              width: double.infinity,
              color: const Color(0xFF0F172A), // Very dark slate
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Why ',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: 'Trusted',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: 'Maid',
                          style: TextStyle(color: Color(0xFFF97316)),
                        ),
                        TextSpan(
                          text: ' is different from other agencies',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Table Container
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF2E3B4E),
                        width: 1,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        // Header Row
                        _buildComparisonRow(
                          'OTHER MAID AGENCIES',
                          '✓ TRUSTED MAID',
                          isHeader: true,
                        ),
                        // Data Rows
                        ...List.generate(_comparisonData.length, (idx) {
                          final item = _comparisonData[idx];
                          return _buildComparisonRow(
                            item['other']!,
                            item['trusted']!,
                            isLast: idx == _comparisonData.length - 1,
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Row with Sparkles icon
                  const Row(
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.amber, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Quick Facts About Trusted Maid',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Two columns using LayoutBuilder and Row/Column
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      if (width > 750) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFactBlock(
                                    'What is Trusted Maid?',
                                    "Trusted Maid is Mumbai's leading **maid agency**, operating as a premium **home maid service** and **house maid service** provider. We connect families with background-verified **domestic help services** and **house help services**, offering **insta help** for modern households.",
                                  ),
                                  _buildFactBlock(
                                    'Core Services:',
                                    "We specialize in placing verified **house maid services**, **home maid services**, cooks, babysitters, nannies, and specialized **japa maid** postnatal care professionals. We also provide **kitchen cleaning services**.",
                                  ),
                                  _buildFactBlock(
                                    'Maid Cleaning & Placements:',
                                    "Whether you require a **house maid** for general chores, **full time maid services**, a **daily maid service**, or want to book a verified **maid online**, we match you with a trusted **maid for home** or **insta help maid**. We are also launching our upcoming **maid services app** to make hiring even easier.",
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFactBlock(
                                    'Areas Served:',
                                    "If you are searching for the best **house maid services near me**, **home maid services near me**, or general **house cleaning services**, we serve all major localities across Mumbai, Thane, and Navi Mumbai.",
                                  ),
                                  _buildFactBlock(
                                    'Insta Maid Quick Matches:',
                                    "With our fast **insta maid** placement model, families are matched with a background-verified professional within **24 to 48 hours**.",
                                  ),
                                  _buildFactBlock(
                                    'Our Cleaning Guarantee:',
                                    "We cover all **maid services for home** and **maid service for home** with **professional maid services**. If you need **cleaning services near me**, **cleaning maid services near me**, **cleaning maid services**, **maid cleaning services**, **maid services for home near me**, or **maid cleaning services near me**, we guarantee high-quality work with a free replacement policy.",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        // Stacked layout for mobile screens
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFactBlock(
                              'What is Trusted Maid?',
                              "Trusted Maid is Mumbai's leading **maid agency**, operating as a premium **home maid service** and **house maid service** provider. We connect families with background-verified **domestic help services** and **house help services**, offering **insta help** for modern households.",
                            ),
                            _buildFactBlock(
                              'Core Services:',
                              "We specialize in placing verified **house maid services**, **home maid services**, cooks, babysitters, nannies, and specialized **japa maid** postnatal care professionals. We also provide **kitchen cleaning services**.",
                            ),
                            _buildFactBlock(
                              'Maid Cleaning & Placements:',
                              "Whether you require a **house maid** for general chores, **full time maid services**, a **daily maid service**, or want to book a verified **maid online**, we match you with a trusted **maid for home** or **insta help maid**. We are also launching our upcoming **maid services app** to make hiring even easier.",
                            ),
                            _buildFactBlock(
                              'Areas Served:',
                              "If you are searching for the best **house maid services near me**, **home maid services near me**, or general **house cleaning services**, we serve all major localities across Mumbai, Thane, and Navi Mumbai.",
                            ),
                            _buildFactBlock(
                              'Insta Maid Quick Matches:',
                              "With our fast **insta maid** placement model, families are matched with a background-verified professional within **24 to 48 hours**.",
                            ),
                            _buildFactBlock(
                              'Our Cleaning Guarantee:',
                              "We cover all **maid services for home** and **maid service for home** with **professional maid services**. If you need **cleaning services near me**, **cleaning maid services near me**, **cleaning maid services**, **maid cleaning services**, **maid services for home near me**, or **maid cleaning services near me**, we guarantee high-quality work with a free replacement policy.",
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

            // Why Choose Trusted Maid Section (Upgraded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Sub-header Pill
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/sec-title-shape-1-1.png',
                        height: 12,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'WHY CHOOSE TRUSTED MAID',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/icons/sec-title-shape-1-1.png',
                        height: 12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Title
                  const Text(
                    'Why families across Mumbai trust us',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 28),
                  // 6 Trust Cards
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final columns = width > 900 ? 3 : (width > 600 ? 2 : 1);
                      final spacing = 16.0;
                      final itemWidth =
                          (width - (spacing * (columns - 1))) / columns;

                      final trustCards = [
                        {
                          'icon': Icons.shield_outlined,
                          'title': 'Quick & Hassle-Free',
                          'desc':
                              'No waiting around. We shortlist verified candidates fast so you can get help when you actually need it.',
                        },
                        {
                          'icon': Icons.check_circle_outline_rounded,
                          'title': '100% Background Verified',
                          'desc':
                              'Every professional is document and identity verified before being placed. Your safety is never compromised.',
                        },
                        {
                          'icon': Icons.people_alt_outlined,
                          'title': 'Multiple Service Options',
                          'desc':
                              'House maid, cook, nanny, japa maid, patient care, elderly care — we cover every home care need.',
                        },
                        {
                          'icon': Icons.star_outline_rounded,
                          'title': 'Skilled & Trained Staff',
                          'desc':
                              'Our professionals are assessed for skills, reliability, and conduct before being added to our network.',
                        },
                        {
                          'icon': Icons.chevron_right_rounded,
                          'title': 'Free Replacement',
                          'desc':
                              "If a professional leaves or doesn't work out, we replace within days — no questions, no extra charges.",
                        },
                        {
                          'icon': Icons.shield_outlined,
                          'title': 'Client-First Always',
                          'desc':
                              'We are not just another agency. From enquiry to placement and beyond, your satisfaction drives everything we do.',
                        },
                      ];

                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: List.generate(trustCards.length, (idx) {
                          final card = trustCards[idx];
                          return SizedBox(
                            width: itemWidth,
                            child: _buildTrustDetailCard(
                              card['icon'] as IconData,
                              card['title'] as String,
                              card['desc'] as String,
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Why Families Choose TrustedMaid for Their Homes Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Why Families Choose TrustedMaid for Their Homes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Perfect for busy working professionals, new mothers needing extra hands, or elderly couples needing daily assistance across Mumbai.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.darkTextSecondary,
                        fontSize: 12.5,
                        height: 1.45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final columns = width > 750 ? 3 : 1;
                      final spacing = 16.0;

                      final items = [
                        {
                          'icon': Icons.group_outlined,
                          'iconColor': const Color(0xFF2D59D6),
                          'title': 'Working Professionals',
                          'desc':
                              'Find reliable cooks and cleaners so you can focus on your career.',
                        },
                        {
                          'icon': Icons.star_outline_rounded,
                          'iconColor': const Color(0xFFF97316),
                          'title': 'New Parents',
                          'desc':
                              'Hire trusted nannies and Japa maids who understand infant care.',
                        },
                        {
                          'icon': Icons.location_on_outlined,
                          'iconColor': const Color(0xFF16A06A),
                          'title': 'Local Service Areas',
                          'desc':
                              'Serving Andheri, Bandra, Juhu, Powai, Thane, Navi Mumbai and more.',
                        },
                      ];

                      if (columns == 3) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(items.length, (idx) {
                            final it = items[idx];
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: idx == items.length - 1 ? 0 : spacing,
                                ),
                                child: _buildChooseCard(
                                  it['icon'] as IconData,
                                  it['iconColor'] as Color,
                                  it['title'] as String,
                                  it['desc'] as String,
                                ),
                              ),
                            );
                          }),
                        );
                      } else {
                        return Column(
                          children: items.map((it) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildChooseCard(
                                it['icon'] as IconData,
                                it['iconColor'] as Color,
                                it['title'] as String,
                                it['desc'] as String,
                              ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _buildHomeFAQSection(),
            const SizedBox(height: 32),

            // Quick Facts Section
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: _showScrollToTop
          ? Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: GestureDetector(
                onTap: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      // ignore: deprecated_member_use
                      color: AppColors.line.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_upward_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildHighlightedText(String text) {
    final List<TextSpan> spans = [];
    final RegExp regex = RegExp(r'\*\*(.*?)\*\*');
    int start = 0;

    for (final Match match in regex.allMatches(text)) {
      if (match.start > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, match.start),
            style: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 13,
              height: 1.45,
            ),
          ),
        );
      }
      spans.add(
        TextSpan(
          text: match.group(1),
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 13,
            height: 1.45,
          ),
        ),
      );
      start = match.end;
    }

    if (start < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(start),
          style: const TextStyle(
            color: Color(0xFF475569),
            fontSize: 13,
            height: 1.45,
          ),
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }

  Widget _buildFactBlock(String title, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 14.5,
          ),
        ),
        const SizedBox(height: 8),
        _buildHighlightedText(body),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildStepCard(
    String stepNumber,
    IconData icon,
    String title,
    String description,
  ) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 14),
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.line),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F7FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primary, size: 22),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.darkTextSecondary,
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              stepNumber,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrustDetailCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7FF),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.darkTextSecondary,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChooseCard(
    IconData icon,
    Color iconColor,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 14),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.darkTextSecondary,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(
    String otherText,
    String trustedText, {
    bool isHeader = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              color: isHeader
                  ? const Color(0xFF1E293B)
                  : const Color(0xFF131C2E),
              alignment: Alignment.centerLeft,
              child: isHeader
                  ? Center(
                      child: Text(
                        otherText,
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5,
                          letterSpacing: 0.6,
                        ),
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.close_rounded,
                          color: Color(0xFFEF4444),
                          size: 14,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            otherText,
                            style: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 12.5,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          Container(width: 1, color: const Color(0xFF2E3B4E)),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              color: isHeader ? AppColors.primary : const Color(0xFF17243B),
              alignment: Alignment.centerLeft,
              child: isHeader
                  ? Center(
                      child: Text(
                        trustedText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5,
                          letterSpacing: 0.6,
                        ),
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_rounded,
                          color: Color(0xFF10B981),
                          size: 14,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            trustedText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.5,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard(String problem, String solution) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Problem part (dusty dark reddish/maroon)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFF2C1E26), // Dark dusty pink/maroon background
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFC05A65), // Dusty red badge
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    problem,
                    style: const TextStyle(
                      color: Color(0xFFFCA5A5), // Dusty pink/red text
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Solution part (dark blue/slate)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFF1E293B), // Dark surface/slate background
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF10B981), // Green checkmark badge
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    solution,
                    style: const TextStyle(
                      color: Color(0xFFE2E8F0),
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

  Widget _buildHomeFAQSection() {
    final List<Map<String, String>> faqs = [
      {
        'q': 'How long does it take to get a maid or caregiver placed?',
        'a':
            'In most cases we present shortlisted candidates within 24–48 working hours of receiving your requirements. Availability may vary slightly based on your location and specific service type.',
      },
      {
        'q': 'Are all your professionals background verified?',
        'a':
            'Yes, without exception. Every professional goes through identity verification (Aadhaar/ID), address confirmation, and reference checks from previous employers before being placed with any family.',
      },
      {
        'q': 'What if the maid or caregiver doesn\'t work out?',
        'a':
            'We provide a replacement promptly — no extra charge. Our placement support doesn\'t end at day one. If the match isn\'t right for any reason, we find a better fit.',
      },
      {
        'q': 'Do you charge before showing candidates?',
        'a':
            'No. We first understand your requirements, shortlist suitable candidates, and arrange for you to meet them. You proceed only when you are satisfied with the match.',
      },
      {
        'q': 'Can I get a part-time maid or do I have to take full-time?',
        'a':
            'We offer complete flexibility — full-time, part-time (2–4 hours daily), hourly, and live-in arrangements. We match based on your household\'s actual needs, not a standard package.',
      },
      {
        'q': 'Which areas in Mumbai do you cover?',
        'a':
            'We serve families across Mumbai including Andheri, Bandra, Borivali, Powai, Malad, Goregaon, Chembur, Thane, Navi Mumbai, Juhu, Kandivali, and many more locations.',
      },
      {
        'q': 'Do you provide services other than house maids?',
        'a':
            'Yes — we place house maids, home cooks, nannies, baby sitters, japa maids, patient care attendants, and elder care professionals. One call covers all your home care needs.',
      },
      {
        'q': 'How do I get started?',
        'a':
            'Simply fill out the form on this page, call us at +91 7718003880, or WhatsApp us. Share your requirements and our team will respond within a few hours.',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFAQLogo(),
              const SizedBox(width: 8),
              const Text(
                'COMMON QUESTIONS',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Frequently Asked Questions',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Everything you need to know before booking domestic help through Trusted Maid.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.darkTextSecondary,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
                                    fontSize: 13.5,
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                isOpen
                                    ? Icons.close_rounded
                                    : Icons.add_rounded,
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
                                height: 1.45,
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
      ),
    );
  }

  Widget _buildHeroTrustBadge(IconData icon, Color color, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        // ignore: deprecated_member_use
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 13),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
