import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/location_model.dart';
import '../models/maid_service_model.dart';

/// Data source interface for fetching domestic maid helper services.
abstract class MaidServiceRemoteDataSource {
  /// Loads available maid services list.
  Future<List<MaidServiceModel>> getMaidServices();

  /// Search matching locations based on query.
  Future<List<LocationModel>> searchLocations(String query);

  /// Submits customer/calculator enquiry.
  Future<void> submitEnquiry({
    required String fullName,
    required String phone,
    required String email,
    required String service,
    required String location,
    required int locationId,
    required String workingHours,
    required String shiftType,
    required String message,
  });

  /// Register a new agent.
  Future<void> registerAgent({
    required String agentType,
    required String fullName,
    required String? companyName,
    required String phone,
    required String? alternatePhone,
    required String? email,
    required String? address,
    required String? aadharUrl,
    required String? notes,
  });

  /// Upload a file for agent documents.
  Future<String> uploadPublicFile(String filePath);

  /// Register a new maid.
  Future<void> registerMaid({
    required String fullName,
    required String gender,
    required String age,
    required String phone,
    required String alternatePhone,
    required String email,
    required String dob,
    required String maritalStatus,
    required String religion,
    required String? agentId,
    required int? currentLocationId,
    required List<int> preferredLocationIds,
    required String expectedSalary,
    required String workingHours,
    required List<String> languages,
    required bool aadhaarVerified,
    required bool policeVerified,
    required String? photoPath,
    required String? aadhaarPath,
    required List<Map<String, dynamic>> services,
  });
}

/// Implementation of [MaidServiceRemoteDataSource] using [DioClient].
class MaidServiceRemoteDataSourceImpl implements MaidServiceRemoteDataSource {
  final DioClient client;

  MaidServiceRemoteDataSourceImpl({required this.client});

  @override
  Future<void> submitEnquiry({
    required String fullName,
    required String phone,
    required String email,
    required String service,
    required String location,
    required int locationId,
    required String workingHours,
    required String shiftType,
    required String message,
  }) async {
    try {
      await client.post(
        'https://www.trustedmaid.in/api/customers',
        data: {
          'fullName': fullName,
          'phone': phone,
          'email': email,
          'service': service,
          'location': location,
          'location_id': locationId,
          'working_hours': workingHours,
          'shift_type': shiftType,
          'message': message,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> registerAgent({
    required String agentType,
    required String fullName,
    required String? companyName,
    required String phone,
    required String? alternatePhone,
    required String? email,
    required String? address,
    required String? aadharUrl,
    required String? notes,
  }) async {
    try {
      await client.post(
        'https://www.trustedmaid.in/api/public/agents',
        data: {
          'agent_code': null,
          'agent_type': agentType,
          'full_name': fullName,
          'company_name': companyName,
          'phone': phone,
          'alternate_phone': alternatePhone,
          'email': email,
          'address': address,
          'aadhar_url': aadharUrl,
          'pan_url': null,
          'agreement_url': null,
          'commission_type': 'percentage',
          'default_commission_value': 40,
          'status': 'inactive',
          'notes': notes,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> uploadPublicFile(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
      });

      final response = await client.post(
        'https://www.trustedmaid.in/api/public/upload?type=agent&folder=aadhar',
        data: formData,
      );

      if (response.data != null && response.data['url'] != null) {
        return response.data['url'] as String;
      }
      throw Exception('Failed to get file URL from upload response');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> registerMaid({
    required String fullName,
    required String gender,
    required String age,
    required String phone,
    required String alternatePhone,
    required String email,
    required String dob,
    required String maritalStatus,
    required String religion,
    required String? agentId,
    required int? currentLocationId,
    required List<int> preferredLocationIds,
    required String expectedSalary,
    required String workingHours,
    required List<String> languages,
    required bool aadhaarVerified,
    required bool policeVerified,
    required String? photoPath,
    required String? aadhaarPath,
    required List<Map<String, dynamic>> services,
  }) async {
    try {
      final Map<String, dynamic> formDataMap = {
        'fullName': fullName,
        'phone': phone,
        'alternatePhone': alternatePhone.isEmpty ? null : alternatePhone,
        'email': email.isEmpty ? null : email,
        'maritalStatus': maritalStatus,
        'gender': gender,
        'age': age,
        'current_location_id': currentLocationId,
        'salary': expectedSalary,
        'languages': languages.join(', '),
        'working_hours': workingHours,
        'religion': religion,
        'selectedServices': jsonEncode(services.map((s) => {
          'id': s['id'],
          'name': s['name'],
          'experience': s['experience'],
        }).toList()),
        'preferred_location_ids': jsonEncode(preferredLocationIds),
      };

      if (photoPath != null && photoPath.isNotEmpty) {
        formDataMap['photo'] = await MultipartFile.fromFile(
          photoPath,
          filename: photoPath.split('/').last,
        );
      }

      if (aadhaarPath != null && aadhaarPath.isNotEmpty) {
        formDataMap['aadharCard'] = await MultipartFile.fromFile(
          aadhaarPath,
          filename: aadhaarPath.split('/').last,
        );
      }

      final formData = FormData.fromMap(formDataMap);

      await client.post(
        'https://www.trustedmaid.in/api/maids',
        data: formData,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LocationModel>> searchLocations(String query) async {
    try {
      final response = await client.get(
        'https://www.trustedmaid.in/api/locations',
        queryParameters: {'q': query},
      );
      if (response.data != null && response.data is List) {
        return (response.data as List)
            .map((json) => LocationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MaidServiceModel>> getMaidServices() async {
    // Attempting to mock network response representing the real services
    try {
      await Future.delayed(const Duration(milliseconds: 650));
      return _mockMaidServices;
    } catch (e) {
      rethrow;
    }
  }

  static const List<MaidServiceModel> _mockMaidServices = [
    MaidServiceModel(
      id: '1',
      title: 'House Maid',
      description: 'Verified maids for dusting, floor mopping, utensil cleaning, and complete house cleaning chores.',
      priceDescription: 'Starts at ₹5,000/month',
      imageUrl: 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?q=80&w=600',
      rating: 4.8,
      popularTags: ['Daily Chores', 'Utensils & Mopping', 'Background Verified'],
    ),
    MaidServiceModel(
      id: '2',
      title: 'Cook for Home',
      description: 'Experienced home cooks providing regional, vegetarian, non-vegetarian, and Jain food meal preparations.',
      priceDescription: 'Starts at ₹7,000/month',
      imageUrl: 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?q=80&w=600',
      rating: 4.9,
      popularTags: ['Jain Food Option', 'Hygiene Trained', 'Multi-Cuisine'],
    ),
    MaidServiceModel(
      id: '3',
      title: 'Baby Sitter / Nanny',
      description: 'Dedicated childcare assistants experienced with infants, toddlers, and early-child development support.',
      priceDescription: 'Starts at ₹10,000/month',
      imageUrl: 'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?q=80&w=600',
      rating: 4.7,
      popularTags: ['Infant Playtime', 'Toddler Care', 'Flexible Shifts'],
    ),
    MaidServiceModel(
      id: '4',
      title: 'Patient Care Attendant',
      description: 'Attendants for post-surgery support, stroke recovery, and mobility assistance at home.',
      priceDescription: 'Starts at ₹12,000/month',
      imageUrl: 'https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?q=80&w=600',
      rating: 4.9,
      popularTags: ['Post-Op Attendant', 'Mobility Help', 'Night Attendant'],
    ),
    MaidServiceModel(
      id: '5',
      title: 'Japa Maid',
      description: 'Specialized confinement care maids for newborn massage, mother recovery support, and baby baths.',
      priceDescription: 'Starts at ₹18,000/month',
      imageUrl: 'https://images.unsplash.com/photo-1536640712263-df87d9a191f3?q=80&w=600',
      rating: 4.9,
      popularTags: ['Newborn Massage', 'Mother Recovery', 'Baby Care Specialists'],
    ),
    MaidServiceModel(
      id: '6',
      title: 'Elderly Care',
      description: 'Compassionate assistance and companion support for senior citizens needing medicine tracking and physical help.',
      priceDescription: 'Starts at ₹11,000/month',
      imageUrl: 'https://images.unsplash.com/photo-1576765608622-06b9847240c1?q=80&w=600',
      rating: 4.8,
      popularTags: ['Companion Care', 'Meds Tracking', 'Fall Support'],
    ),
  ];
}
