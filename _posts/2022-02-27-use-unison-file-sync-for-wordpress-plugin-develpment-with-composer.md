---
layout: post
title: WordPress Plug-In development with unison file-system sync and git clean composer.{json,lock} files
excerpt_separator: <!--end-of-excerpt-->
categories:
 - wordpress
 - php
---
This scripted [unison] I use to keep things separated, clean and synced:

```sh
if [ $# != 2 ]; then
    echo "usage: $0 <dir1> <dir2>"
    exit
fi
dir1=$1
dir2=$2

echo "${dir1} <-> ${dir2}"

while true; do
    clear
    # ignore files and dirs which should not be synced. You might need to adjust this a bit.
    unison -batch -auto  $dir1 $dir2  \
        -ignore 'Path vendor'         \
        -ignore 'Path .*.sw*'         \
        -ignore 'Path .git'           \
        -ignore 'Path x.*'            \
        -ignore 'Path sync-dirs.sh'   \
        -ignore 'Path .gitignore'
    sleep 1
done
```
<!--end-of-excerpt-->

## What is the Problem anyhow?

Answer: To keep your local development setup tweaking out of your config files
and out of the git repo. 

Here it is not about WordPress Plugin development in general (lots of nightmare
options there, another story, for another time). In here I assume you have
found a local setup to WordPress (like [bedrock]) which gets you a
`composer.json` to keep you organized. Now you are working on a plugin of
yours, which you have nicely packaged, in its own repo, and with its own
`composer.json`. Properly registered with packagist.com you can install it:

```
$ composer require crux/zero-feature-wordpress-plugin-package
```

The problem is your own plugin package gets pulled from the internet, not the
one from local on your filesystem. To overcome this, you can add your local
source as repository to composer.json:

```json
  ...
  "repositories": [
    ...,
    {
      "type": "path",
      "url": "../zero-feature-wordpress-plugin-package",
      "options": {
        "symlink": false
      }
    }
  ],
```

That makes your package being sourced locally. Nice, big improvment in turn
around time. Symlinking would be nice, and it is the default, but if you do so,
your docker'ed WordPress container dev won't be able to see the files. They are
outside of the mounted volumes/paths, and for very good reason the app inside a
docker container can not simply step out of its container and follow the
symlinks. That is the reason for `"symlink": false`. 

Next problem, you would like to check-in the composer.json to you git repo, but
by no means you want to leak your extra repository entry with your local
filesystem repo addition. An annoyance, to edit this out prior to every git
commit, or to have that file marked dirty uncommited all the time.

**[composer-merge-plugin] to the rescue!**

Install it (`composer require wikimedia/composer-merge-plugin`) and add you can add a local
override setting file to your composer.json:

```json
  ...
  "extra": {
    ...
    "merge-plugin": {
      "include": [
        "composer.local.json"
      ]
    }
  },
```

That local `composer.local.json` of yours can now hold the extra repository
setting. Add `composer.local.json` to your gitignore file and voila, your
`composer.json` remains clean. 

One last problem, if you like to commit your `composer.lock` to the repo, bad
luck, because that file or course records where exactly your package was coming
from. Again, leaking your local package set-up. 

## Solution

This is where the above little unison scripting comes into place. [Unison] can do a lot of things, bi-directional syncing is really difficult. But it is a solved problem, and they did it. So, what I do: 

 1. Have a local dockerized WordPress development, like [bedrock] for example.
 2. Use composer to require your packages, as much as possible, from top-level
    wordpress development directory, this builds on [composer/installers].
 3. Install the plugin you want to work on, without symlinks, and do NOT use any composer overloading local settings.
 4. set-up the above script to sync the installed plugin with the plugin source dir anywhere on your laptop.
 5. Work and develop interactively with your plug-in, in wordpress, in the
    docker container. You can edit, add, remove, move files and dirs in both
    directories. They stay in sync. 
 6. Once things are working as aspected, go the plugin source dir and package
    the new release. With tags and packagist upload etc. 
 7. Shut down the sync-script and update your wordpress site with the new plugin release from the internet.
 8. Now everthing should work for you identical as anyone else using your package would see it. 


have fun

[bedrock]: https://docs.roots.io/bedrock/master/local-development/#additional-resources
[unison]: https://www.cis.upenn.edu/~bcpierce/unison/
[composer-merge-plugin]: https://github.com/wikimedia/composer-merge-plugin
[composer/installers]: https://github.com/composer/installers
