import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Common.Sha', () {
    List<Map<String, String>> sha256data;
    List<Map<String, String>> sha512data;

    setUp(() {
      sha256data = [
        {
          "input": "",
          "expected":
              "E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855"
        },
        {
          "input": "HashLib4Pascal",
          "expected":
              "BCF45544CB98DDAB731927F8760F81821489ED04C0792A4D254134887BEA9E38"
        },
        {
          "input": "123456789",
          "expected":
              "15E2B0D3C33891EBB0F1EF609EC419420C20E320CE94C65FBC8C3312448EB225"
        },
        {
          "input": "abcde",
          "expected":
              "36BBE50ED96841D10443BCB670D6554F0A34B761BE67EC9C4A8AD2C0C44CA42C"
        }
      ];
      sha512data = [
        {
          "input": "",
          "expected":
              "CF83E1357EEFB8BDF1542850D66D8007D620E4050B5715DC83F4A921D36CE9CE47D0D13C5D85F2B0FF8318D2877EEC2F63B931BD47417A81A538327AF927DA3E"
        },
        {
          "input": "HashLib4Pascal",
          "expected":
              "0A5DA12B113EBD3DEA4C51FD10AFECF1E2A8EE6C3848A0DD4407141ADDA04375068D85A1EEF980FAFF68DC3BF5B1B3FBA31344178042197B5180BD95530D61AC"
        },
        {
          "input": "123456789",
          "expected":
              "D9E6762DD1C8EAF6D61B3C6192FC408D4D6D5F1176D0C29169BC24E71C3F274AD27FCD5811B313D681F7E55EC02D73D499C95455B6B5BB503ACF574FBA8FFE85"
        },
        {
          "input": "abcde",
          "expected":
              "878AE65A92E86CAC011A570D4C30A7EAEC442B85CE8ECA0C2952B5E3CC0628C2E79D889AD4D5C7C626986D452DD86374B6FFAA7CD8B67665BEF2289A5C70B0A1"
        }
      ];
    });

    test('SHA256 Test', () {
      String result;
      sha256data.forEach((hash) {
        result = PDUtil.byteToHex(
            Sha.sha256([PDUtil.stringToBytesUtf8(hash['input'])]));
        expect(result, hash['expected']);
      });
    });
    test('SHA512 Test', () {
      String result;
      sha512data.forEach((hash) {
        result = PDUtil.byteToHex(
            Sha.sha512([PDUtil.stringToBytesUtf8(hash['input'])]));

        expect(result, hash['expected']);
      });
    });
  });
}
