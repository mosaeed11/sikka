import 'package:flutter_test/flutter_test.dart';
import 'package:sikka/core/utils/validators.dart';

void main() {
  group('Validators - Egyptian Phone Numbers', () {
    test('accepts standard 11-digit numbers with leading 0', () {
      expect(Validators.isValidEgyptianPhone('01012345678'), isTrue);
      expect(Validators.isValidEgyptianPhone('01110057671'), isTrue);
      expect(Validators.isValidEgyptianPhone('01298765432'), isTrue);
      expect(Validators.isValidEgyptianPhone('01511223344'), isTrue);
    });

    test('accepts 10-digit numbers without leading 0', () {
      expect(Validators.isValidEgyptianPhone('1012345678'), isTrue);
      expect(Validators.isValidEgyptianPhone('1110057671'), isTrue);
      expect(Validators.isValidEgyptianPhone('1298765432'), isTrue);
      expect(Validators.isValidEgyptianPhone('1511223344'), isTrue);
    });

    test('accepts phone with +20 or 0020 or 20 country code and spaces', () {
      expect(Validators.isValidEgyptianPhone('+201012345678'), isTrue);
      expect(Validators.isValidEgyptianPhone('+20 11 1005 7671'), isTrue);
      expect(Validators.isValidEgyptianPhone('00201298765432'), isTrue);
      expect(Validators.isValidEgyptianPhone('201511223344'), isTrue);
      expect(Validators.isValidEgyptianPhone('010-1234-5678'), isTrue);
    });

    test('accepts Arabic-Indic numerals', () {
      expect(Validators.isValidEgyptianPhone('٠١٠١٢٣٤٥٦٧٨'), isTrue);
      expect(Validators.isValidEgyptianPhone('+٢٠١١١٠٠٥٧٦٧١'), isTrue);
    });

    test('rejects non-mobile and invalid formats', () {
      expect(Validators.isValidEgyptianPhone('01312345678'), isFalse); // Landline
      expect(Validators.isValidEgyptianPhone('010123456'), isFalse); // Too short
      expect(Validators.isValidEgyptianPhone('010123456789'), isFalse); // Too long
      expect(Validators.isValidEgyptianPhone(''), isFalse);
      expect(Validators.isValidEgyptianPhone(null), isFalse);
      expect(Validators.isValidEgyptianPhone('abcdefghijk'), isFalse);
    });
  });

  group('Validators - Email', () {
    test('accepts empty/null when optional', () {
      expect(Validators.isValidEmail(null, isOptional: true), isTrue);
      expect(Validators.isValidEmail('', isOptional: true), isTrue);
      expect(Validators.isValidEmail('   ', isOptional: true), isTrue);
    });

    test('rejects empty when not optional', () {
      expect(Validators.isValidEmail(null, isOptional: false), isFalse);
      expect(Validators.isValidEmail('', isOptional: false), isFalse);
    });

    test('accepts valid email addresses', () {
      expect(Validators.isValidEmail('test@example.com'), isTrue);
      expect(Validators.isValidEmail('ahmed.ali+sikka@gmail.com'), isTrue);
      expect(Validators.isValidEmail('captain123@sub.domain.co.uk'), isTrue);
    });

    test('rejects invalid email formats', () {
      expect(Validators.isValidEmail('plainaddress'), isFalse);
      expect(Validators.isValidEmail('@missingusername.com'), isFalse);
      expect(Validators.isValidEmail('username@.com'), isFalse);
      expect(Validators.isValidEmail('username@domain'), isFalse);
    });
  });

  group('Validators - Full Name', () {
    test('accepts full names with 2 or more words', () {
      expect(Validators.isValidFullName('أحمد محمد'), isTrue);
      expect(Validators.isValidFullName('محمد أحمد عبد الرحمن'), isTrue);
      expect(Validators.isValidFullName('Ahmed Ali'), isTrue);
      expect(Validators.isValidFullName('  محمود   حسن  '), isTrue);
    });

    test('rejects single-word or empty names', () {
      expect(Validators.isValidFullName('أحمد'), isFalse);
      expect(Validators.isValidFullName(''), isFalse);
      expect(Validators.isValidFullName(null), isFalse);
      expect(Validators.isValidFullName('A M'), isFalse);
    });
  });

  group('Validators - Passwords & Matching', () {
    test('validates password length >= 6', () {
      expect(Validators.isValidPassword('123456'), isTrue);
      expect(Validators.isValidPassword('secretPass!'), isTrue);
      expect(Validators.isValidPassword('12345'), isFalse);
      expect(Validators.isValidPassword(''), isFalse);
      expect(Validators.isValidPassword(null), isFalse);
    });

    test('matches passwords exactly without losing characters', () {
      expect(Validators.doPasswordsMatch('pass#123!', 'pass#123!'), isTrue);
      expect(Validators.doPasswordsMatch('pass#123!', 'pass#1234'), isFalse);
      expect(Validators.doPasswordsMatch('', ''), isFalse);
      expect(Validators.doPasswordsMatch('abc', null), isFalse);
    });
  });
}
