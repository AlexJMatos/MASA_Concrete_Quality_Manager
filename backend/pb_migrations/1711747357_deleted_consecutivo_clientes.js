/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("kq1m01a6gss4ftn");

  return dao.deleteCollection(collection);
}, (db) => {
  const collection = new Collection({
    "id": "kq1m01a6gss4ftn",
    "created": "2024-03-29 17:28:50.713Z",
    "updated": "2024-03-29 17:58:38.976Z",
    "name": "consecutivo_clientes",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "vgd2to5y",
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
      },
      {
        "system": false,
        "id": "fhzpkibq",
        "name": "activo",
        "type": "bool",
        "required": false,
        "presentable": true,
        "unique": false,
        "options": {}
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
})