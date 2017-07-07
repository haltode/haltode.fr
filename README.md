# napnac.fr

This is my personal website where I post articles about algorithms (in French), and my projects. All the articles are written in [Markdown](https://en.wikipedia.org/wiki/Markdown), and then converted with a home made script into HTML pages.

## Conversion script

The script `build.py` uses different Python librairies:

- [Markdown](https://pypi.python.org/pypi/Markdown): to convert Markdown content into HTML pages, with the following extensions:
   - [Extra](https://pythonhosted.org/Markdown/extensions/extra.html): compilation of useful various extensions
   - [Meta-Data](https://pythonhosted.org/Markdown/extensions/meta_data.html): defines meta-data about an article
   - [Table of Contents](https://pythonhosted.org/Markdown/extensions/toc.html): generates a table of contents
   - (Third Party Extension) [figureAltCaption](https://github.com/jdittrich/figureAltCaption): adds captions to images
   - These are the fixes I use, until Python Markdown 3 comes out:
      - [Fix regression of single column tables](https://github.com/waylan/Python-Markdown/pull/540)
      - [Add toc_depth parameter to toc extension](https://github.com/waylan/Python-Markdown/pull/431)
         - Instead of adding the fix after the line `self.set_level(el)` in `toc.py`, I added it before `toc_tokens.append(...)` because I still want the ids to be generated.
- [Jinja](http://jinja.pocoo.org/): to create templates for the future HTML pages

I also added some custom Markdown blocks, such as:
   - `[[secret="title"]]` and `[[/secret]]`: hide the text between them, and enable a toggle button to show/hide the element.

## Server

The website is hosted thanks to [Github Pages](https://pages.github.com/), but with some tweaks to suit my needs:
   - [Set subdirectory as website root on Github Pages](https://stackoverflow.com/questions/36782467/set-subdirectory-as-website-root-on-github-pages)
      - I wanted my `website` subfolder to be the root of `napnac.fr`, so the branch `gh-pages` contains the subtree (you can set the branch to be the source on which Github Pages will build the website in the repository's settings)
      - When I commit and push to the `master` branch, I can simply type `git subtree push --prefix website origin gh-pages` to update the website
   - [Using a custom domain with GitHub Pages](https://help.github.com/articles/using-a-custom-domain-with-github-pages/)
      - [Setting up an apex domain](https://help.github.com/articles/setting-up-an-apex-domain/)
      - [Setting up a www subdomain](https://help.github.com/articles/setting-up-a-www-subdomain/)
      - You will need a `CNAME` file at the root of your website to indicate your custom domain, in my case `napnac.fr`
   - [Secure and fast GitHub Pages with CloudFlare](https://blog.cloudflare.com/secure-and-fast-github-pages-with-cloudflare/)
      - Github Pages doesn't support HTTPS for custom domain, so I had to use [Cloudflare](https://www.cloudflare.com/) to handle this task (and the DNS part as well)
   - Since I am using my own script, code, theme, etc. to generate the website, I added a `.nojekyll` file at the root of the website to prevent [Jekyll](https://jekyllrb.com/) from interfering in any way

## License

The content of this website is licensed under the [Creative Commons license](http://creativecommons.org/licenses/by-nc-sa/4.0/), and the source code in this project is licensed under the [MIT license](http://opensource.org/licenses/mit-license.php).
