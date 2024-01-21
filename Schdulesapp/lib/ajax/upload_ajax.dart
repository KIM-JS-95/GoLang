// 이미지 전송 비동기 전송
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';
import '../models/UserProvider.dart';

class Uploadajax {
  static Future<XFile?> uploadajax(User user) async {
    final backAddr = 'http://10.0.2.2:8080/flutter';
    XFile? _pickedFile;

    try {
      _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_pickedFile == null) {
        print('No image picked.');
        return null;
      }

      final uri = Uri.parse(backAddr);
      final request = http.MultipartRequest('POST', uri);

      // Add file to the request
      request.files.add(await http.MultipartFile.fromPath('image', _pickedFile.path));

      // Set headers
      request.headers.addAll(<String, String>{
        'Content-Type': 'multipart/form-data',
        'Authorization': user.auth, // Replace with the actual token
      });

      final response = await request.send();

      if (response.statusCode == 200) {
        // Upload successful
        String responseBody = await response.stream.bytesToString();
        print('Image uploaded successfully. Server response: $responseBody');
      } else {
        // Upload failed
        print('Failed to upload image. Status code: ${response.statusCode}');
      }

    } catch (error) {
      print('Error during image upload: $error');
    }

    return _pickedFile;
  }
}