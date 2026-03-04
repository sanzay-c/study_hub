import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { dev, staging, prod }

class EnvConfig {
  static Environment _environment = Environment.dev;
  
  static Environment get environment => _environment;
  
  static Future<void> initialize(Environment env) async {
    _environment = env;
    
    String envFile;
    switch (env) {
      case Environment.dev:
        envFile = '.env.dev'; 
        break;
      case Environment.staging:
        envFile = '.env.staging';
        break;
      case Environment.prod:
        envFile = '.env.prod';
        break;
    }
    
    await dotenv.load(fileName: envFile);
  }
  
  // Getter methods
  static String get appName => dotenv.get('APP_NAME', fallback: 'MyApp');
  static String get apiBaseUrl => dotenv.get('API_BASE_URL');
  static String get apiKey => dotenv.get('API_KEY');
  static bool get debugMode => 
      dotenv.get('DEBUG_MODE', fallback: 'false') == 'true';
  
  // Custom getter with default value
  static String getString(String key, {String defaultValue = ''}) {
    return dotenv.get(key, fallback: defaultValue);
  }

  /// Resolves a relative image path to a full URL using the API base URL.
  static String? resolveImageUrl(String? path) {
    if (path == null || path.isEmpty) return null;
    if (path.startsWith('http')) return path;
    
    // Ensure the base URL doesn't end with a slash
    final baseUrl = apiBaseUrl.endsWith('/') 
        ? apiBaseUrl.substring(0, apiBaseUrl.length - 1) 
        : apiBaseUrl;
    
    // Ensure the path starts with /media/ if it's a relative path from the API
    String normalizedPath = path.startsWith('/') ? path : '/$path';
    if (!normalizedPath.startsWith('/media/')) {
      normalizedPath = '/media$normalizedPath';
    }
    
    return '$baseUrl$normalizedPath';
  }
}