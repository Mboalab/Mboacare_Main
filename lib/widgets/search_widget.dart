import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:mboacare/global/styles/colors.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mboacare/services/apis.dart';

import '../app_modules/user/screens/inner_screen/blog_details.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController searchText = TextEditingController();
  List<Map<String, dynamic>> searchResult = [];
  bool showList = false;
  var val1;
  var url = Apis.baseUrl;
  Future<void> searchBlog(String val) async {
    var searchUrl = "$url/blog/search?q=$val";
    var searchResponse = await http.get(Uri.parse(searchUrl));

    try {
      if (searchResponse.statusCode == 201 ||
          searchResponse.statusCode == 200) {
        var tempData = jsonDecode(searchResponse.body);
        var searchJson = tempData['data'];
        for (var item in searchJson) {
          if (item['id'] != null &&
              item['blogTitle'] != null &&
              item['blogWebLink'] != null) {
            searchResult.add({
              'id': item['id'],
              'blogTitle': item['blogTitle'],
              'blogPubDate': item['blogPubDate'],
              'blogAuthor': item['blogAuthor'],
              'blogImage': item['blogImage'],
              'blogWebLink': item['blogWebLink'],
            });

            if (searchResult.length > 20) {
              searchResult.removeRange(20, searchResult.length);
            }
          } else {}
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        showList = !showList;
      },
      child: Column(
        children: [
          TextField(
            controller: searchText,
            onSubmitted: (value) {
              searchResult.clear();
              setState(() {
                val1 = value;
              });
            },
            onChanged: (value) {
              searchResult.clear();
              setState(() {
                val1 = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Search blogs',
              labelStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Color(0XFFecfded),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 2.0,
                ),
              ),
              suffixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.search, color: AppColors.primaryColor)),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 12.0,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          if (searchText.text.isNotEmpty)
            FutureBuilder(
                future: searchBlog(val1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      height: 400,
                      child: ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.vertical,
                          itemCount: searchResult.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                    () => BlogDetails(
                                        url: searchResult[index]['blogWebLink'],
                                        title: searchResult[index]
                                            ['blogTitle']),
                                    duration: const Duration(
                                      milliseconds: 800,
                                    ),
                                    curve: Curves.easeInCirc,
                                    transition: Transition.fadeIn);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 4, bottom: 4),
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: AppColors.registerCard,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              searchResult[index]['blogImage']),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              searchResult[index]['blogTitle'],
                                              style: const TextStyle(
                                                  color: AppColors.cardbg,
                                                  fontSize: 14.0),
                                            ),
                                            Text(
                                              searchResult[index]['blogAuthor'],
                                              style: const TextStyle(
                                                  color: AppColors.grey,
                                                  fontSize: 12.0),
                                            ),
                                            Text(
                                              searchResult[index]['blogPubDate']
                                                  .toString(),
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: AppColors.grey,
                                                  fontSize: 12.0),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return const Center(
                        child: SpinKitCircle(
                      color: AppColors.buttonColor,
                    ));
                  }
                })
        ],
      ),
    );
  }
}
