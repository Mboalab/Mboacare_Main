import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mboacare/colors.dart';
import 'package:mboacare/facilities/view/screens/search_facilties_page.dart';

class PickAddressPage extends StatelessWidget {
  const PickAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: const Text(
          'Hospital address',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.grey),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search location.......',
                hintStyle: TextStyle(color: AppColors.grey300),
                contentPadding: EdgeInsets.only(left: 40),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchFacilitiesPage()));
              },
              child: Row(
                children: [
                  SvgPicture.asset('lib/assests/icons/location_search.svg'),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Choose current location',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey300),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
