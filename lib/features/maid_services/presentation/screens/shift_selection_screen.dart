import 'package:flutter/material.dart';
import '../../../../resources/app_colors.dart';
import '../../../../utils/extensions.dart';
import '../../domain/entities/location_entity.dart';
import 'apartment_selection_screen.dart';

/// Screen representing Step 3: Shift & Work Hours Selection.
class ShiftSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> service;
  final LocationEntity selectedLocation;

  const ShiftSelectionScreen({
    super.key,
    required this.service,
    required this.selectedLocation,
  });

  @override
  State<ShiftSelectionScreen> createState() => _ShiftSelectionScreenState();
}

class _ShiftSelectionScreenState extends State<ShiftSelectionScreen> {
  final List<Map<String, dynamic>> _shiftOptions = [
    {'title': '2 Hrs', 'badge': 'Part-time', 'price': 4000},
    {'title': '4 Hrs', 'badge': 'Part-time', 'price': 6500},
    {'title': '5 Hrs', 'badge': 'Semi-full', 'price': 8000},
    {'title': '6 Hrs', 'badge': 'Semi-full', 'price': 9500},
    {'title': '8 Hrs', 'badge': 'Full shift', 'price': 12000},
    {'title': '10 Hrs', 'badge': 'Full shift', 'price': 14500},
    {'title': '12 Hrs', 'badge': 'Full shift', 'price': 17000},
    {'title': '24 Hrs', 'badge': 'Live-in', 'price': 25000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Select Shift',
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
                  // Locality summary chip
                  Wrap(
                    children: [
                      _buildStepSummaryChip(
                        'Locality',
                        widget.selectedLocation.displayName,
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
                      'STEP 03',
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
                    'SELECT SHIFT & WORK HOURS',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'How many hours of daily support does your family require?',
                    style: const TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _shiftOptions.length,
                    itemBuilder: (context, idx) {
                      final option = _shiftOptions[idx];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              settings: const RouteSettings(name: 'ShiftSelectionScreen'),
                              builder: (_) => ApartmentSelectionScreen(
                                service: widget.service,
                                selectedLocation: widget.selectedLocation,
                                selectedShift: option,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
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
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: AppColors.primary.withOpacity(0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.access_time_filled_rounded,
                                  color: AppColors.primary,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      option['title'] as String,
                                      style: const TextStyle(
                                        color: AppColors.secondary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      option['badge'] as String,
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
