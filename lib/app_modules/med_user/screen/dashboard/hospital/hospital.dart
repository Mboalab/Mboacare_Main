import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mboacare/app_modules/med_user/screen/inner_screen/hospitaldetails.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/model/hospital_model/hospital_model.dart';
import 'package:mboacare/model/search_hospital_model.dart';
import 'package:mboacare/services/appService.dart';
import 'package:mboacare/utils/app_dropdown.dart';
import 'package:mboacare/widgets/chip_widget.dart';
//import 'package:mboacare/app_modules/user/screens/inner_screen/hospitaldetails.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as devtools show log;

class HospitalDashboard extends StatefulWidget {
  const HospitalDashboard({super.key});

  @override
  State<HospitalDashboard> createState() => _HospitalDashboardState();
}

class _HospitalDashboardState extends State<HospitalDashboard> {
  // List<SearchHospitalModel> searchResults = [];
  List<SearchHospitalModel> filteredHospitals = [];

  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'View All'; // Initialize with 'View All'
  String dropdownValue = dropdownItems.first; // Initialize with 'View All'

  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController dropdownController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _searchForHospitals(String name, String location) async {
    final hospitals = await ApiServices().searchHospital();

    setState(() {
      filteredHospitals = hospitals
          .where((hospital) =>
              hospital.name?.toLowerCase().contains(name.toLowerCase()) ==
                  true ||
              hospital.placeAddress
                      ?.toLowerCase()
                      .contains(location.toLowerCase()) ==
                  true)
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    ApiServices().fetchAllHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Unfocus the search field when tapping outside
          _searchFocusNode.unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
              leading: Image.asset(
                ImageAssets.logo,
              ),
              backgroundColor: AppColors.navbarColor,
              titleSpacing: 0,
              title: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 50, // Set the height of the search bar
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onTap: () {
                      _searchFocusNode.requestFocus();
                    },
                    onChanged: (value) {
                      //print('Search text changed: $value');
                      _searchForHospitals(value, _selectedFilter);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite,
                      labelText: 'Search Hospitals',
                      // labelStyle: const TextStyle(color: AppColors.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: AppColors.navbarColor,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                          width: 1.0,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: iconSize,
                        color: AppColors.primaryColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: RefreshIndicator(
                backgroundColor: Colors.white,
                onRefresh: _refreshData,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Connecting Hospitals Globally',
                                  style: AppTextStyles.headerTwo.copyWith(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Effortlessly Access a Network of Hospitals Worldwide',
                            style: AppTextStyles.bodyOne.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryTextColor,
                              fontFamily:
                                  'Inter', // Replace with the appropriate font family
                            ),
                            // textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.0),

                          // Filter Tabs
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildFilterTab('View All'),
                                _buildFilterTab('Surgery'),
                                _buildFilterTab('Paediatrics'),
                                _buildFilterTab('Internal Medicine'),
                                _buildFilterTab('Obstetrics & Gynaecology'),
                                _buildFilterTab('Cardiology'),
                                _buildFilterTab('Oncology'),
                                _buildFilterTab('Neurology'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          // Hospital filter dropdown menu
                          DropdownMenu<String>(
                              controller: dropdownController,
                              inputDecorationTheme: const InputDecorationTheme(
                                filled: true,
                                fillColor: AppColors.navbarColor,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              enableFilter: true,
                              menuStyle: const MenuStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        AppColors.navbarColor),
                              ),
                              label: const Text('Filter'),
                              leadingIcon:
                                  const Icon(Icons.filter_list_outlined),
                              trailingIcon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              selectedTrailingIcon:
                                  const Icon(Icons.keyboard_arrow_up_outlined),
                              onSelected: (String? newValue) {
                                // setState(() {
                                //   dropdownValue = newValue!;
                                //   hospitalProvider.setSelectedFilter(dropdownValue);
                                //   Future.delayed(const Duration(milliseconds: 500))
                                //       .then((_) {
                                //     hospitalProvider.updateFilteredHospitalsDropdown;
                                //     hospitalProvider.filterHospitals(_selectedFilter);
                                //   });
                                // });
                              },
                              dropdownMenuEntries: dropdownItems
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                  value: value,
                                  label: value,
                                );
                              }).toList()),
                          SizedBox(height: 16.0),

                          // Hospitals list
                          Expanded(
                            child: filteredHospitals.isEmpty
                                ? _buildAllHospitals()
                                : _buildFilteredHospitals(),
                          )
                        ])))));
  }

  Widget _buildFilterTab(String filterOption) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filterOption;
          // hospitalProvider.setSelectedFilter(filterOption);
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            // hospitalProvider.updateFilteredHospitals;
          });
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          filterOption,
          style: AppTextStyles.bodyOne.copyWith(
            fontSize: 16,
            color: _selectedFilter == filterOption
                ? AppColors.primaryColor
                : Colors.black26,
            fontWeight: _selectedFilter == filterOption
                ? FontWeight.w600
                : FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildAllHospitals() {
    return FutureBuilder<List<HospitalModel>>(
        future: ApiServices().fetchAllHospitals(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: SpinKitWaveSpinner(
                size: 50.0,
                color: AppColors.buttonColor,
                trackColor: AppColors.registerCard,
                waveColor: AppColors.deleteColor,
              ),
            );
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final hospitalData = snapshot.data;
          return ListView.builder(
            itemCount: hospitalData!.length,
            itemBuilder: (context, index) {
              final hospital = hospitalData[index];

              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 5.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: const BorderSide(
                    width: 0.1,
                    color: AppColors.primaryColor,
                  ),
                ),
                color: Colors.white,
                shadowColor: AppColors.primaryColor,
                surfaceTintColor: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Hospital Image
                    SizedBox(
                      height: 250.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image(
                                image: NetworkImage(hospital.hospitalImage!),
                              )),
                          Positioned(
                            right: 2,
                            top: 2,
                            child: IconButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                  const Size(2.0, 10.0),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                side: MaterialStateProperty.all(
                                  const BorderSide(
                                    width: 2.0,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              onPressed: null,
                              icon: const Icon(
                                Icons.star_border_rounded,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),

                    // Display Hospital Name with Right Arrow Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Text(
                            hospital.name!.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HospitalDetailsPage(
                                    hospital: hospital,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              size: 20.0,
                              Icons.arrow_forward,
                              color: AppColors.greenColor,
                            ),
                            // style: ButtonStyle(
                            //   backgroundColor: MaterialStateProperty.all(
                            //       AppColors.buttonColor),
                            //   fixedSize: MaterialStateProperty.all(
                            //     const Size(2.0, 10.0),
                            //   ),
                            //   shape: MaterialStateProperty.all<
                            //       RoundedRectangleBorder>(
                            //     RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // Display Hospital Address
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Text(
                        hospital.placeAddress!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.textColor2,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8.0),
                    // Display Hospital Specialities as Colorful Boxes
                    hospital.serviceType == ''
                        ? Padding(
                            padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
                            child: Text(
                              'This facility has no specialties',
                              style: AppTextStyles.bodyTwo.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                                fontFamily: 'Inter',
                              ),
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: Wrap(
                              spacing: 5.0,
                              runSpacing: 5.0,
                              children: (hospital.serviceType ?? [])
                                  .map(
                                    (speciality) => ChipWidget(speciality),
                                  )
                                  .toList(),
                            ),
                          ),
                    // ... Add any other hospital information here ...
                  ],
                ),
              );
            },
          );
        });
  }

  Widget _buildFilteredHospitals() {
    return ListView.builder(
      itemCount: filteredHospitals.length,
      itemBuilder: (context, index) {
        final hospital = filteredHospitals[index];
        return Card(
          elevation: 5.0,
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 5.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(
              width: 0.1,
              color: AppColors.primaryColor,
            ),
          ),
          color: Colors.white,
          shadowColor: AppColors.primaryColor,
          surfaceTintColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hospital Image
              SizedBox(
                height: 250.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image(
                          image: NetworkImage(hospital.hospitalImage!),
                        )
                        // hospital
                        //             .hospitalImage ==
                        //         ''
                        //     ? Image(
                        //         image: NetworkImage(
                        //             hospital
                        //                 .hospitalImage!),
                        //         fit: BoxFit.cover,
                        //       )
                        //     : Image(
                        //         image: AssetImage(
                        //             ImageAssets
                        //                 .myHospital),
                        //         fit: BoxFit.cover,
                        //       ),
                        ),
                    Positioned(
                      right: 2,
                      top: 2,
                      child: IconButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(2.0, 10.0),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                              width: 2.0,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        onPressed: null,
                        icon: const Icon(
                          Icons.star_border_rounded,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),

              // Display Hospital Name with Right Arrow Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(
                      hospital.name!.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor2,
                      ),
                    ),
                  ),
                  //   IconButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (_) =>
                  //               HospitalDetailsPage(
                  //             hospital: hospital,
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     icon: const Icon(
                  //       size: 60.0,
                  //       Icons.arrow_forward,
                  //       color: Colors.white,
                  //     ),
                  //     style: ButtonStyle(
                  //       backgroundColor:
                  //           MaterialStateProperty
                  //               .all(AppColors
                  //                   .buttonColor),
                  //       fixedSize:
                  //           MaterialStateProperty
                  //               .all(
                  //         const Size(2.0, 10.0),
                  //       ),
                  //       shape: MaterialStateProperty
                  //           .all<
                  //               RoundedRectangleBorder>(
                  //         RoundedRectangleBorder(
                  //           borderRadius:
                  //               BorderRadius
                  //                   .circular(10),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
              const SizedBox(height: 8.0),
              // Display Hospital Address
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  hospital.placeAddress!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textColor2,
                  ),
                ),
              ),

              const SizedBox(height: 8.0),
              // Display Hospital Specialities as Colorful Boxes
              hospital.serviceType == ''
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                      child: Text(
                        'This facility has no specialties',
                        style: AppTextStyles.bodyTwo.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                          fontFamily: 'Inter',
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: (hospital.serviceType ?? [])
                            .map(
                              (speciality) => ChipWidget(speciality),
                            )
                            .toList(),
                      ),
                    ),
              // ... Add any other hospital information here ...
            ],
          ),
        );
      },
    );
  }
}
