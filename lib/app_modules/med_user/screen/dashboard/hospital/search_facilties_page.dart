import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/model/placemodel/geometry_model.dart';
import 'package:mboacare/services/facilities_provider.dart';
import 'package:provider/provider.dart';

class SearchFacilitiesPage extends StatefulWidget {
  final GeometryModel geometryModel;
  const SearchFacilitiesPage({super.key, required this.geometryModel});

  @override
  State<SearchFacilitiesPage> createState() => _SearchFacilitiesPageState();
}

class _SearchFacilitiesPageState extends State<SearchFacilitiesPage> {
    @override
  void initState() {
    super.initState();
    final facilitiesProvider =
        Provider.of<FacilitiesProvider>(context, listen: false);
   // facilitiesProvider.getGeometry(placeId: widget.geometryModel.pl);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'lib/assests/images/map.png',
            // height: 900,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 10,
            top: 40,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          color: AppColors.whiteColor, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                            'lib/assests/icons/arrow_left.svg'),
                      )),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50,
                  width: 280,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Dolls hospital',
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.search))),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 600,
            //left: 1
            child: Container(
              height: 180,
              width: 400,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('lib/assests/icons/locate.svg'),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          'Dolls Hospital',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'House Number, Street Name, City Name, State, Country',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             AddFacilitiesPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor,
                          foregroundColor: AppColors.whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'CONFIRM LOCATION',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
