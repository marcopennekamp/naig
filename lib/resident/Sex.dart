part of naig.resident;

class Sex implements Savable {

    static final Sex male = new Sex._internal ('male');
    static final Sex female = new Sex._internal ('female');

    String name;

    Sex._internal (this.name);

    String toString () => name;

    Object toEncodable () => name;

    static Sex fromEncodable (Object object) {
        String name = object;
        if (name == 'male') {
            return male;
        }else {
            return female;
        }
    }

}