import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mboacare/utils/constants.dart';
import 'package:mboacare/widgets/custom_btn.dart';
import 'package:mboacare/widgets/extensions.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import '../dashboard.dart';

import '../hospitaldashboard.dart';
import '../widgets/input_fields.dart';
import 'add_hospital_provider.dart';
import 'components/check_list_item.dart';
import 'components/chips_items.dart';
import 'components/image_upload_view.dart';

class AddHospitalPage extends StatefulWidget {
  const AddHospitalPage({super.key});

  @override
  State<AddHospitalPage> createState() => _AddHospitalPageState();
}

class _AddHospitalPageState extends State<AddHospitalPage> {
  bool? argIsChecked = false;
  String? selectedTitle = "";

  void handleItemSelected(String? title, bool? isChecked) {
    debugPrint("Selected:: Title: $title, isChecked: $isChecked");
    setState(() {});
    selectedTitle = title;
    argIsChecked = isChecked;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddHospitalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.back,
          style: const TextStyle(color: AppColors.greyColor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.greyColor),
          onPressed: () {
            // Navigate back to the dashboard page
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const DashboardScreen(
                        userName: '',
                      )),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.information,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          const Divider(
                            color: AppColors.primaryColor,
                            thickness: 2.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Name *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                    hintText: "Enter name",
                    controller: provider.hospitalNameController,
                    onChanged: (value) {
                      setState(() {
                        provider.setHospitalName(value);
                      });
                    },
                ),

                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Email *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                    hintText: "Enter email",
                    prefixIcon: AppImages.emailIcon,
                    controller: provider.hospitalEmailController,
                    onChanged: (value) {
                      setState(() {
                        provider.setHospitalEmail(value);
                      });
                    },
                ),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Phone number *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                PhoneNumberInput(
                  number: provider.number,
                  hintText: "Enter phone number",
                  controller: provider.hospitalPhoneNumberController,
                  onInputChanged: (number) {
                    setState(() {});
                    debugPrint("onInputChanged: ${number.phoneNumber}");
                  },
                  validator: (value) {
                    setState(() {});
                    debugPrint("validator value: $value");
                    return "";
                  },
                  onInputValidated: (value) {
                    setState(() {});
                    debugPrint("onInputValidated value: $value");
                  },
                  onSubmit: () {
                    setState(() {});
                    debugPrint("onSubmit");
                  },
                  onSaved: (number) {
                    setState(() {});
                    debugPrint("onSaved: $number");
                  },
                ),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Website *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                    hintText: "Enter website",
                    controller: provider.hospitalWebsiteController),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Address *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                  hintText: "Add address",
                  controller: provider.hospitalAddressController,
                  prefixIcon: AppImages.markerPinIcon,
                ),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Medical Services Offered *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                provider.medicalServicesChipItems.isNotEmpty
                ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ChipListView(
                    listItems: provider.medicalServicesChipItems,
                    textController: provider.hospitalMedicalController,
                    onRemoveClicked: () {  }, ),
                ) : const SizedBox.shrink(),
                EditTextForm(
                    hintText: "Add a medical service",
                    controller: provider.hospitalMedicalController,
                    onSubmitted: (text) {
                      if (text.isNotEmpty) {
                        provider.addToMedsChip(text);
                      }
                    },
                ),

                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Facilities Available *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                provider.facilitiesAvailableChipItems.isNotEmpty
                    ? Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ChipListView(
                  listItems: provider.facilitiesAvailableChipItems,
                  textController: provider.hospitalFacilityController,
                  onRemoveClicked: () {  }, ),
                    ) : const SizedBox.shrink(),
                EditTextForm(
                    hintText: "Add facility",
                    controller: provider.hospitalFacilityController,
                    onSubmitted: (text) {
                      debugPrint("onSubmitted: $text");
                      if (text.isNotEmpty) {
                        provider.addToFacilitiesChip(text);
                      }
                      setState(() {});
                    },
                ),

                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Type *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                  hintText: "Select hospital type",
                  controller: provider.hospitalTypeController,
                  readonly: true,
                  onTap: () => hospitalTypeBottomSheet(
                      context,
                    pageTitle: "Hospital Type",
                    listItems: provider.hospitalTypeList,
                    onCloseIconClicked: () {
                      Navigator.pop(context);
                    },
                    onItemClicked: (title, checked) {
                        setState(() {});
                        provider.hospitalTypeController.text = title.toString();
                    }
                  ),
                  suffixIcon: AppImages.arrowDown,
                ),

                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Size *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                  hintText: "Select hospital size",
                  readonly: true,
                  suffixIcon: AppImages.arrowDown,
                  controller: provider.hospitalSizeController,
                    onTap: () => hospitalTypeBottomSheet(
                        context,
                        pageTitle: "Hospital Size",
                        listItems: provider.hospitalSizeList,
                        onCloseIconClicked: () {
                          Navigator.pop(context);
                        },
                        onItemClicked: (title, checked) {
                          setState(() {});
                          provider.hospitalSizeController.text = title.toString();
                        }
                    ),
                ),

                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Ownership *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                  hintText: "Select hospital ownership",
                  readonly: true,
                  suffixIcon: AppImages.arrowDown,
                  controller: provider.hospitalOwnerShipController,
                  onTap: () => hospitalTypeBottomSheet(
                      context,
                      pageTitle: "Hospital Ownership",
                      listItems: provider.hospitalSizeOwnershipList,
                      onCloseIconClicked: () {
                        Navigator.pop(context);
                      },
                      onItemClicked: (title, checked) {
                        setState(() {});
                        provider.hospitalOwnerShipController.text = title.toString();
                      }
                  ),
                ),
                SizedBox(height: AppFontSizes.fontSize20),
                provider.selectedImage != null
                    ? SelectedImageView(
                    selectedImage: provider.selectedImage,
                  onTap: provider.pickImage,
                )
                    : ImageUploadView(
                        onTap: provider.pickImage,
                      ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: context.getWidth() / 3,
                    child: AppButton(
                        onPressed: () {
                          provider.concatenateMedicalServices();
                          provider.concatenateFacilities();
                          provider.concatenateEmergencyService();
                          Future.delayed(const Duration(seconds: 1)).then((_) {
                            provider.submitForm(
                              onSuccessNavigate: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HospitalDashboard(),
                                  ),
                                );
                              }
                            );
                          });
                        },
                        title: 'Submit',
                        enabled: provider.formKey.currentState?.validate() == true),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void hospitalTypeBottomSheet(
      BuildContext context,
      {
        String? pageTitle,
        List<String>? listItems,
        Function()? onCloseIconClicked,
        Function(String?, bool?)? onItemClicked
      }) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CheckItemList(
            pageTitle: pageTitle.toString(),
            listItems: listItems!,
            onCloseIconClicked: onCloseIconClicked!,
            onItemClicked: onItemClicked!,
          );
        });
  }

  void getPhoneNumber(String phoneNumber, PhoneNumber receivedNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      receivedNumber = number;
    });
  }

}

class ChecklistItem {
  String title;
  bool isChecked;

  ChecklistItem({required this.title, required this.isChecked});
}

