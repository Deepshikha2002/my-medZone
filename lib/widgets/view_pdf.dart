import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class ViewPDF extends StatefulWidget {
  PDFDocument document;
  ViewPDF(this.document);
  @override
  _ViewPDFState createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: PDFViewer(document: widget.document));
  }
}
