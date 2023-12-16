const String smsAddress = 'EmiratesNBD';
const String smsLike = 'Purchase of % with % ending % at % Avl % is %';
const String smsLikeSampleVariables =
    'AED 75.50 | Debit Card | 0189 | Dubai Mall. | Balance | AED 99,627.29.';
RegExp regExp = RegExp(
  r'^Purchase of (?<purchasedAmount>.*) with (?<cardType>.*) ending (?<cardNumber>[0-9]{4}) at (?<purchasedAt>.*) Avl (?<availableAmountType>.*) is (?<availableAmount>.*).*$',
  caseSensitive: false,
  multiLine: true,
);
