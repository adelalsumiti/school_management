import 'dart:io';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/data/model/invoicemodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfInvoiceModel {
  dynamic pdfPath;
  // dynamic invoiceName;
  // dynamic date;
  // dynamic invid;
  // dynamic customerName;

  int? countColumn;
  InvoiceModel? invoiceModel;
  PdfInvoiceModel({
    this.pdfPath,
    // this.invoiceName,
    // this.date,
    // this.customerName,
    // this.invid,
    this.countColumn,
    this.invoiceModel,
  });
  final countItem = 0;
  int ind = 0;
  // List<InvoiceBillsModel> _bills = [];
  // int _getCountItemPrint() {
  //   if (_bills.length > 15) {
  //     return 15;
  //   } else {
  //     return _bills.length;
  //   }
  // }

  int _getCountPage() {
    if (invoiceModel == null) {
      return 0;
    } else if (invoiceModel!.bills == null) {
      return 0;
    } else if (invoiceModel!.bills!.isEmpty) {
      return 0;
    } else {
      double co = (invoiceModel!.bills!.length / 15);
      return co.ceil();
    }
  }

  Future<File?> generatePDF() async {
    final File? file;
    if (invoiceModel != null) {
      if (invoiceModel!.bills != null) {
        // _bills = invoiceModel!.bills!;
        int countPage = _getCountPage();

        final PdfDocument document = PdfDocument();
        print(
            "=====generatePDF================${invoiceModel!.bills!.length}==================");
        for (int i = 0; i < countPage; i++) {
          //Create a PDF document.
          //Add page to the PDF
          final PdfPage page = document.pages.add();
          //Get page client size
          final Size pageSize = page.getClientSize();
          //Draw rectangle
          page.graphics.drawRectangle(
              bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
              pen: PdfPen(PdfColor(142, 170, 219)));
          //Generate PDF grid.
          final PdfGrid grid = _getGrid();
          //Draw the header section by creating text element
          final PdfLayoutResult result = _drawHeader(page, pageSize, grid);
          //Draw grid
          _drawGrid(page, grid, result);
          //Add invoice footer
          _drawFooter(page, pageSize);
        }
        ind = 0;
        //Save and dispose the document.
        final List<int> bytes = await document.save();
        document.dispose();
        //Launch file.
        // final Directory? directory = await getDownloadsDirectory();
        // final path = directory!.path;
        // pdfPath = pdfPath ?? "Invoice44";
        // print("========path=======================$path======================");
        file = File('$pdfPath');

        return await file.writeAsBytes(bytes, flush: false);
      } else {
        return null;
      }
    } else {
      return null;
    }
    // await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice.pdf');
  }

//Draws the invoice header
  PdfLayoutResult _drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(invoiceModel!.table ?? 'INVOICE',
        PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));
    page.graphics.drawString(r'$' + _getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Amount', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        'Invoice Number: ${invoiceModel!.invId}\r\n\r\nDate: ${invoiceModel!.dateCre}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    String name = invoiceModel!.accName!.codeUnits.toString();
    print("==name===========$name===========");
    String address = 'Bill To:  Fares Mohammed';
    PdfTextElement(
      text: invoiceNumber,
      font: contentFont,
    ).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));
    return PdfTextElement(
      text: address,
      font: contentFont,
    ).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

//Draws the grid
  void _drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
    //Draw grand total.
    page.graphics.drawString('Grand Total',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds!.left,
            result.bounds.bottom + 10,
            quantityCellBounds!.width,
            quantityCellBounds!.height));
    page.graphics.drawString(_getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom + 10,
            totalPriceCellBounds!.width,
            totalPriceCellBounds!.height));
  }

//Draw the invoice footer data.
  void _drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
        PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));
    const String footerContent =
        '800 Interchange Blvd.\r\n\r\nSuite 2501, Austin, TX 78721\r\n\r\nAny Questions? support@adventure-works.com';
    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

//Create PDF grid and return
  PdfGrid _getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: countColumn);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    if (countColumn == 5) {
      headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(
          AppColors.primaryColor.red,
          AppColors.primaryColor.green,
          AppColors.primaryColor.blue));
      headerRow.style.textBrush = PdfBrushes.black;
      headerRow.cells[0].value = 'Item Id';
      headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
      headerRow.cells[1].value = 'Item Name';
      headerRow.cells[2].value = 'Price';
      headerRow.cells[3].value = 'Quantity';
      headerRow.cells[4].value = 'Total';
    } else if (countColumn == 6) {
      headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(
          AppColors.primaryColor.red,
          AppColors.primaryColor.green,
          AppColors.primaryColor.blue));
      headerRow.style.textBrush = PdfBrushes.black;
      headerRow.cells[0].value = 'Item Id';
      headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
      headerRow.cells[1].value = 'Item Name';
      headerRow.cells[2].value = 'Color Name';
      headerRow.cells[3].value = 'Price';
      headerRow.cells[4].value = 'Quantity';
      headerRow.cells[5].value = 'Total';
    } else {
      headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(
          AppColors.primaryColor.red,
          AppColors.primaryColor.green,
          AppColors.primaryColor.blue));
      headerRow.style.textBrush = PdfBrushes.black;
      headerRow.cells[0].value = 'Item Id';
      headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
      headerRow.cells[1].value = 'Item Name';
      headerRow.cells[2].value = 'Color Name';
      headerRow.cells[3].value = 'Size Name';
      headerRow.cells[4].value = 'Price';
      headerRow.cells[5].value = 'Quantity';
      headerRow.cells[6].value = 'Total';
    }

    _addProducts(grid);
    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
    // addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
    // addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
    // addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    if (countColumn == 5) {
      grid.columns[1].width = 200;
    } else if (countColumn == 6) {
      grid.columns[1].width = 150;
    } else {
      grid.columns[1].width = 100;
    }
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

//Create and row for the grid.
  void _addProducts(PdfGrid grid) {
    // int count = _getCountItemPrint();
    // List<InvoiceBillsModel> list = _bills;
    // print(
    //     "==count==$count=====invoice=No===${invoiceModel!.invId}======Countbills======${invoiceModel!.bills!.length}========");
    int count = 0;
    for (int i = ind; i < invoiceModel!.bills!.length; i++) {
      InvoiceBillsModel bill = invoiceModel!.bills![i];
      final PdfGridRow row = grid.rows.add();
      if (countColumn == 5) {
        row.cells[0].value = bill.itmId;
        row.cells[1].value = bill.itmName;
        row.cells[2].value = bill.price.toString();
        row.cells[3].value = bill.qty.toString();
        row.cells[4].value =
            (double.parse(bill.price ?? "1") * double.parse(bill.qty ?? "1"))
                .toString();
      } else if (countColumn == 6) {
        row.cells[0].value = bill.itmId;
        row.cells[1].value = bill.itmName;
        row.cells[2].value = bill.clrName;
        row.cells[3].value = bill.price.toString();
        row.cells[4].value = bill.qty.toString();
        row.cells[5].value =
            (double.parse(bill.price ?? "1") * double.parse(bill.qty ?? "1"))
                .toString();
      } else {
        row.cells[0].value = bill.itmId;
        row.cells[1].value = bill.itmName;
        row.cells[2].value = bill.clrName;
        row.cells[3].value = bill.sizeName;
        row.cells[4].value = bill.price.toString();
        row.cells[5].value = bill.qty.toString();
        row.cells[6].value =
            (double.parse(bill.price ?? "1") * double.parse(bill.qty ?? "1"))
                .toString();
      }
      ind++;
      if (count == 14) {
        break;
      } else {
        count++;
      }
    }
  }

//Get the total amount.
  double _getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value =
          grid.rows[i].cells[grid.columns.count - 1].value as String;
      total += double.parse(value);
    }
    return total;
  }
}
