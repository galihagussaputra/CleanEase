import 'package:clean_ease/utils/formatters/formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppFormatter.formatPhoneNumber', () {
    test('formats 10 and 11 digit numbers', () {
      expect(AppFormatter.formatPhoneNumber('1234567890'), '(123) 456 7890');
      expect(AppFormatter.formatPhoneNumber('12345678901'), '(1234) 567 8901');
    });

    test('returns unsupported lengths unchanged', () {
      expect(AppFormatter.formatPhoneNumber('123'), '123');
      expect(AppFormatter.formatPhoneNumber(''), '');
    });
  });

  group('AppFormatter.internationalFormatPhoneNumber', () {
    test('formats numbers with country codes', () {
      expect(
          AppFormatter.internationalFormatPhoneNumber('+1 (415) 555-2671'),
          '(+1) 415 555 2671');
      expect(
          AppFormatter.internationalFormatPhoneNumber('+62 812-3456-7890'),
          '(+62) 81 23 45 67 89 0');
    });

    test('does not throw for short or empty input', () {
      expect(AppFormatter.internationalFormatPhoneNumber(''), '');
      expect(AppFormatter.internationalFormatPhoneNumber('1'), '1');
      expect(AppFormatter.internationalFormatPhoneNumber('12'), '12');
    });

    test('returns the formatted number, not the original input', () {
      const input = '+62 812-3456-7890';
      expect(AppFormatter.internationalFormatPhoneNumber(input), isNot(input));
    });
  });

  group('AppFormatter.formatCurrency', () {
    test('formats USD currency values', () {
      expect(AppFormatter.formatCurrency(1234.5), '\$1,234.50');
      expect(AppFormatter.formatCurrency(0), '\$0.00');
    });
  });
}
