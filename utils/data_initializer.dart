import 'dart:convert';
import 'dart:io';
import '../models/guitar.dart';

class DataInitializer {
  //lista per memorizzare le chitarre
  List<Guitar> _guitars = [];
  static const String _jsonFilePath = 'assets/mark_guitars.json';

  DataInitializer();

  List<Guitar> getGuitars() {
    return this._guitars;
  }

  // Funzione principale per caricare le chitarre
  Future<void> loadInitialData() async {
    _guitars.addAll(await loadGuitars());
  }

  Future<void> initialize() async {
    await loadInitialData(); //carica i dati all'avvio dell'app
  }

  // Funzione per caricare le chitarre dal file JSON
  Future<List<Guitar>> loadGuitars() async {
    try {
      final file = File(_jsonFilePath);
      final jsonString = await file.readAsString();

      print('JSON Content: $jsonString'); // Stampa il contenuto del file JSON

      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => Guitar.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading guitars: $e');
      return [];
    }
  }
}
