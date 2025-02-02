class Either<Left, Right> {
  final Left? leftValue;
  final Right? rightValue;

  Either.left(this.leftValue) : rightValue = null;

  Either.right(this.rightValue) : leftValue = null;

  bool get isLeft => leftValue != null;

  bool get isRight => rightValue != null;

  Left? get left => leftValue;

  Right? get right => rightValue;

  T fold<T>({
    required T Function(Left) onLeft,
    required T Function(Right) onRight,
  }) {
    if (isLeft) {
      return onLeft(leftValue!);
    } else if (isRight) {
      return onRight(rightValue!);
    } else {
      throw Exception('Either must be either left or right.');
    }
  }
}
