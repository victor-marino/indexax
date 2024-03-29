import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  // Class that handles all network operations
  final String url, token;

  NetworkHelper(this.url, this.token);

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communicating with server with status code: ${response.statusCode}');
    }
  }

  Future getData() async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-AUTH-TOKEN': token,
          HttpHeaders.acceptHeader: '*/*',
        },
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }
}

class CustomException implements Exception {
  final dynamic _message, _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String message = ""])
      : super(message, "Communication error: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String message = ""])
      : super(message, "Invalid input: ");
}
