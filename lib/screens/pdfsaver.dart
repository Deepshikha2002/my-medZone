import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:firebase_storage/firebase_storage.dart' ;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:schedule_reminder/widgets/image_page.dart';
import 'package:schedule_reminder/services/firebase_api.dart';
import 'package:schedule_reminder/widgets/view_pdf.dart';
import 'package:schedule_reminder/model/firebase_file.dart';
import 'package:path/path.dart'  ;
import '../services/firebase_api.dart';
class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  late Future<List<FirebaseFile>> futureFiles;
  UploadTask? task;
  File? file;
  @override
  void initState() {
    super.initState();
    futureFiles= FirebaseApi.listAll('/');
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[200],
        title: Text("medic Doc saver"),
        centerTitle:true,
      ),
      body: FutureBuilder<List<FirebaseFile>>(
        future:futureFiles,
        builder:(context,snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if(snapshot.hasError){
                return Center(child: Text('some error occured'),);
              }else {
                final files = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(files.length),
                    const SizedBox(height: 12,),
                    Expanded(
                        child: ListView.builder(
                            itemCount: files.length,
                          itemBuilder: (context,index){
                              final file=files[index];
                              return buildFile(context,file);
                          },
                        ))
                  ],);
              }
          }
        },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final result= await FilePicker.platform.pickFiles(
              allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ['pdf', 'doc','jpg', 'png','jpeg'],
          );
          if(result==null) return;

         // final file = result.files.first;
          final path = result.files.first.path;
          setState(()=> file = File(path!));
          uploadFile(file);


        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.cyan[200],
      ),

    );

   }
  Widget buildFile(BuildContext context, FirebaseFile file)=>ListTile(
    leading:
    ClipOval(
      child:  (file.name.contains('pdf'))?
      (const Icon(
        Icons.picture_as_pdf,
        size: 44.0)
      ):
    Image.network(
    file.url,
    width: 52,
    height: 52,
    fit: BoxFit.cover,
    ),
    ),

    title: Text(
      file.name,
      style:TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.black,
      ),
    ),
    onTap: () async {
      if(file.name.contains('.pdf')){
        String downloadURL = await file.ref.getDownloadURL();
        print(downloadURL);
        PDFDocument doc = await PDFDocument.fromURL(downloadURL);
        Navigator.push(this.context, MaterialPageRoute(builder: (context)=>ViewPDF(doc)));
      }
      else {
        Navigator.of(context).push(MaterialPageRoute(

          builder: (context) => ImagePage(file: file),
        ));
      }
    }
  );
  Widget buildHeader(int length) => ListTile(
    tileColor: Colors.cyan[100],
    leading: Container(
      width: 52,
      height: 52,
      child: Icon(
        Icons.file_copy,
        color: Colors.white,
      ),
    ),
    title: Text(
      '$length Files',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
   Future uploadFile(file) async{
    if(file==null) return ;
    final fileName = basename(file!.path);
    final destination ='files/$fileName';
    task=FirebaseApi.uploadFile(destination, file!);
  }
  // Future<void> downloadURLExample(file) async {
  //   String downloadURL = await file.ref().getDownloadURL();
  //   print(downloadURL);
  //   PDFDocument doc = await PDFDocument.fromURL(downloadURL);
  //   Navigator.push(this.context, MaterialPageRoute(builder: (context)=>ViewPDF(doc)));  //Notice the Push Route once this is done.
  // }





}
