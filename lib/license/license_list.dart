import 'package:admin_dormsync/branch/branch_list.dart';
import 'package:admin_dormsync/license/create_license.dart';
import 'package:admin_dormsync/model/licence_model.dart';
import 'package:admin_dormsync/onboarding/login.dart';
import 'package:admin_dormsync/premium/premium_list.dart';
import 'package:admin_dormsync/utils/colors.dart';
import 'package:admin_dormsync/utils/components/api.dart';
import 'package:admin_dormsync/utils/components/prefences.dart';
import 'package:admin_dormsync/utils/navigations.dart';
import 'package:admin_dormsync/utils/resue.dart';
import 'package:admin_dormsync/utils/sizes.dart';
import 'package:admin_dormsync/utils/snackbar.dart';
import 'package:flutter/material.dart';

class LicenseViewScreen extends StatefulWidget {
  const LicenseViewScreen({super.key});

  @override
  State<LicenseViewScreen> createState() => _LicenseViewScreenState();
}

class _LicenseViewScreenState extends State<LicenseViewScreen> {
  List<LicenceList> licenceList = [];
  // StyleText textstyles = StyleText();
  // Sample data for the table

  // Store the filter values
  String _searchQuery = '';
  int _pageSize = 10; // Initial page size
  int _currentPage = 1; // Current page
  final List<int> _pageSizeOptions = [5, 10, 20, 50]; // Page size options

  // Function to filter the data
  List<LicenceList> get _filteredData {
    List<LicenceList> result = licenceList; // Initialize with unfiltered data
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();

      result =
          licenceList.where((item) {
            final Map<String, dynamic> itemMap = item.toJson();
            return itemMap.values.any((value) {
              return value?.toString().toLowerCase().contains(query) ?? false;
            });
          }).toList();
    }
    return result;
  }

  // Function to get paginated data
  List<LicenceList> get _pagedData {
    final startIndex = (_currentPage - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    final filteredData = _filteredData;
    if (startIndex > filteredData.length) {
      return [];
    }
    return filteredData.sublist(
      startIndex,
      endIndex > filteredData.length ? filteredData.length : endIndex,
    );
  }

  // Function to handle page change
  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  // Function to handle page size change
  void _onPageSizeChanged(int size) {
    setState(() {
      _pageSize = size;
      _currentPage = 1; // Reset to first page when page size changes
    });
  }

  @override
  void initState() {
    getLicenes().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            logoutPrefData();
            pushNdRemove(LoginScreen());
          },
          icon: Icon(Icons.logout, color: AppColor.red),
        ),
        title: Text(
          "DormSync Licenses",
          style: TextStyle(color: AppColor.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
            onPressed: () {
              pushTo(PremiumListScreen());
            },
            child: Text(
              "Premium Features",
              style: TextStyle(color: AppColor.white, fontSize: 16),
            ),
          ),
          SizedBox(width: Sizes.width * .03),
          InkWell(
            onTap: () async {
              var updatedData = await pushTo(CreateLicense());
              if (updatedData == "New Data") {
                getLicenes().then((value) {
                  setState(() {});
                });
              }
            },
            child: Row(
              children: [
                Text(
                  "Create  ",
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CircleAvatar(
                  minRadius: 14,
                  backgroundColor: AppColor.black.withValues(alpha: .1),
                  child: Icon(Icons.add, color: AppColor.white),
                ),
                SizedBox(width: 30),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.width * .02,
          vertical: Sizes.height * .01,
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: <Widget>[
                    // Page Size Dropdown
                    Text("Show "),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: AppColor.grey,
                            spreadRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(4),
                      ),

                      child: DropdownButton<int>(
                        value: _pageSize,
                        onChanged: (int? newValue) {
                          if (newValue != null) {
                            // null check
                            _onPageSizeChanged(newValue);
                          }
                        },
                        items:
                            _pageSizeOptions.map<DropdownMenuItem<int>>((
                              int value,
                            ) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              );
                            }).toList(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColor.lightblack,
                        ),
                        underline: Container(), // Remove underline
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ), // Custom icon
                      ),
                    ),
                    Text(" enteries"),
                    const SizedBox(width: 8),
                    Spacer(),
                    Spacer(),
                    Text("Total ${licenceList.length}"),
                    const SizedBox(width: 8),
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    //   decoration: BoxDecoration(color: Color(0xffECFFE5)),
                    //   // child: IconButton(
                    //   //   onPressed: () {},
                    //   //   icon: Image.asset(Images.pdf),
                    //   // ),
                    // ),

                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    //   decoration: BoxDecoration(color: Color(0xffECFFE5)),
                    //   // child: IconButton(
                    //   //   onPressed: () {},
                    //   //   icon: Image.asset(Images.excel),
                    //   // ),
                    // ),
                    Expanded(
                      flex: Sizes.width < 800 ? 8 : 1,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                              _currentPage = 1; // Reset to first page on search
                            });
                          },
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(), // Remove border
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ), // Add search icon
                          ),
                          style: TextStyle(fontSize: 14, color: AppColor.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Sizes.width >= 800
                ? Container()
                : Column(
                  children: [
                    ..._pagedData.map((item) {
                      return Card(
                        color: Color(0xffE5FDDD),
                        child: Column(
                          children: [
                            ListTile(
                              minVerticalPadding: 0,
                              leading: Text(item.licenceNo.toString()),
                              title: Text(
                                item.companyName.toString(),
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              trailing: Text(
                                "${item.amcDueDate?.day}-${item.amcDueDate?.month}-${item.amcDueDate?.year}",
                              ),
                            ),
                            ListTile(
                              dense: true,
                              minVerticalPadding: 0,
                              title: Text(item.contactNo.toString()),
                              trailing: Text(
                                item.branchCount.toString(),
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
            // Data Table
            Sizes.width <= 800
                ? Container()
                : Table(
                  border: TableBorder.all(color: Colors.grey),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    // Table Header Row
                    TableRow(
                      decoration: BoxDecoration(color: Color(0xffE5FDDD)),
                      children: [
                        tableHeader('License No.'),
                        tableHeader('AMC Due Date'),
                        tableHeader('Company Name'),
                        tableHeader('City'),
                        tableHeader('Owner Name'),
                        tableHeader('Contact No.'),
                        tableHeader('Deal Amt.'),
                        tableHeader('Branch Count'),
                        tableHeader('Action'),
                      ],
                    ),
                    // Table Data Rows
                    ..._pagedData.map((item) {
                      print(Preference.getString(PrefKeys.token));
                      return TableRow(
                        decoration: BoxDecoration(color: AppColor.white),

                        children: [
                          tableBody(item.licenceNo.toString()),
                          tableBody(
                            "${item.amcDueDate?.day}-${item.amcDueDate?.month}-${item.amcDueDate?.year}",
                          ),
                          tableBody(item.companyName.toString()),
                          tableBody(item.lCity.toString()),
                          tableBody(item.ownerName.toString()),
                          tableBody(item.contactNo.toString()),
                          tableBody(item.dealAmt.toString()),
                          tableBody(item.branchCount.toString()),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.visibility,
                                      color: AppColor.blue,
                                    ),
                                    onPressed: () {
                                      pushTo(
                                        BranchListScreen(
                                          licenceNo: item.licenceNo,
                                        ),
                                      );
                                    },
                                  ),

                                  // IconButton(
                                  //   icon: Icon(
                                  //     Icons.delete,
                                  //     color: AppColor.red,
                                  //   ),
                                  //   onPressed: () {
                                  //     showDialog(
                                  //       context: context,
                                  //       builder:
                                  //           (dialogContext) => AlertDialog(
                                  //             title: const Text("Warning"),
                                  //             content: const Text(
                                  //               "Are you sure you want to delete this licence?",
                                  //             ),
                                  //             actions: [
                                  //               TextButton(
                                  //                 onPressed:
                                  //                     () =>
                                  //                         Navigator.of(
                                  //                           dialogContext,
                                  //                         ).pop(),
                                  //                 child: const Text("Cancel"),
                                  //               ),
                                  //               ElevatedButton(
                                  //                 style:
                                  //                     ElevatedButton.styleFrom(
                                  //                       backgroundColor:
                                  //                           AppColor.red,
                                  //                     ),
                                  //                 onPressed: () {
                                  //                   deleteLicenes(
                                  //                     item.id.toString(),
                                  //                   ).then((value) {
                                  //                     getLicenes().then((valy) {
                                  //                       setState(() {
                                  //                         Navigator.of(
                                  //                           dialogContext,
                                  //                         ).pop();
                                  //                       });
                                  //                     });
                                  //                   });
                                  //                 },
                                  //                 child: const Text("Delete"),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //     );
                                  //   },
                                  // ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      color: AppColor.primary,
                                    ),
                                    onPressed: () async {
                                      var updatedData = await pushTo(
                                        CreateLicense(licenceData: item),
                                      );
                                      if (updatedData == "New Data") {
                                        getLicenes().then((value) {
                                          setState(() {});
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
            SizedBox(height: Sizes.height * 0.02),
            // Pagination Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Previous Page Button
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed:
                      _currentPage > 1
                          ? () => _onPageChanged(_currentPage - 1)
                          : null, // Disable if on first page
                ),
                // Current Page Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Page ${_currentPage} of ${(_filteredData.length / _pageSize).ceil()}',
                  ), //display the current page and the total number of pages
                ),
                // Next Page Button
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed:
                      _currentPage < (_filteredData.length / _pageSize).ceil()
                          ? () => _onPageChanged(_currentPage + 1)
                          : null, // Disable if on last page
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future getLicenes() async {
    var response = await ApiService.fetchData("licences");

    if (response["status"] == true) {
      print(response);
      licenceList = licenceListFromJson(response['data']);
    } else {
      print(response);
    }
  }

  Future deleteLicenes(String id) async {
    var response = await ApiService.deleteData(
      "licences/delete/$id",
      licenceNo: null,
    );

    if (response["status"] == true) {
      showCustomSnackbarSuccess(context, response['message']);
    } else {
      showCustomSnackbarError(context, response['message']);
    }
  }
}
