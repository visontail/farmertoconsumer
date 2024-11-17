class GetAllReturnValue<TModel> {
  final int total;
  final int current;
  final List<TModel> data;

  GetAllReturnValue({
    required this.total,
    required this.current,
    required this.data,
  });
}
