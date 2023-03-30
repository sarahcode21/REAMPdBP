import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:reamp/model/model.dart';

abstract class StateDataProvider {
  Future<StateData?> read();
  Future<void> write(StateData data);
  Future<void> delete();
}

class FileStateDataProvider extends StateDataProvider {
  final String filename;

  FileStateDataProvider({required this.filename});

  Future<File> getDataFile() async {
    final dir = await path_provider.getApplicationDocumentsDirectory();
    final path = dir.path;
    return File('$path/$filename');
  }

  @override
  Future<StateData?> read() async {
    final file = await getDataFile();
    if (await file.exists()) {
      final res = await file.readAsString();
      return StateData.fromJson(json.decode(res));
    } else {
      return null;
    }
  }

  @override
  Future<void> write(StateData data) async {
    final file = await getDataFile();
    await file.writeAsString(json.encode(data.toJson()));
  }

  @override
  Future<void> delete() async {
    final file = await getDataFile();
    await file.delete();
  }
}
