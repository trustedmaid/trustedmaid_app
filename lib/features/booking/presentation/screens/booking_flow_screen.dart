import 'package:flutter/material.dart';
import '../../../../resources/app_colors.dart';
import 'booking_confirmation_screen.dart';

/// Multi-step Booking Form Wizard implementing schedule configuration, address checks, and review summary.
class BookingFlowScreen extends StatefulWidget {
  final String serviceName;
  final String planName;
  final int monthlyCharge;

  const BookingFlowScreen({
    super.key,
    required this.serviceName,
    required this.planName,
    required this.monthlyCharge,
  });

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  int _currentStep = 1; // 1: Schedule, 2: Address, 3: Review

  // Step 1 State Fields
  String _selectedPlan = '';
  String _selectedStartDate = 'Tomorrow';
  String _selectedTimeSlot = 'Morning 7–10';
  final List<String> _selectedLanguages = ['Hindi', 'Marathi'];

  // Step 2 State Fields
  int _selectedAddressIdx = 0; // 0: Powai, 1: Add new
  String _selectedHomeType = '3 BHK';
  String _selectedMembers = '3–4';
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedPlan = widget.planName;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (_currentStep > 1) {
              setState(() {
                _currentStep--;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(_getStepTitle()),
      ),
      body: Column(
        children: [
          // Step Indicators
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Row(
              children: [
                _buildStepBar(active: _currentStep >= 1),
                const SizedBox(width: 6),
                _buildStepBar(active: _currentStep >= 2),
                const SizedBox(width: 6),
                _buildStepBar(active: _currentStep >= 3),
              ],
            ),
          ),
          
          Expanded(
            child: _buildStepBody(),
          ),
          
          // Sticky Bottom Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _currentStep == 3 ? AppColors.secondary : AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _handleStepSubmit,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentStep == 3 ? 'Confirm Request' : 'Continue',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(width: 8),
                    Icon(_currentStep == 3 ? Icons.check_rounded : Icons.arrow_forward_rounded, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 1:
        return 'Booking · Schedule';
      case 2:
        return 'Booking · Address';
      case 3:
        return 'Review & Confirm';
      default:
        return 'Booking';
    }
  }

  Widget _buildStepBar({required bool active}) {
    return Expanded(
      child: Container(
        height: 5,
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.line,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }

  Widget _buildStepBody() {
    switch (_currentStep) {
      case 1:
        return _buildScheduleStep();
      case 2:
        return _buildAddressStep();
      case 3:
        return _buildReviewStep();
      default:
        return const SizedBox.shrink();
    }
  }

  void _handleStepSubmit() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Step 3 submission -> Go to confirmation screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BookingConfirmationScreen(
            serviceName: widget.serviceName,
            planName: _selectedPlan,
          ),
        ),
      );
    }
  }

  // =========================================================================
  // STEP 1: Schedule Form
  // =========================================================================
  Widget _buildScheduleStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 16, 18, 7),
            child: Text('Service type', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                _buildRadioCard('Part-time (2–4 hrs/day)', _selectedPlan == 'Part-time', Icons.schedule_rounded, () {
                  setState(() => _selectedPlan = 'Part-time');
                }),
                const SizedBox(height: 9),
                _buildRadioCard('Full-time (8 hrs/day)', _selectedPlan == 'Full-time', Icons.work_history_rounded, () {
                  setState(() => _selectedPlan = 'Full-time');
                }),
                const SizedBox(height: 9),
                _buildRadioCard('Live-in (stays at home)', _selectedPlan == 'Live-in', Icons.night_shelter_rounded, () {
                  setState(() => _selectedPlan = 'Live-in');
                }),
              ],
            ),
          ),
          
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 16, 18, 7),
            child: Text('Preferred start', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSelectChip('Today', _selectedStartDate == 'Today', () => setState(() => _selectedStartDate = 'Today')),
                _buildSelectChip('Tomorrow', _selectedStartDate == 'Tomorrow', () => setState(() => _selectedStartDate = 'Tomorrow')),
                _buildSelectChip('This week', _selectedStartDate == 'This week', () => setState(() => _selectedStartDate = 'This week')),
                _buildSelectChip('Pick date', _selectedStartDate == 'Pick date', () => setState(() => _selectedStartDate = 'Pick date')),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(18, 16, 18, 7),
            child: Text('Preferred time slot', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSelectChip('Morning 7–10', _selectedTimeSlot == 'Morning 7–10', () => setState(() => _selectedTimeSlot = 'Morning 7–10')),
                _buildSelectChip('Noon 12–3', _selectedTimeSlot == 'Noon 12–3', () => setState(() => _selectedTimeSlot = 'Noon 12–3')),
                _buildSelectChip('Evening 4–7', _selectedTimeSlot == 'Evening 4–7', () => setState(() => _selectedTimeSlot = 'Evening 4–7')),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(18, 16, 18, 7),
            child: Text('Languages preferred', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildMultiChip('Hindi', _selectedLanguages.contains('Hindi'), () {
                  setState(() {
                    _selectedLanguages.contains('Hindi') ? _selectedLanguages.remove('Hindi') : _selectedLanguages.add('Hindi');
                  });
                }),
                _buildMultiChip('Marathi', _selectedLanguages.contains('Marathi'), () {
                  setState(() {
                    _selectedLanguages.contains('Marathi') ? _selectedLanguages.remove('Marathi') : _selectedLanguages.add('Marathi');
                  });
                }),
                _buildMultiChip('English', _selectedLanguages.contains('English'), () {
                  setState(() {
                    _selectedLanguages.contains('English') ? _selectedLanguages.remove('English') : _selectedLanguages.add('English');
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioCard(String label, bool isSel, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: isSel ? AppColors.brandSoft : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSel ? AppColors.primary : AppColors.line,
            width: isSel ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 21),
            const SizedBox(width: 11),
            Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.darkText),
            ),
            const Spacer(),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSel ? AppColors.primary : AppColors.line,
                  width: 2,
                ),
                color: isSel ? AppColors.primary : Colors.transparent,
              ),
              child: isSel
                  ? Center(
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectChip(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: active ? AppColors.primary : AppColors.line, width: 1.5),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : AppColors.darkText,
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMultiChip(String text, bool active, VoidCallback onTap) {
    return _buildSelectChip(text, active, onTap);
  }

  // =========================================================================
  // STEP 2: Address Form
  // =========================================================================
  Widget _buildAddressStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 16, 18, 7),
            child: Text('Home address', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                _buildAddressRadioCard('Home — A-1204, Hiranandani, Powai', _selectedAddressIdx == 0, Icons.home_rounded, () {
                  setState(() => _selectedAddressIdx = 0);
                }),
                const SizedBox(height: 9),
                _buildAddressRadioCard('Add new address', _selectedAddressIdx == 1, Icons.add_rounded, () {
                  setState(() => _selectedAddressIdx = 1);
                }),
              ],
            ),
          ),
          
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 16, 18, 7),
            child: Text('Home type', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSelectChip('1 BHK', _selectedHomeType == '1 BHK', () => setState(() => _selectedHomeType = '1 BHK')),
                _buildSelectChip('2 BHK', _selectedHomeType == '2 BHK', () => setState(() => _selectedHomeType = '2 BHK')),
                _buildSelectChip('3 BHK', _selectedHomeType == '3 BHK', () => setState(() => _selectedHomeType = '3 BHK')),
                _buildSelectChip('Villa', _selectedHomeType == 'Villa', () => setState(() => _selectedHomeType = 'Villa')),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(18, 16, 18, 7),
            child: Text('Members at home', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSelectChip('1–2', _selectedMembers == '1–2', () => setState(() => _selectedMembers = '1–2')),
                _buildSelectChip('3–4', _selectedMembers == '3–4', () => setState(() => _selectedMembers = '3–4')),
                _buildSelectChip('5+', _selectedMembers == '5+', () => setState(() => _selectedMembers = '5+')),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(18, 16, 18, 7),
            child: Text('Any special requirement?', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.line, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.edit_note_rounded, color: AppColors.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        hintText: 'Pets at home, gated society, etc.',
                        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 13),
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

  Widget _buildAddressRadioCard(String label, bool isSel, IconData icon, VoidCallback onTap) {
    return _buildRadioCard(label, isSel, icon, onTap);
  }

  // =========================================================================
  // STEP 3: Review summary
  // =========================================================================
  Widget _buildReviewStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Summarized Service Info
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.brandSoft,
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    child: Icon(Icons.cleaning_services_rounded, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.serviceName} · $_selectedPlan',
                        style: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Sunita K. · 4.9 ★',
                        style: TextStyle(color: Colors.grey, fontSize: 11.5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Cost Details Card
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSummaryRow('Start date', '$_selectedStartDate, $_selectedTimeSlot'),
                  _buildSummaryRow('Address', 'Powai · $_selectedHomeType'),
                  _buildSummaryRow('Monthly charge', '₹${widget.monthlyCharge}'),
                  _buildSummaryRow('Placement fee', '₹1,500'),
                  _buildSummaryRow('Replacement', 'Free', isGreen: true),
                  const Divider(height: 24, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pay now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.secondary)),
                      Text('₹0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.secondary)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Guarantee badge
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified_user_rounded, color: Colors.green, size: 14),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Pay only after you meet & approve the pro',
                    style: TextStyle(color: Colors.green[800], fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String left, String right, {bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(
            right,
            style: TextStyle(
              color: isGreen ? Colors.green : AppColors.darkText,
              fontWeight: isGreen ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
