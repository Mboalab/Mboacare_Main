import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/search_address.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/utils/constants.dart';
import 'package:mboacare/widgets/custom_btn.dart';
import 'package:mboacare/widgets/extensions.dart';
import 'package:provider/provider.dart';
import '../../../../user/user_dashboard.dart';
import '../../../../../global/styles/colors.dart';

import '../../../../user/screens/dashboard/hospital.dart';
import '../../../../../widgets/input_fields.dart';
import '../../../../../services/hospital_provider/add_hospital_provider.dart';
import '../../../../../widgets/check_list_item.dart';
import '../../../../../widgets/chips_items.dart';
import '../../../../../widgets/image_upload_view.dart';

class AddHospitalPage extends StatefulWidget {
  AddHospitalPage(
      {super.key,
      required this.placeName,
      required this.lat,
      required this.lng});
  String placeName;
  double lat;
  double lng;
  @override
  State<AddHospitalPage> createState() => _AddHospitalPageState();
}

class _AddHospitalPageState extends State<AddHospitalPage> {
  bool? argIsChecked = false;
  String? selectedTitle = "";
  bool isAddressAvailable = false;

  void handleItemSelected(String? title, bool? isChecked) {
    debugPrint("Selected:: Title: $title, isChecked: $isChecked");
    selectedTitle = title;
    argIsChecked = isChecked;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddHospitalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.navbarColor,
        title: Text(
          AppStrings.back,
          style: const TextStyle(color: AppColors.greyColor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.greyColor),
          onPressed: () {
            // Navigate back to the dashboard page
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            // key: provider.formKey,
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
                  prefixIcon: ImageAssets.emailIcon,
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
                GestureDetector(
                  onTap: () {
                    Get.to(() => SearchAddress());
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Image.asset(ImageAssets.makerIcon,
                            width: 22.0, height: 22.0),
                        Text(
                          isAddressAvailable ? "Add address" : widget.placeName,
                          style: GoogleFonts.inter(
                              color: AppColors.hintTextColor,
                              fontSize: AppFontSizes.fontSize16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
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
                          onRemoveClicked: () {},
                        ),
                      )
                    : const SizedBox.shrink(),
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
                          onRemoveClicked: () {},
                        ),
                      )
                    : const SizedBox.shrink(),
                EditTextForm(
                  hintText: "Add facility",
                  controller: provider.hospitalFacilityController,
                  onSubmitted: (text) {
                    debugPrint("onSubmitted: $text");
                    if (text.isNotEmpty) {
                      setState(() {
                        provider.addToFacilitiesChip(text);
                        print(text);
                      });
                    }
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
                  onTap: () => hospitalTypeBottomSheet(context,
                      pageTitle: "Hospital Type",
                      listItems: provider.hospitalTypeList,
                      onCloseIconClicked: () {
                    Navigator.pop(context);
                  }, onItemClicked: (title, checked) {
                    setState(() {});
                    provider.hospitalTypeController.text = title.toString();
                    print(title);
                  }),
                  suffixIcon: ImageAssets.arrowIcon,
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
                  suffixIcon: ImageAssets.arrowIcon,
                  controller: provider.hospitalSizeController,
                  onTap: () => hospitalTypeBottomSheet(context,
                      pageTitle: "Hospital Size",
                      listItems: provider.hospitalSizeList,
                      onCloseIconClicked: () {
                    Navigator.pop(context);
                  }, onItemClicked: (title, checked) {
                    setState(() {});
                    provider.hospitalSizeController.text = title.toString();
                    print(title);
                  }),
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
                  suffixIcon: ImageAssets.arrowIcon,
                  controller: provider.hospitalOwnerShipController,
                  onTap: () => hospitalTypeBottomSheet(context,
                      pageTitle: "Hospital Ownership",
                      listItems: provider.hospitalSizeOwnershipList,
                      onCloseIconClicked: () {
                    Navigator.pop(context);
                  }, onItemClicked: (title, checked) {
                    setState(() {});
                    provider.hospitalOwnerShipController.text =
                        title.toString();
                  }),
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
                    child: Consumer<AddHospitalProvider>(
                        builder: (context, hospital, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (hospital.reqMessage != '') {
                          hospital.clear();
                        }
                      });
                      return AppButton(
                          status: hospital.isLoading,
                          onPressed: () {
                            // if (provider.formKey.currentState!.validate()) {
                            String hospitalLat = widget.lat.toString();
                            String hospitalLng = widget.lng.toString();
                            String hospitalAddress = widget.placeName;
                            String hospitalName =
                                provider.hospitalNameController.text.trim();
                            String hospitalWeblink =
                                provider.hospitalWebsiteController.text;
                            String hospitalEmail =
                                provider.hospitalEmailController.text.trim();
                            String hospitalPhone =
                                provider.hospitalPhoneNumberController.text;
                            String hospitalOwner =
                                provider.hospitalOwnerShipController.text;
                            String hospitalSize =
                                provider.hospitalSizeController.text;
                            String hospitalMedicalServices =
                                provider.hospitalServices.toString();
                            String hospitalFacilities =
                                provider.hospitalFacilities.toString();
                            String hospitalType =
                                provider.hospitalTypeController.text;
                            hospital.addHospital(
                                hospitalName,
                                hospitalWeblink,
                                hospitalEmail,
                                hospitalType,
                                hospitalOwner,
                                hospitalSize,
                                hospitalMedicalServices,
                                hospitalFacilities,
                                hospitalAddress,
                                hospitalLat,
                                hospitalLng,
                                hospitalPhone,
                                provider.selectedImage,
                                context);
                          },
                          title: 'Submit',
                          enabled: true);
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void hospitalTypeBottomSheet(BuildContext context,
      {String? pageTitle,
      List<String>? listItems,
      Function()? onCloseIconClicked,
      Function(String?, bool?)? onItemClicked}) {
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
