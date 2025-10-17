import 'package:admin_dormsync/model/licence_model.dart';
import 'package:admin_dormsync/utils/colors.dart';
import 'package:admin_dormsync/utils/components/api.dart';
import 'package:admin_dormsync/utils/container.dart';
import 'package:admin_dormsync/utils/date_change.dart';
import 'package:admin_dormsync/utils/field_outside.dart';
import 'package:admin_dormsync/utils/images.dart';
import 'package:admin_dormsync/utils/sizes.dart';
import 'package:admin_dormsync/utils/snackbar.dart';
import 'package:admin_dormsync/utils/state_cities.dart';
import 'package:admin_dormsync/utils/textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';

class CreateLicense extends StatefulWidget {
  const CreateLicense({this.licenceData, super.key});
  final LicenceList? licenceData;

  @override
  State<CreateLicense> createState() => _CreateLicenseState();
}

class _CreateLicenseState extends State<CreateLicense> {
  TextEditingController licenceNoController = TextEditingController();
  TextEditingController licenceDateController = TextEditingController();
  TextEditingController amcDueDateController = TextEditingController();
  TextEditingController amcAmtController = TextEditingController();
  TextEditingController dealAmtController = TextEditingController();
  TextEditingController recieveAmtController = TextEditingController();
  TextEditingController dueAmtController = TextEditingController();
  TextEditingController branchCountController = TextEditingController();
  TextEditingController salesPersonController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController gstNoController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  late List<String> statesSuggestions;
  late List<String> citiesSuggestions;

  late SearchFieldListItem<String>? selectedState;
  late SearchFieldListItem<String>? selectedCity;

  @override
  void initState() {
    if (widget.licenceData != null) {
      licenceNoController.text = widget.licenceData!.licenceNo ?? "";
      licenceDateController.text = DateFormat(
        'yyyy-MM-dd',
      ).format(widget.licenceData!.licenseDueDate!);
      amcDueDateController.text = DateFormat(
        'yyyy-MM-dd',
      ).format(widget.licenceData!.amcDueDate!);
      dealAmtController.text = widget.licenceData!.dealAmt ?? "";
      amcAmtController.text = widget.licenceData!.amcAmt ?? "";
      recieveAmtController.text = widget.licenceData!.receiveAmt ?? "";
      dueAmtController.text = widget.licenceData!.dueAmt ?? "";
      branchCountController.text = widget.licenceData!.branchCount.toString();
      salesPersonController.text = widget.licenceData!.salesman ?? "";
      companyNameController.text = widget.licenceData!.companyName ?? "";
      addressController.text = widget.licenceData!.lAddress ?? "";
      cityController.text = widget.licenceData!.lCity ?? "";
      stateController.text = widget.licenceData!.lState ?? "";
      gstNoController.text = widget.licenceData!.gstNo ?? "";
      ownerNameController.text = widget.licenceData!.ownerName ?? "";
      contactNoController.text = widget.licenceData!.contactNo ?? "";
      remarkController.text = widget.licenceData!.remarks ?? "";

      statesSuggestions = stateCities.keys.toList();
      selectedState = SearchFieldListItem<String>(
        widget.licenceData!.lState ?? "",
        item: widget.licenceData!.lState ?? "",
      );

      citiesSuggestions = stateCities[widget.licenceData!.lState] ?? [];

      selectedCity = SearchFieldListItem<String>(
        widget.licenceData!.lCity ?? "",
        item: widget.licenceData!.lCity ?? "",
      );
    } else {
      statesSuggestions = stateCities.keys.toList();
      citiesSuggestions = [];
      selectedState = null;
      selectedCity = null;
    }
    getLicenceNo().then((_) {
      setState(() {});
    });
    super.initState();
  }

  String _previousTextLicence = '';
  String _previousTextAMC = '';
  @override
  Widget build(BuildContext context) {
    // branchCountController.clear();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: AppColor.white),
        ),
        centerTitle: true,
        title: Text(
          "Create Licence",
          style: TextStyle(fontWeight: FontWeight.w500, color: AppColor.white),
        ),
        backgroundColor: AppColor.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.width * .03,
          vertical: Sizes.height * .03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonContainer(image: Images.town, text: "License Details"),
            SizedBox(height: Sizes.height * .02),

            addMasterOutside(
              children: [
                CommonTextField(
                  controller: licenceNoController,
                  image: Images.studentId,
                  hintText: 'License No.',
                ),
                CommonTextField(
                  onPressIcon: () async {
                    selectDate(context, licenceDateController).then((onValue) {
                      setState(() {});
                    });
                  },

                  controller: licenceDateController,
                  image: Images.year,
                  hintText: 'Licence Active Date*',
                  onChanged: (val) {
                    smartDateOnChanged(
                      value: val,
                      controller: licenceDateController,
                      previousText: _previousTextLicence,
                      updatePreviousText:
                          (newText) => _previousTextLicence = newText,
                    );
                  },
                ),

                CommonTextField(
                  onPressIcon: () async {
                    selectDate(context, amcDueDateController).then((onValue) {
                      setState(() {});
                    });
                  },

                  controller: amcDueDateController,
                  image: Images.year,
                  hintText: 'AMC Due Date*',
                  onChanged: (val) {
                    smartDateOnChanged(
                      value: val,
                      controller: amcDueDateController,
                      previousText: _previousTextAMC,
                      updatePreviousText:
                          (newText) => _previousTextAMC = newText,
                    );
                  },
                ),

                CommonTextField(
                  controller: dealAmtController,
                  image: Images.deal,
                  hintText: 'Deal Amount',
                ),
                CommonTextField(
                  controller: amcAmtController,
                  image: Images.deal,
                  hintText: 'AMC Amount',
                ),
                CommonTextField(
                  controller: recieveAmtController,
                  image: Images.receive,
                  hintText: 'Receive Amount',
                ),
                CommonTextField(
                  controller: dueAmtController,
                  image: Images.overdue,
                  hintText: 'Due Amount',
                ),

                CommonTextField(
                  controller: salesPersonController,
                  image: Images.salesman,
                  hintText: 'Sales Person',
                ),
              ],
              context: context,
            ),
            SizedBox(height: Sizes.height * .05),
            ButtonContainer(image: Images.department, text: "Company Details"),
            SizedBox(height: Sizes.height * .02),
            addMasterOutside(
              children: [
                CommonTextField(
                  controller: companyNameController,
                  image: Images.business,
                  hintText: 'Company Name',
                ),
                CommonTextField(
                  controller: addressController,
                  image: Images.location,
                  hintText: 'Address',
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
                          labelText: 'Select State*',
                          labelStyle: TextStyle(
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
                          labelText: 'Select City*',
                          labelStyle: TextStyle(
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
                  controller: gstNoController,
                  image: Images.gst,
                  hintText: 'GST No.',
                ),
                CommonTextField(
                  controller: ownerNameController,
                  image: Images.owner,
                  hintText: 'Owner Name',
                ),
                CommonTextField(
                  controller: contactNoController,
                  image: Images.contactNo,
                  hintText: 'Contact No.',
                ),
                CommonTextField(
                  image: Images.department,
                  hintText: 'Branch Count',
                  controller: branchCountController,
                ),
              ],
              context: context,
            ),
            SizedBox(height: Sizes.height * .03),
            Center(
              child: InkWell(
                onTap: () {
                  widget.licenceData != null
                      ? showDialog(
                        context: context,
                        builder:
                            (contextDialog) => AlertDialog(
                              title: const Text("Warning"),
                              content: const Text(
                                "Are you sure you want to update this licence?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.of(contextDialog).pop(),
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primary,
                                  ),
                                  onPressed: () {
                                    updateLicence().then((_) {
                                      Navigator.pop(contextDialog, "New Data");
                                    });
                                  },
                                  child: const Text("Update"),
                                ),
                              ],
                            ),
                      )
                      : postLicence();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: Sizes.height * .02),
                  width: 200,
                  height: 45,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 2,
                        spreadRadius: 3,
                        color: AppColor.grey,
                      ),
                    ],
                  ),
                  child: Text(
                    widget.licenceData != null ? "Update" : "Create",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future postLicence() async {
    var response = await ApiService.postData('licences', {
      'licence_no': licenceNoController.text.trim().toString(),
      'license_due_date': DateFormat("yyyy-MM-dd").format(
        DateFormat("dd/MM/yyyy").parse(licenceDateController.text.trim()),
      ),
      'amc_due_date': DateFormat("yyyy-MM-dd").format(
        DateFormat("dd/MM/yyyy").parse(amcDueDateController.text.trim()),
      ),
      'company_name': companyNameController.text.trim().toString(),
      'l_address': addressController.text.trim().toString(),
      'l_city': cityController.text.trim().toString(),
      'l_state': stateController.text.trim().toString(),
      'gst_no': gstNoController.text.trim().toString(),
      'owner_name': ownerNameController.text.trim().toString(),
      'contact_no': contactNoController.text.trim().toString(),
      'deal_amt': dealAmtController.text.trim().toString(),
      'amc_amt': amcAmtController.text.trim().toString(),
      'receive_amt': recieveAmtController.text.trim().toString(),
      'due_amt': dueAmtController.text.trim().toString(),
      'branch_count': branchCountController.text.trim().toString(),
      'remarks': remarkController.text.trim().toString(),
      'salesman': salesPersonController.text.trim().toString(),
      'other1': "",
      'other2': "",
      'other3': "",
      'other4': "",
      'other5': "",
    });

    if (response["status"] == true) {
      showCustomSnackbarSuccess(context, response['message']);
      Navigator.pop(context, "New Data");
    } else {
      showCustomSnackbarError(context, response['message']);
    }
  }

  Future updateLicence() async {
    var response =
        await ApiService.postData('licences/update/${widget.licenceData!.id}', {
          'licence_no': licenceNoController.text.trim().toString(),
          'license_due_date': licenceDateController.text.trim().toString(),
          'amc_due_date': amcDueDateController.text.trim().toString(),
          'company_name': companyNameController.text.trim().toString(),
          'l_address': addressController.text.trim().toString(),
          'l_city': cityController.text.trim().toString(),
          'l_state': stateController.text.trim().toString(),
          'gst_no': gstNoController.text.trim().toString(),
          'owner_name': ownerNameController.text.trim().toString(),
          'contact_no': contactNoController.text.trim().toString(),
          'deal_amt': dealAmtController.text.trim().toString(),
          'amc_amt': amcAmtController.text.trim().toString(),
          'receive_amt': recieveAmtController.text.trim().toString(),
          'due_amt': dueAmtController.text.trim().toString(),
          'branch_count': branchCountController.text.trim().toString(),
          'branch_list': [],
          'remarks': remarkController.text.trim().toString(),
          'salesman': salesPersonController.text.trim().toString(),
          'other1': "",
          'other2': "",
          'other3': "",
          'other4': "",
          'other5': "",
          '_method': "PUT",
        });

    if (response["status"] == true) {
      showCustomSnackbarSuccess(context, response['message']);
      Navigator.pop(context, "New Data");
    } else {
      showCustomSnackbarError(context, response['message']);
      Navigator.pop(context, "New Data");
    }
  }

  Future getLicenceNo() async {
    var response = await ApiService.fetchData("next_licence_no");
    licenceNoController.text =
        widget.licenceData != null
            ? widget.licenceData!.licenceNo!
            : response['next_licence_no'].toString();
  }
}
