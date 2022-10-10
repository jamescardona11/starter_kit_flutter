abstract class BaseUseCase<R extends Object?, I extends dynamic> {
  R call(I data);
}

abstract class CommandUseCase<R extends Object?>
    implements BaseUseCase<R, void> {}

abstract class QueryUseCase<R extends Object?, I extends dynamic>
    implements BaseUseCase<R, I> {}
