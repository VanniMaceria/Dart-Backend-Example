//questa route gestisce il GET globale delle chitarre
import 'dart:convert';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import '../models/guitar.dart';

//lista per memorizzare le chitarre
final List<Guitar> guitars = [];
const String jsonFilePath = 'assets/mark_guitars.json';

// Funzione principale per caricare le chitarre
Future<void> loadInitialData() async {
  guitars.addAll(await _loadGuitars());
}

Future<void> initialize() async {
  await loadInitialData(); //carica i dati all'avvio dell'app
}

Future<Response> onRequest(RequestContext context) async {
  // Se la lista è vuota, carica i dati
  if (guitars.isEmpty) {
    await initialize();
  }

  final request = context.request; //ottengo la richiesta
  final method = request.method.value; //accedo al tipo di metodo http

  switch (method) {
    case 'GET':
      return _handleGet();
    default:
      return Response(statusCode: 405, body: 'Method Not Allowed');
  }
}

// Gestione delle richieste GET
Response _handleGet() {
  final jsonGuitars = guitars.map((guitar) => guitar.toJson()).toList();
  return Response.json(body: jsonGuitars, statusCode: 200);
}

// Funzione per caricare le chitarre dal file JSON
Future<List<Guitar>> _loadGuitars() async {
  try {
    final file = File(jsonFilePath);
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
