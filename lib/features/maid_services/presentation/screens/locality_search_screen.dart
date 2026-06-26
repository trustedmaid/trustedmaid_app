import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../resources/app_colors.dart';
import '../../../../utils/extensions.dart';
import '../../domain/entities/location_entity.dart';
import '../bloc/location_search_bloc.dart';
import '../bloc/location_search_event.dart';
import '../bloc/location_search_state.dart';
import 'shift_selection_screen.dart';

/// Screen representing Step 2: Locality Search.
class LocalitySearchScreen extends StatefulWidget {
  final Map<String, dynamic> service;

  const LocalitySearchScreen({super.key, required this.service});

  @override
  State<LocalitySearchScreen> createState() => _LocalitySearchScreenState();
}

class _LocalitySearchScreenState extends State<LocalitySearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  LocationSearchBloc? _locationSearchBloc;

  @override
  void initState() {
    super.initState();
    _locationSearchBloc = sl<LocationSearchBloc>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    _locationSearchBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Locality Search',
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
                      'STEP 02',
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
                    'WHERE DO YOU NEED HELP?',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please search and select your locality. Salary rates will be calculated based on your area:',
                    style: const TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (val) {
                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        _debounce = Timer(const Duration(milliseconds: 400), () {
                          _locationSearchBloc?.add(SearchLocationQueryChanged(val));
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search locality (e.g. Bandra, Thane)',
                        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        suffixIcon: Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey[400],
                          size: 20,
                        ),
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
                      ),
                      style: const TextStyle(fontSize: 14, color: AppColors.secondary, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<LocationSearchBloc, LocationSearchState>(
                    bloc: _locationSearchBloc,
                    builder: (context, state) {
                      if (state is LocationSearchLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(strokeWidth: 2.5, color: AppColors.primary),
                            ),
                          ),
                        );
                      } else if (state is LocationSearchSuccess) {
                        if (state.locations.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                            child: Text(
                              'No localities found',
                              style: TextStyle(color: Colors.grey[500], fontSize: 13),
                            ),
                          );
                        }
                        return Container(
                          constraints: const BoxConstraints(maxHeight: 220),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.line),
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const ClampingScrollPhysics(),
                            itemCount: state.locations.length,
                            separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.line),
                            itemBuilder: (context, index) {
                              final loc = state.locations[index];
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                title: Text(
                                  loc.displayName,
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                leading: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: AppColors.brandSoft,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.location_on_rounded, color: AppColors.primary, size: 16),
                                ),
                                trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 18),
                                dense: true,
                                onTap: () {
                                  _selectLocation(loc);
                                },
                              );
                            },
                          ),
                        );
                      } else if (state is LocationSearchError) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          child: Text(
                            'Failed to load suggestions: ${state.message}',
                            style: const TextStyle(color: AppColors.error, fontSize: 13),
                          ),
                        );
                      }
                      
                      final popularList = [
                        const LocationEntity(id: 1, displayName: 'Bandra, Mumbai'),
                        const LocationEntity(id: 2, displayName: 'Powai, Mumbai'),
                        const LocationEntity(id: 3, displayName: 'Thane, Maharashtra'),
                        const LocationEntity(id: 4, displayName: 'Andheri, Mumbai'),
                        const LocationEntity(id: 5, displayName: 'Juhu, Mumbai'),
                      ];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            child: Text(
                              'Popular Localities',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: popularList.map((pop) {
                              return GestureDetector(
                                onTap: () {
                                  _selectLocation(pop);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
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
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.location_on_outlined, size: 14, color: AppColors.primary),
                                      const SizedBox(width: 6),
                                      Text(
                                        pop.displayName.split(',')[0],
                                        style: const TextStyle(
                                          color: AppColors.secondary,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
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

  void _selectLocation(LocationEntity location) {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: const RouteSettings(name: 'LocalitySearchScreen'),
        builder: (_) => ShiftSelectionScreen(
          service: widget.service,
          selectedLocation: location,
        ),
      ),
    );
  }
}
