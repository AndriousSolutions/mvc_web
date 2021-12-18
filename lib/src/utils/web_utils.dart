// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert' show utf8;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show AnchorElement, Blob, FileReader, Url;

import 'package:file_picker/file_picker.dart';

import 'package:universal_html/html.dart';

class WebUtils {
  //
  Future<File?> textFile() async {
    //
    File? fileObj;
    FilePickerResult? result;

    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
      );
    } catch (e) {
      result = null;
    }

    if (result != null) {
      //
      final file = result.files.first;

      fileObj = File(file.bytes!, file.path!);
    }
    return fileObj;
  }

  Future<List<String>> updateTextFile() async {
    return readTextFile();
  }

  Future<List<String>> readTextFile() async {
    //
    List<String> text = [];

    final File? file = await textFile();

    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      withReadStream: true,
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    //
    if (file != null) {
      final reader = FileReader();
      reader.readAsText(file);
      text = reader.result.toString().split('\n');
    }

    if (result != null) {
      final PlatformFile file = result.files.first;
      final Stream<String> fileContent = file.readStream!.map(utf8.decode);
      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);
      final lines = await fileContent.single;
      text = lines.split('\n');
    }
    return text;
  }

  bool saveTextFile(List<String>? text, String? fileName) {
    //
    if (text == null || text.isEmpty) {
      return false;
    }

    if (fileName == null || fileName.isEmpty) {
      return false;
    }

    fileName = fileName.trim();

//    readTextFile();

    final name = this.fileName(fileName);

    final ext = fileExt(name);

    if (ext.isEmpty) {
      fileName = '$name.txt';
    }

    bool save;

    try {
      final blob = Blob(text, 'text/plain', 'native');
      AnchorElement()
        //ignore:unsafe_html
        ..href = Url.createObjectUrlFromBlob(blob).toString()
        ..download = fileName
        ..style.display = 'none'
        ..click();
      save = true;
    } catch (e) {
      save = false;
    }
    return save;
  }

  String fileExt(String? file) {
    if (file == null || file.isEmpty) {
      return '';
    }
    file = file.trim();
    String ext;
    if (file.lastIndexOf('.') < 0) {
      ext = '';
    } else {
      ext = file.split('.').last;
    }
    return ext;
  }

  String fileName(String? file) {
    if (file == null || file.isEmpty) {
      return '';
    }
    return file.trim().split('/').last;
  }
}
