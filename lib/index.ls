/*
 * create-xml
 * https://github.com/yamadapc/create-xml
 *
 * Copyright (c) 2013
 * Licensed under the MIT license.
*/

## Dependencies
_ = require \underscore
{Document} = require \libxmljs

##
# set-node :: Document -> value -> String -> Document
#
# Sets a root element's nested tag based on a key and a value.
# Optionally, if the value is an object and it has an $attr property, its
# respective tag's attributes will be unpacked from this property
#
set-node = (root, value, key) -->
  new-root = root.node key, value

  if value?$attr
    _.each value.$attr, (value, param) -> new-root.attr param, value
    delete value.$attr
  if value instanceof Object
    _.each value, (set-node new-root)

  root

##
# create-xml :: obj, options -> String
#
# Recursively creates an libxmljs Document based on an object
#
create-xml = (obj, options) ->
  if (_.size _.keys obj) > 1
    throw new Error 'There must be only one root element'

  xml-doc = new Document options?version, options?encoding

  _.reduce obj, set-node, xml-doc
  xml-doc.to-string(options?pretty or false)

module.exports = create-xml
