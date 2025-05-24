import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "image-uplode-4d545",
          "private_key_id": "535f7587bd103eedef4c77cc9baeec4e06f86be8",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDGGJEvsvGHN3wq\nzGBeUsuUrLPeAGlkPxYaErM4J2wQlQ62wDo7r4yKXVca3dQtutGMk3OZDoj33iQz\nQ3xUYqYYJQURzRnpnXyGCGtoKH5gqII31XzdtrIZzaRtQX68YtpUlD3YuAHiF1Hb\nN9/hCU0xUIb2KlBiuOTFFT2T42WAIX+iGlTmkMq5/LWL4/xw+V5QRTH+silHgicm\n0WMSg5bggkHMTnHchnuEXYrnW0DyQRKETp1MiCQIqliJm+0peF7QS/gejlRjAIoH\nAIVT8B0GgT3FBfuKArER0iDRqOI4KJlgO9N/DonUNqynIcsTM8G8PQ3hYng3OrQy\nuWLFAftjAgMBAAECggEAGFm8vxhICE8RvFETJ4UV8VipY4i5a9E1bk8OKMDvz7oC\n7QQEJIIXzIpcwrix9E0apSUa+J2IyK9N099f0R+vOxiR3vZPUSBCxlcSnOMdZdRQ\n7XwYtUhX7EQTCjsa0R11qR/v2kwELz6emUvtAUSbcIxtiqT47Km9tVw/DYbOW0mL\ngbtXhJjrEvSKrXqTnYVz/zq9+0MFXb0llnMUc+a20foKrZvfSzg3i8qj9z5OiZDz\nBsj2yrhDOiemAIjD7s8dGWUPZlBmOeHFOTwlrEJkCsu+HAB7CQLZUEifNr260DKl\nDXZd+rrH9b+M9UHshtsKKMZtr5wSeUb1EBqEwLZlwQKBgQDhFyZAGEZa9KSObx6Z\nVJdXdUU/t83Kx8bP7w1DbuX/SWPz19TRflNJI3VRDFINAAWoS/DuccEC/DDPFsnP\nVxQqPisdRxksa00OlHUtHeV6TW1okhvkIzLnuL8VqTvJi7A/QwLSO/6Htl3kkLMu\nnrbcHQsRvzKz2kv0GllbcZvMnQKBgQDhTHOpBK4Z+bnZQbhjG5YX/mBic5pe+7Ym\njCVl1hrWG0kerls36YdBgR+nXWD6wCq+oTtwtS7qkZhK54wQXJct8eac9XZIb3Bl\nfS2SaiebcKGot+qhZVqEWsrcZs6q6pSoaSA8deHorX81whEAVsIDPpKjN/5hz0lO\nO/qxzhZn/wKBgEcwIhnNU5r6mnytqhjGRyMS5LbVM9G5QyiKK0Czdyw5EtKQ5S7o\nbADKpRTf96dC5YcnlWhkM631Ap7MT0EzAh6mEM6uqMiCmxlMXI7LUMNQb5TN+OI7\nO6NLq6t3HYCNnE01rVO+Q666P5HFLdZFvgF5cgHH3YpCNRlbp/0iviqFAoGASRDI\nObpA1D++3AyKRen+ZU2j6InhOIidbCbrQfmLvoAe2IpnHtzndoDvyRFpkCieNDCJ\n3GWGD6CkKTaqn+vHQ6k9xw18DMXHR8Ku8trmeWyvoM30k98Q2fev7oaQ47EsAOoH\nAFSirRkHNmH3rYp1ZSP33mMcZpAZD/w3s05IyfUCgYAbR35UQvHN63T3vKtD3ztY\nsxZOb8CSkKkucaVXVpBwVVgsgPXnfpDG5yzdCW0w5alpjhLimiBiiN6pUoV2ZNmG\nEubLXDQ8RQjACu3vbzwfvLs6SWRY3fXVMeL3ZIVCQ0mewsgyAnLcZaBUgouetrEx\nBASkWN1KXRnCUMN8PsMSPw==\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-uh6hb@image-uplode-4d545.iam.gserviceaccount.com",
          "client_id": "114230849879205636967",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-uh6hb%40image-uplode-4d545.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
