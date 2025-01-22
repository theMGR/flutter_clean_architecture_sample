abstract class UseCase<Request, Response> {
  Future<Response> execute(Request request);
}

class NoParams {
  NoParams();
}
