import 'package:flutter_test/flutter_test.dart';
import 'package:sikka/features/auth/logic/otp_cubit.dart';

void main() {
  group('OtpCubit Tests', () {
    late OtpCubit cubit;

    setUp(() {
      cubit = OtpCubit(phoneNumber: '01012345678');
    });

    tearDown(() {
      cubit.close();
    });

    test('initializes with seed digits and countdown timer running', () {
      expect(cubit.state.phoneNumber, '01012345678');
      expect(cubit.state.digits.length, 6);
      expect(cubit.state.secondsRemaining, greaterThan(0));
    });

    test('entering digits updates list and advances focus', () {
      cubit.digitEntered(4, '7');
      expect(cubit.state.digits[4], '7');
      expect(cubit.state.focusedIndex, 5);
    });

    test('completing all 6 digits auto-verifies and succeeds', () async {
      cubit.digitEntered(4, '7');
      cubit.digitEntered(5, '8');

      expect(cubit.state.isComplete, isTrue);

      // Await verification simulation
      await Future.delayed(const Duration(milliseconds: 800));
      expect(cubit.state.isSuccess, isTrue);
    });
  });
}
