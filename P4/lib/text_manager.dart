import 'dart:convert';
import 'text_component.dart';
import 'package:http/http.dart' as http;

class TextManager {
  final String apiUrl = 'http://localhost:3000/texts';
  List<StyledText> texts = [];

  TextManager(this.texts);

  Future<http.Response> loadTexts(String usuario) async {
    final response = await http.get(Uri.parse('$apiUrl?usuario=$usuario'));

    if (response.statusCode == 200) {
      List<dynamic> textsJson = json.decode(response.body);
      texts.clear();
      texts.addAll(textsJson.map((json) => StyledText.fromJson(json)).toList());
    } 
    return response;
  }

  // Other methods...



  Future<void> addText(StyledText text) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(text.toJson()),
    );

    if (response.statusCode == 201) {
      texts.add(StyledText.fromJson(json.decode(response.body)));
    } else {
      throw Exception('Failed to add text: ${response.body}');
    }
  }

  Future<void> deleteText(StyledText text) async {
    final response = await http.delete(Uri.parse('$apiUrl/${text.id}'));

    if (response.statusCode == 200) {
      texts.removeWhere((t) => t.id == text.id);
    } else {
      throw Exception('Failed to delete text');
    }
  }
}
