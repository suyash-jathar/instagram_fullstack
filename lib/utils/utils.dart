import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// pickImage(ImageSource source)
// async{
//   final ImagePicker _imagepicker=ImagePicker();
//   XFile? _file=await _imagepicker.pickImage(source: source);
//   if(_file!=null)
//   {
//     return await _file.readAsBytes();
//   }
//   // print('Image is Not Selected');
// }

// showSnackBar(BuildContext context,String content)
// {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(content),
//       // duration: Duration(seconds: 2),
//     ),
//   );
// }

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}