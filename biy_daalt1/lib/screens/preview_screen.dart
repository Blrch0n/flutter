import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../models/prescription.dart';
import '../pdf/prescription_pdf.dart';

class PreviewScreen extends StatelessWidget {
  final Prescription prescription;
  const PreviewScreen({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Preview')),
      body: PdfPreview(
        build: (f) => buildPrescriptionPdf(prescription),
        canChangePageFormat: false, canChangeOrientation: false,
      ),
    );
  }
}
