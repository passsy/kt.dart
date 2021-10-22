import 'package:kt_dart/kt.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main(){
  test("sumOfDouble - [0.0]", () {
    final originalList = [0.toDouble()];
    final klist = listFrom<double>(originalList);    

    final result = klist.sumOf( (it) => it );

    expect(result, 0.0);
  });

  test("sumOfDouble - [0.0, 1.0, 2.0]", () {
    final originalList = [0.0, 1.0, 2.0];
    final klist = listFrom<double>(originalList);    

    final result = klist.sumOf( (it) => it );

    expect(result, 3.0);
  });
}