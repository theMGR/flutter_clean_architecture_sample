abstract class Mapper<IN, OUT> {
  OUT transform(IN inner);

  IN reverse(OUT outer);

  List<OUT> transformList(List<IN>? inList) {
    List<OUT> outList = [];
    if (inList != null) {
      inList.map((input) => outList.add(transform(input))).toList();
    }
    return outList;
  }

  List<IN> reverseList(List<OUT>? inList) {
    List<IN> outList = [];
    if (inList != null) {
      inList.map((input) => outList.add(reverse(input))).toList();
    }
    return outList;
  }
}
