class CountryCallingCode {
  final String? code;
  final String? name;

  CountryCallingCode({this.code, this.name});

  factory CountryCallingCode.fromMap(Map<String, String> map) {
    return CountryCallingCode(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'code': code!,
      'name': name!,
    };
  }
  @override
  String toString() {
    return '  $name';
  }
}
class Country {
  final String? name;

  Country({this.name});

  factory Country.fromMap(Map<String, String> map) {
    return Country(name: map['name'] ?? '');
  }

  Map<String, String> toMap() {
    return {'name': name!};
  }

  @override
  String toString() {
    return "$name";
  }
}
class StateAbbreviation {
  final String? abbreviation;

  StateAbbreviation({this.abbreviation});

  factory StateAbbreviation.fromMap(Map<String, String> map) {
    return StateAbbreviation(abbreviation: map['abbreviation'] ?? '');
  }

  Map<String, String> toMap() {
    return {'abbreviation': abbreviation!};
  }

  @override
  String toString() {
    return "$abbreviation";
  }
}
List<String> usStateAbbreviations = [
  "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
  "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
  "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
  "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
  "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"
];

List<String> countryNames = [
  "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria",
  "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan",
  "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon",
  "Canada", "Cape Verde", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo (Democratic Republic)",
  "Congo (Republic)", "Costa Rica", "Côte d'Ivoire", "Croatia", "Cuba", "Cyprus", "Czechia", "Denmark", "Djibouti", "Dominica",
  "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini", "Ethiopia", "Fiji",
  "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau",
  "Guyana", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica",
  "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea (North)", "Korea (South)", "Kosovo", "Kuwait", "Kyrgyzstan", "Laos",
  "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Madagascar", "Malawi", "Malaysia",
  "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia",
  "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger",
  "Nigeria", "North Macedonia", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines",
  "Poland", "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines",
  "Samoa", "San Marino", "São Tomé and Príncipe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore",
  "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Korea", "South Sudan", "Spain", "Sri Lanka", "Sudan",
  "Suriname", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga",
  "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom",
  "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"
];

final List<Map<String, String>> countryCallingCodes = [
  {'code': 'AF', 'name': '+93 Afghanistan'},
  {'code': 'AL', 'name': '+355 Albania'},
  {'code': 'DZ', 'name': '+213 Algeria'},
  {'code': 'AS', 'name': '+1 684 American Samoa'},
  {'code': 'AD', 'name': '+376 Andorra'},
  {'code': 'AO', 'name': '+244 Angola'},
  {'code': 'AI', 'name': '+1 264 Anguilla'},
  {'code': 'AQ', 'name': '+672 Antarctica'},
  {'code': 'AG', 'name': '+1 268 Antigua and Barbuda'},
  {'code': 'AR', 'name': '+54 Argentina'},
  {'code': 'AM', 'name': '+374 Armenia'},
  {'code': 'AW', 'name': '+297 Aruba'},
  {'code': 'AU', 'name': '+61 Australia'},
  {'code': 'AT', 'name': '+43 Austria'},
  {'code': 'AZ', 'name': '+994 Azerbaijan'},
  {'code': 'BS', 'name': '+1 242 Bahamas'},
  {'code': 'BH', 'name': '+973 Bahrain'},
  {'code': 'BD', 'name': '+880 Bangladesh'},
  {'code': 'BB', 'name': '+1 246 Barbados'},
  {'code': 'BY', 'name': '+375 Belarus'},
  {'code': 'BE', 'name': '+32 Belgium'},
  {'code': 'BZ', 'name': '+501 Belize'},
  {'code': 'BJ', 'name': '+229 Benin'},
  {'code': 'BM', 'name': '+1 441 Bermuda'},
  {'code': 'BT', 'name': '+975 Bhutan'},
  {'code': 'BO', 'name': '+591 Bolivia'},
  {'code': 'BQ', 'name': '+599 Bonaire, Sint Eustatius, and Saba'},
  {'code': 'BA', 'name': '+387 Bosnia and Herzegovina'},
  {'code': 'BW', 'name': '+267 Botswana'},
  {'code': 'BR', 'name': '+55 Brazil'},
  {'code': 'IO', 'name': '+246 British Indian Ocean Territory'},
  {'code': 'BN', 'name': '+673 Brunei Darussalam'},
  {'code': 'BG', 'name': '+359 Bulgaria'},
  {'code': 'BF', 'name': '+226 Burkina Faso'},
  {'code': 'BI', 'name': '+257 Burundi'},
  {'code': 'KH', 'name': '+855 Cambodia'},
  {'code': 'CM', 'name': '+237 Cameroon'},
  {'code': 'CA', 'name': '+1 Canada'},
  {'code': 'CV', 'name': '+238 Cape Verde'},
  {'code': 'KY', 'name': '+1 345 Cayman Islands'},
  {'code': 'CF', 'name': '+236 Central African Republic'},
  {'code': 'TD', 'name': '+235 Chad'},
  {'code': 'CL', 'name': '+56 Chile'},
  {'code': 'CN', 'name': '+86 China'},
  {'code': 'CX', 'name': '+61 Christmas Island'},
  {'code': 'CC', 'name': '+61 Cocos (Keeling) Islands'},
  {'code': 'CO', 'name': '+57 Colombia'},
  {'code': 'KM', 'name': '+269 Comoros'},
  {'code': 'CG', 'name': '+242 Congo'},
  {'code': 'CD', 'name': '+243 Democratic Republic of the Congo'},
  {'code': 'CK', 'name': '+682 Cook Islands'},
  {'code': 'CR', 'name': '+506 Costa Rica'},
  {'code': 'CI', 'name': "+225 Côte d'Ivoire"},
  {'code': 'HR', 'name': '+385 Croatia'},
  {'code': 'CU', 'name': '+53 Cuba'},
  {'code': 'CY', 'name': '+357 Cyprus'},
  {'code': 'CZ', 'name': '+420 Czech Republic'},
  {'code': 'DK', 'name': '+45 Denmark'},
  {'code': 'DJ', 'name': '+253 Djibouti'},
  {'code': 'DO', 'name': '+1 809, 829, 849 Dominican Republic'},
  {'code': 'EC', 'name': '+593 Ecuador'},
  {'code': 'EG', 'name': '+20 Egypt'},
  {'code': 'SV', 'name': '+503 El Salvador'},
  {'code': 'GQ', 'name': '+240 Equatorial Guinea'},
  {'code': 'ER', 'name': '+291 Eritrea'},
  {'code': 'EE', 'name': '+372 Estonia'},
  {'code': 'ET', 'name': '+251 Ethiopia'},
  {'code': 'FK', 'name': '+500 Falkland Islands'},
  {'code': 'FO', 'name': '+298 Faroe Islands'},
  {'code': 'FJ', 'name': '+679 Fiji'},
  {'code': 'FI', 'name': '+358 Finland'},
  {'code': 'FR', 'name': '+33 France'},
  {'code': 'GF', 'name': '+594 French Guiana'},
  {'code': 'PF', 'name': '+689 French Polynesia'},
  {'code': 'GA', 'name': '+241 Gabon'},
  {'code': 'GM', 'name': '+220 Gambia'},
  {'code': 'GE', 'name': '+995 Georgia'},
  {'code': 'DE', 'name': '+49 Germany'},
  {'code': 'GH', 'name': '+233 Ghana'},
  {'code': 'GI', 'name': '+350 Gibraltar'},
  {'code': 'GR', 'name': '+30 Greece'},
  {'code': 'GL', 'name': '+299 Greenland'},
  {'code': 'GD', 'name': '+1 473 Grenada'},
  {'code': 'GP', 'name': '+590 Guadeloupe'},
  {'code': 'GU', 'name': '+1 671 Guam'},
  {'code': 'GT', 'name': '+502 Guatemala'},
  {'code': 'GG', 'name': '+44 1481 Guernsey'},
  {'code': 'GN', 'name': '+224 Guinea'},
  {'code': 'GW', 'name': '+245 Guinea-Bissau'},
  {'code': 'GY', 'name': '+595 Guyana'},
  {'code': 'HT', 'name': '+509 Haiti'},
  {'code': 'HN', 'name': '+504 Honduras'},
  {'code': 'HK', 'name': '+852 Hong Kong'},
  {'code': 'HU', 'name': '+36 Hungary'},
  {'code': 'IS', 'name': '+354 Iceland'},
  {'code': 'IN', 'name': '+91 India'},
  {'code': 'ID', 'name': '+62 Indonesia'},
  {'code': 'IR', 'name': '+98 Iran'},
  {'code': 'IQ', 'name': '+964 Iraq'},
  {'code': 'IE', 'name': '+353 Ireland'},
  {'code': 'IL', 'name': '+972 Israel'},
  {'code': 'IT', 'name': '+39 Italy'},
  {'code': 'JM', 'name': '+1 876 Jamaica'},
  {'code': 'JP', 'name': '+81 Japan'},
  {'code': 'JE', 'name': '+44 1534 Jersey'},
  {'code': 'JO', 'name': '+962 Jordan'},
  {'code': 'KZ', 'name': '+7 Kazakhstan'},
  {'code': 'KE', 'name': '+254 Kenya'},
  {'code': 'KI', 'name': '+686 Kiribati'},
  {'code': 'KR', 'name': '+82 Korea, South'},
  {'code': 'KW', 'name': '+965 Kuwait'},
  {'code': 'KG', 'name': '+996 Kyrgyzstan'},
  {'code': 'LA', 'name': '+856 Laos'},
  {'code': 'LV', 'name': '+371 Latvia'},
  {'code': 'LB', 'name': '+961 Lebanon'},
  {'code': 'LS', 'name': '+266 Lesotho'},
  {'code': 'LR', 'name': '+231 Liberia'},
  {'code': 'LY', 'name': '+218 Libya'},
  {'code': 'LI', 'name': '+423 Liechtenstein'},
  {'code': 'LT', 'name': '+370 Lithuania'},
  {'code': 'LU', 'name': '+352 Luxembourg'},
  {'code': 'MO', 'name': '+853 Macau'},
  {'code': 'MK', 'name': '+389 Macedonia'},
  {'code': 'MG', 'name': '+261 Madagascar'},
  {'code': 'MW', 'name': '+265 Malawi'},
  {'code': 'MY', 'name': '+60 Malaysia'},
  {'code': 'MV', 'name': '+960 Maldives'},
  {'code': 'ML', 'name': '+223 Mali'},
  {'code': 'MT', 'name': '+356 Malta'},
  {'code': 'MH', 'name': '+692 Marshall Islands'},
  {'code': 'MQ', 'name': '+596 Martinique'},
  {'code': 'MR', 'name': '+222 Mauritania'},
  {'code': 'MU', 'name': '+230 Mauritius'},
  {'code': 'YT', 'name': '+262 Mayotte'},
  {'code': 'MX', 'name': '+52 Mexico'},
  {'code': 'FM', 'name': '+691 Micronesia'},
  {'code': 'MD', 'name': '+373 Moldova'},
  {'code': 'MC', 'name': '+377 Monaco'},
  {'code': 'MN', 'name': '+976 Mongolia'},
  {'code': 'ME', 'name': '+382 Montenegro'},
  {'code': 'MS', 'name': '+1 664 Montserrat'},
  {'code': 'MA', 'name': '+212 Morocco'},
  {'code': 'MZ', 'name': '+258 Mozambique'},
  {'code': 'MM', 'name': '+95 Myanmar'},
  {'code': 'NA', 'name': '+264 Namibia'},
  {'code': 'NR', 'name': '+674 Nauru'},
  {'code': 'NP', 'name': '+977 Nepal'},
  {'code': 'NL', 'name': '+31 Netherlands'},
  {'code': 'NC', 'name': '+687 New Caledonia'},
  {'code': 'NZ', 'name': '+64 New Zealand'},
  {'code': 'NI', 'name': '+505 Nicaragua'},
  {'code': 'NE', 'name': '+227 Niger'},
  {'code': 'NG', 'name': '+234 Nigeria'},
  {'code': 'NU', 'name': '+683 Niue'},
  {'code': 'NF', 'name': '+672 Norfolk Island'},
  {'code': 'MP', 'name': '+1 670 Northern Mariana Islands'},
  {'code': 'NO', 'name': '+47 Norway'},
  {'code': 'OM', 'name': '+968 Oman'},
  {'code': 'PK', 'name': '+92 Pakistan'},
  {'code': 'PW', 'name': '+680 Palau'},
  {'code': 'PS', 'name': '+970 Palestine'},
  {'code': 'PA', 'name': '+507 Panama'},
  {'code': 'PG', 'name': '+675 Papua New Guinea'},
  {'code': 'PY', 'name': '+595 Paraguay'},
  {'code': 'PE', 'name': '+51 Peru'},
  {'code': 'PH', 'name': '+63 Philippines'},
  {'code': 'PL', 'name': '+48 Poland'},
  {'code': 'PT', 'name': '+351 Portugal'},
  {'code': 'PR', 'name': '+1 787, 939 Puerto Rico'},
  {'code': 'QA', 'name': '+974 Qatar'},
  {'code': 'RE', 'name': '+262 Réunion'},
  {'code': 'RO', 'name': '+40 Romania'},
  {'code': 'RU', 'name': '+7 Russia'},
  {'code': 'RW', 'name': '+250 Rwanda'},
  {'code': 'BL', 'name': '+590 Saint Barthélemy'},
  {'code': 'SH', 'name': '+290 Saint Helena'},
  {'code': 'KN', 'name': '+1 869 Saint Kitts and Nevis'},
  {'code': 'LC', 'name': '+1 758 Saint Lucia'},
  {'code': 'MF', 'name': '+590 Saint Martin'},
  {'code': 'PM', 'name': '+508 Saint Pierre and Miquelon'},
  {'code': 'VC', 'name': '+1 784 Saint Vincent and the Grenadines'},
  {'code': 'WS', 'name': '+685 Samoa'},
  {'code': 'SM', 'name': '+378 San Marino'},
  {'code': 'ST', 'name': '+239 São Tomé and Príncipe'},
  {'code': 'SA', 'name': '+966 Saudi Arabia'},
  {'code': 'SN', 'name': '+221 Senegal'},
  {'code': 'RS', 'name': '+381 Serbia'},
  {'code': 'SC', 'name': '+248 Seychelles'},
  {'code': 'SL', 'name': '+232 Sierra Leone'},
  {'code': 'SG', 'name': '+65 Singapore'},
  {'code': 'SX', 'name': '+1 721 Sint Maarten'},
  {'code': 'SK', 'name': '+421 Slovakia'},
  {'code': 'SI', 'name': '+386 Slovenia'},
  {'code': 'SB', 'name': '+677 Solomon Islands'},
  {'code': 'SO', 'name': '+252 Somalia'},
  {'code': 'ZA', 'name': '+27 South Africa'},
  {'code': 'KR', 'name': '+82 South Korea'},
  {'code': 'SS', 'name': '+211 South Sudan'},
  {'code': 'ES', 'name': '+34 Spain'},
  {'code': 'LK', 'name': '+94 Sri Lanka'},
  {'code': 'SD', 'name': '+249 Sudan'},
  {'code': 'SR', 'name': '+597 Suriname'},
  {'code': 'SZ', 'name': '+268 Eswatini'},
  {'code': 'SE', 'name': '+46 Sweden'},
  {'code': 'CH', 'name': '+41 Switzerland'},
  {'code': 'SY', 'name': '+963 Syria'},
  {'code': 'TW', 'name': '+886 Taiwan'},
  {'code': 'TJ', 'name': '+992 Tajikistan'},
  {'code': 'TZ', 'name': '+255 Tanzania'},
  {'code': 'TH', 'name': '+66 Thailand'},
  {'code': 'TG', 'name': '+228 Togo'},
  {'code': 'TK', 'name': '+690 Tokelau'},
  {'code': 'TO', 'name': '+676 Tonga'},
  {'code': 'TT', 'name': '+1 868 Trinidad and Tobago'},
  {'code': 'TN', 'name': '+216 Tunisia'},
  {'code': 'TR', 'name': '+90 Turkey'},
  {'code': 'TM', 'name': '+993 Turkmenistan'},
  {'code': 'TC', 'name': '+1 649 Turks and Caicos Islands'},
  {'code': 'TV', 'name': '+688 Tuvalu'},
  {'code': 'UG', 'name': '+256 Uganda'},
  {'code': 'UA', 'name': '+380 Ukraine'},
  {'code': 'AE', 'name': '+971 United Arab Emirates'},
  {'code': 'GB', 'name': '+44 United Kingdom'},
  {'code': 'US', 'name': '+1 United States'},
  {'code': 'UY', 'name': '+598 Uruguay'},
  {'code': 'UZ', 'name': '+998 Uzbekistan'},
  {'code': 'VU', 'name': '+678 Vanuatu'},
  {'code': 'VE', 'name': '+58 Venezuela'},
  {'code': 'VN', 'name': '+84 Vietnam'},
  {'code': 'WF', 'name': '+681 Wallis and Futuna'},
  {'code': 'EH', 'name': '+212 Western Sahara'},
  {'code': 'YE', 'name': '+967 Yemen'},
  {'code': 'ZM', 'name': '+260 Zambia'},
  {'code': 'ZW', 'name': '+263 Zimbabwe'},
];
