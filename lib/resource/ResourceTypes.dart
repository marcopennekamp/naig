part of naig.resource;

class ResourceTypes {
    /* Materials. */
    static final wood = new ResourceType ('wood', ResourceCategory.material);
    static final stone = new ResourceType ('stone', ResourceCategory.material);

    /* Food. */
    static final wheat = new ResourceType ('wheat', ResourceCategory.material);
    static final bread = new ResourceType ('bread', ResourceCategory.material);

    /* Weapons. */
    static final spear = new ResourceType ('spear', ResourceCategory.weapon);

    static final Map<String, ResourceType> nameToType = _toMap ([
        /* Materials. */
        ResourceTypes.wood,
        ResourceTypes.stone,

        /* Food. */
        ResourceTypes.wheat,
        ResourceTypes.bread,

        /* Weapons. */
        ResourceTypes.spear,
    ]);

    static Map<String, ResourceType> _toMap (List<ResourceType> types) {
        Map<String, ResourceType> map = new Map ();
        for (var type in types) {
            map[type.name] = type;
        }
        return map;
    }
}