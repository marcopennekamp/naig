part of naig.resident;

enum SkillType {
    logging, hunting, cooking,
}

class Skill {
    static const int maxLevel = 10;
    static const int minLevel = 1;

    SkillType type;
    int level;

    Skill (this.type, this.level);

    Skill.randomLevel (this.type) {
        level = random.nextInt ((maxLevel / 3) as int) + minLevel;
    }
}
