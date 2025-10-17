import 'package:admin_dormsync/model/premium_model.dart';
import 'package:admin_dormsync/premium/premium_create.dart';
import 'package:admin_dormsync/utils/colors.dart';
import 'package:admin_dormsync/utils/components/api.dart';
import 'package:admin_dormsync/utils/navigations.dart';
import 'package:admin_dormsync/utils/resue.dart';
import 'package:admin_dormsync/utils/sizes.dart';
import 'package:admin_dormsync/utils/snackbar.dart';
import 'package:flutter/material.dart';

class PremiumListScreen extends StatefulWidget {
  const PremiumListScreen({super.key});

  @override
  State<PremiumListScreen> createState() => _PremiumListScreenState();
}

class _PremiumListScreenState extends State<PremiumListScreen> {
  List<PremiumModel> premiumList = [];

  String _searchQuery = '';
  int _pageSize = 10;
  int _currentPage = 1;
  final List<int> _pageSizeOptions = [5, 10, 20, 50];

  List<PremiumModel> get _filteredData {
    if (_searchQuery.isEmpty) return premiumList;
    final query = _searchQuery.toLowerCase();
    return premiumList.where((item) {
      return (item.featureName ?? '').toLowerCase().contains(query) ||
          (item.type ?? '').toLowerCase().contains(query);
    }).toList();
  }

  List<PremiumModel> get _pagedData {
    final start = (_currentPage - 1) * _pageSize;
    final end =
        (start + _pageSize) > _filteredData.length
            ? _filteredData.length
            : (start + _pageSize);
    return _filteredData.sublist(start, end);
  }

  @override
  void initState() {
    super.initState();
    getPremiumList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: Text(
          "Premium List",
          style: TextStyle(
            color: AppColor.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: () async {
              var updated = await pushTo(const CreatePremium());
              if (updated == "New Data") getPremiumList();
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
                const SizedBox(width: 30),
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
            _buildFilterBar(),
            const SizedBox(height: 8),
            Table(
              border: TableBorder.all(color: AppColor.grey),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1.5),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2),
                4: FlexColumnWidth(2),
                5: FlexColumnWidth(1.2),
              },
              children: [
                _tableHeader(),
                ..._pagedData.map((item) => _tableRow(item)),
              ],
            ),
            SizedBox(height: Sizes.height * 0.02),
            _buildPagination(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Row(
      children: [
        const Text("Show "),
        DropdownButton<int>(
          value: _pageSize,
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                _pageSize = newValue;
                _currentPage = 1;
              });
            }
          },
          items:
              _pageSizeOptions
                  .map(
                    (size) =>
                        DropdownMenuItem(value: size, child: Text("$size")),
                  )
                  .toList(),
        ),
        const Text(" entries"),
        const Spacer(),
        SizedBox(
          width: 220,
          child: TextField(
            onChanged:
                (value) => setState(() {
                  _searchQuery = value;
                  _currentPage = 1;
                }),
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Search feature or type',
              hintStyle: TextStyle(fontSize: 14, color: AppColor.grey),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(Icons.search, color: AppColor.grey),
            ),
          ),
        ),
      ],
    );
  }

  TableRow _tableHeader() {
    return TableRow(
      decoration: const BoxDecoration(color: Color(0xffE8F8F5)),
      children: [
        tableHeader('Feature Name'),
        tableHeader('Type'),
        tableHeader('3 Months'),
        tableHeader('6 Months'),
        tableHeader('12 Months'),
        tableHeader('Action'),
      ],
    );
  }

  TableRow _tableRow(PremiumModel item) {
    String getPlan(String duration, String field) {
      final plan = item.plans.firstWhere(
        (p) => p.duration == duration,
        orElse: () => PlanModel(),
      );
      if (field == 'basic') return plan.basic ?? '-';
      if (field == 'premium') return plan.premium ?? '-';
      return '-';
    }

    return TableRow(
      children: [
        tableBody(item.featureName ?? '-'),
        tableBody(item.type ?? '-'),
        tableBody(
          "B: ${getPlan("3 Months", "basic")}\nP: ${getPlan("3 Months", "premium")}",
        ),
        tableBody(
          "B: ${getPlan("6 Months", "basic")}\nP: ${getPlan("6 Months", "premium")}",
        ),
        tableBody(
          "B: ${getPlan("12 Months", "basic")}\nP: ${getPlan("12 Months", "premium")}",
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: AppColor.primary),
                  onPressed: () async {
                    var updated = await pushTo(
                      CreatePremium(premiumData: item),
                    );
                    if (updated == "New Data") getPremiumList();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: AppColor.red),
                  onPressed: () => _deletePremium(item.id ?? ''),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    int totalPages = (_filteredData.length / _pageSize).ceil();
    if (totalPages == 0) totalPages = 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed:
              _currentPage > 1 ? () => setState(() => _currentPage--) : null,
        ),
        Text('Page $_currentPage of $totalPages'),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed:
              _currentPage < totalPages
                  ? () => setState(() => _currentPage++)
                  : null,
        ),
      ],
    );
  }

  Future<void> getPremiumList() async {
    var response = await ApiService.fetchData("premium");
    if (response['status'] == true) {
      premiumList = premiumModelFromJson(response['data']);
      setState(() {});
    } else {
      showCustomSnackbarError(context, response["message"]);
    }
  }

  Future<void> _deletePremium(String id) async {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text("Warning"),
            content: const Text(
              "Are you sure you want to delete this feature?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColor.red),
                onPressed: () async {
                  var response = await ApiService.deleteData(
                    "premium/delete/$id",
                  );
                  Navigator.pop(dialogContext);
                  if (response["status"] == true) {
                    showCustomSnackbarSuccess(context, response["message"]);
                    getPremiumList();
                  } else {
                    showCustomSnackbarError(context, response["message"]);
                  }
                },
                child: const Text("Delete"),
              ),
            ],
          ),
    );
  }
}
