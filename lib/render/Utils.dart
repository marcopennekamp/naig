part of naig.render;

void renderIterable (Element container, Iterable<Renderable> renderables) {
    for (var renderable in renderables) {
        String idStr = renderable.uniqueId ();
        Element element = querySelector ('#' + idStr);
        if (element == null) {
            element = renderable.render ();
            element.id = idStr;
            container.append (element);
        }else if (renderable.isDirty ()) {
            Element toInsert = renderable.render ();
            toInsert.id = idStr;
            element.insertAdjacentElement ('afterEnd', toInsert);
            element.remove ();
        }
    }
}