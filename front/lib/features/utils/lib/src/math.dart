extension DoubleScale on num {
  double scale(num from1, num from2, num to1, num to2) {
    return ((this - from1) / (from2 - from1)) * (to2 - to1) + to1;
  }

  double normalize(num from1, num from2) {
    return scale(from1, from2, 0, 1);
  }
}

const maxInt = -1 >>> 1;
