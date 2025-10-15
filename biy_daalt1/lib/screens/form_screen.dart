import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/prescription.dart';
import '../utils/dose_calc.dart';
import 'preview_screen.dart';

class FormScreen extends StatefulWidget { const FormScreen({super.key}); @override State<FormScreen> createState()=>_FormScreenState(); }
class _FormScreenState extends State<FormScreen>{
  final _formKey = GlobalKey<FormState>();
  final _items=<PrescriptionItem>[];
  final _name=TextEditingController(); final _sex=TextEditingController(text:'Эр');
  final _diag=TextEditingController(); final _reg=TextEditingController();
  final _doc=TextEditingController(text:'Др. Нэр'); final _phone=TextEditingController(text:'99112233');
  DateTime _date=DateTime.now();
  final _med=TextEditingController(),_str=TextEditingController(text:'500 мг'),_form=TextEditingController(text:'Шахмал'),_sig=TextEditingController(text:'1ш 3 удаа'),_route=TextEditingController(text:'Амаар'),_dur=TextEditingController(text:'7 хоног');
  final _dose=TextEditingController(text:'500'),_freq=TextEditingController(text:'3'),_days=TextEditingController(text:'7'),_mg=TextEditingController(text:'500');
  String _info='';
  void _add(){ setState(()=>_items.add(PrescriptionItem(medName:_med.text,strength:_str.text,form:_form.text,sig:_sig.text,route:_route.text,duration:_dur.text))); _med.clear(); }
  void _calc(){ final r=computeDose(doseMg:double.parse(_dose.text),freqPerDay:int.parse(_freq.text),days:int.parse(_days.text),mgPerUnit:double.parse(_mg.text));
    setState(()=>_info='Тун: ${r['schedule']} → нэг удаад ${(r['unitsPerDose'] as double).toStringAsFixed(2)} нэгж, нийт ${(r['totalUnits'] as double).toStringAsFixed(0)} нэгж'); }
  @override Widget build(BuildContext c){
    return Scaffold(appBar: AppBar(title: const Text('Эмийн жор бичих')),body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(12),child: Form(key:_formKey,child: Column(crossAxisAlignment: CrossAxisAlignment.start,children:[
      Row(children:[Image.asset('assets/images/med.png',width:48,height:48),const SizedBox(width:8),Text('MNS 5376:2016 загвартай PDF',style: Theme.of(c).textTheme.titleLarge)],),
      const SizedBox(height:12),
      Wrap(spacing:12,runSpacing:12,children:[
        SizedBox(width:300,child: TextFormField(controller:_name, decoration: const InputDecoration(labelText:'Өвчтөний овог, нэр'), validator:(v)=>v==null||v.isEmpty?'Шаардлагатай':null)),
        SizedBox(width:120,child: TextFormField(controller:_sex, decoration: const InputDecoration(labelText:'Хүйс'))),
        SizedBox(width:300,child: TextFormField(controller:_diag, decoration: const InputDecoration(labelText:'Онош'))),
        SizedBox(width:200,child: TextFormField(controller:_reg, decoration: const InputDecoration(labelText:'Регистрийн №'))),
        SizedBox(width:200,child: InkWell(onTap:() async {final d=await showDatePicker(context:c,firstDate:DateTime(2000),lastDate:DateTime(2100),initialDate:_date);if(d!=null)setState(()=>_date=d);}, child: InputDecorator(decoration: const InputDecoration(labelText:'Огноо'), child: Text(DateFormat('yyyy-MM-dd').format(_date))))),
      ]),
      const SizedBox(height:12),
      Wrap(spacing:12,runSpacing:12,children:[
        SizedBox(width:240,child: TextFormField(controller:_med, decoration: const InputDecoration(labelText:'Эмийн нэр'))),
        SizedBox(width:140,child: TextFormField(controller:_str, decoration: const InputDecoration(labelText:'Тун'))),
        SizedBox(width:140,child: TextFormField(controller:_form, decoration: const InputDecoration(labelText:'Хэлбэр'))),
        SizedBox(width:260,child: TextFormField(controller:_sig, decoration: const InputDecoration(labelText:'Хэрэглэх арга'))),
        SizedBox(width:140,child: TextFormField(controller:_route, decoration: const InputDecoration(labelText:'Зам'))),
        SizedBox(width:140,child: TextFormField(controller:_dur, decoration: const InputDecoration(labelText:'Хугацаа'))),
        FilledButton.icon(onPressed:_add, icon: const Icon(Icons.add), label: const Text('Нэмэх')),
      ]),
      const SizedBox(height:8),
      ..._items.map((e)=>ListTile(title: Text('${e.medName} ${e.strength} (${e.form})'),subtitle: Text('${e.sig}, ${e.route}, ${e.duration}'))),
      const Divider(),
      Wrap(spacing:12,runSpacing:12,children:[
        SizedBox(width:120,child: TextField(controller:_dose, decoration: const InputDecoration(labelText:'Тун мг'))),
        SizedBox(width:120,child: TextField(controller:_freq, decoration: const InputDecoration(labelText:'Өдөрт удаа'))),
        SizedBox(width:120,child: TextField(controller:_days, decoration: const InputDecoration(labelText:'Өдөр'))),
        SizedBox(width:120,child: TextField(controller:_mg, decoration: const InputDecoration(labelText:'1 ширхэг мг'))),
        OutlinedButton(onPressed:_calc, child: const Text('Тооцоолох')),
      ]),
      if(_info.isNotEmpty) Padding(padding: const EdgeInsets.only(top:6), child: Text(_info)),
      const SizedBox(height:12),
      FilledButton(onPressed:(){
        if(!_formKey.currentState!.validate()) return;
        final rx=Prescription(patient: Patient(fullName:_name.text, sex:_sex.text, diagnosis:_diag.text, regNo:_reg.text, date:_date), doctorName:_doc.text, doctorPhone:_phone.text, items: List.of(_items));
        Navigator.of(c).push(MaterialPageRoute(builder:(_)=>PreviewScreen(prescription: rx)));
      }, child: const Text('Preview PDF')),
    ])))));}
}
