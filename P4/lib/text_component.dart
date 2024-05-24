import 'package:flutter/material.dart';

abstract class TextComponent {
  TextStyle applyStyle(TextStyle textStyle);
  Map<String, dynamic> toJson();
}

class PlainText implements TextComponent {
  String content;

  PlainText(this.content);

  @override
  TextStyle applyStyle(TextStyle textStyle) {
    return textStyle;
  }

  @override
  Map<String, dynamic> toJson() {
    return {'content': content, 'bold': false, 'italic': false, 'underline': false};
  }
}

class StyledText extends PlainText {
  int? id;
  String usuario;
  bool bold;
  bool italic;
  bool underline;

  StyledText(this.id, String content, {required this.usuario, this.bold = false, this.italic = false, this.underline = false}) : super(content);

  @override
  TextStyle applyStyle(TextStyle textStyle) {
    TextStyle style = textStyle;
    if (bold) style = style.copyWith(fontWeight: FontWeight.bold);
    if (italic) style = style.copyWith(fontStyle: FontStyle.italic);
    if (underline) style = style.copyWith(decoration: TextDecoration.underline);
    return style;
  }
  
factory StyledText.fromJson(Map<String, dynamic> json) {
  return StyledText(
    json['id'] as int?,
    json['content'] as String,
    usuario: json['usuario'] as String,
    bold: json['bold'] as bool,
    italic: json['italic'] as bool,
    underline: json['underline'] as bool,
  );
}


  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'content': content,
      'usuario': usuario,
      'bold': bold,
      'italic': italic,
      'underline': underline,
    };
  }

  @override
  String toString() {
    return '$content - Bold: $bold, Italic: $italic, Underline: $underline';
  }
}
