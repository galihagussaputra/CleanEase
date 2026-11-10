import 'package:clean_ease/utils/validators/validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppValidator.validateEmail', () {
    test('accepts valid email addresses', () {
      expect(AppValidator.validateEmail('user@example.com'), isNull);
      expect(AppValidator.validateEmail(' user.name+tag@example.co.id '), isNull);
      expect(AppValidator.validateEmail('first_last@sub.example.dev'), isNull);
    });

    test('rejects invalid email addresses', () {
      expect(AppValidator.validateEmail(null), isNotNull);
      expect(AppValidator.validateEmail(''), isNotNull);
      expect(AppValidator.validateEmail('user'), isNotNull);
      expect(AppValidator.validateEmail('user@example'), isNotNull);
      expect(AppValidator.validateEmail('user @example.com'), isNotNull);
      expect(AppValidator.validateEmail('@example.com'), isNotNull);
    });
  });

  group('AppValidator.validatePassword', () {
    test('accepts required-length passwords', () {
      expect(AppValidator.validatePassword('secret'), isNull);
    });

    test('rejects empty and short passwords', () {
      expect(AppValidator.validatePassword(null), isNotNull);
      expect(AppValidator.validatePassword(''), isNotNull);
      expect(AppValidator.validatePassword('12345'), isNotNull);
    });
  });

  group('AppValidator.validateStrongPassword', () {
    test('accepts passwords with all required character groups', () {
      expect(AppValidator.validateStrongPassword('Secret1!'), isNull);
    });

    test('rejects missing uppercase, number, or special character', () {
      expect(AppValidator.validateStrongPassword('secret1!'), isNotNull);
      expect(AppValidator.validateStrongPassword('Secret!!'), isNotNull);
      expect(AppValidator.validateStrongPassword('Secret11'), isNotNull);
      expect(AppValidator.validateStrongPassword('Ab1!'), isNotNull);
    });
  });

  group('AppValidator.validatePhoneNumber', () {
    test('accepts common local and international formats', () {
      expect(AppValidator.validatePhoneNumber('0812345678'), isNull);
      expect(AppValidator.validatePhoneNumber('+62 812 3456 7890'), isNull);
      expect(AppValidator.validatePhoneNumber('(555) 123-4567'), isNull);
    });

    test('rejects empty and implausible phone numbers', () {
      expect(AppValidator.validatePhoneNumber(null), isNotNull);
      expect(AppValidator.validatePhoneNumber(''), isNotNull);
      expect(AppValidator.validatePhoneNumber('123'), isNotNull);
      expect(AppValidator.validatePhoneNumber('not a phone'), isNotNull);
      expect(AppValidator.validatePhoneNumber('abc12345678'), isNotNull);
      expect(AppValidator.validatePhoneNumber('1234567890123456'), isNotNull);
    });
  });

  group('AppValidator.validateEmptyText', () {
    test('rejects whitespace-only required fields', () {
      expect(AppValidator.validateEmptyText('Name', '   '), isNotNull);
      expect(AppValidator.validateEmptyText('Name', 'Clean Ease'), isNull);
    });
  });
}
