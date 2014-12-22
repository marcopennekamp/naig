part of naig.resident;

class JobSelect implements Renderable {

    Resident _resident;
    SelectElement _element;

    JobSelect (this._resident);

    Element render () {
        if (_element == null) {
            _element = new SelectElement ();
            _element.addEventListener ('change', _selected);
            var keys = Job.jobConstructorMap.keys;
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
        _resident.job = Job.jobConstructorMap[_element.options[_element.selectedIndex].value] (_resident);
    }

    bool isDirty () => true;
    String uniqueId () => 'jobSelect-${_resident.id}';

}