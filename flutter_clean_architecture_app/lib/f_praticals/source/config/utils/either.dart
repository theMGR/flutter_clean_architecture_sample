class Either<Left, Right> {
  final Left? leftValue;
  final Right? rightValue;

  Either.left(this.leftValue) : rightValue = null;
  Either.right(this.rightValue) : leftValue = null;

  bool get isLeft => leftValue != null;
  bool get isRight => rightValue != null;

  Left? get left => leftValue;
  Right? get right => rightValue;
}