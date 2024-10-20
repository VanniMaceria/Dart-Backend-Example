import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import '../../models/guitar.dart';
import '../../utils/data_initializer.dart';

DataInitializer dataInitializer = DataInitializer();

// Funzione principale per la gestione delle richieste
Future<Response> onRequest(RequestContext context, String nome) async {
  // Carica i dati iniziali se la lista è vuota
  if (dataInitializer.getGuitars().isEmpty) {
    await dataInitializer.loadInitialData();
  }

  final request = context.request; //prendo la richiesta
  final method = request.method.value; //ottengo il metodo

  switch (method) {
    case 'GET':
      return _handleGet(nome);
    case 'PUT':
      return await _handlePut(request, nome);
    case 'DELETE':
      return _handleDelete(nome);
    default:
      return Response(statusCode: 405, body: 'Method Not Allowed');
  }
}

//gestione del GET per una singola chitarra
Response _handleGet(String nome) {
  try {
    // Decodifica il nome, se necessario
    String decodedNome = Uri.decodeComponent(nome);

    //cerca la chitarra nella lista in base al nome
    final Guitar guitar = dataInitializer.getGuitars().firstWhere(
        (guitar) => guitar.nome == decodedNome,
        //se non trova la chitarra nella lista ritorna una chitarra nulla
        orElse: () => Guitar(nome: null, urlImmagine: null, descrizione: null));

    return Response.json(body: guitar.toJson(), statusCode: 200);
  } catch (e) {
    return Response(statusCode: 500, body: 'Internal Server Error: $e');
  }
}

//gestione del PUT per aggiornare una singola chitarra
Future<Response> _handlePut(Request request, String nome) async {
  final body = await request.body(); //prendo il body della richiesta (chitarra)
  final json = jsonDecode(body);

  final guitarToUpdate = Guitar.fromJson(json as Map<String, dynamic>);
  final index = dataInitializer.getGuitars().indexWhere(
        (guitar) => guitar.nome == nome,
      );

  if (index == -1) {
    return Response(statusCode: 404, body: 'Guitar not found');
  }

  // Aggiorna la chitarra con i nuovi dati
  dataInitializer.getGuitars()[index] = guitarToUpdate;
  return Response(body: 'Guitar updated successfully', statusCode: 200);
}

//gestione del DELETE per rimuovere una singola chitarra
Response _handleDelete(String nome) {
  // Decodifica il nome della chitarra per gestire gli spazi
  final decodedNome = Uri.decodeComponent(nome);

  final index = dataInitializer.getGuitars().indexWhere(
        //prendo l'indice della chitarra col nome che c'era nell'url
        (guitar) => guitar.nome == decodedNome,
      );

  if (index == -1) {
    return Response(statusCode: 404, body: 'Guitar not found');
  }

  // Rimuove la chitarra dalla lista
  dataInitializer.getGuitars().removeAt(index);
  return Response(body: 'Guitar deleted successfully', statusCode: 200);
}
