import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/extension/iterable_extension_mixin.dart";
import "package:kt_dart/src/collection/impl/iterable.dart";

/// A progression of values of type `int`
/// starting at [first] until [last] with steps of size [stepSize]
class IntProgression extends KtIterable<int>
    with KtIterableExtensionsMixin<int> {
  // TODO make const if possible
  IntProgression(int first, int endInclusive, int step)
      : assert(() {
          if (first == null) throw ArgumentError("start can't be null");
          if (endInclusive == null) {
            throw ArgumentError("endInclusive can't be null");
          }
          if (step == null) throw ArgumentError("step can't be null");
          return true;
        }()),
        assert(() {
          if (step > 0 && first > endInclusive ||
              step < 0 && first < endInclusive) {
            print(
                "The IntProgression from $first to $endInclusive with step $step doesn't contain any element.");
            print(StackTrace.current);
          }
          return true;
        }()),
        _first = first,
        // ignore: prefer_initializing_formals
        stepSize = step,
        _last = _getProgressionLastElement(first, endInclusive, step) {
    if (step == 0) {
      throw ArgumentError("Step must be non-zero");
    }
  }

  IntProgression step(int step) => IntProgression(_first, _last, step);

  /// The first element in the progression.
  final int _first;

  /// The last element in the progression.
  final int _last;

  /// The step of the progression.
  final int stepSize;

  @override
  int first([bool Function(int) predicate]) {
    if (predicate == null) return _first;
    return super.first(predicate);
  }

  @override
  int last([bool Function(int) predicate]) {
    if (predicate == null) return _last;
    return super.last(predicate);
  }

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

  /// Checks if the progression is empty.
  bool isEmpty() {
    if (stepSize.compareTo(0) > 0) {
      return _first > 0;
    } else {
      return _first < _last;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IntProgression && isEmpty() && other.isEmpty()) ||
      other is IntProgression &&
          runtimeType == other.runtimeType &&
          _first == other._first &&
          _last == other._last &&
          stepSize == other.stepSize;

  @override
  int get hashCode {
    if (isEmpty()) return -1;
    return 31 * (31 * _first + _last) + stepSize;
  }

  @override
  String toString() {
    final direction = stepSize > 0 ? ".." : " downTo ";
    final step = stepSize == 1 ? "" : " step $stepSize";
    return "$_first$direction$_last$step";
  }

  @override
  KtIterator<int> iterator() =>
      _IntProgressionIterator(_first, _last, stepSize);

  @override
  Iterable<int> get iter => _IntProgressionIterable(this).iter;
}

class _IntProgressionIterable extends KtIterable<int>
    with KtIterableExtensionsMixin<int> {
  _IntProgressionIterable(this.progression);

  final IntProgression progression;

  @override
  Iterable<int> get iter => KtToDartIterable(this);

  @override
  KtIterator<int> iterator() => _IntProgressionIterator(
      progression._first, progression._last, progression.stepSize);
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
      if (!_hasNext) throw const NoSuchElementException();
      _hasNext = false;
    } else {
      _next += step;
    }
    return value;
  }
}
