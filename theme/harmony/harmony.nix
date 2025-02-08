{
  # TODO:
  # write a functions to match based on values (bidirectonial)
  # eg: f red "50" <-> f red "950"
  # pairLevels = color: level: _;
  # pairContrast = color: contrast: _;
  # pairChroma = color: chroma: _;
  levels = [
    "50"
    "100"
    "200"
    "300"
    "400"
    "500"
    "600"
    "700"
    "800"
    "900"
    "950"
  ];
  contrast = [
    "105"
    "100"
    "90"
    "77"
    "65"
    "54"
    "65"
    "77"
    "90"
    "100"
    "105"
  ];
  chroma = [
    "0.005"
    "0.02"
    "0.04"
    "0.08"
    "0.11"
    "0.15"
    "0.14"
    "0.12"
    "0.09"
    "0.07"
    "0.04"
  ];

  red = [
    "#FEFAFA"
    "#FDF0F0"
    "#FADCDA"
    "#F7C0BE"
    "#F2A4A2"
    "#EC8786"
    "#C06868"
    "#9B5353"
    "#6F3A3A"
    "#462322"
    "#210D0D"
  ];

  orange = [
    "#FDFAF9"
    "#FCF1EC"
    "#F9DED1"
    "#F4C3AC"
    "#EFA987"
    "#E98D61"
    "#BC6D47"
    "#985738"
    "#6D3D26"
    "#452515"
    "#200E06"
  ];

  amber = [
    "#FDFBF8"
    "#FBF2E9"
    "#F4E1CA"
    "#ECC8A0"
    "#E4B073"
    "#DB9640"
    "#B17629"
    "#8E5E1F"
    "#664214"
    "#402809"
    "#1E1103"
  ];

  yellow = [
    "#FCFBF8"
    "#F7F3E8"
    "#EDE4C8"
    "#DFCE9B"
    "#D1B86C"
    "#C5A231"
    "#9D8018"
    "#7F6712"
    "#5A480A"
    "#382C05"
    "#1A1302"
  ];

  lime = [
    "#FBFBF8"
    "#F4F4E9"
    "#E6E6C9"
    "#D3D29D"
    "#C1BE6F"
    "#B0AA39"
    "#8C8721"
    "#706C1A"
    "#504D10"
    "#312F07"
    "#161502"
  ];

  green = [
    "#FBFCF9"
    "#F1F5E9"
    "#DFE7CC"
    "#C6D5A3"
    "#AFC37A"
    "#97B14C"
    "#778D35"
    "#607129"
    "#43501B"
    "#29320E"
    "#111604"
  ];

  emerald = [
    "#FAFCF9"
    "#EFF6EC"
    "#D8E9D2"
    "#BAD8AD"
    "#9BC789"
    "#7DB664"
    "#60914A"
    "#4C753B"
    "#355228"
    "#203417"
    "#0C1708"
  ];

  teal = [
    "#F9FCFA"
    "#ECF6EF"
    "#D1EADA"
    "#ACDABD"
    "#86CAA0"
    "#5AB983"
    "#419466"
    "#337751"
    "#225438"
    "#133422"
    "#"
  ];

  cyan = [
    "#F9FCFB"
    "#EAF6F3"
    "#CCEBE3"
    "#A2DBCE"
    "#75CAB8"
    "#39BAA4"
    "#1E9481"
    "#177768"
    "#0D5449"
    "#06342C"
    "#021713"
  ];

  sky = [
    "#F9FCFD"
    "#E9F6F9"
    "#CBEAF1"
    "#9FD9E6"
    "#6FC7DC"
    "#2AB6D1"
    "#0690A8"
    "#057487"
    "#035260"
    "#02333C"
    "#01161B"
  ];

  blue = [
    "#F9FCFE"
    "#ECF5FD"
    "#D0E7FB"
    "#AAD4F8"
    "#83C0F5"
    "#58ACF2"
    "#3E88C5"
    "#316E9F"
    "#214D72"
    "#123048"
    "#051522"
  ];

  indigo = [
    "#FAFBFE"
    "#EEF4FE"
    "#D7E5FE"
    "#B7CFFE"
    "#98BAFE"
    "#79A4FE"
    "#5D82CF"
    "#4A68A7"
    "#334978"
    "#1E2D4C"
    "#0B1425"
  ];

  violet = [
    "#FAFBFE"
    "#F1F2FE"
    "#DFE2FE"
    "#C6CBFF"
    "#AFB4FE"
    "#989CFF"
    "#787ACF"
    "#6062A8"
    "#434578"
    "#292A4D"
    "#111225"
  ];

  purple = [
    "#FBFBFE"
    "#F5F2FD"
    "#E7E0FC"
    "#D5C6F9"
    "#C4AEF7"
    "#B394F4"
    "#8F74C7"
    "#735DA1"
    "#514173"
    "#332749"
    "#171123"
  ];

  fucshia = [
    "#FCFAFD"
    "#F8F1FB"
    "#EFDDF5"
    "#E2C3EF"
    "#D6A8E7"
    "#CA8DE1"
    "#A36EB6"
    "#835893"
    "#5D3D69"
    "#3B2543"
    "#1B0F1F"
  ];

  pink = [
    "#FDFAFC"
    "#FAF0F7"
    "#F5DDEE"
    "#EDC1E0"
    "#E5A5D3"
    "#DC88C7"
    "#B26AA0"
    "#8F5480"
    "#663A5B"
    "#412339"
    "#1E0E1A"
  ];

  rose = [
    "#FDFAFB"
    "#FCF0F3"
    "#F9DCE4"
    "#F4C0CF"
    "#EEA3BB"
    "#E886A7"
    "#BB6784"
    "#97526A"
    "#6C394B"
    "#44222E"
    "#200D14"
  ];

  slate = [
    "#FAFBFE"
    "#F0F3FF"
    "#E0E3F3"
    "#CBCEDE"
    "#B6B9C9"
    "#A3A6B5"
    "#808392"
    "#666977"
    "#474A57"
    "#2B2E3A"
    "#12141E"
  ];

  gray = [
    "#FAFBFE"
    "#F0F3FE"
    "#E1E3EE"
    "#CCCED9"
    "#B7BAC4"
    "#A4A6B0"
    "#82848D"
    "#676973"
    "#494A53"
    "#2C2E36"
    "#13141B"
  ];

  zinc = [
    "#FAFBFE"
    "#F2F3F8"
    "#E2E3E9"
    "#CDCED4"
    "#B9BABF"
    "#A5A6AB"
    "#838489"
    "#696A6E"
    "#4A4B4F"
    "#2D2E32"
    "#141418"
  ];

  neutral = [
    "#FBFBFB"
    "#F3F3F3"
    "#E4E4E4"
    "#CFCFCF"
    "#BABABA"
    "#A6A6A6"
    "#838383"
    "#6A6A6A"
    "#4B4B4B"
    "#2E2E2E"
    "#141414"
  ];

  stone = [
    "#FEFBF6"
    "#F6F3EE"
    "#E6E3DF"
    "#D1CECA"
    "#BDBAB5"
    "#A9A6A2"
    "#86847F"
    "#6C6965"
    "#4D4A47"
    "#302E2B"
    "#161411"
  ];

  sand = [
    "#FFFBF4"
    "#F7F3EC"
    "#E8E3DC"
    "#D3CEC7"
    "#BEB9B3"
    "#AAA69F"
    "#88837D"
    "#6D6963"
    "#4E4A45"
    "#312E29"
    "#17140F"
  ];

  olive = [
    "#FBFCF7"
    "#F3F4EF"
    "#E3E5DF"
    "#CECFCA"
    "#BABBB6"
    "#A5A7A2"
    "#83847F"
    "#696B66"
    "#4A4B47"
    "#2E2F2B"
    "#141511"
  ];

  mauve = [
    "#FDFAFE"
    "#F6F2F7"
    "#E6E2E6"
    "#D1CDD1"
    "#BCB9BD"
    "#A8A5A9"
    "#868386"
    "#6C686C"
    "#4D4A4D"
    "#302D30"
    "#161316"
  ];
}
