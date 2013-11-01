/*
 * create-xml
 * https://github.com/yamadapc/create-xml
 *
 * Copyright (c) 2013
 * Licensed under the MIT license.
*/

_ = require \underscore

{Document, Element} = require \libxmljs

set-node = (root, value, key) -->
  new-root = root.node key, value
            ..attr value?attr

  if value instanceof Object
    _.each value, (set-node new-root)

  root

create-xml = (obj, options) ->
  if (_.size _.keys obj) > 1
    throw new Error 'There must be only one root element'

  xml-declaration = options?xml-declaration
  xml-doc = new Document declaration?version, declaration?encoding

  _.reduce obj, set-node, xml-doc
  xml-doc.to-string(options?pretty or false)

module.exports = create-xml
