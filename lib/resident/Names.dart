part of naig.resident;


final List<String> maleFirstNames = [
    'Gabe'
];

final List<String> femaleFirstNames = [
    'Anne'
];

final List<String> lastNames = [
    'Newman'
];

String generateName (Sex sex) {
    var firstNames;
    if (sex == Sex.male) {
        firstNames = maleFirstNames;
    }else {
        firstNames = femaleFirstNames;
    }

    String firstName = firstNames[random.nextInt (firstNames.length)];
    String lastName = lastNames[random.nextInt (lastNames.length)];
    return '$firstName $lastName';
}
