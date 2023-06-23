const bool useMockData = false;
const bool useDebugBorders = false;
const bool useDebugBanner = false;

const String appName = 'Pay Tracker';

const String smsAddress = 'EmiratesNBD';
const String smsLike = 'Purchase of % with % ending % at % Avl % is %';
const String smsLikeSampleVariables =
    'AED 75.50 | Debit Card | 0189 | Dubai Mall. | Balance | AED 99,627.29.';
RegExp regExp = RegExp(
  r'^Purchase of (?<purchasedAmount>.*) with (?<cardType>.*) ending (?<cardNumber>.*) at (?<purchasedAt>.*) Avl (?<availableAmountType>.*) is (?<availableAmount>.*).*$',
  caseSensitive: false,
  multiLine: true,
);

const String noSmsFoundText =
    'No payment messages found in your inbox!\nThis application looks for SMS like the one below.';
const String noSmsAccessText =
    'This application requires your permission to read SMS inbox!';
const String errorBoundaryText =
    'This following error occurred. Please show this to a programmer.';

const String creditCardCoverImageUri = 'lib/assets/images/credit_card';
const String debitCardCoverImageUri = 'lib/assets/images/debit_card';
const String cardCoverFileType = '.jpg';
