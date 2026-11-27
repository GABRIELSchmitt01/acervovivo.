import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  ApiClient._();
  static final ApiClient instance = ApiClient._();

  // Public HTTPS API. Can be overridden at build time with --dart-define.
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://acervovivo-api.duckdns.org',
  );

  String? _token;
  Map<String, dynamic>? _user;
  Map<String, dynamic>? get user => _user;
  bool get isLoggedIn => _token != null && _user != null;
  bool get isLibrarian => _user?['role'] == 'librarian';

  Future<void> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token');
    final raw = prefs.getString('user_json');
    if (raw != null) {
      try {
        _user = Map<String, dynamic>.from(jsonDecode(raw));
      } catch (_) {
        await clearSession();
      }
    }
    if (_token != null) {
      try {
        _user = Map<String, dynamic>.from(await get('/auth/me'));
      } catch (_) {
        await clearSession();
      }
    }
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email.trim(), 'password': password}),
    );
    final data = _decode(response);
    _token = data['access_token'] as String;
    _user = Map<String, dynamic>.from(data['user']);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', _token!);
    await prefs.setString('user_json', jsonEncode(_user));
  }

  Future<void> clearSession() async {
    _token = null;
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('user_json');
  }

  Future<dynamic> get(String path, {Map<String, String>? query}) =>
      _request('GET', path, query: query);
  Future<dynamic> post(String path, {Object? body}) =>
      _request('POST', path, body: body);
  Future<dynamic> put(String path, {Object? body}) =>
      _request('PUT', path, body: body);
  Future<dynamic> delete(String path) => _request('DELETE', path);

  Future<dynamic> _request(
    String method,
    String path, {
    Object? body,
    Map<String, String>? query,
  }) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query);
    final headers = <String, String>{'Accept': 'application/json'};
    if (body != null) headers['Content-Type'] = 'application/json';
    if (_token != null) headers['Authorization'] = 'Bearer $_token';

    late http.Response response;
    switch (method) {
      case 'GET':
        response = await http.get(uri, headers: headers);
        break;
      case 'POST':
        response = await http.post(
          uri,
          headers: headers,
          body: body == null ? null : jsonEncode(body),
        );
        break;
      case 'PUT':
        response = await http.put(
          uri,
          headers: headers,
          body: body == null ? null : jsonEncode(body),
        );
        break;
      case 'DELETE':
        response = await http.delete(uri, headers: headers);
        break;
      default:
        throw Exception('Método HTTP não suportado.');
    }
    if (response.statusCode == 204 || response.body.isEmpty) return null;
    return _decode(response);
  }

  dynamic _decode(http.Response response) {
    dynamic data;
    try {
      data = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (_) {
      data = {'detail': 'Resposta inválida do servidor.'};
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final msg = data is Map ? data['detail']?.toString() : null;
      throw Exception(msg ?? 'Falha na comunicação (${response.statusCode}).');
    }
    return data;
  }
}
