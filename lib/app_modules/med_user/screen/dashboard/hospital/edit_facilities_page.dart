
// import 'dart:developer';

// // ignore_for_file: unused_element, unused_field


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mboacare/global/styles/colors.dart';
// //import 'package:mboacare/model/placemodel/facilities_model.dart';
// import 'package:mboacare/services/facilities_provider.dart';
// import 'package:provider/provider.dart';

// import '../../../../../widgets/custom_textfield.dart';

// class EditFacilitiesPage extends StatefulWidget {
//   final FacilitiesModel facilitiesModel;
//   const EditFacilitiesPage({super.key, required this.facilitiesModel});

//   @override
//   State<EditFacilitiesPage> createState() => _EditFacilitiesPageState();
// }

// class _EditFacilitiesPageState extends State<EditFacilitiesPage> {
  
//   String selectedType = 'Public';
//   List<String> type = [
//     'Public',
//     'Private',
//     'Other',
//   ];
//   String selectedSize = 'Medium';
//   List<String> size = [
//     'Small',
//     'Medium',
//     'Large',
//   ];
//   String selectedOwnership = 'Government';
//   List<String> ownership = [
//     'Individual',
//     'Corporate',
//     'Government',
//   ];

//   bool isSize = false;
//   bool isType = false;
//   bool isOwnership = false;
//   int selectedIndex = 0;
//   final ImagePicker _imagePicker = ImagePicker();
//   File? _selectedImage;
//   List<String> facilitiesTags = [];
//   List<String> medicalTags = [];
//   Future<void> _pickImage() async {
//     final pickedImage =
//         await _imagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedImage != null) {
//         _selectedImage = File(pickedImage.path);
//       }
//     });
//   }

//   final formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _phoneNoController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _websiteController = TextEditingController();
//   final _addressController = TextEditingController();
//   TextEditingController medicalTagsController = TextEditingController();
//   TextEditingController facilitiesTagsController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//    // final facilitiesProvider = Provider.of<FacilitiesProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//             )),
//         title: const Text(
//           'Edit facility',
//           style: TextStyle(
//               fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.grey),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 20),
//             child: InkWell(
//                 onTap: () {
//                   deleteDialog(context);
//                 },
//                 child: SvgPicture.asset('lib/assests/icons/delete.svg')),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               const Text(
//                 'Hospital Information',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.buttonColor),
//               ),
//               const Divider(
//                 color: AppColors.buttonColor,
//                 thickness: 2.5,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Hospital name *',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.grey),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               CustomTextField(
//                 hintText: widget.facilitiesModel.name ?? '',
//                 controller: _nameController,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Hospital Email',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.grey),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               CustomTextField(
//                 hintText: widget.facilitiesModel.email ?? '',
//                 controller: _emailController,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Phone Number *',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.grey),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               CustomTextField(
//                 hintText: widget.facilitiesModel.phoneNumber ?? '',
//                 controller: _phoneNoController,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Hospital Website *',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.grey),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               CustomTextField(
//                 hintText: widget.facilitiesModel.website ?? '',
//                 controller: _websiteController,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Hospital Address *',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.grey),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               CustomTextField(
//                 controller: _addressController,
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(17.0),
//                   child: SvgPicture.asset(
//                     'lib/assests/icons/location.svg',
//                   ),
//                 ),
//                 hintText: '5447, Park Lane, London, UK',
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text('Medical Services Offered'),
//               widget.facilitiesModel.facilitiesType != null
//                   ? GridView.builder(
//                       shrinkWrap: true,
//                       padding: const EdgeInsets.all(10),
//                       itemCount: widget.facilitiesModel.facilitiesType?.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         mainAxisExtent: 45,
//                       ),
//                       itemBuilder: (context, index) {
//                         print(widget.facilitiesModel.facilitiesType?.length);
//                         return Chip(
//                           backgroundColor: Colors.white,
//                           label: Text(
//                             widget.facilitiesModel.facilitiesType![index],
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 17),
//                           ),
//                           deleteIconColor: Colors.black,
//                           padding: const EdgeInsets.all(0),
//                           onDeleted: () {
//                             setState(() {
//                               widget.facilitiesModel.facilitiesType?.remove(
//                                   widget
//                                       .facilitiesModel.facilitiesType?[index]);
//                             });
//                           },
//                         );
//                       },
//                     )
//                   : const SizedBox(),
//               medicalTags.isNotEmpty
//                   ? GridView.builder(
//                       shrinkWrap: true,
//                       padding: const EdgeInsets.all(10),
//                       itemCount: medicalTags.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         mainAxisExtent: 45,
//                       ),
//                       itemBuilder: (context, index) => Chip(
//                         backgroundColor: Colors.white,
//                         label: Text(
//                           medicalTags[index],
//                           style: const TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 17),
//                         ),
//                         deleteIconColor: Colors.black,
//                         padding: const EdgeInsets.all(0),
//                         onDeleted: () {
//                           setState(() {
//                             medicalTags.remove(medicalTags[index]);
//                           });
//                         },
//                       ),
//                     )
//                   : const SizedBox.shrink(),
//               TextFormField(
//                 controller: medicalTagsController,
//                 cursorColor: Colors.teal,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide:
//                         const BorderSide(color: AppColors.grey300, width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide:
//                         const BorderSide(color: AppColors.grey300, width: 1.5),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide:
//                         const BorderSide(color: AppColors.grey300, width: 1.5),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//                   hintText: 'Add a medical service',
//                 ),
//                 onFieldSubmitted: (_) {
//                   setState(() {
//                     medicalTags.add(medicalTagsController.text);

//                     medicalTagsController.text = '';
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Facilities available',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.grey),
//               ),
//               widget.facilitiesModel.serviceType != null
//                   ? GridView.builder(
//                       shrinkWrap: true,
//                       padding: const EdgeInsets.all(10),
//                       itemCount: widget.facilitiesModel.serviceType?.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         mainAxisExtent: 45,
//                       ),
//                       itemBuilder: (context, index) {
//                         print(widget.facilitiesModel.serviceType?.length);
//                         return Chip(
//                           backgroundColor: Colors.white,
//                           label: Text(
//                             widget.facilitiesModel.serviceType![index],
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 17),
//                           ),
//                           deleteIconColor: Colors.black,
//                           padding: const EdgeInsets.all(0),
//                           onDeleted: () {
//                             setState(() {
//                               widget.facilitiesModel.serviceType?.remove(
//                                   widget.facilitiesModel.serviceType?[index]);
//                             });
//                           },
//                         );
//                       },
//                     )
//                   : const SizedBox(),
//               facilitiesTags.isNotEmpty
//                   ? GridView.builder(
//                       shrinkWrap: true,
//                       padding: const EdgeInsets.all(10),
//                       itemCount: facilitiesTags.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         mainAxisExtent: 45,
//                       ),
//                       itemBuilder: (context, index) => Chip(
//                         backgroundColor: Colors.white,
//                         label: Text(
//                           facilitiesTags[index],
//                           style: const TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 17),
//                         ),
//                         deleteIconColor: Colors.black,
//                         padding: const EdgeInsets.all(0),
//                         onDeleted: () {
//                           setState(() {
//                             facilitiesTags.remove(facilitiesTags[index]);
//                           });
//                         },
//                       ),
//                     )
//                   : const SizedBox.shrink(),
//               TextFormField(
//                 controller: facilitiesTagsController,
//                 cursorColor: Colors.teal,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide:
//                         const BorderSide(color: AppColors.grey300, width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide:
//                         const BorderSide(color: AppColors.grey300, width: 1.5),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide:
//                         const BorderSide(color: AppColors.grey300, width: 1.5),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//                   hintText: 'Add a facility',
//                 ),
//                 onFieldSubmitted: (_) {
//                   setState(() {
//                     facilitiesTags.add(facilitiesTagsController.text);

//                     facilitiesTagsController.text = '';
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Hospital Type',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.grey),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   isType = !isType;
//                   setState(() {});
//                 },
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: AppColors.whiteColor,
//                       border: Border.all(color: AppColors.grey300, width: 1.5),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             selectedType,
//                             style: const TextStyle(
//                                 color: AppColors.grey200,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           const Icon(
//                             Icons.keyboard_arrow_down,
//                             color: AppColors.grey,
//                           )
//                         ]),
//                   ),
//                 ),
//               ),
//               if (isType)
//                 Card(
//                   elevation: 0.2,
//                   child: SizedBox(
//                     height: 200,
//                     width: double.infinity,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 10),
//                           child: Text(
//                             'Select Hospital Type',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         const Divider(
//                           color: AppColors.grey,
//                         ),
//                         ListView.builder(
//                           primary: true,
//                           shrinkWrap: true,
//                           itemCount: type.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               color: selectedIndex == index
//                                   ? AppColors.grey100
//                                   : Colors.transparent,
//                               child: InkWell(
//                                   onTap: () {
//                                     selectedType = type[index];
//                                     selectedIndex = index;
//                                     isType = false;
//                                     setState(() {});
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10),
//                                     child: Row(
//                                       children: [
//                                         selectedIndex == index
//                                             ? SvgPicture.asset(
//                                                 'lib/assests/icons/check.svg')
//                                             : SvgPicture.asset(
//                                                 'lib/assests/icons/uncheck.svg'),
//                                         const SizedBox(
//                                           width: 10,
//                                         ),
//                                         Text(
//                                           type[index],
//                                           style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Hospital Size',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.grey),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   isSize = !isSize;
//                   setState(() {});
//                 },
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: AppColors.whiteColor,
//                       border: Border.all(color: AppColors.grey300, width: 1.5),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
                            
//                                selectedSize, 
//                             style: const TextStyle(
//                                 color: AppColors.grey200,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           const Icon(
//                             Icons.keyboard_arrow_down,
//                             color: AppColors.grey,
//                           )
//                         ]),
//                   ),
//                 ),
//               ),
//               if (isSize)
//                 Card(
//                   elevation: 0.2,
//                   child: SizedBox(
//                     height: 200,
//                     width: double.infinity,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 10),
//                           child: Text(
//                             'Select hospital Size',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         const Divider(
//                           color: AppColors.grey,
//                         ),
//                         ListView.builder(
//                           primary: true,
//                           shrinkWrap: true,
//                           itemCount: size.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               color: selectedIndex == index
//                                   ? AppColors.grey100
//                                   : Colors.transparent,
//                               child: InkWell(
//                                   onTap: () {
//                                     isSize = false;
//                                     selectedSize = type[index];
//                                     selectedIndex = index;
//                                     setState(() {});
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10),
//                                     child: Row(
//                                       children: [
//                                         selectedIndex == index
//                                             ? SvgPicture.asset(
//                                                 'lib/assests/icons/check.svg')
//                                             : SvgPicture.asset(
//                                                 'lib/assests/icons/uncheck.svg'),
//                                         const SizedBox(
//                                           width: 10,
//                                         ),
//                                         Text(
//                                           size[index],
//                                           style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Hospital Ownership',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.grey),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   isOwnership = !isOwnership;
//                   setState(() {});
//                 },
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: AppColors.whiteColor,
//                       border: Border.all(color: AppColors.grey300, width: 1.5),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             selectedOwnership,
//                             style: const TextStyle(
//                                 color: AppColors.grey200,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           const Icon(
//                             Icons.keyboard_arrow_down,
//                             color: AppColors.grey,
//                           )
//                         ]),
//                   ),
//                 ),
//               ),
//               if (isOwnership)
//                 Card(
//                   elevation: 0.2,
//                   child: SizedBox(
//                     height: 230,
//                     width: double.infinity,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 10),
//                           child: Text(
//                             'Select hospital ownership',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         const Divider(
//                           color: AppColors.grey,
//                         ),
//                         ListView.builder(
//                           primary: true,
//                           shrinkWrap: true,
//                           itemCount: ownership.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               color: selectedIndex == index
//                                   ? AppColors.grey100
//                                   : Colors.transparent,
//                               child: InkWell(
//                                   onTap: () {
//                                     isOwnership = false;
//                                     selectedOwnership = ownership[index];
//                                     selectedIndex = index;
//                                     setState(() {});
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10),
//                                     child: Row(
//                                       children: [
//                                         selectedIndex == index
//                                             ? SvgPicture.asset(
//                                                 'lib/assests/icons/check.svg')
//                                             : SvgPicture.asset(
//                                                 'lib/assests/icons/uncheck.svg'),
//                                         const SizedBox(
//                                           width: 10,
//                                         ),
//                                         Text(
//                                           ownership[index],
//                                           style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Stack(
//                 children: [
//                   Container(
//                       height: 150,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           // image: DecorationImage(
//                           //     fit: BoxFit.cover,

//                           //     image:
//                           //     NetworkImage(
//                           //         widget.facilitiesModel.hospitalImage ?? ''),
//                           //         ),
//                           borderRadius: BorderRadius.circular(15),
//                           border:
//                               Border.all(color: AppColors.grey300, width: 1.5)),
//                       child: _selectedImage == null
//                           ? Image.network(
//                               widget.facilitiesModel.hospitalImage ?? '',
//                               fit: BoxFit.cover,
//                             )
//                           : Image.file(
//                               _selectedImage!,
//                               fit: BoxFit.cover,
//                               height: 150,
//                             )),
//                   Positioned(
//                     top: 90,
//                     left: 180,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         _pickImage();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.buttonColor,
//                         foregroundColor: AppColors.whiteColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         minimumSize: const Size(15, 35),
//                       ),
//                       child: const Text(
//                         'Change photo',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // facilitiesProvider.editFacilities(
//                     //     name: _nameController.text,
//                     //     email: _emailController.text,
//                     //     website: _websiteController.text,
//                     //     phoneno: _phoneNoController.text,
//                     //     context: context,
//                     //     latitude: '20.00',
//                     //     longitude: '30.00',
//                     //     hospitalAddress: _addressController.text,
//                     //     serviceType: medicalTags,
//                     //     facilitiesType: facilitiesTags,
//                     //     hospitalType: selectedType,
//                     //     hospitalOwner: selectedOwnership,
//                     //     hospitalSize: selectedSize,
//                     //     hospitalImage: _selectedImage!);
                    
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.buttonColor,
//                     foregroundColor: AppColors.whiteColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     minimumSize: const Size(150, 45),
//                   ),
//                   child: const Text(
//                     'Submit',
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 50,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void deleteDialog(BuildContext context) {
//     final facilitiesProvider =
//        // Provider.of<FacilitiesProvider>(context, listen: false);
//     showDialog<AlertDialog>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           icon: Container(
//             height: 50,
//             width: 50,
//             decoration: const BoxDecoration(
//                 shape: BoxShape.circle, color: AppColors.danger),
//             child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SvgPicture.asset(
//                   'lib/assests/icons/delete.svg',
//                 )),
//           ),
//           title: const Text(
//             'Delete  medical facility',
//             style: TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
//           ),
//           content: const Text(
//             'You are about to permanently delete this medical facility.',
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
//             textAlign: TextAlign.center,
//           ),
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                 //     print('hh');
//                 // await    facilitiesProvider.deleteFacilities(
//                 //       context: context,
//                 //         website: widget.facilitiesModel.website ?? '');
//                 //          facilitiesProvider.getFacilities();
//                 //     Navigator.pop(context);
//                 //     Navigator.pop(context);
                   
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.deleteColor,
//                     foregroundColor: AppColors.whiteColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     minimumSize: const Size(40, 40),
//                   ),
//                   child: const Text(
//                     'DELETE',
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.buttonColor,
//                     foregroundColor: AppColors.whiteColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     minimumSize: const Size(40, 40),
//                   ),
//                   child: const Text(
//                     'CANCEL',
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
