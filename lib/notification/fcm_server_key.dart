import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    var scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "image-uplode-4d545",
          "private_key_id": "91d4e9ab74294eecc660b7589c5b60c28830a8d0",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQDT2jeRUYHHNwqS\nPqy9y3NUkjEHCQqpuRi/TSICJrHaVNbiA8sG8ThaZAkQOEDLfdYe7x3A8TTgPDNl\nPziREYaqXosCD4R91PrmwrHH3KbLM6Yf+Ne2dExXYcgkfpTauZd4mBD4M7pccwoe\nDPGS5wGkcUvyWF8GCRa/5RTab+fAQ4DqlTRExS4wmsV8kXKXvTCRH8Ot3Qvg2g5y\n+WczHWYp0EpRvJX3+qM1kSUcLl2tTGxdy5hpLygtJqYKpxGTBJNfTUV4gH1px1az\nWpa2VAMRQij+/wy1YUhfkbAP+N/nQFfJTULIN2Z4H5gnMtZisyZ0ExNViRvJL8IH\nHPS4IEkRAgMBAAECggEAClgdXnscWx3U5k8pIBtPBlIdErreSms/Shf6ESDSjlaW\nJ3MH9s7QcZlw19nnUAhU7C3AxisA6fIGkGsF2A+DA86Z+v/G+F3t4lafV6Lugf2D\nnwwHfGExWRLtMtr7abKmMr06FuRvtRPo6o63PPUKn3zouGyYNzM6aSRGYGQWbMzI\nNzHgoSnS5lFlPB5k9HjbFWTMgGdDJFqFQn2ElseTpNukduOR6exJ+mJnVQtUnnzn\nPE/cMROyiS1amLyDir+aWdQtqT6pMw5ROkRconmagA+ZOXeej7fTq3cTUax+9Kkc\nMn8MrUqlX76VSgrRwGuRlTDDHiTjx4FLDPInQ+I4AQKBgQD2gpD1Igw2WmbSMLQn\nO5O3qd2MkBamFtIRHlmrrUXRcjmIXgGRoEY5h+ZuQQ9cwB2r8TfVvi0LQuv2QFxk\nazaBS/7Y5DDPgDNHT7teSOL2KP2t7lvHGXuaBXkPk5ghz0DLGsADlzIBv5+lomjw\nIFnWAOhdA9iiWK1CZ7q0RtndNQKBgQDcAhbSF6VxbOY55SyRh9tthfzxlION0eXw\nxQqvqLV3j/dKtaXVLuN18cvbYU7e3Gu72M89eRjdKjzx3OxBDfQQCnbI8guk0Kgy\nitrUCmHusbMZD0pPQxDuFq00RBKcuKIKeSwIcbcZpkNid/rgPXF5WWEWaBa4cqn5\nXQwno7dj7QKBgC320oiivJw15w4yPqVCGp0Yc1MOWurFPo4qlpXITUhsgAXJYYmB\n1RZNHM5aGz80I1Q4Oi0EtOlwpQbZoWCoDRW20eInSmKmiOk3GLzP4mH76rFPzJUn\nT0C83IHnB2rmdjJo3nzM6GojDOWZju+XWKjqqmkNmotK9aN4K/wJaf4xAn9b9IOV\nTEzaG6oeiKsYKLCOFnKihnB11kVFXRYaVWmDj6jMkR+++toXcfjCuOk+POLKoNP9\n3Z+G0SCn9q7IggyAp97+Hiy/tnaWqXLNLYnBOoSg9MMaXe21lcTPE6Sz3Hfd6Md+\nwAjHr7Z6catqDkRfc/wgYWEdts9Uao+qAcOlAoGBAIT21JXC86WtIjNnWiCxSo7V\nQFCtrb6XzPmKvucufxR2HsMcB0MvuLrMnjQl4yTeaSO4TJeQFizYCutkNrx3lut6\n387hP5+7K1K00SdkGA/7zwRdGj9A77ecFq/3wdsvM2NLR1ta60ZR+BSI7503KfqJ\nWShi10qaDiaq4ga1fFkK\n-----END PRIVATE KEY-----\n",
          "client_email": "firebase-adminsdk-uh6hb@image-uplode-4d545.iam.gserviceaccount.com",
          "client_id": "114230849879205636967",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-uh6hb%40image-uplode-4d545.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
        ), scopes);
    final serverKey = client.credentials.accessToken.data;
    print("ServerKey = $serverKey /");
    return serverKey;
  }
}
