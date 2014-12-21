part of naig.resident;

abstract class Job {
    Resident _resident;
    int _cooldown;

    Job (this._resident) {
        _cooldown = maxCooldown ();
    }

    void tick () {
        _cooldown -= 1;
        if (_cooldown <= 0) {
            _work ();
            _cooldown = maxCooldown ();
        }
    }

    void _work ();

    /**
     * A max cooldown of 1 or less means that the job is executed each week.
     * So setting the max cooldown to 2, for example, means that the job is
     * executed every second week.
     */
    int maxCooldown ();
    String name ();
}

class JobUnemployed extends Job {
    static const String uniqueId = 'unemployed';

    JobUnemployed (Resident resident) : super (resident);

    void _work () {
        game.displayNotification ('${_resident.name} is currently unemployed. Assign them.');
    }

    int maxCooldown () => 1;
    String name () => uniqueId;
}

class JobLogger extends Job {
    static const String uniqueId = 'logger';

    JobLogger (Resident resident) : super (resident);

    void _work () {
        game.resourceManager.get (ResourceTypes.wood.name).changeAmount (1);
    }

    int maxCooldown () => 1;
    String name () => uniqueId;
}