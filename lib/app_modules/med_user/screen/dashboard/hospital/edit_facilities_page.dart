import 'dart:developer';

// ignore_for_file: unused_element, unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/edit_search.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/manageFacilities.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/search_address.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/global/styles/colors.dart';
//import 'package:mboacare/model/placemodel/facilities_model.dart';
import 'package:mboacare/services/facilities_provider.dart';
import 'package:mboacare/services/hospital_provider/delete_hospitalProvider.dart';
import 'package:mboacare/services/hospital_provider/edit_hospitalProvider.dart';
import 'package:mboacare/utils/constants.dart';
import 'package:mboacare/widgets/check_list_item.dart';
import 'package:mboacare/widgets/chips_items.dart';
import 'package:mboacare/widgets/custom_btn.dart';
import 'package:mboacare/widgets/extensions.dart';
import 'package:mboacare/widgets/image_upload_view.dart';
import 'package:mboacare/widgets/input_fields.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/custom_textfield.dart';

class EditFacilitiesPage extends StatefulWidget {
  // final FacilitiesModel facilitiesModel;
  const EditFacilitiesPage(
      {super.key,
      this.email,
      this.hospitalAddress,
      this.id,
      this.hospitalFacilities,
      this.hospitalOwner,
      this.hospitalServices,
      this.hospitalSize,
      this.hospitalType,
      this.image,
      this.name,
      this.phone,
      this.website,
      this.lat,
      this.lng});

  final String? id,
      name,
      email,
      phone,
      hospitalType,
      hospitalOwner,
      hospitalAddress,
      hospitalSize,
      hospitalServices,
      hospitalFacilities,
      website,
      lat,
      lng,
      image;

  @override
  State<EditFacilitiesPage> createState() => _EditFacilitiesPageState();
}

class _EditFacilitiesPageState extends State<EditFacilitiesPage> {
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
    final provider = Provider.of<EditHospitalProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        titleSpacing: 0.0,
        title: Text(
          widget.name.toString(),
          style: GoogleFonts.inter(
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const ManageFacilities());
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 25.0,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _showDialog(context);
              },
              icon: const Icon(
                Icons.delete_outline_outlined,
                color: Color.fromARGB(255, 225, 82, 82),
              ))
        ],
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
                  hintText: widget.name.toString(),
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
                  hintText: widget.email.toString(),
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
                  hintText: widget.phone,
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
                    hintText: widget.website.toString(),
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
                    Get.to(() => EditSearch());
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
                          isAddressAvailable
                              ? "Add address"
                              : widget.hospitalAddress.toString(),
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
                  hintText: widget.hospitalServices.toString(),
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
                  hintText: widget.hospitalFacilities.toString(),
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
                  hintText: widget.hospitalType.toString(),
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
                  hintText: widget.hospitalSize.toString(),
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
                  hintText: widget.hospitalOwner.toString(),
                  readonly: true,
                  suffixIcon: ImageAssets.arrowIcon,
                  controller: provider.hospitalOwnerShipController,
                  onTap: () => hospitalTypeBottomSheet(context,
                      pageTitle: 'Hospital Owner',
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
                    child: Consumer<EditHospitalProvider>(
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
                            String hospitalAddress =
                                widget.hospitalAddress.toString();
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
                            String id = widget.id.toString();

                            hospital.editHospital(
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
                                id,
                                provider.selectedImage,
                                context);
                          },
                          title: 'Update',
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

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 40),
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 50),
          title: const Text(
            textAlign: TextAlign.center,
            "Delete Hospital",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: const Text(
            textAlign: TextAlign.center,
            "Are you sure you want to delete Hospital?",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Consumer<DeleteHospitalProvider>(
                      builder: (context, hospital, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (hospital.reqMessage != '') {}
                      hospital.clear();
                    });
                    return hospital.isLoading
                        ? const SpinKitThreeBounce(
                            color: AppColors.cardbg,
                          )
                        : TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(AppColors.cardbg),
                            ),
                            onPressed: () {
                              print(widget.id);
                              hospital.deleteHospital(
                                  hospitalId: widget.id.toString(),
                                  context: context);
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ));
                  }),
                ],
              ),
            ),
          ],
        );
      },
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
