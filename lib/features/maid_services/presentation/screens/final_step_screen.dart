import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../resources/app_colors.dart';
import '../../../../utils/extensions.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/usecases/submit_enquiry_usecase.dart';
import 'in_app_webview_screen.dart';
import 'salary_estimation_result_screen.dart';

/// Screen representing Step 5: Final Enquiry and Estimation Submit Form.
class FinalStepScreen extends StatefulWidget {
  final Map<String, dynamic> service;
  final LocationEntity selectedLocation;
  final Map<String, dynamic> selectedShift;
  final Map<String, dynamic> selectedApartment;

  const FinalStepScreen({
    super.key,
    required this.service,
    required this.selectedLocation,
    required this.selectedShift,
    required this.selectedApartment,
  });

  @override
  State<FinalStepScreen> createState() => _FinalStepScreenState();
}

class _FinalStepScreenState extends State<FinalStepScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  double _getLocalityMultiplier(String locality) {
    final lower = locality.toLowerCase();
    if (lower.contains('bandra') ||
        lower.contains('colaba') ||
        lower.contains('worli') ||
        lower.contains('juhu') ||
        lower.contains('marine lines') ||
        lower.contains('churchgate')) {
      return 1.15; // 15% premium
    } else if (lower.contains('thane') || lower.contains('kalyan')) {
      return 0.85; // 15% discount
    }
    return 1.0;
  }

  void _openWebView(String title, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InAppWebViewScreen(title: title, url: url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedShift = widget.selectedShift;
    final selectedApartment = widget.selectedApartment;
    final service = widget.service;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Final Step',
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
                  // Breadcrumbs summary chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildStepSummaryChip('Locality', widget.selectedLocation.displayName, () {
                        Navigator.popUntil(context, ModalRoute.withName('LocalitySearchScreen'));
                      }),
                      _buildStepSummaryChip('Shift', '${selectedShift['title']} (${selectedShift['badge']})', () {
                        Navigator.popUntil(context, ModalRoute.withName('ShiftSelectionScreen'));
                      }),
                      _buildStepSummaryChip('Apartment', selectedApartment['title'].split(' (')[0], () {
                        Navigator.pop(context);
                      }),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // FINAL STEP Badge
                  Align(
                    alignment: Alignment.center,
                    child: Container(
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
                        'FINAL STEP',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.5,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Heading
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Enter Details to View Estimated Salary',
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input fields
                  Container(
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
                    ),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Your Name *',
                        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                        prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.primary, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: AppColors.line, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      style: const TextStyle(fontSize: 14, color: AppColors.secondary, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
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
                    ),
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'WhatsApp / Phone Number *',
                        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                        prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.primary, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: AppColors.line, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      style: const TextStyle(fontSize: 14, color: AppColors.secondary, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Terms and disclaimer
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(color: Colors.grey[600], fontSize: 11.5, height: 1.45),
                          children: [
                            const TextSpan(text: 'By clicking submit, I accept the '),
                            TextSpan(
                              text: 'Terms of Use',
                              style: TextStyle(color: Colors.grey[700], decoration: TextDecoration.underline, fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()..onTap = () => _openWebView('Terms of Use', 'https://www.trustedmaid.in/term/'),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(color: Colors.grey[700], decoration: TextDecoration.underline, fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()..onTap = () => _openWebView('Privacy Policy', 'https://www.trustedmaid.in/privacy-policy/'),
                            ),
                            const TextSpan(text: ' of TrustedMaid.in'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Submit Button in primary gradient
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: AppColors.primary.withOpacity(0.24),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(26),
                        onTap: _isSubmitting
                            ? null
                            : () async {
                                final name = _nameController.text.trim();
                                final phone = _phoneController.text.trim();
                                if (name.isEmpty || phone.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please enter your Name and Phone number.'),
                                      backgroundColor: AppColors.error,
                                    ),
                                  );
                                  return;
                                }

                                setState(() {
                                  _isSubmitting = true;
                                });

                                final double localityMultiplier = _getLocalityMultiplier(widget.selectedLocation.displayName);
                                final double feeMultiplier = selectedApartment['feeMultiplier'] as double;
                                final int computedPrice = ((selectedShift['price'] as int) * localityMultiplier * feeMultiplier).round();

                                // Calculate estimated range (e.g. ₹4,000 - ₹5,000)
                                final int lowerBound = (computedPrice / 1000).floor() * 1000;
                                final int upperBound = lowerBound + 1000;

                                String formatVal(int val) {
                                  final valStr = val.toString();
                                  if (valStr.length > 3) {
                                    return '${valStr.substring(0, valStr.length - 3)},${valStr.substring(valStr.length - 3)}';
                                  }
                                  return valStr;
                                }

                                final String estimatedSalaryStr = '₹${formatVal(lowerBound)} - ₹${formatVal(upperBound)}';
                                final String workingHoursStr = '${selectedShift['title'].toLowerCase().replaceAll('hrs', 'hours')}';

                                final String messageBody = 'Salary Calculator Request:\n'
                                    'Service: ${service['title']}\n'
                                    'Location: ${widget.selectedLocation.displayName}\n'
                                    'Shift/Hours: ${selectedShift['title']} (${selectedShift['badge']})\n'
                                    'Home Size: ${selectedApartment['title'].split(' (')[0]}\n'
                                    'Salary Estimated: $estimatedSalaryStr';

                                final result = await sl<SubmitEnquiryUseCase>().call(
                                  SubmitEnquiryParams(
                                    fullName: name,
                                    phone: phone,
                                    email: 'calculator@trustedmaid.in',
                                    service: service['title'] as String,
                                    location: widget.selectedLocation.displayName,
                                    locationId: widget.selectedLocation.id,
                                    workingHours: workingHoursStr,
                                    shiftType: 'hourly',
                                    message: messageBody,
                                  ),
                                );

                                if (mounted) {
                                  setState(() {
                                    _isSubmitting = false;
                                  });
                                }

                                result.fold(
                                  (failure) {
                                    if (mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Failed to submit enquiry: ${failure.message}'),
                                          backgroundColor: AppColors.error,
                                        ),
                                      );
                                    }
                                  },
                                  (success) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => SalaryEstimationResultScreen(
                                          fullName: name,
                                          phone: phone,
                                          salaryRange: estimatedSalaryStr,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                        child: Center(
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Calculate Salary & Submit Enquiry',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.5,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Policy Verification Card
                  Container(
                    padding: const EdgeInsets.all(16),
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
                      border: Border.all(color: AppColors.line),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => _openWebView(
                            'Trust & Verification',
                            'https://www.trustedmaid.in/verification-process',
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: AppColors.success.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.shield_rounded,
                                  color: AppColors.success,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  'Identity & Police Background Verified',
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const Icon(Icons.open_in_new_rounded, color: Colors.grey, size: 14),
                            ],
                          ),
                        ),
                        const Divider(height: 24, color: AppColors.line),
                        Text(
                          'REPLACEMENT SUPPORT POLICIES:',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: AppColors.success.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: AppColors.success,
                                size: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '1 Year Contract',
                              style: TextStyle(fontSize: 12.5, color: AppColors.secondary, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            const Text(
                              '3 Replacements',
                              style: TextStyle(fontSize: 12.5, color: AppColors.secondary, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: AppColors.success.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: AppColors.success,
                                size: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '3 to 6 Months',
                              style: TextStyle(fontSize: 12.5, color: AppColors.secondary, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            const Text(
                              '1 Replacement',
                              style: TextStyle(fontSize: 12.5, color: AppColors.secondary, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
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
