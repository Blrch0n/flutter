import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/prescription.dart';

pw.Widget _hRule() => pw.Container(height: .8, color: PdfColors.grey600);
pw.Widget _labelLine(pw.Font font, String label) => pw.Row(children:[pw.Text(label, style: pw.TextStyle(font: font, fontSize: 10)), pw.SizedBox(width:6), pw.Expanded(child: _hRule())]);
pw.Widget _threeCols(pw.Font font, String a, String b, String c) => pw.Row(children:[pw.Expanded(child:_labelLine(font,a)), pw.SizedBox(width:10), pw.Expanded(child:_labelLine(font,b)), pw.SizedBox(width:10), pw.Expanded(child:_labelLine(font,c))]);

pw.Widget _rpBlock(pw.Font font, PrescriptionItem? it){
  final small = pw.TextStyle(font: font, fontSize: 9);
  final bold  = pw.TextStyle(font: font, fontSize:10, fontWeight: pw.FontWeight.bold);
  return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children:[
    pw.Text('Rp:', style: bold),
    pw.SizedBox(height:2),
    if(it!=null)...[
      pw.Text('Эмийн нэр: ${it.medName}', style: small),
      pw.Text('Тун, хэмжээ: ${it.strength}', style: small),
      pw.Text('Хэлбэр: ${it.form}', style: small),
      pw.Text('Хэрэглэх арга, давтамж: ${it.sig}', style: small),
      pw.Text('Хэрэглэх зам: ${it.route}', style: small),
      pw.Text('Хугацаа: ${it.duration}', style: small),
    ] else pw.SizedBox(height:40),
    pw.SizedBox(height:2),
    pw.Text('S:', style: bold),
    pw.SizedBox(height:14),
  ]);
}

pw.Widget _dispenseTable(pw.Font font, List<PrescriptionItem> items){
  final head = pw.TextStyle(font: font, fontSize: 9, fontWeight: pw.FontWeight.bold);
  final cell = pw.TextStyle(font: font, fontSize: 9);
  return pw.Table(border: pw.TableBorder.all(color: PdfColors.grey600, width: .6), columnWidths: {
    0: const pw.FlexColumnWidth(1), 1: const pw.FlexColumnWidth(4), 2: const pw.FlexColumnWidth(3), 3: const pw.FlexColumnWidth(2),
  }, children: [
    pw.TableRow(decoration: const pw.BoxDecoration(color: PdfColorGrey(0.95)), children:[
      pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('№', style: head)),
      pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Эмийн нэр, тун, хэмжээ, хэлбэр', style: head)),
      pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Хэрэглэх арга, хугацаа', style: head)),
      pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Олгосон /гарын үсэг/', style: head)),
    ]),
    ...List.generate(3, (i){
      final it = i < items.length ? items[i] : null;
      return pw.TableRow(children:[
        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('${i+1}', style: cell)),
        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(it==null?'':'${it.medName} ${it.strength} (${it.form})', style: cell)),
        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(it==null?'':'${it.sig} • ${it.duration}', style: cell)),
        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('', style: cell)),
      ]);
    }),
  ]);
}

Future<Uint8List> buildPrescriptionPdf(Prescription rx) async {
  final ttf = await rootBundle.load('assets/fonts/DejaVuSans.ttf');
  final font = pw.Font.ttf(ttf);
  final small = pw.TextStyle(font: font, fontSize: 9);

  final doc = pw.Document();
  doc.addPage(pw.Page(pageFormat: PdfPageFormat.a4, margin: const pw.EdgeInsets.all(24), build: (ctx){
    return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.stretch, children:[
      pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.end, children:[
        pw.Text('MNS 5376:2016', style: small),
        pw.Expanded(child: pw.Column(children:[
          pw.Text('A хавсралт', style: pw.TextStyle(font: font, fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.Text('(норматив)', style: small),
          pw.Text('Энгийн эмийн жорын маягт', style: pw.TextStyle(font: font, fontSize: 12, fontWeight: pw.FontWeight.bold)),
        ])),
        pw.SizedBox(width:60),
      ]),
      pw.SizedBox(height:8),
      pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children:[
        // LEFT
        pw.Expanded(child: pw.Container(padding: const pw.EdgeInsets.all(10), decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey600, width: .8)), child:
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.stretch, children:[
            pw.Center(child: pw.Text('Энгийн эмийн жор', style: pw.TextStyle(font: font, fontSize: 11, fontWeight: pw.FontWeight.bold))),
            pw.SizedBox(height:6),
            pw.Align(alignment: pw.Alignment.centerRight, child: pw.Text('${DateFormat('yyyy').format(rx.patient.date)} оны ${DateFormat('MM').format(rx.patient.date)} сарын ${DateFormat('dd').format(rx.patient.date)}', style: small)),
            pw.SizedBox(height:6),
            _labelLine(font, 'Өвчтөний овог, нэр:'),
            pw.SizedBox(height:8),
            _threeCols(font, 'Нас:', 'Хүйс:', 'Онош:'),
            pw.SizedBox(height:8),
            _labelLine(font, 'Регистрийн №'),
            pw.SizedBox(height:10),
            ...List.generate(3, (i)=> _rpBlock(font, i < rx.items.length ? rx.items[i] : null)),
            _labelLine(font, 'Жор бичсэн эмчийн нэр, утас, тэмдэг:'),
            pw.SizedBox(height:8),
            _labelLine(font, 'Эмийн санчийн нэр:'),
            pw.SizedBox(height:10),
            _dispenseTable(font, rx.items),
          ]))),
        pw.SizedBox(width:10),
        // RIGHT
        pw.Expanded(child: pw.Container(padding: const pw.EdgeInsets.all(10), decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey600, width: .8)), child:
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children:[
            pw.Text('Энэхүү маягтыг 3-аас ихгүй бүлэг эмд ашиглана. Жор 7 хоног хүчинтэй.', style: small),
            pw.SizedBox(height:4),
            pw.Text('Эмийн нэр, тун, хэлбэр, хэрэглээ, хугацаа, эмчийн тэмдэгийг тодорхой бичнэ.', style: small),
            pw.SizedBox(height:4),
            pw.Text('Эмийн сан жорыг бүртгэлд авч, ар талын хүснэгтийг бөглөнө.', style: small),
            pw.SizedBox(height:12),
            pw.Table(border: pw.TableBorder.all(color: PdfColors.grey600, width: .6), columnWidths: const {
              0: pw.FlexColumnWidth(3), 1: pw.FlexColumnWidth(3), 2: pw.FlexColumnWidth(3), 3: pw.FlexColumnWidth(3), 4: pw.FlexColumnWidth(2),
            }, children: [
              pw.TableRow(decoration: const pw.BoxDecoration(color: PdfColorGrey(0.95)), children:[
                pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Жор хүлээн авсан', style: small)),
                pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Бэлтгэсэн', style: small)),
                pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Шалгасан', style: small)),
                pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Олгосон', style: small)),
                pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Оноо', style: small)),
              ]),
              ...List.generate(4, (_)=> pw.TableRow(children: List.generate(5, (__)=> pw.SizedBox(height:24)))),
            ]),
            pw.SizedBox(height:12),
            _hRule(),
            pw.SizedBox(height:6),
            pw.Text('Энэ хэсгийг эмийн сан хэрэглэнэ.', style: small),
          ]))),
      ]),
      pw.SizedBox(height:6),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children:[pw.Text('Урд тал', style: small), pw.Text('Ар тал', style: small)]),
      pw.SizedBox(height:6),
      pw.Center(child: pw.Text('6', style: small)),
    ]);
  }));
  return doc.save();
}
