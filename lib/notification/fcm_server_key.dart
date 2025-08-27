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
          "private_key_id": "b413e1017dbf0beb667281733e3e8f35704aab43",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDl9jG3Wp1ZrxMf\nypbu8ve19ljwmbAQrcuL9ElI8gu8f9Bxxp0oKJ6b8sSTTcdmFCpHc3O8OoB5EMI3\nF+6VewIa4g7xNM0gu07qbDARIOPhWPhouCWrGAIjL+/CNb0MPAo9dUuBKIDVSRF3\ntV6jdqtrJzsIPDu5ea9g1oTzibU+wLONOG1kgHk3Wpg0Iecku9wUSkGAIqcbXB6E\nI5Z4fpMtiFYoEOLJ4iq5J39BeaYYns/Bv5NKUkq/LxzXaohgI+ScWDtR+YfS2uzE\nIgPqItabJIQTPwJfjl3AQLfM+P5lyO4/snJTLVXWz70o0Uif+/jkJO8zB9AK+fOr\nWMG/x5FtAgMBAAECggEAPQMw9aDJFr5oqIqruQIlztVpi4x7NjGmS5+owf3WN1EC\nEO3NTJZaXq3ukdaVDPRUs1hiYJJ0+6oCnXNwDaDxUgigRkboFcMckP3bUvATBfsB\nDWeuNtLL3mIdjr2LRu+3F89DFSWV6QDV7ZjlXyFhIbDq7KhugCtU6LCB3cuvltIx\nDgypMKdFadU6ssOUBjhCeCZQWO9CQ7+WDbJ4Pqv7hS36th/rLpq1WmEXqNaEKqtd\nE8jX3lNw6I4sDvpzIGiSYpIXNbvZWEXIel4I/Xgg5g/8SAmk8PzhBGD01dGUHiki\nmhWNyOei5C3qB5fnGKxKDTUm6uYWmVqPPeYojsUnUQKBgQDvQm4dfwgfuBzMu1GK\nIWt01xMy8UB4raMKb+IikHnxfrwjkhCpb/7BCX3zczfnTVi4gZLLu857fguSSNr5\nVA0EPYhS8pr/LAFNFcrzc8Jbej1i2o6ENZnkIr3mU1/VUfQv5FxivEe6cM+0FMW+\n1znkucv6Ofwdi7RHyKDbdUw/WwKBgQD2DTlGOAddqXyBkEcqKdMhrr7pWZfBMzd9\nxRkkgRKsnpSbHcPmdD5mfXN0OIX8Qky/z0+l8Sr0PPiZu968hy0ns0FOUNZF7R7A\nPuGG5l8Xc88CPozZaA7yUt3nsevu1oHBMe7xwRnYtPYb9c4xYUubxRD9c9Gq2Xn1\nQd2r6oXU1wKBgAt0wNUEuhzasfZTmcnlY8HKco7j4lRk7AOZ69f/1vbrPJLvcYDL\nbgVMMQ2xHKIkn/Tlr2O18GMVW/R7LJD3p0/mqlpeZ3GEZ+OLAZa6mjnLFplfIafO\n8TltOG6I23PZYrnQU2Qe48hXknpq7DUBFTKQeuXWVO4NPGqbfqhDa401AoGAI7v7\n63TLrRCmYnK/wyHb5fJpC57VaVu03XE4m5KbUbKeRoDmKJwNS/lAQUrMOryuRNUo\n7iK+aEZKnJkqWhsPtcpU27jlxbYQVz9KpbrjaJaLI/pNnm18bjkWvUWbzE4e/h3w\nY+/1fwGZFKp4TbehsXfHZefiNXvsOHBeb09aLHUCgYAgqYU7f3K4bnGlMjN2Gc/z\n7X4g4/q53S2/FLESPUXXRB4shD/x0tsri+0TOqnhXjZejuDXABMPthnKucU8/uCU\nwKUTi9jqS0aCbOoprDuovoKjEcYB7Nh99Yh46Uh/xFnTEvWDKmYD4BP76MJdol1w\nTcfi/8PTazEWsVVn2RNGEg==\n-----END PRIVATE KEY-----\n",
          "client_email": "firebase-adminsdk-uh6hb@image-uplode-4d545.iam.gserviceaccount.com",
          "client_id": "114230849879205636967",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-uh6hb%40image-uplode-4d545.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }), scopes);
    final serverKey = client.credentials.accessToken.data;
    print("ServerKey = $serverKey /");
    return serverKey;
  }

  // Future<String> getServerKeyToken() async {
  //   final scopes = [
  //     "https://www.googleapis.com/auth/userinfo.email",
  //     "https://www.googleapis.com/auth/firebase.database",
  //     "https://www.googleapis.com/auth/firebase.messaging",
  //   ];
  //   final client = await clientViaServiceAccount(
  //       ServiceAccountCredentials.fromJson({
  //         "type": "service_account",
  //         "project_id": "image-uplode-4d545",
  //         "private_key_id": "535f7587bd103eedef4c77cc9baeec4e06f86be8",
  //         "private_key":
  //             "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDGGJEvsvGHN3wq\nzGBeUsuUrLPeAGlkPxYaErM4J2wQlQ62wDo7r4yKXVca3dQtutGMk3OZDoj33iQz\nQ3xUYqYYJQURzRnpnXyGCGtoKH5gqII31XzdtrIZzaRtQX68YtpUlD3YuAHiF1Hb\nN9/hCU0xUIb2KlBiuOTFFT2T42WAIX+iGlTmkMq5/LWL4/xw+V5QRTH+silHgicm\n0WMSg5bggkHMTnHchnuEXYrnW0DyQRKETp1MiCQIqliJm+0peF7QS/gejlRjAIoH\nAIVT8B0GgT3FBfuKArER0iDRqOI4KJlgO9N/DonUNqynIcsTM8G8PQ3hYng3OrQy\nuWLFAftjAgMBAAECggEAGFm8vxhICE8RvFETJ4UV8VipY4i5a9E1bk8OKMDvz7oC\n7QQEJIIXzIpcwrix9E0apSUa+J2IyK9N099f0R+vOxiR3vZPUSBCxlcSnOMdZdRQ\n7XwYtUhX7EQTCjsa0R11qR/v2kwELz6emUvtAUSbcIxtiqT47Km9tVw/DYbOW0mL\ngbtXhJjrEvSKrXqTnYVz/zq9+0MFXb0llnMUc+a20foKrZvfSzg3i8qj9z5OiZDz\nBsj2yrhDOiemAIjD7s8dGWUPZlBmOeHFOTwlrEJkCsu+HAB7CQLZUEifNr260DKl\nDXZd+rrH9b+M9UHshtsKKMZtr5wSeUb1EBqEwLZlwQKBgQDhFyZAGEZa9KSObx6Z\nVJdXdUU/t83Kx8bP7w1DbuX/SWPz19TRflNJI3VRDFINAAWoS/DuccEC/DDPFsnP\nVxQqPisdRxksa00OlHUtHeV6TW1okhvkIzLnuL8VqTvJi7A/QwLSO/6Htl3kkLMu\nnrbcHQsRvzKz2kv0GllbcZvMnQKBgQDhTHOpBK4Z+bnZQbhjG5YX/mBic5pe+7Ym\njCVl1hrWG0kerls36YdBgR+nXWD6wCq+oTtwtS7qkZhK54wQXJct8eac9XZIb3Bl\nfS2SaiebcKGot+qhZVqEWsrcZs6q6pSoaSA8deHorX81whEAVsIDPpKjN/5hz0lO\nO/qxzhZn/wKBgEcwIhnNU5r6mnytqhjGRyMS5LbVM9G5QyiKK0Czdyw5EtKQ5S7o\nbADKpRTf96dC5YcnlWhkM631Ap7MT0EzAh6mEM6uqMiCmxlMXI7LUMNQb5TN+OI7\nO6NLq6t3HYCNnE01rVO+Q666P5HFLdZFvgF5cgHH3YpCNRlbp/0iviqFAoGASRDI\nObpA1D++3AyKRen+ZU2j6InhOIidbCbrQfmLvoAe2IpnHtzndoDvyRFpkCieNDCJ\n3GWGD6CkKTaqn+vHQ6k9xw18DMXHR8Ku8trmeWyvoM30k98Q2fev7oaQ47EsAOoH\nAFSirRkHNmH3rYp1ZSP33mMcZpAZD/w3s05IyfUCgYAbR35UQvHN63T3vKtD3ztY\nsxZOb8CSkKkucaVXVpBwVVgsgPXnfpDG5yzdCW0w5alpjhLimiBiiN6pUoV2ZNmG\nEubLXDQ8RQjACu3vbzwfvLs6SWRY3fXVMeL3ZIVCQ0mewsgyAnLcZaBUgouetrEx\nBASkWN1KXRnCUMN8PsMSPw==\n-----END PRIVATE KEY-----\n",
  //         "client_email":
  //             "firebase-adminsdk-uh6hb@image-uplode-4d545.iam.gserviceaccount.com",
  //         "client_id": "114230849879205636967",
  //         "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  //         "token_uri": "https://oauth2.googleapis.com/token",
  //         "auth_provider_x509_cert_url":
  //             "https://www.googleapis.com/oauth2/v1/certs",
  //         "client_x509_cert_url":
  //             "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-uh6hb%40image-uplode-4d545.iam.gserviceaccount.com",
  //         "universe_domain": "googleapis.com"
  //       }),
  //       scopes);
  //   final accessServerKey = client.credentials.accessToken.data;
  //   return accessServerKey;
  // }
}
