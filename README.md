balde-markdown
==============

A balde extension that adds Markdown support.


How to install
--------------

You need to install [Discount](http://www.pell.portland.or.us/~orc/Code/discount/) and [balde](http://balde.io/) before trying to install this extension.

With all the dependencies in place, type:

```sh
./autogen.sh  # if installing from Git repository
./configure
make
make install  # or sudo make install
```


How to use
----------

Supposing that you have a template variable called ``content``, with the markdown content, you can just add something like this to the template:

```html
{% include "balde-markdown.h" %}
<html>
<body>
{{ markdown(content) }}
</body>
</html>
```

The ``balde-markdown.h`` header should be in your include path.

If you want to render the markdown content outside of the templates (e.g. to do some caching), you can use the ``balde_markdown_parse()`` function, as defined below:

```c
gchar* balde_markdown_parse(balde_app_t *app, const gchar *mkd_source);
```

The ``gchar*`` returned should be free'd with ``g_free()`` after usage.


Online tests
------------

This extension is tested by a [Jenkins instance](https://ci.rgm.io/job/balde-markdown/). You can see the results below:

[![Build Status](https://ci.rgm.io/buildStatus/icon?job=balde-markdown)](https://ci.rgm.io/job/balde-markdown/)
