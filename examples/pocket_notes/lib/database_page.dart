import 'package:flutter/material.dart';
import 'package:pocket/pocket.dart';

import 'notes_model.dart';

class DatabasePage extends StatefulWidget {
  /// default constructor
  const DatabasePage({
    super.key,
  });

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  // SembastPocket? sembastPocket;
  TextEditingController controller = TextEditingController();
  final tableName = 'notes_db';
  final List<Notes> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
              autocorrect: false,
              controller: controller,
            ),
          ),
          ElevatedButton(
            onPressed: saveNoteInDB,
            child: Text('Save Note'),
          ),
          if (SembastPocket.wasInitCalled)
            Expanded(
              child: StreamBuilder<Iterable<AdapterDto>>(
                stream: SembastPocket.instance().readWhere(table: tableName),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    notes.clear();

                    notes.addAll(
                      snapshot.requireData.map(
                        (dto) => Notes(
                          id: dto.id,
                          note: dto.data['note'],
                        ),
                      ),
                    );
                  }

                  return notes.isEmpty
                      ? Center(child: Text('No items'))
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: notes.length,
                            itemBuilder: (_, index) => Container(
                              height: 50,
                              margin: EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: -4,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    )
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        notes[index].note,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          deleteNote(notes[index].id),
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                },
              ),
            )
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: dropTable,
        child: Text('Clear DB'),
      ),
    );
  }

  Future<void> saveNoteInDB() async {
    if (controller.text.isEmpty) return;

    await SembastPocket.instance().create(
      table: tableName,
      item: AdapterDto(
        DateTime.now().millisecondsSinceEpoch.toString(),
        {'note': controller.text},
      ),
    );

    controller.text = '';
  }

  void dropTable() {
    SembastPocket.instance().dropTable(tableName);
  }

  void deleteNote(String id) {
    SembastPocket.instance().delete(table: tableName, id: id);
  }
}
