String getGiftCountString(int count) {
  if (count <= 0) {
    return 'Подарки отсутствуют';
  } else if (count <= 20) {
    return '$count подарков';
  }
  if (count / 10 % 10 == 1) {
    // Склонение если последние две цифры в числе 11 - 19 ... "подарков" при любой посленей цифре в числе
    return '$count ${_getStringForGiftRemainderOfDivision(count)}';
  }
  return '$count ${_getStringForGiftRemainderOfDivision(count % 10)}';
}

String _getStringForGiftRemainderOfDivision(int remander) {
  if (remander == 1) {
    return 'подарок';
  } else if (remander > 1 && remander <= 4) {
    return 'подарка';
  } else {
    // (remander == 0 || remander >= 5)
    return 'подарков';
  }
}
