abstract class UseCase<Input, output> {
  Future<output> call(Input input);
}

class NoParams {
  NoParams();
}
