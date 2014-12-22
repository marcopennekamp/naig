part of naig.util;

abstract class Savable {
    static Object callback_toEncodable (Object object) {
        if (object is Savable) {
            return object.toEncodable ();
        }else {
            return object;
        }
    }

    Object toEncodable ();
}
