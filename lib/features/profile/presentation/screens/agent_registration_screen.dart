// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/presentation/widgets/staggered_column.dart';
import '../../../../resources/app_colors.dart';
import '../../../maid_services/domain/usecases/register_agent_usecase.dart';

class AgentRegistrationScreen extends StatefulWidget {
  const AgentRegistrationScreen({super.key});

  @override
  State<AgentRegistrationScreen> createState() => _AgentRegistrationScreenState();
}

class _AgentRegistrationScreenState extends State<AgentRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _companyNameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _experienceController = TextEditingController();

  String _selectedAgentType = 'agency'; // individual, agency, corporate
  String _selectedHelpersCount = '10 - 50'; // 0 - 10, 10 - 50, 50 - 100, 100+

  final List<String> _availableServices = [
    'House Maid',
    'Home Cook',
    'Baby Sitter',
    'Elderly Care',
    'Patient Care',
    'Japa Maid',
  ];
  final List<String> _selectedServices = [];

  bool _isSubmitting = false;

  @override
  void dispose() {
    _companyNameController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  void _toggleService(String service) {
    setState(() {
      if (_selectedServices.contains(service)) {
        _selectedServices.remove(service);
      } else {
        _selectedServices.add(service);
      }
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedServices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one service category.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final params = RegisterAgentParams(
      companyName: _companyNameController.text.trim(),
      fullName: _fullNameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      address: _addressController.text.trim(),
      agentType: _selectedAgentType,
      experienceYears: _experienceController.text.trim().isEmpty ? '0' : _experienceController.text.trim(),
      helpersCount: _selectedHelpersCount,
      servicesProvided: _selectedServices,
    );

    final result = await sl<RegisterAgentUseCase>().call(params);

    setState(() {
      _isSubmitting = false;
    });

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: AppColors.error,
          ),
        );
      },
      (_) {
        _showSuccessDialog();
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.white,
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.successSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.success,
                    size: 64,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Registration Submitted!',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Thank you for registering as an Agent Partner. Our team will review your application and contact you within 24-48 hours.',
                  style: TextStyle(
                    color: AppColors.darkTextSecondary,
                    fontSize: 13.5,
                    height: 1.45,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        Navigator.pop(context); // Close dialog
                        Navigator.pop(context); // Go back to Support screen
                      },
                      child: const Center(
                        child: Text(
                          'Back to Support',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Agent Registration',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background visual elements
          Positioned(
            left: -100,
            top: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.04),
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
                color: AppColors.accent.withOpacity(0.03),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: StaggeredColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Grow Your Business with Us',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Provide your agency details to partner with TrustedMaid and get placement opportunities.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.darkTextSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Agent Type Selector
                    const Text(
                      'Agent / Partnership Type',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildTypeChip('agency', 'Agency / Agency Owner', Icons.business_rounded),
                        const SizedBox(width: 10),
                        _buildTypeChip('individual', 'Freelancer / Individual', Icons.person_rounded),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Inputs Card Section
                    _buildInputField(
                      controller: _companyNameController,
                      hint: 'Agency / Business Name *',
                      icon: Icons.store_rounded,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter business name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildInputField(
                      controller: _fullNameController,
                      hint: 'Contact Person Name *',
                      icon: Icons.badge_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter contact person name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildInputField(
                      controller: _phoneController,
                      hint: 'WhatsApp / Phone Number *',
                      icon: Icons.phone_android_rounded,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter phone number';
                        }
                        if (value.trim().length < 10) {
                          return 'Please enter a valid 10-digit number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildInputField(
                      controller: _emailController,
                      hint: 'Email Address',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    _buildInputField(
                      controller: _experienceController,
                      hint: 'Years of Experience as Agent *',
                      icon: Icons.timeline_rounded,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter experience years';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildInputField(
                      controller: _addressController,
                      hint: 'Office / Business Address *',
                      icon: Icons.location_on_outlined,
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Number of active helpers list
                    const Text(
                      'How many active helpers/maids are under your network?',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildHelpersCountChip('0 - 10'),
                        _buildHelpersCountChip('10 - 50'),
                        _buildHelpersCountChip('50 - 100'),
                        _buildHelpersCountChip('100+'),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Services Provided Checklist
                    const Text(
                      'Helper Services You Can Provide *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableServices.map((service) {
                        final isSelected = _selectedServices.contains(service);
                        return FilterChip(
                          label: Text(
                            service,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.white : AppColors.secondary,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (_) => _toggleService(service),
                          backgroundColor: Colors.white,
                          selectedColor: AppColors.primary,
                          checkmarkColor: Colors.white,
                          elevation: 0,
                          pressElevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: isSelected ? AppColors.primary : AppColors.line,
                              width: 1.2,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 36),

                    // Submit Button
                    Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
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
                          onTap: _isSubmitting ? null : _submitForm,
                          child: Center(
                            child: _isSubmitting
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text(
                                    'Submit Application',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip(String type, String label, IconData icon) {
    final isSelected = _selectedAgentType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedAgentType = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.brandSoft : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.line,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.darkTextSecondary,
                size: 24,
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? AppColors.primary : AppColors.darkTextSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpersCountChip(String text) {
    final isSelected = _selectedHelpersCount == text;
    return ChoiceChip(
      label: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.white : AppColors.secondary,
        ),
      ),
      selected: isSelected,
      onSelected: (val) {
        if (val) {
          setState(() {
            _selectedHelpersCount = text;
          });
        }
      },
      backgroundColor: Colors.white,
      selectedColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.line,
          width: 1.2,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
          prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.error, width: 2.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        style: const TextStyle(fontSize: 14, color: AppColors.secondary, fontWeight: FontWeight.w500),
      ),
    );
  }
}
