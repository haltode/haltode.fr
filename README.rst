haltode.fr
==========

Build
-----

Pages are written using reStructuredText, because it is way nicer than raw HTML.
A custom Python builder converts RST to HTML (using `pandoc
<https://pandoc.org/>`_ and `jinja <http://jinja.pocoo.org/>`_ templating),
which gives me great control over how I write content. For every page there is a
``.meta`` file providing basic information for the page, where to store it, what
to template to use, etc.

.. code:: shell

    $ poetry shell
    $ poetry install
    $ make build runserver

Note: despite the Python virtual env, you still need to install a recent version
of pandoc because pypandoc is only a wrapper around it.

Deploy
------

The sources are committed under ``docs/`` to be deployed through GitHub pages.

License
-------

The content of this website is licensed under the `Creative Commons license
<http://creativecommons.org/licenses/by-nc-sa/4.0/>`_, and the source code in
this project is licensed under the `MIT license
<http://opensource.org/licenses/mit-license.php>`_.
