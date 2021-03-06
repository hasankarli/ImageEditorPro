const FilterNames = [
  "NO FILTER",
  "SEPIA",
  "GREYSCALE",
  "VINTAGE",
  "SWEET",
  "SEPIUM",
  "MILK",
  "COLD LIFE",
  "OLD TIMES",
  "BLACK WHITE",
  "CYAN",
  "YELLOW"
];
final List<List<double>> filters = [
  NO_FILTER,
  SEPIA_MATRIX,
  GREYSCALE_MATRIX,
  VINTAGE_MATRIX,
  SWEET_MATRIX,
  SEPIUM,
  MILK,
  COLD_LIFE,
  OLD_TIMES,
  BLACK_WHITE,
  CYAN,
  YELLOW
];

const NO_FILTER = [
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];
const SEPIA_MATRIX = [
  0.39,
  0.769,
  0.189,
  0.0,
  0.0,
  0.349,
  0.686,
  0.168,
  0.0,
  0.0,
  0.272,
  0.534,
  0.131,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];

const GREYSCALE_MATRIX = [
  0.2126,
  0.7152,
  0.0722,
  0.0,
  0.0,
  0.2126,
  0.7152,
  0.0722,
  0.0,
  0.0,
  0.2126,
  0.7152,
  0.0722,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];

const VINTAGE_MATRIX = [
  0.9,
  0.5,
  0.1,
  0.0,
  0.0,
  0.3,
  0.8,
  0.1,
  0.0,
  0.0,
  0.2,
  0.3,
  0.5,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];

const SWEET_MATRIX = [
  1.0,
  0.0,
  0.2,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];
const SEPIUM = [
  1.3,
  -0.3,
  1.1,
  0.0,
  0.0,
  0.0,
  1.3,
  0.2,
  0.0,
  0.0,
  0.0,
  0.0,
  0.8,
  0.2,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];
const MILK = [
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.6,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];

const COLD_LIFE = [
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  -0.2,
  0.2,
  0.1,
  0.4,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];

const OLD_TIMES = [
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  -0.4,
  1.3,
  -0.4,
  0.2,
  -0.1,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];

const BLACK_WHITE = [
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  1.0,
  0.0
];

const CYAN = [
  1.0,
  0.0,
  0.0,
  1.9,
  -2.2,
  0.0,
  1.0,
  0.0,
  0.0,
  0.3,
  0.0,
  0.0,
  1.0,
  0.0,
  0.5,
  0.0,
  0.0,
  0.0,
  1.0,
  0.2
];

const YELLOW = [
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  -0.2,
  1.0,
  0.3,
  0.1,
  0.0,
  -0.1,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];
