import 'package:discount_helper/pages/drawer.dart';
import 'package:discount_helper/utils/colors.dart';
import 'package:discount_helper/widgets/tag_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  var priceController = TextEditingController();
  var discountController = TextEditingController();
  String totalprice = '0';
  String discount = '0';
  double discountprice = 0.0;
  double saved = 0.0;
  var showTotalPrice = "";
  var showDiscount = "";
  String? validateRange(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    if (number < 0 || number > 100) {
      return 'Please enter a number between 0 and 100';
    }
    return null;
  }

  final List<double> discountList = [
    5,
    10,
    15,
    20,
    25,
    30,
    35,
    40,
    45,
    50,
    55,
    60,
  ];
  _calculate(totalprice, discount) {
    totalprice = double.parse(totalprice);
    discount = double.parse(discount);
    double cal = (discount * totalprice) / 100;
    discountprice = totalprice - cal;
    return discountprice;
  }

  double _calculateAmountSaved(totalprice, discountprice) {
    totalprice = double.parse(totalprice);
    double saved = totalprice - discountprice;
    return saved;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        title: const Text(
          "Descuento Discount Mate",
          style: TextStyle(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextFormField(
                  controller: priceController,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value == "") {
                      return "please enter your price";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    hintText: "Write your price",
                  ),
                ),
                const Gap(20.0),
                TextFormField(
                  controller: discountController,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    hintText: "Write discount",
                  ),
                  validator: validateRange,
                ),
                const Gap(30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Wrap(
                                        alignment: WrapAlignment.spaceEvenly,
                                        spacing: 5.0,
                                        runSpacing: 10.0,
                                        children: discountList
                                            .map((e) => TagDiscount(
                                                  discount: e.toInt().toString(),
                                                  color:
                                                      discountController.text == e.toInt().toString() ? AppColors.primaryColor : AppColors.whiteColor,
                                                  onPressed: () {
                                                    discountController.text = e.toInt().toString();
                                                    setState(() {});
                                                    Navigator.of(context).pop();
                                                  },
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 35.0,
                        width: 70.0,
                        child: const Center(
                          child: Text(
                            "add",
                            style: TextStyle(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20.0),
                GestureDetector(
                  onTap: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    showTotalPrice = priceController.text;
                    showDiscount = double.parse(discountController.text).toInt().toString();
                    discountprice = _calculate(priceController.text, double.parse(discountController.text).toInt().toString());
                    saved = _calculateAmountSaved(priceController.text, discountprice);
                    // priceController.clear();
                    // discountController.clear();
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 45.0,
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "Calculate",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(30.0),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "$discountprice",
                        style: const TextStyle(
                          fontSize: 80.0,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Text(
                        "Discounted Price",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Calculations:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Price: ${priceController.text == "" // Ambigious logic but working
                                                ? "" : priceController.text}",
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            discountprice == 0.0 ? "Discounted Price: " : "Discounted Price: ${discountprice.toInt()}",
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            saved == 0.0 ? "Saved: " : "Saved: ${saved.toInt()}",
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
