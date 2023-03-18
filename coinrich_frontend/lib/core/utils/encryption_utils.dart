import 'package:basic_utils/basic_utils.dart';
import 'package:encrypt/encrypt.dart';

String rsaEncrypt(String content) {
  const String publicKey =
      "-----BEGIN RSA PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAz0yYwEls8R5iPkiW+GvrfyCvlnk1MM98nc5appfQdr9lHGWpJhz1yPJfTfhjtFND6LPL8ky5sGm4hnwtOl4DsEs6wcvDypOOgMznToH2SFQfIyoBD0vgIT2K04KJwI0nGLm3pzLCOnS2bz7kgGUYB/aDtKxqWECyE0h4ujKNN6T3kI9CqNDvboL0UqfXIaA8J40DLnuzisUFa6DkLeaCtlfvzxha1IFl06va0JAn67K1Gv99SsGA4EM5hfEIjY1SJi67XtEvodVCJnIZon/+qWQJrfQnZGWevy0yW6D9TP4c9qFX9g5cKu0KQpy6RBzBeLY6E5Ygt/hgv5BLq58Y+QIDAQAB\n-----END RSA PUBLIC KEY-----";
  final Encrypter encryptor = Encrypter(RSA(publicKey: CryptoUtils.rsaPublicKeyFromPem(publicKey)));
  return encryptor.encrypt(content).base64;
}

String aesDecrypt(String content, String key) {
  key = "$key                ";
  key = key.substring(0, 16);
  final Encrypter encryptor = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.ecb));
  return encryptor.decrypt(Encrypted.fromBase64(content), iv: IV.fromLength(16));
}
