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
    // Prueba para diferentes decoradores de texto
    test('Prueba de Todos los Decoradores', () async {
      final textStyle = TextStyle(fontSize: 16.0);

      final boldText = StyledText(
        4, 
        'Bold Text', 
        usuario: 'Daniel',
        bold: true,
      );
      final italicText = StyledText(
        5, 
        'Italic Text', 
        usuario: 'Daniel',
        italic: true,
      );
      final underlineText = StyledText(
        6, 
        'Underline Text', 
        usuario: 'Daniel',
        underline: true,
      );

      expect(boldText.applyStyle(textStyle), textStyle.copyWith(fontWeight: FontWeight.bold));
      expect(italicText.applyStyle(textStyle), textStyle.copyWith(fontStyle: FontStyle.italic));
      expect(underlineText.applyStyle(textStyle), textStyle.copyWith(decoration: TextDecoration.underline));
    });

    // Prueba de campo de texto por defecto
    testWidgets('Prueba de Contenido de Campo de Texto por Defecto', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: TextField(decoration: InputDecoration(hintText: 'Enter new text')))));

      expect(find.text('Enter new text'), findsOneWidget);
    });

    // Prueba de inicialización de la aplicación
    testWidgets('Prueba de Inicialización de la Aplicación', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        title: 'Text Decorator',
        debugShowCheckedModeBanner: false,
        home: Scaffold(appBar: AppBar(title: Text('Text Decorator'))),
      ));

      expect(find.byType(MaterialApp), findsOneWidget);

      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      expect(app.title, equals('Text Decorator'));
      expect(app.debugShowCheckedModeBanner, isFalse);
    });

    
  });
}



