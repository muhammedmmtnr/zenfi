import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:zenfi/splash/splashscreen.dart';
import 'package:zenfi/utils/color_resources.dart';
import 'package:zenfi/utils/stykle_resources.dart';

class InvoiceUI extends StatefulWidget {
  final List<InvoiceItem> invoiceItems;
  final String customerName;
  final String advanceAmt;
  final String address;
  final String discount;

  InvoiceUI({
    Key? key,
    required this.invoiceItems,
    required this.customerName,
    required this.address,
    required this.advanceAmt,
    required this.discount,
  }) : super(key: key);

  @override
  State<InvoiceUI> createState() => _InvoiceUIState();
}

final screenshotController = ScreenshotController();
DateTime now = DateTime.now();
String formattedDate = DateFormat('dd-MM-yyyy').format(now);
int total = 0;

class _InvoiceUIState extends State<InvoiceUI> {
  @override
  void initState() {
    super.initState();
    total = 0;
    calculateTotal();
  }

  void calculateTotal() {
    for (var item in widget.invoiceItems) {
      total += item.price * item.quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const SplashScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: ColorResource.greyColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: const Center(
                    child: Text(
                      'Create New',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: ColorResource.invoicePrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  takeBillPdf();
                },
                child: Container(
                  height: 48.0,
                  decoration: const BoxDecoration(
                    color: ColorResource.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: const Center(
                    child: Text(
                      'Share PDF',
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: const Color(0xfff2f2f2),
        centerTitle: true,
        leading: const SizedBox(),
        title: Text(
          'Invoice',
          style: StyleResources.mediumGreyText16(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Screenshot(
              controller: screenshotController,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: AspectRatio(
                  aspectRatio: 0.71 / 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorResource.whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 70.0,
                          decoration: const BoxDecoration(
                            color: ColorResource.invoicePrimaryColor,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 70.0,
                                width: 75.0,
                                color: ColorResource.goldenColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Image.asset(
                                    'assets/logo.png',
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'INVOICE',
                                style:
                                    StyleResources.mediumWhiteText26(context),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'INVOICE TO:',
                                        style: StyleResources.mediumGreyText8(
                                            context),
                                      ),
                                      const SizedBox(height: 2.0),
                                      Text(
                                        widget.customerName.toUpperCase(),
                                        style: StyleResources.mediumBlackText(
                                            context, 8),
                                      ),
                                      Text(
                                        widget.address,
                                        style: StyleResources.mediumGreyText8(
                                                context)
                                            .copyWith(height: 0.9),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'INVOICE DATE',
                                        style: StyleResources.mediumGreyText8(
                                            context),
                                      ),
                                      const SizedBox(height: 2.0),
                                      Text(
                                        formattedDate,
                                        style: StyleResources.mediumGreyText8(
                                            context),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32.0),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Container(
                                      color: ColorResource.invoicePrimaryColor,
                                      height: 20.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 50.0,
                                              child: Text(
                                                'SL.',
                                                style: StyleResources
                                                    .normalWhiteText8(context),
                                              ),
                                            ),
                                            Text(
                                              'Item Description',
                                              style: StyleResources
                                                  .normalWhiteText8(context),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: 60.0,
                                              child: Text(
                                                'Quantity',
                                                style: StyleResources
                                                    .normalWhiteText8(context),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 60.0,
                                              child: Text(
                                                'Total',
                                                style: StyleResources
                                                    .normalWhiteText8(context),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 140,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                widget.invoiceItems.length,
                                            itemBuilder: (context, index) {
                                              final item =
                                                  widget.invoiceItems[index];
                                              return Container(
                                                height: 20.0,
                                                color: (index & 1) == 0
                                                    ? Colors.white
                                                    : Colors.black12
                                                        .withOpacity(0.05),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12.0),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 50.0,
                                                        child: Text(
                                                          '${index + 1}.',
                                                          style: StyleResources
                                                              .mediumGreyText8(
                                                                  context),
                                                        ),
                                                      ),
                                                      Text(
                                                        item.name,
                                                        style: StyleResources
                                                            .mediumGreyText8(
                                                                context),
                                                      ),
                                                      const Spacer(),
                                                      SizedBox(
                                                        width: 60.0,
                                                        child: Text(
                                                          '${item.quantity}',
                                                          style: StyleResources
                                                              .mediumGreyText8(
                                                                  context),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 60.0,
                                                        child: Text(
                                                          currency((item.price *
                                                                  item.quantity)
                                                              .toString()),
                                                          style: StyleResources
                                                              .mediumGreyText8(
                                                                  context),
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                            height: 2.0, child: Divider()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 90.0,
                                            child: Text(
                                              'Total Amount:'.toUpperCase(),
                                              style:
                                                  StyleResources.mediumBoldText(
                                                      context, 8),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50.0,
                                            child: Text(
                                              currency(total.toString()),
                                              style:
                                                  StyleResources.boldBlackText(
                                                      context, 8),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2.0),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 90.0,
                                            child: Text(
                                              'Advance:'.toUpperCase(),
                                              style:
                                                  StyleResources.mediumBoldText(
                                                      context, 8),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50.0,
                                            child: Text(
                                              currency(widget.advanceAmt),
                                              style:
                                                  StyleResources.boldBlackText(
                                                      context, 8),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2.0),
                                      widget.discount != ''
                                          ? Row(
                                              children: [
                                                SizedBox(
                                                  width: 90.0,
                                                  child: Text(
                                                    'Discount:'.toUpperCase(),
                                                    style: StyleResources
                                                        .mediumBoldText(
                                                            context, 8),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 50.0,
                                                  child: Text(
                                                    currency(widget.discount),
                                                    style: StyleResources
                                                        .boldBlackText(
                                                            context, 8),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                      const SizedBox(height: 4.0),
                                      Container(
                                        height: 20.0,
                                        color: ColorResource.greyColor
                                            .withOpacity(0.1),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 90.0,
                                                child: Text(
                                                  'Total Balance: ',
                                                  style: StyleResources
                                                      .mediumBoldBlueText(
                                                          context, 10),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50.0,
                                                child: Text(
                                                  currency(
                                                      calculateTotalBalance()),
                                                  style: StyleResources
                                                      .mediumBoldBlueText(
                                                          context, 10),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Payment Info:',
                                    style: StyleResources.mediumBlackText(
                                        context, 8),
                                  ),
                                  const SizedBox(height: 2.0),
                                  Text(
                                    'Google Pay',
                                    style:
                                        StyleResources.mediumGreyText8(context),
                                  ),
                                  Text(
                                    '+91 81290 13343',
                                    style:
                                        StyleResources.mediumGreyText8(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: double.infinity,
                          color: ColorResource.invoicePrimaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 4.0),
                            child: Center(
                              child: Text(
                                'Thank you for your support - THE BLENDING STUDIO',
                                style: StyleResources.normalWhiteText8(context),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              child: Opacity(
                opacity: 0.0,
                child: Image.asset(
                  'assets/invoice.jpg',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> takeBillPdf() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final pdf = pw.Document();
        final imageMemory = pw.MemoryImage(image);

        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Image(imageMemory),
              );
            },
          ),
        );

        final output = await getTemporaryDirectory();
        final file = File("${output.path}/invoice.pdf");
        await file.writeAsBytes(await pdf.save());

        final xFile = XFile(file.path);
        await Share.shareXFiles([xFile], text: 'Invoice');
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  String calculateTotalBalance() {
    int advanceAmount = int.parse(widget.advanceAmt);
    int discountAmount =
        widget.discount.isNotEmpty ? int.parse(widget.discount) : 0;
    int totalBalance = total - advanceAmount - discountAmount;
    return totalBalance.toString();
  }
}

String currency(String amount) {
  return '\u{20B9} $amount';
}

class Invoice {
  final String customerName;
  final String address;
  final int advance;
  final List<InvoiceItem> items;

  Invoice(
    this.advance,
    double field, {
    required this.customerName,
    required this.address,
    required this.items,
    required int advanceAmt,
    required String discount,
    // required int advance
  });

  get price => null;

  get discount => null;

  get advanceAmt => null;
}

class InvoiceItem {
  final String name;
  final int price;
  final int quantity;

  InvoiceItem(
      {required this.name, required this.price, required this.quantity});
}
