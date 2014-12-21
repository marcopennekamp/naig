part of naig.resource;

class ResourceType {
    final String name;
    final ResourceCategory category;
    ResourceType (this.name, this.category);
}

class Resource implements Renderable {
    final ResourceType _type;
    int amount;

    Resource (this._type) : amount = 0;

    void changeAmount (int change) {
        amount += change;
    }

    bool use (int used) {
        if (amount < used) {
            return false;
        }else {
            changeAmount (-used);
            return true;
        }
    }

    ResourceType get type => _type;

    Element render () {
        LIElement element = new LIElement ();
        element.setInnerHtml (
            """
            <b>${type.name}</b>: $amount
            """
        );
        return element;
    }

    bool isDirty () => true;
    String uniqueId () => 'resource-${type.name}';

    /* String toJson () {
        return JSON.encode (toEncodable ());
    } */

    Object toEncodable () {
        return {'type': _type.name, 'amount': amount};
    }

    static Resource fromEncodable (Object encodable) {
        // TODO: Check that encodable is a Map.
        Map data = encodable;
        Resource resource = new Resource (ResourceTypes.nameToType[data['type']]);
        resource.amount = data['amount'];
        return resource;
    }

}