part of naig.resident;

class JobSelect implements Renderable {

    static Map<String, Function> _jobMap = null;

    Resident _resident;
    SelectElement _element;

    JobSelect (this._resident) {
        /* Initialize the job map... */
        // TODO: Probably the wrong place to do this!
        if (_jobMap == null) {
            _jobMap = new Map ();
            _jobMap[JobUnemployed.uniqueId] = (Resident resident) => new JobUnemployed (resident);
            _jobMap[JobLogger.uniqueId] = (Resident resident) => new JobLogger (resident);
        }
    }

    Element render () {
        if (_element == null) {
            _element = new SelectElement ();
            _element.addEventListener ('change', _selected);
            var keys = _jobMap.keys;
            for (String key in keys) {
                OptionElement option = new OptionElement ();
                option.value = key;
                option.text = key;
                option.selected = _resident.job.name () == key;
                _element.append (option);
            }
        }
        return _element;
    }

    void _selected (Event e) {
        _resident.job = _jobMap[_element.options[_element.selectedIndex].value] (_resident);
    }

    bool isDirty () => true;
    String uniqueId () => 'jobSelect-${_resident.id}';

}