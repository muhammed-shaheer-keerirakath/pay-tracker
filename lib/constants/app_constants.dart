const bool useMockData = true;
const bool useDebugBorders = false;
const bool useDebugBanner = false;

const String appName = 'Pay Tracker';

const String smsAddress = 'EmiratesNBD';
const String smsLike = 'Purchase of % with % ending % at % Avl % is %';
RegExp regExp = RegExp(
  r"^Purchase of (?<purchasedAmount>.*) with (?<cardType>.*) ending (?<cardNumber>.*) at (?<purchasedAt>.*) Avl (?<availableAmountType>.*) is (?<availableAmount>.*).*$",
  caseSensitive: false,
  multiLine: true,
);

const String noSmsAccessText =
    'This application requires your permission to read SMS inbox!';
const String errorBoundaryText =
    'This following error occurred. Please show this to a programmer.';
