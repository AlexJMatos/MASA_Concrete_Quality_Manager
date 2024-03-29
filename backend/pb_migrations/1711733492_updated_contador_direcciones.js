/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4tsftbf5djxkj6s")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "uamouoi6",
    "name": "contador",
    "type": "number",
    "required": true,
    "presentable": true,
    "unique": false,
    "options": {
      "min": 1,
      "max": null,
      "noDecimal": true
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4tsftbf5djxkj6s")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "uamouoi6",
    "name": "contador",
    "type": "number",
    "required": true,
    "presentable": true,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "noDecimal": true
    }
  }))

  return dao.saveCollection(collection)
})
