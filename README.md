# X-Wing Damage simulator.


# Catan Helper
[Try the damage simulator out!](http://dbsmash.github.io/xwing-simulator/)

The X-Wing damage simulator is a simple Dart-based tool to simulate the average damage in a specified attack scenario.

# Steps for hosting on github.io

```bash
git checkout gh-pages
pub get
pub build
git add -f build/web && git commit -m "commiting build for gh-pages"
git push origin --delete gh-pages
git subtree push --prefix build/web origin gh-pages
```
