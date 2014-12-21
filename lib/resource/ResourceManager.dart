part of naig.resource;

class ResourceManager {
    Map<String, Resource> _resources = new Map ();

    Resource get (String name) {
        return _resources.putIfAbsent (name, () {
            return new Resource (ResourceTypes.nameToType[name]);
        });
    }

    void render () {
        renderIterable (querySelector ('#storage'), _resources.values);
    }

    bool isDirty () => true;
    String uniqueId () => 'resource-manager';


    Object toEncodable () {
        List list = new List ();
        for (Resource res in _resources.values) {
            list.add (res.toEncodable ());
        }
        return list;
    }

    static ResourceManager fromEncodable (Object encodable) {
        // TODO: Check if encodable is a List.
        List values = encodable;
        ResourceManager resourceManager = new ResourceManager ();
        for (Object value in values) {
            Resource res = Resource.fromEncodable (value);
            resourceManager._resources[res.type.name] = res;
        }
        return resourceManager;
    }

}