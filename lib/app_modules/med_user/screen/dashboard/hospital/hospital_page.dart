import 'package:flutter/material.dart';
import 'package:mboacare/app_modules/user/screens/inner_screen/hospitaldetails.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/model/hospital_model.dart';
import 'package:mboacare/services/hospital_provider.dart';
import 'package:mboacare/utils/app_dropdown.dart';
import 'package:mboacare/widgets/chip_widget.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as devtools show log;

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'View All'; // Initialize with 'View All'
  String dropdownValue = dropdownItems.first; // Initialize with 'View All'
  late List<HospitalData> filteredHospitals;
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController dropdownController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    //final hospitalProvider = Provider.of<HospitalProvider>(context);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      //hospitalProvider.getHospitalsStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hospitalProvider = Provider.of<HospitalProvider>(context);

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
                focusNode: _searchFocusNode, // Add this line
                onTap: () {
                  _searchFocusNode.requestFocus(); // Add this line
                },
                onChanged: (query) {
                  devtools.log('Search query: $query');
                  hospitalProvider.filterHospitals(query);
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {},
          tooltip: 'Add Hospital',
          child: const Icon(
            Icons.add,
            size: 40.0,
            color: Colors.white,
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
                  // textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Connecting Hospitals Globally',
                        style: AppTextStyles.headerTwo.copyWith(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontFamily:
                              'Inter', // Replace with the appropriate font family
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
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
                const SizedBox(height: 16.0),

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
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    enableFilter: true,
                    menuStyle: const MenuStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          AppColors.navbarColor),
                    ),
                    label: const Text('Filter'),
                    leadingIcon: const Icon(Icons.filter_list_outlined),
                    trailingIcon:
                        const Icon(Icons.keyboard_arrow_down_outlined),
                    selectedTrailingIcon:
                        const Icon(Icons.keyboard_arrow_up_outlined),
                    onSelected: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        hospitalProvider.setSelectedFilter(dropdownValue);
                        Future.delayed(const Duration(milliseconds: 500))
                            .then((_) {
                          hospitalProvider.updateFilteredHospitalsDropdown(
                              filteredHospitals);
                          //hospitalProvider.filterHospitals(_selectedFilter);
                        });
                      });
                    },
                    dropdownMenuEntries: dropdownItems
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                      );
                    }).toList()),
                const SizedBox(height: 16.0),

                // Hospitals list
                Expanded(
                  child: StreamBuilder<List<HospitalData>>(
                    stream: hospitalProvider.getHospitalsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // Apply filtering based on selected filter tab and search query
                        filteredHospitals = hospitalProvider.applyFilters(
                          snapshot.data!,
                          _searchController.text,
                          _selectedFilter,
                        );

                        // Update the _filteredHospitals list with the latest data
                        //hospitalProvider.updateFilteredHospitals(filteredHospitals);

                        return ListView.builder(
                          itemCount: hospitalProvider.filteredHospitals.length,
                          itemBuilder: (context, index) {
                            // var hospital = hospitalProvider.hospitals[index];
                            // devtools.log(hospital.hospitalImageUrl);
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: hospitalProvider
                                                      .filteredHospitals[index]
                                                      .hospitalImageUrl !=
                                                  ''
                                              ? Image(
                                                  image: NetworkImage(
                                                      hospitalProvider
                                                          .filteredHospitals[
                                                              index]
                                                          .hospitalImageUrl),
                                                  fit: BoxFit.cover,
                                                )
                                              : Image(
                                                  image: AssetImage(
                                                      ImageAssets.myHospital),
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Positioned(
                                          right: 2,
                                          top: 2,
                                          child: IconButton(
                                            style: ButtonStyle(
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                const Size(2.0, 10.0),
                                              ),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14.0),
                                        child: Text(
                                          hospitalProvider
                                              .filteredHospitals[index]
                                              .hospitalName,
                                          // .toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textColor2,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  HospitalDetailsPage(
                                                hospital: hospitalProvider
                                                    .filteredHospitals[index],
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          size: 20.0,
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.buttonColor),
                                          fixedSize: MaterialStateProperty.all(
                                            const Size(2.0, 10.0),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  // Display Hospital Address
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Text(
                                      hospitalProvider.filteredHospitals[index]
                                          .hospitalAddress,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.textColor2,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 8.0),
                                  // Display Hospital Specialities as Colorful Boxes
                                  hospitalProvider.filteredHospitals[index]
                                              .hospitalSpecialities ==
                                          ''
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: 12.0, bottom: 8.0),
                                          child: Text(
                                            'This facility has no specialties',
                                            style:
                                                AppTextStyles.bodyTwo.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, bottom: 8.0),
                                          child: Wrap(
                                            spacing: 5.0,
                                            runSpacing: 5.0,
                                            children: hospitalProvider
                                                .filteredHospitals[index]
                                                .hospitalSpecialities
                                                .split(',')
                                                .map(
                                                  (speciality) =>
                                                      ChipWidget(speciality),
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
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTab(String filterOption) {
    final hospitalProvider = Provider.of<HospitalProvider>(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filterOption;
          hospitalProvider.setSelectedFilter(filterOption);
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            hospitalProvider.updateFilteredHospitals(filteredHospitals);
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
}
