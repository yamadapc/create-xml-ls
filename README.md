# create-xml-pure [![Build Status](https://secure.travis-ci.org/yamadapc/create-xml-ls.png?branch=master)](http://travis-ci.org/yamadapc/create-xml-ls)

Another JS object to XML converter

## Example

### Javascript

```javascript
var createXml = require('create-xml-ls');

createXml({
  something: {
    is: 'very',
    ugly: {
      $attr: {
        IMHO: 'it sucks'
      }
      but: 'sometimes we have to live with it'
    }
  }
});
/* =>
<?xml version="1.0" encoding="UTF-8"?>
<something>
  <is>very</is>
  <ugly IMHO="it sucks">
    <but>sometimes we have to live with it</but>
  </ugly>
</something>

(though indentation is off by default and can be toggled with the pretty
 option)
*/
```

## License
Copyright (c) 2013 Pedro Yamada. Licensed under the MIT license.
