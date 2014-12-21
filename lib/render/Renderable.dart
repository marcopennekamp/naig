part of naig.render;

abstract class Renderable {
    /**
     * Should set isDirty to false.
     */
    Element render ();

    bool isDirty ();

    String uniqueId ();
}