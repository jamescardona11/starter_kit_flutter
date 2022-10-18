abstract class BaseUseCase<R extends Object?, I extends dynamic> {
  R call(I data);
}

abstract class CommandUseCase<I extends Object?>
    implements BaseUseCase<void, I> {}

abstract class QueryUseCase<R extends Object?, I extends dynamic>
    implements BaseUseCase<R, I> {}
