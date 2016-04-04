# X-Wing Damage simulator.


# Catan Helper
[Try the damage simulator out!](http://dbsmash.github.io/xwing-simulator/)

The X-Wing damage simulator is a simple Dart-based tool to simulate the average damage in a specified attack scenario.

# How to use

* Customize the attack parameters such as attack value, evade value, whether the attacker is focused, etc
* Choose a number of simulations to run (or keep the default of 1000)
* Run the simulation with the Attack! button
* Simulator will give you average damage across all simulated attacks
* Url parameters will update and provide you a copy/pastable link to the specific simulations you setup

# Steps for hosting on github.io

```bash
git checkout gh-pages
git pull origin master
pub get
pub build
git add -f build/web && git commit -m "commiting build for gh-pages"
git push origin --delete gh-pages
git subtree push --prefix build/web origin gh-pages
```
