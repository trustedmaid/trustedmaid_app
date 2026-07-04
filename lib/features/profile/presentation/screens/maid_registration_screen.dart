// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/presentation/widgets/staggered_column.dart';
import '../../../../resources/app_colors.dart';
import '../../../maid_services/domain/entities/location_entity.dart';
import '../../../maid_services/domain/usecases/register_maid_usecase.dart';
import '../../../maid_services/domain/usecases/search_locations_usecase.dart';

class MaidRegistrationScreen extends StatefulWidget {
  const MaidRegistrationScreen({super.key});

  @override
  State<MaidRegistrationScreen> createState() => _MaidRegistrationScreenState();
}

class _MaidRegistrationScreenState extends State<MaidRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _alternatePhoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _currentCityController = TextEditingController();
  final _preferredLocationController = TextEditingController();
  final _expectedSalaryController = TextEditingController();

  // Selected values
  String? _selectedAge = '25 Years';
  String _selectedGender = 'Female';
  String _selectedMaritalStatus = 'Single';
  String _selectedReligion = 'Hindu';
  String? _selectedWorkingHours;

  // Selected Languages list (Multi-select)
  final List<String> _selectedLanguages = [];

  // Services list and their checked state / experience
  final List<Map<String, dynamic>> _servicesOptions = [
    {'id': 3, 'name': 'Baby Sitter', 'checked': false, 'experience': '1 Year'},
    {'id': 2, 'name': 'Cook', 'checked': false, 'experience': '1 Year'},
    {'id': 6, 'name': 'Elderly Care', 'checked': false, 'experience': '1 Year'},
    {'id': 1, 'name': 'House Maid', 'checked': false, 'experience': '1 Year'},
    {'id': 5, 'name': 'Japa Maid', 'checked': false, 'experience': '1 Year'},
    {'id': 7, 'name': 'Nanny', 'checked': false, 'experience': '1 Year'},
    {'id': 4, 'name': 'Patient Care', 'checked': false, 'experience': '1 Year'},
  ];

  final List<String> _experienceOptions = [
    ...List.generate(
      50,
      (index) => '${index + 1} Year${index == 0 ? "" : "s"}',
    ),
  ];

  final List<String> _ageOptions = List.generate(
    48,
    (index) => '${index + 18} Years',
  );

  final List<String> _genderOptions = ['Female', 'Male', 'Other'];

  final List<String> _maritalStatusOptions = [
    'Single',
    'Married',
    'Widowed',
    'Divorced',
  ];

  final List<String> _religionOptions = [
    'Hindu',
    'Muslim',
    'Christian',
    'Sikh',
    'Buddhist',
    'Jain',
    'Other',
  ];

  final List<String> _hoursOptions = List.generate(
    24,
    (index) => '${index + 1} Hour${index == 0 ? "" : "s"}',
  );

  final List<String> _availableLanguages = [
    'Hindi',
    'English',
    'Marathi',
    'Fluent English',
  ];

  // Document mock variables
  String? _aadhaarFileName;
  String? _aadhaarFilePath;
  bool _isUploadingAadhaar = false;
  String? _photoFileName;
  String? _photoFilePath;
  bool _isUploadingPhoto = false;

  bool _aadhaarVerified = false;
  bool _policeVerified = false;

  bool _isSubmitting = false;

  // Location suggestion variables
  List<LocationEntity> _citySuggestions = [];
  bool _isLoadingCitySuggestions = false;
  Timer? _cityDebounce;
  int? _currentCityId;

  List<LocationEntity> _prefSuggestions = [];
  bool _isLoadingPrefSuggestions = false;
  Timer? _prefDebounce;

  bool _showPrefOverlay = false;
  final _prefSearchController = TextEditingController();
  final List<LocationEntity> _selectedPreferredLocations = [];

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _alternatePhoneController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _currentCityController.dispose();
    _preferredLocationController.dispose();
    _expectedSalaryController.dispose();
    _prefSearchController.dispose();
    _cityDebounce?.cancel();
    _prefDebounce?.cancel();
    super.dispose();
  }

  void _toggleLanguage(String lang) {
    setState(() {
      if (_selectedLanguages.contains(lang)) {
        _selectedLanguages.remove(lang);
      } else {
        _selectedLanguages.add(lang);
      }
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1960),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.secondary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dobController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        // Compute age dynamically
        final today = DateTime.now();
        int age = today.year - picked.year;
        if (today.month < picked.month ||
            (today.month == picked.month && today.day < picked.day)) {
          age--;
        }
        if (age >= 18 && age <= 65) {
          _selectedAge = '$age Years';
        }
      });
    }
  }

  Future<void> _pickFile(bool isAadhaar) async {
    setState(() {
      if (isAadhaar) {
        _isUploadingAadhaar = true;
      } else {
        _isUploadingPhoto = true;
      }
    });

    try {
      final FilePickerResult? result = await FilePicker.pickFiles(
        type: isAadhaar ? FileType.any : FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        final fileName = result.files.single.name;
        final filePath = result.files.single.path;
        setState(() {
          if (isAadhaar) {
            _aadhaarFileName = fileName;
            _aadhaarFilePath = filePath;
          } else {
            _photoFileName = fileName;
            _photoFilePath = filePath;
          }
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick file: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        if (isAadhaar) {
          _isUploadingAadhaar = false;
        } else {
          _isUploadingPhoto = false;
        }
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    // Check if at least one service is selected
    final selectedServices = _servicesOptions
        .where((s) => s['checked'] == true)
        .toList();
    if (selectedServices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select at least one service category and experience.',
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Map selected services
    final List<Map<String, dynamic>> servicesPayload = selectedServices.map((s) {
      int id = (s['id'] as int?) ?? 1;
      if (s['id'] == null) {
        final name = s['name'] as String? ?? '';
        if (name.contains('Cook')) {
          id = 2;
        } else if (name.contains('Baby Sitter')) {
          id = 3;
        } else if (name.contains('Patient Care')) {
          id = 4;
        } else if (name.contains('Japa')) {
          id = 5;
        } else if (name.contains('Elderly')) {
          id = 6;
        } else if (name.contains('Nanny')) {
          id = 7;
        }
      }
      return {
        'id': id,
        'name': s['name'] as String? ?? '',
        'experience': s['experience'] as String? ?? '1 Year',
      };
    }).toList();

    // Map preferred locations
    final List<int> preferredLocationIds = _selectedPreferredLocations
        .map((loc) => loc.id)
        .toList();

    // Prepare parameters
    final params = RegisterMaidParams(
      fullName: _fullNameController.text.trim(),
      gender: _selectedGender,
      age: _selectedAge ?? '25 Years',
      phone: _phoneController.text.trim(),
      alternatePhone: _alternatePhoneController.text.trim(),
      email: _emailController.text.trim(),
      dob: _dobController.text.trim(),
      maritalStatus: _selectedMaritalStatus,
      religion: _selectedReligion,
      agentId: null,
      currentLocationId: _currentCityId ?? 1,
      preferredLocationIds: preferredLocationIds.isEmpty ? [1] : preferredLocationIds,
      expectedSalary: _expectedSalaryController.text.trim(),
      workingHours: _selectedWorkingHours ?? '',
      languages: _selectedLanguages,
      aadhaarVerified: _aadhaarVerified,
      policeVerified: _policeVerified,
      photoPath: _photoFilePath,
      aadhaarPath: _aadhaarFilePath,
      services: servicesPayload,
    );

    final result = await sl<RegisterMaidUseCase>().call(params);

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
                  'Application Submitted!',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your domestic helper job application was submitted successfully. Our operations team will review your background and call you shortly.',
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
    return GestureDetector(
      onTap: () {
        setState(() {
          _showPrefOverlay = false;
          _citySuggestions = [];
        });
      },
      child: Scaffold(
        backgroundColor:
            Colors.white, // Clean white background as in screenshots
        appBar: AppBar(
          title: const Text(
            'Add Job Application',
            style: TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.secondary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close_rounded,
                color: AppColors.secondary,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
          elevation: 0.5,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Form(
              key: _formKey,
              child: StaggeredColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                stepDelayMs: 60,
                children: [
                  // ── CONTACT DETAILS ──────────────────────────────────────────
                  _buildFieldLabel('Full Name (नाम) *'),
                  _buildInputField(
                    controller: _fullNameController,
                    hint: 'e.g. Sushma Sakpal',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildFieldLabel('Mobile No. (मोबाइल नंबर) *'),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildFieldLabel('Alternate No. (वैकल्पिक नंबर)'),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildInputField(
                          controller: _phoneController,
                          hint: '+91 9619144310',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter mobile';
                            }
                            if (value.trim().length < 10) {
                              return '10 digits required';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildInputField(
                          controller: _alternatePhoneController,
                          hint: 'e.g. 9876543210',
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildFieldLabel('Email Address (ईमेल)'),
                  _buildInputField(
                    controller: _emailController,
                    hint: 'e.g. sushma@example.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 28),

                  // ── PERSONAL DETAILS ─────────────────────────────────────────
                  _buildSectionHeader('PERSONAL DETAILS'),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildFieldLabel('Date of Birth (जन्म तिथि)'),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildFieldLabel('Age (उम्र)'),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _selectDate,
                          child: AbsorbPointer(
                            child: _buildInputField(
                              controller: _dobController,
                              hint: 'Select Date',
                              suffixIcon: const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildDropdownField<String>(
                          value: _selectedAge,
                          items: _ageOptions,
                          onChanged: (val) =>
                              setState(() => _selectedAge = val),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildFieldLabel('Gender (लिंग)'),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildFieldLabel('Marital Status (वैवाहिक स्थिति)'),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildDropdownField<String>(
                          value: _selectedGender,
                          items: _genderOptions,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedGender = val);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildDropdownField<String>(
                          value: _selectedMaritalStatus,
                          items: _maritalStatusOptions,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedMaritalStatus = val);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildFieldLabel('Religion (धर्म)'),
                  _buildDropdownField<String>(
                    value: _selectedReligion,
                    items: _religionOptions,
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedReligion = val);
                    },
                  ),
                  const SizedBox(height: 28),

                  // ── SERVICES & EXPERIENCE ────────────────────────────────────
                  _buildSectionHeader(
                    'SERVICES & EXPERIENCE (सेवाएं और अनुभव) *',
                  ),
                  const SizedBox(height: 16),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _servicesOptions.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, idx) {
                      final item = _servicesOptions[idx];
                      final bool isChecked = item['checked'] as bool;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isChecked
                              ? AppColors.brandSoft.withOpacity(0.2)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isChecked
                                ? AppColors.primary
                                : const Color(0xFFE2E8F0),
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              activeColor: AppColors.success,
                              onChanged: (val) {
                                setState(() {
                                  item['checked'] = val ?? false;
                                });
                              },
                            ),
                            Text(
                              item['name'] as String,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isChecked
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: AppColors.secondary,
                              ),
                            ),
                            const Spacer(),
                            if (isChecked)
                              SizedBox(
                                width: 120,
                                height: 40,
                                child: _buildDropdownField<String>(
                                  value: item['experience'] as String,
                                  items: _experienceOptions,
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(() {
                                        item['experience'] = val;
                                      });
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 28),

                  // ── LOCATIONS & SALARY ───────────────────────────────────────
                  _buildSectionHeader('LOCATIONS & SALARY'),
                  const SizedBox(height: 16),

                  // Current City (शहर) *
                  _buildFieldLabel('Current City (शहर) *'),
                  _buildInputField(
                    controller: _currentCityController,
                    hint: 'e.g. Mumbai, Andheri...',
                    suffixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 20,
                    ),
                    onChanged: (val) {
                      setState(() {
                        _currentCityId = null;
                      });
                      if (_cityDebounce?.isActive ?? false)
                        _cityDebounce!.cancel();
                      _cityDebounce = Timer(
                        const Duration(milliseconds: 350),
                        () async {
                          if (val.trim().isEmpty) {
                            setState(() {
                              _citySuggestions = [];
                            });
                            return;
                          }
                          setState(() {
                            _isLoadingCitySuggestions = true;
                          });
                          final result = await sl<SearchLocationsUseCase>()
                              .call(val.trim());
                          result.fold(
                            (failure) {
                              setState(() {
                                _isLoadingCitySuggestions = false;
                                _citySuggestions = [];
                              });
                            },
                            (locations) {
                              setState(() {
                                _isLoadingCitySuggestions = false;
                                _citySuggestions = locations;
                              });
                            },
                          );
                        },
                      );
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter current city';
                      }
                      return null;
                    },
                  ),
                  if (_isLoadingCitySuggestions)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 8.0),
                      child: SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  if (_citySuggestions.isNotEmpty)
                    GestureDetector(
                      onTap:
                          () {}, // Prevent tap from bubbling up and closing suggestions
                      child: _buildSuggestionsList(_citySuggestions, (loc) {
                        setState(() {
                          _currentCityController.text = loc.displayName;
                          _currentCityId = loc.id;
                          _citySuggestions = [];
                        });
                      }),
                    ),
                  const SizedBox(height: 16),

                  // Preferred Work Location (पसंदीदा क्षेत्र)
                  _buildFieldLabel('Preferred Work Location (पसंदीदा क्षेत्र)'),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showPrefOverlay = !_showPrefOverlay;
                      });
                    },
                    child: AbsorbPointer(
                      child: _buildInputField(
                        controller: _preferredLocationController,
                        hint: 'Select preferred locations...',
                        suffixIcon: Icon(
                          _showPrefOverlay
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  if (_showPrefOverlay)
                    GestureDetector(
                      onTap:
                          () {}, // Prevent tap from bubbling up and closing overlay
                      child: Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Search bar inside the overlay
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: TextFormField(
                                controller: _prefSearchController,
                                onChanged: (val) {
                                  if (_prefDebounce?.isActive ?? false)
                                    _prefDebounce!.cancel();
                                  _prefDebounce = Timer(
                                    const Duration(milliseconds: 350),
                                    () async {
                                      if (val.trim().isEmpty) {
                                        setState(() {
                                          _prefSuggestions = [];
                                        });
                                        return;
                                      }
                                      setState(() {
                                        _isLoadingPrefSuggestions = true;
                                      });
                                      final result =
                                          await sl<SearchLocationsUseCase>()
                                              .call(val.trim());
                                      result.fold(
                                        (failure) {
                                          setState(() {
                                            _isLoadingPrefSuggestions = false;
                                            _prefSuggestions = [];
                                          });
                                        },
                                        (locations) {
                                          setState(() {
                                            _isLoadingPrefSuggestions = false;
                                            _prefSuggestions = locations;
                                          });
                                        },
                                      );
                                    },
                                  );
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search location...',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF94A3B8),
                                    fontSize: 13.5,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search_rounded,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            if (_isLoadingPrefSuggestions)
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            if (!_isLoadingPrefSuggestions &&
                                _prefSuggestions.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                child: Center(
                                  child: Text(
                                    _prefSearchController.text.isEmpty
                                        ? 'Type to search locations'
                                        : 'No locations found',
                                    style: const TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            if (!_isLoadingPrefSuggestions &&
                                _prefSuggestions.isNotEmpty)
                              Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 220,
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: _prefSuggestions.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                        height: 1,
                                        color: Color(0xFFE2E8F0),
                                      ),
                                  itemBuilder: (context, index) {
                                    final loc = _prefSuggestions[index];
                                    final isSelected =
                                        _selectedPreferredLocations.any(
                                          (item) => item.id == loc.id,
                                        );

                                    // Split display name into title and subtitle if it has a comma
                                    final parts = loc.displayName.split(',');
                                    final title = parts[0].trim();
                                    final subtitle = parts.length > 1
                                        ? parts
                                              .skip(1)
                                              .map((s) => s.trim())
                                              .join(' · ')
                                        : null;

                                    return ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 2,
                                          ),
                                      leading: Checkbox(
                                        value: isSelected,
                                        activeColor: AppColors.primary,
                                        onChanged: (val) {
                                          setState(() {
                                            if (val == true) {
                                              _selectedPreferredLocations.add(
                                                loc,
                                              );
                                            } else {
                                              _selectedPreferredLocations
                                                  .removeWhere(
                                                    (item) => item.id == loc.id,
                                                  );
                                            }
                                            _preferredLocationController.text =
                                                _selectedPreferredLocations
                                                    .map(
                                                      (item) =>
                                                          item.displayName,
                                                    )
                                                    .join(', ');
                                          });
                                        },
                                      ),
                                      title: Text(
                                        title,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                      subtitle: subtitle != null
                                          ? Text(
                                              subtitle,
                                              style: const TextStyle(
                                                fontSize: 11.5,
                                                color: Color(0xFF64748B),
                                              ),
                                            )
                                          : null,
                                      dense: true,
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            _selectedPreferredLocations
                                                .removeWhere(
                                                  (item) => item.id == loc.id,
                                                );
                                          } else {
                                            _selectedPreferredLocations.add(
                                              loc,
                                            );
                                          }
                                          _preferredLocationController.text =
                                              _selectedPreferredLocations
                                                  .map(
                                                    (item) => item.displayName,
                                                  )
                                                  .join(', ');
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildFieldLabel(
                          'Expected Salary (अपेक्षित वेतन) (₹)',
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildFieldLabel('Working Hours (काम के घंटे)'),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildInputField(
                          controller: _expectedSalaryController,
                          hint: 'e.g. 15000',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildDropdownField<String>(
                          value: _selectedWorkingHours,
                          items: _hoursOptions,
                          onChanged: (val) =>
                              setState(() => _selectedWorkingHours = val),
                          hintText: 'Select Hours',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // ── LANGUAGES KNOWN ──────────────────────────────────────────
                  _buildSectionHeader(
                    'WHICH LANGUAGES DO YOU KNOW? (तुम कौन सी भाषा जानते हो?)',
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _availableLanguages.map((lang) {
                      final isSelected = _selectedLanguages.contains(lang);
                      return FilterChip(
                        label: Text(
                          lang,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : AppColors.secondary,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (_) => _toggleLanguage(lang),
                        backgroundColor: const Color(0xFFF1F5F9),
                        selectedColor: AppColors.primary,
                        checkmarkColor: Colors.white,
                        elevation: 0,
                        pressElevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.primary
                                : const Color(0xFFCBD5E1),
                            width: 1.2,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 28),

                  // ── VERIFICATION DOCUMENTS ────────────────────────────────────
                  _buildSectionHeader(
                    'VERIFICATION DOCUMENTS (सत्यापन दस्तावेज)',
                  ),
                  const SizedBox(height: 16),

                  // Upload Headers
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildFieldLabel(
                          'Upload Aadhaar Card (आधार कार्ड)',
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildFieldLabel(
                          'Upload Photo (फोटो)',
                        ),
                      ),
                    ],
                  ),
                  // Upload Boxes
                  Row(
                    children: [
                      Expanded(
                        child: _buildUploadBox(
                          fileName: _aadhaarFileName,
                          filePath: _aadhaarFilePath,
                          isUploading: _isUploadingAadhaar,
                          hint: 'JPG, PNG or PDF · Max 5MB',
                          icon: Icons.description_outlined,
                          onTap: () => _pickFile(true),
                          onDelete: () => setState(() {
                            _aadhaarFileName = null;
                            _aadhaarFilePath = null;
                          }),
                          height: 120,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildUploadBox(
                          fileName: _photoFileName,
                          filePath: _photoFilePath,
                          isUploading: _isUploadingPhoto,
                          hint: 'JPG or PNG · Max 2MB',
                          icon: Icons.portrait_outlined,
                          onTap: () => _pickFile(false),
                          onDelete: () => setState(() {
                            _photoFileName = null;
                            _photoFilePath = null;
                          }),
                          height: 120,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Verification Titles
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildFieldLabel(
                          'Aadhaar Verified (आधार सत्यापित)',
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildFieldLabel(
                          'Police Verified (पुलिस सत्यापित)',
                        ),
                      ),
                    ],
                  ),
                  // Verification Radios
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildVerificationRadioOptions(
                          value: _aadhaarVerified,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _aadhaarVerified = val);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildVerificationRadioOptions(
                          value: _policeVerified,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _policeVerified = val);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

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
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Color(0xFF475569), // slate grey
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.bold,
        color: Color(0xFF64748B), // Slate primary header color
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC), // Off-white/slate fill as in mocks
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 13.5,
            fontWeight: FontWeight.normal,
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.secondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDropdownField<T>({
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
    String? hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<T>(
        initialValue: value,
        hint: hintText != null
            ? Text(
                hintText,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 13.5,
                ),
              )
            : null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          fillColor: Colors.transparent,
          filled: true,
        ),
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.secondary,
          fontWeight: FontWeight.w500,
        ),
        dropdownColor: Colors.white,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Colors.grey,
          size: 20,
        ),
        items: items.map((T item) {
          return DropdownMenuItem<T>(value: item, child: Text(item.toString()));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildUploadBox({
    required String? fileName,
    required String? filePath,
    required bool isUploading,
    required String hint,
    required IconData icon,
    required VoidCallback onTap,
    required VoidCallback onDelete,
    double height = 110,
    double? width,
  }) {
    final bool isImage =
        filePath != null &&
        (filePath.toLowerCase().endsWith('.jpg') ||
            filePath.toLowerCase().endsWith('.jpeg') ||
            filePath.toLowerCase().endsWith('.png') ||
            filePath.toLowerCase().endsWith('.gif') ||
            filePath.toLowerCase().endsWith('.webp'));

    return GestureDetector(
      onTap: fileName == null && !isUploading ? onTap : null,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.2,
            style: BorderStyle.solid,
          ),
        ),
        child: isUploading
            ? const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                ),
              )
            : fileName != null
            ? isImage
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(filePath),
                            fit: BoxFit.cover,
                            width: width ?? double.infinity,
                            height: height,
                          ),
                        ),
                        Positioned(
                          top: 6,
                          right: 6,
                          child: GestureDetector(
                            onTap: onDelete,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.insert_drive_file_outlined,
                            color: AppColors.primary,
                            size: 28,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  fileName,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.secondary,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: onDelete,
                                child: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: AppColors.error,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: AppColors.primary, size: 28),
                  const SizedBox(height: 6),
                  const Text(
                    'Click to upload',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      hint,
                      style: const TextStyle(
                        fontSize: 9.5,
                        color: Color(0xFF94A3B8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildVerificationRadioOptions({
    required bool value,
    required void Function(bool?) onChanged,
  }) {
    return Row(
      children: [
        Radio<bool>(
          value: true,
          groupValue: value,
          activeColor: AppColors.primary,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        ),
        const SizedBox(width: 6),
        const Text(
          'Yes',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 20),
        Radio<bool>(
          value: false,
          groupValue: value,
          activeColor: AppColors.primary,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        ),
        const SizedBox(width: 6),
        const Text(
          'No',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionsList(
    List<LocationEntity> locations,
    void Function(LocationEntity) onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      constraints: const BoxConstraints(maxHeight: 180),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: locations.length,
        separatorBuilder: (context, index) =>
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
        itemBuilder: (context, index) {
          final loc = locations[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 2,
            ),
            title: Text(
              loc.displayName,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: const Icon(
              Icons.location_on_rounded,
              color: AppColors.primary,
              size: 16,
            ),
            dense: true,
            onTap: () => onTap(loc),
          );
        },
      ),
    );
  }
}
