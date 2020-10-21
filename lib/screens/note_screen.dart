import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_example/models/notebook.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // final TextEditingController _noteController = TextEditingController(text: 'тестовая заметка...');
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.orange, statusBarBrightness: Brightness.light),
      child: SafeArea(
        top: true,
        child: Scaffold(
            key: _scaffoldKey,
            body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 200.0,
                      floating: true,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              controller: _noteController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  hintText: 'Заметка',
                                  hintStyle: TextStyle(color: Colors.white70),
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.add_circle_outline, color: Colors.white),
                                      onPressed: () async {
                                        if (_noteController.text.length < 2) {
                                          _scaffoldKey.currentState.showSnackBar(
                                              SnackBar(content: Text('Введите заметку более 2 символов')));
                                          return;
                                        }
                                        final _nb = Provider.of<Notebook>(context, listen: false);
                                        await _nb.addNote(_noteController.text);
                                        _noteController.clear();
                                      })),
                              validator: (value) {
                                return value.length < 2 ? 'Минимум 2 символа' : null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: Consumer<Notebook>(
                  builder: (context, notebook, child) => (ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: notebook.notes.length,
                      itemBuilder: (BuildContext context, int index) {
                        final _note = notebook.notes[index];
                        return Container(
                          height: 50,
                          child: ListTile(
                            title: Text(_note.text),
                            trailing: IconButton(
                              icon: Icon(Icons.delete_forever, size: 28),
                              onPressed: () async {
                                await notebook.deleteNote(_note.id);
                              },
                            ),
                          ),
                        );
                      })),
                ))),
      ),
    );
  }
}
