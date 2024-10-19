//questa route gestisce il GET globale delle chitarre
import 'package:dart_frog/dart_frog.dart';
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
    default:
      return Response(statusCode: 405, body: 'Method Not Allowed');
  }
}

// Gestione delle richieste GET
Response _handleGet() {
  final jsonGuitars =
      dataInitializer.getGuitars().map((guitar) => guitar.toJson()).toList();
  return Response.json(body: jsonGuitars, statusCode: 200);
}
