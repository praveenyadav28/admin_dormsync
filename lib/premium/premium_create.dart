// ignore_for_file: use_build_context_synchronously

import 'package:admin_dormsync/model/premium_model.dart';
import 'package:admin_dormsync/utils/buttons.dart';
import 'package:admin_dormsync/utils/colors.dart';
import 'package:admin_dormsync/utils/components/api.dart';
import 'package:admin_dormsync/utils/field_outside.dart';
import 'package:admin_dormsync/utils/sizes.dart';
import 'package:admin_dormsync/utils/snackbar.dart';
import 'package:admin_dormsync/utils/textfield.dart';
import 'package:flutter/material.dart';

class CreatePremium extends StatefulWidget {
  final PremiumModel? premiumData;
  const CreatePremium({super.key, this.premiumData});

  @override
  State<CreatePremium> createState() => _CreatePremiumState();
}

class _CreatePremiumState extends State<CreatePremium> {
  TextEditingController featureController = TextEditingController();
  String? selectedType;
  final List<String> options = ["Feature", "Price"];

  List<Map<String, TextEditingController>> planControllers = [
    {
      "duration": TextEditingController(text: "3 Months"),
      "basic": TextEditingController(),
      "premium": TextEditingController(),
    },
    {
      "duration": TextEditingController(text: "6 Months"),
      "basic": TextEditingController(),
      "premium": TextEditingController(),
    },
    {
      "duration": TextEditingController(text: "12 Months"),
      "basic": TextEditingController(),
      "premium": TextEditingController(),
    },
  ];

  @override
  void initState() {
    super.initState();
    // Prefill data when updating
    if (widget.premiumData != null) {
      featureController.text = widget.premiumData!.featureName ?? "";
      selectedType = widget.premiumData!.type ?? "";

      if (widget.premiumData!.plans.isNotEmpty) {
        for (int i = 0; i < planControllers.length; i++) {
          if (i < widget.premiumData!.plans.length) {
            final plan = widget.premiumData!.plans[i];
            planControllers[i]["basic"]!.text = plan.basic ?? "";
            planControllers[i]["premium"]!.text = plan.premium ?? "";
          }
        }
      }
    }
  }

  Future<void> postPremium() async {
    if (featureController.text.isEmpty || selectedType == null) {
      showCustomSnackbarError(
        context,
        "Please enter feature name and select type",
      );
      return;
    }

    final planList =
        planControllers.map((plan) {
          return {
            "duration": plan["duration"]!.text,
            "basic": plan["basic"]!.text,
            "premium": plan["premium"]!.text,
          };
        }).toList();

    final data = {
      "name": featureController.text.trim(),
      "type": selectedType ?? "Feature",
      "plan": planList,
    };

    var response = await ApiService.postData('premium', data);

    if (response["status"] == true) {
      showCustomSnackbarSuccess(context, response['message']);
      Navigator.pop(context, "New Data");
    } else {
      showCustomSnackbarError(context, response['message']);
    }
  }

  Future<void> updatePremium() async {
    if (featureController.text.isEmpty || selectedType == null) {
      showCustomSnackbarError(
        context,
        "Please enter feature name and select type",
      );
      return;
    }

    final planList =
        planControllers.map((plan) {
          return {
            "duration": plan["duration"]!.text,
            "basic": plan["basic"]!.text,
            "premium": plan["premium"]!.text,
          };
        }).toList();

    var response = await ApiService.putData(
      'premium/${widget.premiumData!.id}',
      {
        "name": featureController.text.trim(),
        "type": selectedType,
        "plan": planList,
      },
    );

    if (response["status"] == true) {
      showCustomSnackbarSuccess(context, response['message']);
      Navigator.pop(context, "New Data");
    } else {
      showCustomSnackbarError(context, response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.premiumData != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: Text(
          isUpdate ? "Update Premium Feature" : "Add Premium Feature",
          style: TextStyle(
            color: AppColor.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.white),
          onPressed: () => Navigator.pop(context, 'New Data'),
        ),
      ),
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.width * .03,
          vertical: Sizes.height * .015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addMasterOutside(
              context: context,
              children: [
                CommonTextField(
                  controller: featureController,
                  hintText: "Feature Name*",
                ),
                Center(
                  child: DropdownButtonFormField<String>(
                    value: selectedType,
                    decoration: const InputDecoration(
                      labelText: "Select Type",
                      isDense: true,
                      border: UnderlineInputBorder(),
                    ),
                    items:
                        options.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                    onChanged: (String? value) {
                      setState(() => selectedType = value);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Column(
              children:
                  planControllers.map((plan) {
                    return addMasterOutside(
                      context: context,
                      children: [
                        Center(
                          child: Text(
                            plan["duration"]!.text,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                        CommonTextField(
                          controller: plan["basic"]!,
                          hintText: "Basic*",
                        ),
                        CommonTextField(
                          controller: plan["premium"]!,
                          hintText: "Premium*",
                        ),
                      ],
                    );
                  }).toList(),
            ),

            const SizedBox(height: 25),

            Center(
              child: DefaultButton(
                text: isUpdate ? "Update" : "Create",
                width: 150,
                hight: 40,
                onTap: () async {
                  if (isUpdate) {
                    updatePremium();
                  } else {
                    postPremium();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
