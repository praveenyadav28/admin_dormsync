import 'package:admin_dormsync/model/branch_model.dart';
import 'package:admin_dormsync/utils/buttons.dart';
import 'package:admin_dormsync/utils/colors.dart';
import 'package:admin_dormsync/utils/components/api.dart';
import 'package:admin_dormsync/utils/date_change.dart';
import 'package:admin_dormsync/utils/field_outside.dart';
import 'package:admin_dormsync/utils/images.dart';
import 'package:admin_dormsync/utils/sizes.dart';
import 'package:admin_dormsync/utils/snackbar.dart';
import 'package:admin_dormsync/utils/state_cities.dart';
import 'package:admin_dormsync/utils/textfield.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class CreateBranch extends StatefulWidget {
  CreateBranch({super.key, required this.licenceNo, this.branchData});
  String? licenceNo;
  BranchList? branchData;
  @override
  State<CreateBranch> createState() => _CreateBranchState();
}

class _CreateBranchState extends State<CreateBranch> {
  TextEditingController branchNameController = TextEditingController();
  TextEditingController branchAddressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController messBiomaxController = TextEditingController();
  TextEditingController hostelBiomaxController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  late List<String> statesSuggestions;
  late List<String> citiesSuggestions;

  late SearchFieldListItem<String>? selectedState;
  late SearchFieldListItem<String>? selectedCity;
  @override
  void initState() {
    if (widget.branchData != null) {
      branchNameController.text = widget.branchData!.branchName ?? "";
      branchAddressController.text = widget.branchData!.bAddress ?? "";
      contactNoController.text = widget.branchData!.contactNo ?? "";
      messBiomaxController.text = widget.branchData!.other1 ?? "";
      hostelBiomaxController.text = widget.branchData!.other2 ?? "";
      stateController.text = widget.branchData!.bState ?? "";
      cityController.text = widget.branchData!.bCity ?? "";
      userNameController.text = widget.branchData!.user![0].username ?? "";
      passwordController.text = widget.branchData!.user![0].password ?? "";

      statesSuggestions = stateCities.keys.toList();
      selectedState = SearchFieldListItem<String>(
        widget.branchData!.bState ?? "",
        item: widget.branchData!.bState ?? "",
      );

      citiesSuggestions = stateCities[widget.branchData!.bState] ?? [];

      selectedCity = SearchFieldListItem<String>(
        widget.branchData!.bCity ?? "",
        item: widget.branchData!.bCity ?? "",
      );
    } else {
      statesSuggestions = stateCities.keys.toList();
      citiesSuggestions = [];
      selectedState = null;
      selectedCity = null;
    }
    super.initState();
  }

  String _previousTextFrom = '';
  String _previousTextTo = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: Text(
          "Branch-Master",
          style: TextStyle(
            color: AppColor.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, 'New Data');
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.width * .02,
          vertical: Sizes.height * .01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addMasterOutside3(
              children: [
                CommonTextField(
                  controller: branchNameController,
                  image: Images.business,
                  hintText: "Branch Name*",
                ),
                CommonTextField(
                  controller: branchAddressController,
                  image: Images.location,
                  hintText: "Address*",
                ),
                CommonTextField(
                  controller: contactNoController,
                  image: Images.contactNo,
                  hintText: "Contact Number*",
                ),

                Row(
                  children: [
                    Image.asset(Images.state),
                    SizedBox(width: 5),
                    Expanded(
                      child: SearchField<String>(
                        controller: stateController,
                        suggestionStyle: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                        ),
                        searchStyle: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                        ),
                        searchInputDecoration: InputDecoration(
                          hintText: 'Select State*',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                          ),
                          border: UnderlineInputBorder(),
                        ),
                        suggestions:
                            statesSuggestions
                                .map(
                                  (x) =>
                                      SearchFieldListItem<String>(x, item: x),
                                )
                                .toList(),
                        onSuggestionTap: (SearchFieldListItem<String> item) {
                          setState(() {
                            selectedState = item;
                            citiesSuggestions =
                                stateCities[item.searchKey] ?? [];
                            stateController.text = item.searchKey;
                            selectedCity = null;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Image.asset(Images.selectCity),
                    SizedBox(width: 5),
                    Expanded(
                      child: SearchField<String>(
                        controller: cityController,
                        hint: 'Select City*',
                        suggestionStyle: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                        ),
                        searchStyle: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                        ),
                        searchInputDecoration: InputDecoration(
                          floatingLabelStyle: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.w500,
                          ),
                          hintStyle: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.w500,
                          ),
                          isDense: true,
                          border: UnderlineInputBorder(),
                        ),
                        onSuggestionTap: (SearchFieldListItem<String> item) {
                          setState(() {
                            selectedCity = item;
                            cityController.text = item.searchKey;
                          });
                        },
                        suggestions:
                            citiesSuggestions
                                .map(
                                  (x) =>
                                      SearchFieldListItem<String>(x, item: x),
                                )
                                .toList(),
                        suggestionState: Suggestion.expand,
                      ),
                    ),
                  ],
                ),
                CommonTextField(
                  controller: messBiomaxController,
                  image: Images.reports,
                  hintText: "Mess Biomax",
                ),
                CommonTextField(
                  controller: hostelBiomaxController,
                  image: Images.reports,
                  hintText: "Hostel Biomax",
                ),
                CommonTextField(
                  controller: userNameController,
                  image: Images.user,
                  hintText: "Username*",
                ),
                CommonTextField(
                  controller: passwordController,
                  image: Images.lock,
                  hintText: "Password*",
                ),

                if (widget.branchData == null)
                  CommonTextField(
                    onPressIcon: () async {
                      selectDate(context, fromDateController).then((onValue) {
                        setState(() {});
                      });
                    },

                    controller: fromDateController,
                    image: Images.year,
                    hintText: 'Session Start Date*',
                    onChanged: (val) {
                      smartDateOnChanged(
                        value: val,
                        controller: fromDateController,
                        previousText: _previousTextFrom,
                        updatePreviousText:
                            (newText) => _previousTextFrom = newText,
                      );
                    },
                  ),
                if (widget.branchData == null)
                  CommonTextField(
                    onPressIcon: () async {
                      selectDate(context, toDateController).then((onValue) {
                        setState(() {});
                      });
                    },

                    controller: toDateController,
                    image: Images.year,
                    hintText: 'Session End Date*',
                    onChanged: (val) {
                      smartDateOnChanged(
                        value: val,
                        controller: toDateController,
                        previousText: _previousTextTo,
                        updatePreviousText:
                            (newText) => _previousTextTo = newText,
                      );
                    },
                  ),
              ],
              context: context,
            ),

            SizedBox(height: Sizes.height * .05),

            Center(
              child: DefaultButton(
                text: widget.branchData != null ? "Update" : "Create",
                hight: 40,
                width: 150,
                onTap: () {
                  if (widget.branchData != null) {
                    showDialog(
                      context: context,
                      builder:
                          (dialogContext) => AlertDialog(
                            title: const Text("Warning"),
                            content: const Text(
                              "Are you sure you want to update this branch?",
                            ),
                            actions: [
                              TextButton(
                                onPressed:
                                    () => Navigator.of(dialogContext).pop(),
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                ),
                                onPressed: () async {
                                  bool success = await updateBranch();
                                  Navigator.of(dialogContext).pop();
                                  if (success) {
                                    Navigator.of(context).pop("New Data");
                                  }
                                },
                                child: const Text("Update"),
                              ),
                            ],
                          ),
                    );
                  } else if (fromDateController.text.isEmpty ||
                      toDateController.text.isEmpty) {
                    showCustomSnackbarError(
                      context,
                      "Please select session date",
                    );
                  } else {
                    postBranch();
                  }
                },
              ),
            ),
            SizedBox(height: Sizes.height * .04),
          ],
        ),
      ),
    );
  }

  Future postBranch() async {
    var response = await ApiService.postData('branch', {
      'name': branchNameController.text.trim().toString(),
      'branch_name': branchNameController.text.trim().toString(),
      'b_address': branchAddressController.text.trim().toString(),
      'b_city': cityController.text.toString(),
      'b_state': stateController.text.toString(),
      'contact_no': contactNoController.text.trim().toString(),
      'licence_no': widget.licenceNo,
      'username': userNameController.text.trim().toString(),
      'password': passwordController.text.trim().toString(),
      'other1': messBiomaxController.text.trim().toString(),
      'other2': hostelBiomaxController.text.trim().toString(),
    });

    if (response["status"] == true) {
      showCustomSnackbarSuccess(context, response['message']);
      postSession(response['branch']['id'].toString());
    } else {
      showCustomSnackbarError(context, response['message']);
    }
  }

  Future<bool> updateBranch() async {
    var response =
        await ApiService.postData('branch/${widget.branchData!.id}', {
          'name': branchNameController.text.trim(),
          'branch_name': branchNameController.text.trim(),
          'b_address': branchAddressController.text.trim(),
          'b_city': cityController.text.toString(),
          'b_state': stateController.text.toString(),
          'contact_no': contactNoController.text.trim(),
          'licence_no': widget.licenceNo,
          'username': userNameController.text.trim(),
          'password': passwordController.text.trim(),
          'other1': messBiomaxController.text.trim().toString(),
          'other2': hostelBiomaxController.text.trim().toString(),
          '_method': "PUT",
        });

    if (response["status"] == true) {
      showCustomSnackbarSuccess(context, response['message']);
      return true;
    } else {
      showCustomSnackbarError(context, response['message']);
      return false;
    }
  }

  Future postSession(String branchId) async {
    var response = await ApiService.postData('session', {
      'licence_no': widget.licenceNo,
      'branch_id': branchId,
      'session_start_date': fromDateController.text,
      'session_end_date': toDateController.text,
      'is_active': true,
    });

    if (response["status"] == true) {
      showCustomSnackbarSuccess(context, response['message']);
      Navigator.pop(context, "New Data");
    } else {
      showCustomSnackbarError(context, response['message']);
    }
  }
}
