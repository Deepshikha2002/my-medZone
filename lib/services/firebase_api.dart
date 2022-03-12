
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medicdocumentsaver2/api/firebase_file.dart';
import 'package:open_file/open_file.dart';

import 'package:path_provider/path_provider.dart';


class FirebaseApi{
  static UploadTask? uploadFile(String destination, File file){
    try {
      final ref= FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      // TODO
      return null;
    }
  }
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
    Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async{
    final ref= FirebaseStorage.instance.ref('files/');
    final result = await ref.listAll();

    final urls= await _getDownloadLinks(result.items);
    return urls
        .asMap()
        .map((index, url) {
          final ref= result.items[index];
          final name= ref.name;
          print(name);
          final file= FirebaseFile(ref: ref,name:name,url:url);

          return MapEntry(index, file);
    }).values.toList();
  }
  static Future downloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');

    await ref.writeToFile(file);
  }

  // static Future<File> loadFirebase(String url) async {
  //   try {
  //     final refPDF = FirebaseStorage.instance.ref().child(url);
  //     final bytes = await refPDF.getData();
  //
  //     return _storeFile(url);
  //   } catch (e) {
  //     return null;
  //   }
  // }
  //
  // static Future<File> _storeFile(String url) async {
  //   final filename = basename(url);
  //   final dir = await getApplicationDocumentsDirectory();
  //
  //   final file = File('${dir.path}/$filename');
  //   // await file.writeAsBytes(bytes, flush: true);
  //   return file;
  // }


  // Future<File> saveFilePermanently(PlatformFile filex) async {
  //   final appStorage= await getApplicationDocumentsDirectory();
  //   final newFile= File('${appStorage.path}/${filex.name}');
  //   return File(filex.path!).copy(newFile.path);
  // }
  void openFile(PlatformFile file){
    OpenFile.open(file.path!);
  }
  // void openFiles(List<PlatformFile> files)=>
  //     Navigator.of(this.context).push(MaterialPageRoute(
  //       builder: (context)=> FilesPage(
  //         files:files,
  //         onOpenedFile:openFile,
  //       ),
  //     ));
}
