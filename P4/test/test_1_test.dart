import 'package:flutter_test/flutter_test.dart';
import '../lib/text_component.dart';  // Reemplaza con el nombre real de tu proyecto
import '../lib/text_manager.dart';  // Reemplaza con el nombre real de tu proyecto
import 'package:flutter/material.dart';

void main() {
  group('Funcionalidad1', () {
    late TextManager gestor;

    // Configuración inicial para cada prueba
    setUp(() {
      gestor = TextManager([]);
    });

    // Prueba para el cambio básico de texto
    test('Prueba de Cambio de Texto Base', () async {
      StyledText nuevoTexto = StyledText(
        1,
        'pilila',  // Argumento posicional para content
        usuario: 'Juanma',
        bold: false,
        italic: false,
        underline: false,
      );
      await gestor.addText(nuevoTexto);
      
      // Definir el estilo de texto con la propiedad correcta
      final textStyle = TextStyle(fontWeight: FontWeight.normal);
      
      // Verificar el contenido de 'gestor.texts'
      expect(gestor.texts.length, 1);
      expect(gestor.texts.first.content, 'pilila');
      expect(gestor.texts.first.usuario, 'Juanma');
      // Verificación de estilos (descomentar si la función applyStyle está implementada)
      // expect(gestor.texts.first.applyStyle(textStyle), textStyle);
    });

    // Prueba para aplicar estilo sin decoración
    test('Prueba sin Decoración', () async {
      final plainText = StyledText(
        2, 
        'Hello, world!', 
        usuario: 'TestUser',
      );
      final textStyle = TextStyle(fontSize: 16.0);

      await gestor.addText(plainText);
      expect(gestor.texts.length, 1);
      expect(gestor.texts.first.applyStyle(textStyle), textStyle);
    });

    // Prueba para combinaciones de decoradores
    test('Prueba de Combinación de Decoradores', () async {
      final textStyle = TextStyle(fontSize: 16.0);
      final styledText = StyledText(
        3, 
        'Combined Style', 
        usuario: 'TestUser',
        bold: true,
        italic: true,
      );

      await gestor.addText(styledText);
      final combinedStyle = styledText.applyStyle(textStyle);

      expect(gestor.texts.length, 1);
      expect(combinedStyle, textStyle.copyWith(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic));
    });

    // Prueba para diferentes decoradores de texto
    
  });
}
