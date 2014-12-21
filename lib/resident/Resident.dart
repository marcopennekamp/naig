part of naig.resident;

class Resident implements Renderable {

    static int nextId = 0;

    int id;
    String name;
    Sex sex;
    int level;

    Job job;

    bool alive = true;

    /* Attributes. */
    int stamina;
    int strength;
    int intellect;

    Date birthday;

    final Map<SkillType, Skill> skills = new Map ();

    /* Render stuff. */
    JobSelect _jobSelect;

    Resident () {
        id = nextId;
        nextId += 1;
        _generateSex ();
        name = generateName (sex);
        level = 1;
        job = new JobUnemployed (this);
        _generateAttributes ();
        _generateBirthday ();

        _jobSelect = new JobSelect (this);
    }

    void _generateSex () {
        if (random.nextInt (2) == 0) {
            sex = Sex.male;
        }else {
            sex = Sex.female;
        }
    }

    void _generateAttributes () {
        stamina = random.nextInt (10) + 10;
        strength = random.nextInt (10) + 10;
        intellect = random.nextInt (10) + 10;

        /* Reduce intellect or strength, depending on which attribute is less. */
        bool reduceStrength = false;
        bool reduceIntellect = false;
        if (strength < intellect) {
            reduceStrength = true;
        }else if (strength > intellect) {
            reduceIntellect = true;
        }else {
            if (random.nextInt (2) == 0) {
                reduceStrength = true;
            }else {
                reduceIntellect = true;
            }
        }

        if (reduceStrength) {
            strength -= 10;
        }

        if (reduceIntellect) {
            intellect -= 10;
        }
    }

    void _generateBirthday () {
        int yearOffset = random.nextInt (30) + 15;
        int week = random.nextInt (52) + 1;
        int year = game.date.year - yearOffset;
        birthday = new Date (year, week);
    }

    void tick () {
        if (birthday.week == game.date.week) {
            _birthday ();
        }

        job.tick ();
    }

    void _birthday () {
        game.displayNotification ('It\'s $name\'s birthday!');
    }

    int age () {
        int age = game.date.year - birthday.year;
        if (game.date.week < birthday.week) {
            age -= 1;
        }
        return age;
    }


    /* Renderable methods. */

    Element render () {
        DivElement element = new DivElement ();
        element.setAttribute ("class", "resident-box");
        element.setInnerHtml (
        """
        <h4>$name</h4>
        <small>$sex</small><br>
        <b>Attributes:</b>
        <ul>
            <li>Stamina: $stamina</li>
            <li>Strength: $strength</li>
            <li>Intellect: $intellect</li>
        </ul>
        """
        );
        element.append (_jobSelect.render ());
        return element;
    }

    /**
     * Renders each resident anew each tick.
     */
    bool isDirty () => true;

    String uniqueId () => 'resident-$id';

}