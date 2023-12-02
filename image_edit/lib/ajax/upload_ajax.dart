import 'package:image_edit/const/addr.dart';

// 이미지 전송 비동기 전송
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Uploadajax {
  static Future<XFile> uploadajax() async {
    XFile? _pickedFile;
    final uri = Uri.parse(back_addr);

    /// 안드로이드 로컬 혹스트는 127.0.0.1 이 아님
    final request = http.MultipartRequest('POST', uri);
    request.files
        .add(await http.MultipartFile.fromPath('image', _pickedFile!.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      // Upload successful
      String responseBody = await response.stream.bytesToString();
      print('Image uploaded successfully. Server response: $responseBody');
    } else {
      // Upload failed
      print('Failed to upload image');
    }
    return _pickedFile;
  }
}
