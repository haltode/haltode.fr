# Scripts

## Conversion script

The script `build.py` uses different Python librairies:

- [Markdown](https://pypi.python.org/pypi/Markdown): to convert Markdown content
into HTML pages, with the following extensions:
   - [Extra](https://pythonhosted.org/Markdown/extensions/extra.html):
   compilation of useful various extensions
   - [Meta-Data](https://pythonhosted.org/Markdown/extensions/meta_data.html):
   defines meta-data about an article
   - [Table of Contents](https://pythonhosted.org/Markdown/extensions/toc.html):
   generates a table of contents
   - (Third Party Extension)
    [figureAltCaption](https://github.com/jdittrich/figureAltCaption): adds
    captions to images
   - These are the fixes I used, until Python Markdown 3 comes out:
      - [Fix regression of single column
      tables](https://github.com/waylan/Python-Markdown/pull/540)
      - [Add toc_depth parameter to toc
      extension](https://github.com/waylan/Python-Markdown/pull/431)
         - Instead of adding the fix after the line `self.set_level(el)` in
         `toc.py`, I added it before `toc_tokens.append(...)` because I still
         want the ids to be generated.
- [Jinja](http://jinja.pocoo.org/): to create templates for the future HTML
pages

I also added some custom Markdown blocks, such as:
   - `[[secret="title"]]` and `[[/secret]]`: hide the text between them, and
   enable a toggle button to show/hide the element.
