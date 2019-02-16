import 'package:kt_dart/kt.dart';
import 'package:kt_dart/src/collection/extension/iterable_extension_mixin.dart';
import 'package:kt_dart/src/collection/impl/iterable.dart';

/**
 * Represents a range of values (for example, numbers or characters).
 */
abstract class ClosedRange<T> {
  /**
   * The minimum value in the range.
   */
  T get start;

  /**
   * The maximum value in the range (inclusive).
   */
  T get endInclusive;

  int compare(T a, T b) {
    if (a is Comparable) {
      return a.compareTo(b);
    } else if (b is Comparable) {
      return -b.compareTo(a);
    } else {
      throw ArgumentError("Items not Comparable\n\ta=$a\n\tb=$b");
    }
  }

  /**
   * Checks whether the specified [value] belongs to the range.
   */
  bool contains(T value) =>
      compare(value, start) >= 0 && compare(value, endInclusive) <= 0;

  /**
   * Checks whether the range is empty.
   */
  bool isEmpty() => compare(start, endInclusive) > 0;
}

class IntProgression extends KtIterable<int>
    with KtIterableExtensionsMixin<int> {
  IntProgression(this.start, int endInclusive, this.step)
      : assert(() {
          if (start == null) throw ArgumentError("start can't be null");
          if (endInclusive == null)
            throw ArgumentError("endInclusive can't be null");
          if (step == null) throw ArgumentError("step can't be null");
          return true;
        }()),
        end = _getProgressionLastElement(start, endInclusive, step) {
    if (step == 0) {
      throw ArgumentError("Step must be non-zero");
    }
  }

  /**
   * The first element in the progression.
   */
  // should be named `first` but it clashes with KtIterable
  final int start;

  /**
   * The last element in the progression.
   */
  // should be named `last` but it clashes with KtIterable
  final int end;

  /**
   * The step of the progression.
   */
  final int step;

  static int _getProgressionLastElement(int start, int end, int step) {
    if (step > 0) {
      if (start >= end) {
        return end;
      } else {
        return end - _differenceModulo(end, start, step);
      }
    } else if (step < 0) {
      if (start <= end) {
        return end;
      } else {
        return end + _differenceModulo(start, end, -step);
      }
    } else {
      throw ArgumentError("Step is zero");
    }
  }

  // (a - b) mod c
  static int _differenceModulo(int a, int b, int c) {
    return _mod(_mod(a, c) - _mod(b, c), c);
  }

  static int _mod(int a, int b) {
    final mod = a % b;
    if (mod >= 0) {
      return mod;
    } else {
      return mod + b;
    }
  }

  /**
   * Checks if the progression is empty.
   */
  bool isEmpty() {
    if (step.compareTo(0) > 0) {
      return start > 0;
    } else {
      return start < end;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IntProgression && isEmpty() && other.isEmpty()) ||
      other is IntProgression &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end &&
          step == other.step;

  @override
  int get hashCode {
    if (isEmpty()) return -1;
    return 31 * (31 * start + end) + step;
  }

  @override
  String toString() {
    if (step > 0) {
      return "$start..$last step $step";
    } else {
      return "$first downTo $last step ${-step}";
    }
  }

  @override
  Iterable<int> get iter => KtToDartIterable(this);

  @override
  KtIterator<int> iterator() => _IntProgressionIterator(start, end, step);
}

class _IntProgressionIterator extends KtIterator<int> {
  _IntProgressionIterator(int first, int last, this.step)
      : _finalElement = last {
    _hasNext = step > 0 ? first <= last : first >= last;
    _next = _hasNext ? first : _finalElement;
  }

  final int step;
  final int _finalElement;
  bool _hasNext;
  int _next;

  @override
  bool hasNext() => _hasNext;

  @override
  int next() {
    final value = _next;
    if (value == _finalElement) {
      if (!_hasNext) throw NoSuchElementException();
      _hasNext = false;
    } else {
      _next += step;
    }
    return value;
  }
}

class IntRange extends IntProgression with ClosedRange<int> {
  IntRange(int start, this.endInclusive) : super(start, endInclusive, 1);

  @override
  final int endInclusive;
}

main() {
  for (final i in IntRange(0, 10).iter) {
    print(i);
  }
  for (final i in IntProgression(10, 0, -2).iter) {
    print(i);
  }
}
