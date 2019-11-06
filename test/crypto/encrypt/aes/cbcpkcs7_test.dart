import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:pascaldart/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('crypto.encrypt.aes.cbcpkcs7', () {
    List<Map<String, dynamic>> aesData;

    setUp(() {
      aesData = [
        {
          "mode": "aes-128",
          "key": "2b7e151628aed2a6abf7158809cf4f3c",
          "iv": "000102030405060708090A0B0C0D0E0F",
          "input": "6bc1bee22e409f96e93d7e117393172a",
          "output": "7649abac8119b246cee98e9b12e9197d"
        },
        {
          "mode": "aes-128",
          "key": "2b7e151628aed2a6abf7158809cf4f3c",
          "iv": "7649ABAC8119B246CEE98E9B12E9197D",
          "input": "ae2d8a571e03ac9c9eb76fac45af8e51",
          "output": "5086cb9b507219ee95db113a917678b2"
        },
        {
          "mode": "aes-128",
          "key": "2b7e151628aed2a6abf7158809cf4f3c",
          "iv": "5086CB9B507219EE95DB113A917678B2",
          "input": "30c81c46a35ce411e5fbc1191a0a52ef",
          "output": "73bed6b8e3c1743b7116e69e22229516"
        },
        {
          "mode": "aes-128",
          "key": "2b7e151628aed2a6abf7158809cf4f3c",
          "iv": "73BED6B8E3C1743B7116E69E22229516",
          "input": "f69f2445df4f9b17ad2b417be66c3710",
          "output": "3ff1caa1681fac09120eca307586e1a7"
        },
        {
          "mode": "aes-192",
          "key": "8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b",
          "iv": "000102030405060708090A0B0C0D0E0F",
          "input": "6bc1bee22e409f96e93d7e117393172a",
          "output": "4f021db243bc633d7178183a9fa071e8"
        },
        {
          "mode": "aes-192",
          "key": "8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b",
          "iv": "4F021DB243BC633D7178183A9FA071E8",
          "input": "ae2d8a571e03ac9c9eb76fac45af8e51",
          "output": "b4d9ada9ad7dedf4e5e738763f69145a"
        },
        {
          "mode": "aes-192",
          "key": "8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b",
          "iv": "B4D9ADA9AD7DEDF4E5E738763F69145A",
          "input": "30c81c46a35ce411e5fbc1191a0a52ef",
          "output": "571b242012fb7ae07fa9baac3df102e0"
        },
        {
          "mode": "aes-192",
          "key": "8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b",
          "iv": "571B242012FB7AE07FA9BAAC3DF102E0",
          "input": "f69f2445df4f9b17ad2b417be66c3710",
          "output": "08b0e27988598881d920a9e64f5615cd"
        },
        {
          "mode": "aes-256",
          "key":
              "603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4",
          "iv": "000102030405060708090A0B0C0D0E0F",
          "input": "6bc1bee22e409f96e93d7e117393172a",
          "output": "f58c4c04d6e5f1ba779eabfb5f7bfbd6"
        },
        {
          "mode": "aes-256",
          "key":
              "603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4",
          "iv": "F58C4C04D6E5F1BA779EABFB5F7BFBD6",
          "input": "ae2d8a571e03ac9c9eb76fac45af8e51",
          "output": "9cfc4e967edb808d679f777bc6702c7d"
        },
        {
          "mode": "aes-256",
          "key":
              "603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4",
          "iv": "9CFC4E967EDB808D679F777BC6702C7D",
          "input": "30c81c46a35ce411e5fbc1191a0a52ef",
          "output": "39f23369a9d9bacfa530e26304231461"
        },
        {
          "mode": "aes-256",
          "key":
              "603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4",
          "iv": "39F23369A9D9BACFA530E26304231461",
          "input": "f69f2445df4f9b17ad2b417be66c3710",
          "output": "b2eb05e2c39be9fcda6c19078c6a9d1b"
        }
      ];
    });

    test('passes aes-cbc vector tests', () {
      aesData.forEach((aes) {
        Uint8List input = PDUtil.hexToBytes(aes['input']);
        Uint8List output = PDUtil.hexToBytes(aes['output']);
        Uint8List iv = PDUtil.hexToBytes(aes['iv']);
        Uint8List key = PDUtil.hexToBytes(aes['key']);
        Uint8List encrypted = AesCbcPkcs7.encrypt(input, key: key, iv: iv);

        expect(PDUtil.byteToHex(output),
            PDUtil.byteToHex(encrypted.sublist(0, 16)));
      });
    });
  });
}
