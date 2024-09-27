import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:zenfi/model/invoiceitem.dart';
import 'package:zenfi/provider/invoiceprovider.dart';
import 'package:zenfi/utils/color_resources.dart';
import 'package:zenfi/utils/stykle_resources.dart';
import 'package:zenfi/widgets/button/resuable_textformfield.dart';

class AddInvoicePage extends StatefulWidget {
  @override
  _AddInvoicePageState createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  final _formKey = GlobalKey<FormState>();
  final List<InvoiceItem> invoiceItems = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      clearData();
    });

    super.initState();
  }

  clearData() {
    context.read<InvoiceProvider>().customerNameController.clear();
    context.read<InvoiceProvider>().addressController.clear();
    context.read<InvoiceProvider>().itemNameController.clear();
    context.read<InvoiceProvider>().itemPriceController.clear();
    context.read<InvoiceProvider>().itemQuantityController.clear();
    context.read<InvoiceProvider>().advanceController.clear();
    context.read<InvoiceProvider>().discountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   elevation: 0.0,
      //   backgroundColor: ColorResource.primaryColor,
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => InvoiceUI(
      //                 invoiceItems: invoiceItems,
      //                 customerName: _customerNameController.text,
      //                 address: _addressController.text,
      //                 advanceAmt: _advanceController.text.isEmpty ? '0' : _advanceController.text
      //               )),
      //     );
      //   },
      //   child: const Icon(Icons.remove_red_eye, color: ColorResource.whiteTextColor,),
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create Invoice',
          style: StyleResources.mediumGreyText18(context),
        ),
        leading: const SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Consumer<InvoiceProvider>(builder: (context, data, snapshot) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableTextFormField(
                      controller: data.customerNameController,
                      hintText: "Customer Name",
                      validator: _validateName,
                      isNumber: false),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ReusableTextFormField(
                      controller: data.addressController,
                      hintText: "Location/Address",
                      validator: _validateAddress,
                      isNumber: false),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ReusableTextFormField(
                      controller: data.advanceController,
                      hintText: "Advance Amount",
                      validator: _validateAdvAmount,
                      isNumber: true),
                  const SizedBox(height: 10.0),
                  ReusableTextFormField(
                      controller: data.discountController,
                      hintText: "Discount",
                      validator: _validateDiscount,
                      isNumber: false),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24.0),
                    decoration: BoxDecoration(
                        color: ColorResource.greyColor.withOpacity(0.05),
                        //border: Border.all(width: 0.7, color: ColorResource.greyColor.withOpacity(0.3)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Items Details',
                            style: StyleResources.mediumGreyText14(context),
                          ),
                        ),
                        _buildItemInput(),
                        const SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              final name = data.itemNameController.text;
                              final price =
                                  int.parse(data.itemPriceController.text);
                              //final quantity = int.parse(_itemQuantityController.text);

                              setState(() {
                                invoiceItems.add(InvoiceItem(
                                    name: name, price: price, quantity: 1));
                                data.itemNameController.clear();
                                data.itemPriceController.clear();
                                data.itemQuantityController.clear();
                              });

                              // Unfocus the text fields after adding an item.
                              FocusScope.of(context).unfocus();
                            }
                            print('--------------------');
                          },
                          child: Container(
                            height: 48.0,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: ColorResource.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                            child: const Center(
                                child: Text(
                              'Add Item',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            )),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  invoiceItems.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 24.0),
                          decoration: BoxDecoration(
                              color: ColorResource.greyColor.withOpacity(0.05),
                              //border: Border.all(width: 0.7, color: ColorResource.greyColor.withOpacity(0.3)),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text(
                                  'Added Items',
                                  style:
                                      StyleResources.mediumGreyText14(context),
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              invoiceItems.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: invoiceItems.length,
                                      itemBuilder: (context, index) {
                                        final item = invoiceItems[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${index + 1}. ${capitalizeFirstLetters(item.name)}',
                                                style: StyleResources
                                                    .mediumBlackText14(context),
                                              ),
                                              const Spacer(),
                                              Text(currency(
                                                  item.price.toString())),
                                              const SizedBox(
                                                width: 8.0,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  invoiceItems.removeAt(index);
                                                  setState(() {});
                                                },
                                                child: const SizedBox(
                                                    height: 20.0,
                                                    width: 20.0,
                                                    child: Icon(
                                                      Icons.delete,
                                                      size: 15.0,
                                                      color: ColorResource
                                                          .greyColor,
                                                    )),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Visibility(
                    visible: invoiceItems.isNotEmpty,
                    child: GestureDetector(
                      onTap: () {
                        _onCreateInvoiceTap();
                      },
                      child: Container(
                        height: 48.0,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: ColorResource.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        child: const Center(
                            child: Text(
                          'Create Invoice',
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  _onCreateInvoiceTap() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        builder: (context) {
          return Container(
            //height: 150.0,
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 80.0,
                    child: Image.asset(
                      'assets/bill.gif',
                      //color: Colors.white,
                    ),
                  ),
                  Text(
                    'Creating Invoice..',
                    style: StyleResources.normalBlackText14(context),
                  ),
                ],
              ),
            ),
          );
        });
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InvoiceUI(
                discount:
                    context.read<InvoiceProvider>().discountController.text,
                invoiceItems: invoiceItems,
                customerName:
                    context.read<InvoiceProvider>().customerNameController.text,
                address: context.read<InvoiceProvider>().addressController.text,
                advanceAmt: context
                        .read<InvoiceProvider>()
                        .advanceController
                        .text
                        .isEmpty
                    ? '0'
                    : context.read<InvoiceProvider>().advanceController.text)),
      );
    });
  }

  String? _validateDiscount(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an address';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter customer name';
    }
    return null;
  }

  String? _validateAdvAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter advance amount';
    }
    return null;
  }

  String? _validateItemName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter item name';
    }
    return null;
  }

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter amount';
    }
    return null;
  }

  Widget _buildItemInput() {
    SizedBox heightBox = const SizedBox(
      height: 10.0,
    );
    return Column(
      children: [
        heightBox,
        ReusableTextFormField(
            controller: context.read<InvoiceProvider>().itemNameController,
            hintText: "Item Name",
            validator: _validateItemName,
            isNumber: false),
        heightBox,
        ReusableTextFormField(
            controller: context.read<InvoiceProvider>().itemPriceController,
            hintText: "Amount",
            validator: _validateAmount,
            isNumber: true),
        heightBox,
      ],
    );
  }

  String capitalizeFirstLetters(String input) {
    if (input.isEmpty) {
      return input;
    }

    // Split the input string into words
    List<String> words = input.split(' ');

    // Capitalize the first letter of each word
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        // Convert the first letter to uppercase and the rest of the word to lowercase
        words[i] =
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }
    }

    // Join the words back into a single string
    return words.join(' ');
  }
}
