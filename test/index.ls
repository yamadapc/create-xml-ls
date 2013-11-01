o = it # alias mocha's 'it' to o
##
# Dependencies
#
require! should
_ = require \underscore
create-xml = require \..

##
# Tests
#
describe 'create-xml', ->
  describe 'when passing more than one root element', ->
    o 'should throw an exception', ->
      try
        create-xml { foo: 'x', bar: 'y' }
      catch
        e.message.should.equal 'There must be only one root element'

  describe 'when passing a root element', ->
    describe 'with simple child key value pairs', ->
      expected = [
        '<?xml version="1.0" encoding="UTF-8"?>',
        '<root>', '<foo>x</foo>', '<bar>y</bar>', '</root>'
      ]
      input = root: { foo: 'x', bar: 'y' }

      o 'should return the right output', ->
        result = create-xml input, pretty: true
        _.each expected, -> result.should.contain(it)

    describe 'with complex nested objects', ->
      expected = [
        '<?xml version="1.0" encoding="UTF-8"?>',
        '<root>', '<foo>', '<bar>y</bar>', '</root>', '</foo>'
      ]
      input = root: { foo: { bar: 'y' }  }

      o 'should return the right output', ->
        result = create-xml input, pretty: true
        _.each expected, -> result.should.contain(it)
