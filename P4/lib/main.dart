import 'package:flutter/material.dart';
import 'text_manager.dart';
import 'text_component.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Decorator',
      debugShowCheckedModeBanner: false,
      home: TextDecoratorWidget(),
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.lightBlueAccent,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class TextDecoratorWidget extends StatefulWidget {
  @override
  _TextDecoratorWidgetState createState() => _TextDecoratorWidgetState();
}

class _TextDecoratorWidgetState extends State<TextDecoratorWidget> {
  final TextEditingController _controller = TextEditingController();
  final TextManager _textManager = TextManager([]);
  String currentUser = "Juanma";
  List<String> users = ["Juanma", "Daniel", "Maria"];

  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;

  @override
  void initState() {
    super.initState();
    _loadTexts();
  }

  void _loadTexts() async {
    try {
      final response = await _textManager.loadTexts(currentUser);
      print('Server response: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        setState(() {});
      } else {
        throw Exception('Failed to load texts');
      }
    } catch (e) {
      print("Error loading texts: $e");
    }
  }

  void _addText() async {
  final text = _controller.text;
  if (text.isNotEmpty) {
    try {
      await _textManager.addText(StyledText(
        null,
        text,
        usuario: currentUser,  // Asegúrate de pasar el usuario aquí
        bold: isBold,
        italic: isItalic,
        underline: isUnderline,
      ));
      _controller.clear();
      setState(() {}); // Mueve setState aquí
    } catch (e) {
      print("Error adding text: $e");
    }
  }
}


  void _deleteText(StyledText text) async {
    try {
      await _textManager.deleteText(text);
    } catch (e) {
      print("Error deleting text: $e");
    }
    setState(() {});
  }

  TextStyle getTextStyle(StyledText text) {
    TextStyle style = TextStyle(
      color: Colors.black,
      fontSize: 20,
    );
    if (text.bold) style = style.copyWith(fontWeight: FontWeight.bold);
    if (text.italic) style = style.copyWith(fontStyle: FontStyle.italic);
    if (text.underline) style = style.copyWith(decoration: TextDecoration.underline);
    return style;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Decorator'),
        actions: <Widget>[
          DropdownButton<String>(
            value: currentUser,
            icon: Icon(Icons.arrow_downward),
            onChanged: (String? newValue) {
              if (newValue != null && newValue != currentUser) {
                setState(() {
                  currentUser = newValue;
                  _loadTexts();
                });
              }
            },
            items: users.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter new text',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addText,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Checkbox(
                value: isBold,
                onChanged: (value) {
                  setState(() {
                    isBold = value!;
                  });
                },
                activeColor: Colors.blue,
              ),
              Text('Bold'),
              Checkbox(
                value: isItalic,
                onChanged: (value) {
                  setState(() {
                    isItalic = value!;
                  });
                },
                activeColor: Colors.blue,
              ),
              Text('Italic'),
              Checkbox(
                value: isUnderline,
                onChanged: (value) {
                  setState(() {
                    isUnderline = value!;
                  });
                },
                activeColor: Colors.blue,
              ),
              Text('Underline'),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _textManager.texts.length,
              itemBuilder: (context, index) {
                final text = _textManager.texts[index];
                return ListTile(
                  title: Text(
                    text.
                    content,
                    style: getTextStyle(text),
                  ),                                                                                          
                  trailing: Wrap(
                    spacing: 12,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit text
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteText(text),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
