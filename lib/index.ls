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
# set-node :: Options -> Document -> value -> String -> Document
#
# Sets a root element's nested tag based on a key and a value.
# Optionally, if the value is an object and it has an $attr property, its
# respective tag's attributes will be unpacked from this property
#
set-node = (options, root, value, key) -->
  if value instanceof Array
    _.each value, (set-node options, root, _, key)
  else
    new-root = root.node key, value
    if attr = delete value?[options?attributesKey or '$attr']
      _.each attr, (value, param) ->
        new-root.attr param, value

    if value instanceof Object
      _.each value, (set-node options, new-root)

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

  if options?compact
  then obj = objCompact obj

  _.reduce obj, (set-node options), xml-doc
  xml-doc.to-string(options?pretty or false)

##
# objCompact :: Object -> Object
#
# Returns a deep copy of the object, without its falsy properties
#
objCompact = (obj) ->
  _.reduce obj, ((memo, value, key) ->
    if      _.isObject value then memo[key] = objCompact value
    else if !!value          then memo[key] = value
    memo
  ), {}

module.exports = create-xml
