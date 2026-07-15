enum Environment { dev, staging, prod }

class AppConfig {
  static Environment environment = Environment.dev;
  
  static String get baseUrl {
    switch (environment) {
      case Environment.dev:
        // Cấu hình gọi API qua IP LAN của máy tính để điện thoại có thể kết nối được
        // LƯU Ý: 
        // 1. Nếu bạn dùng máy ảo Android (Emulator), hãy đổi thành: 'http://10.0.2.2:5097/api/v1'
        // 2. Nếu dùng máy thật, giữ nguyên IP '192.168.110.197' nhưng phải TẮT TƯỜNG LỬA (Windows Firewall)
        return 'https://unscrutinising-charlotte-deformative.ngrok-free.dev/api/v1'; 
      case Environment.staging:
        return 'https://staging.origamimaster.com/api/v1';
      case Environment.prod:
        return 'https://api.origamimaster.com/api/v1';
    }
  }

  /// The backend host URL (no /api/v1 suffix) used to resolve static file paths
  /// e.g. "/images/origami/crane.jpg" → "http://192.168.110.197:5097/images/origami/crane.jpg"
  static String get mediaBaseUrl {
    final url = baseUrl;
    const suffix = '/api/v1';
    if (url.endsWith(suffix)) {
      return url.substring(0, url.length - suffix.length);
    }
    return url;
  }

  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // IMPORTANT: Replace this with your actual Google OAuth 2.0 Web Client ID
  static const String googleServerClientId = '698858502953-msvek08mbvneb6dd3nhd01q3m6k1hjg1.apps.googleusercontent.com';
}
