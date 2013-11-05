o = it # alias mocha's 'it' to o
##
# Dependencies
#
require! should
_          = require \underscore
create-xml = require \..
{Document} = require \libxmljs

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
      doc = new Document '1.2.1'
      doc.node 'root'
        .node 'foo', 'x' .parent!
        .node 'bar', 'y'
      expected = doc.to-string!
      input = root: { foo: 'x', bar: 'y' }

      o 'should return the right output', ->
        result = create-xml input, pretty: true, version: '1.2.1'
        result.should.equal expected

    describe 'with complex nested objects', ->
      doc = new Document!
      doc.node 'root'
        .node 'foo'
          .node 'bar', 'y'
      expected = doc.to-string!
      input = root: { foo: { bar: 'y' }  }

      o 'should return the right output', ->
        result = create-xml input, pretty: true
        result.should.equal expected

    describe 'with objects containing the $attr key', ->
      doc = new Document!
      doc.node 'root' 
        .node 'foo' .attr 'params', 'are hell'
          .node 'bar', 'y'
      expected = doc.to-string!
      input = root: foo: {$attr: {params: 'are hell'}, bar: 'y'}

      o 'should return the right output', ->
        result = create-xml input, pretty: true
        result.should.equal expected

    describe 'with objects containing a custom attributes key', ->
      doc = new Document!
      doc.node 'root' 
        .node 'foo' .attr 'params', 'are hell'
          .node 'bar', 'y'
      expected = doc.to-string!
      input = root: foo: {attributes: {params: 'are hell'}, bar: 'y'}

      o 'should return the right output', ->
        result = create-xml input, pretty: true, attributesKey: 'attributes'
        result.should.equal expected

    describe 'with objects with falsy properties', ->
      describe 'without passing the \'compact\' option', ->
        doc = new Document!
        doc.node 'root',
          .node 'foo', 'x' .parent!
          .node 'bar', undefined
        expected = doc.to-string!
        input = root: {foo: 'x', bar: undefined}

        o 'should consider the undefined properties', ->
          result = create-xml input, pretty: true
          result.should.equal expected

      describe 'passing the compact option', ->
        doc = new Document!
        doc.node 'root'
          .node 'foo'
            .node 'star', 'x' .parent!
            .node 'idk', 'y'
        expected = doc.to-string!
        input = root: foo: star: 'x', idk: 'y'

        o 'should ignore the undefined properties', ->
          result = create-xml input, pretty: true, compact: true
          result.should.equal expected
