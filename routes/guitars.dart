//questa route gestisce il GET globale delle chitarre
import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import '../models/guitar.dart';
import '../utils/data_initializer.dart';

DataInitializer dataInitializer = DataInitializer();

// Funzione principale per caricare le chitarre
Future<void> loadInitialData() async {
  dataInitializer.getGuitars().addAll(await dataInitializer.loadGuitars());
}

Future<void> initialize() async {
  await loadInitialData(); //carica i dati all'avvio dell'app
}

Future<Response> onRequest(RequestContext context) async {
  // Se la lista è vuota, carica i dati
  if (dataInitializer.getGuitars().isEmpty) {
    await initialize();
  }

  final request = context.request; //ottengo la richiesta
  final method = request.method.value; //accedo al tipo di metodo http

  switch (method) {
    case 'GET':
      return _handleGet();
    case 'POST':
      return await _handlePost(context);
    default:
      return Response(statusCode: 405, body: 'Method Not Allowed');
  }
}

//gestione delle richieste GET
Response _handleGet() {
  final jsonGuitars =
      dataInitializer.getGuitars().map((guitar) => guitar.toJson()).toList();
  return Response.json(body: jsonGuitars, statusCode: 200);
}

//gestione delle richieste POST
Future<Response> _handlePost(RequestContext context) async {
  final body = await context.request.body();
  final json = jsonDecode(body); //decodifica il body JSON

  final newGuitar = Guitar.fromJson(
      json as Map<String, dynamic>); //converte il JSON in un oggetto Guitar
  dataInitializer.addGuitar(newGuitar);
  return Response(statusCode: 201, body: 'Guitar added successfully');
}
