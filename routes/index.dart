/*
 * In Dart Frog, a route consists of an onRequest function (called a route handler) exported from a .dart file
 * in the routes directory. Each endpoint is associated with a routes file based on its file name. 
 * Files named, index.dart will correspond to a / endpoint.
*/

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(body: 'Hello there!');
}
