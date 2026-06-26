import 'package:flutter/material.dart';
import '../../../../resources/app_colors.dart';
import '../../../../utils/extensions.dart';
import '../../domain/entities/location_entity.dart';
import 'final_step_screen.dart';

/// Screen representing Step 4: Apartment BHK Size Selection.
class ApartmentSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> service;
  final LocationEntity selectedLocation;
  final Map<String, dynamic> selectedShift;

  const ApartmentSelectionScreen({
    super.key,
    required this.service,
    required this.selectedLocation,
    required this.selectedShift,
  });

  @override
  State<ApartmentSelectionScreen> createState() => _ApartmentSelectionScreenState();
}

class _ApartmentSelectionScreenState extends State<ApartmentSelectionScreen> {
  final List<Map<String, dynamic>> _apartmentOptions = [
    {'title': '1 BHK / Studio', 'feeMultiplier': 1.0},
    {'title': '2 BHK', 'feeMultiplier': 1.0},
    {'title': '3 BHK (+5% admin fee)', 'feeMultiplier': 1.05},
    {'title': '4 BHK or larger (+10% admin fee)', 'feeMultiplier': 1.10},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Select Apartment Size',
          style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.secondary),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: AppColors.lightBackground,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Decorative background glowing elements for premium depth
            Positioned(
              left: -100,
              top: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // ignore: deprecated_member_use
                  color: AppColors.primary.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              right: -120,
              bottom: -50,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // ignore: deprecated_member_use
                  color: AppColors.accent.withOpacity(0.03),
                ),
              ),
            ),

            // Scrollable contents
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildStepSummaryChip(
                        'Locality',
                        widget.selectedLocation.displayName,
                        () => Navigator.popUntil(context, ModalRoute.withName('LocalitySearchScreen')),
                      ),
                      _buildStepSummaryChip(
                        'Shift',
                        '${widget.selectedShift['title']} (${widget.selectedShift['badge']})',
                        () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        // ignore: deprecated_member_use
                        color: AppColors.primary.withOpacity(0.15),
                      ),
                    ),
                    child: const Text(
                      'STEP 04',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.5,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'WHAT IS YOUR APARTMENT SIZE?',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Rates are computed based on apartment size and floor coverage:',
                    style: const TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _apartmentOptions.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, idx) {
                      final option = _apartmentOptions[idx];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              settings: const RouteSettings(name: 'ApartmentSelectionScreen'),
                              builder: (_) => FinalStepScreen(
                                service: widget.service,
                                selectedLocation: widget.selectedLocation,
                                selectedShift: widget.selectedShift,
                                selectedApartment: option,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(
                              color: AppColors.line,
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: AppColors.primary.withOpacity(0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.home_filled,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  option['title'] as String,
                                  style: const TextStyle(
                                    color: AppColors.secondary,
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.brandSoft,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Select',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: AppColors.primary,
                                      size: 14,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepSummaryChip(String label, String value, VoidCallback onChange) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          // ignore: deprecated_member_use
          color: AppColors.primary.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: AppColors.primary.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(color: Colors.grey[500], fontSize: 11, fontWeight: FontWeight.w500),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(color: AppColors.secondary, fontSize: 11, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onChange,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close_rounded, size: 10, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
