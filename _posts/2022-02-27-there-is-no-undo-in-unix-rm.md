---
layout: post
title: There is no Undo in Unix rm Command
excerpt_separator: <!--end-of-excerpt-->
categories:
 - unix
 - command-line
---

And that's the way I like it!

```sh
$ rm only-copy-of-my-thesis.doc
```

and flush, it's gone. Gone **forever**. There is no way of getting it back. Not from the trash, not from the disk. Technically, and this is the bitter beauty of it, all this bits which make up your so important , now lost, master piece are still there.

<!--end-of-excerpt-->

In theory you could walk down and debug the filesystem to recover the deleted index reference to your file. Scan the `inode` table in the kernel to track down the fragments of your work. In reality this is really really hard. Like hard hard. To make it worse, your unix is a living breathing thing, dozends and dozends of activites are running in the background. All of this generates disk activity and every next `write` system call could wipe out your genious bits. Your `rm` command just did an `unlink` system call. Means the system just throws away the reference where to find it. The files bytes itself are untouched, but its space on disk is declared free. The next `process` coming along needing some space, voila, gets a free run over and through your intellectual property. 

You can plug the power cord to stop all process activites and hope the filesystem survices the crash. This would at least stop all programms from writing over your data. Only problem then, you also can't access the disk anymore. Need to bring it up in read only mode on your system or on another machine. And still, this doesn't make it any easier to actully debug the filesystem to recover the lost `inodes`. 

Isn't this beauty in perfection? How the [[wise gods of operating systems]([rm (Unix) - Wikipedia](https://en.wikipedia.org/wiki/Rm_(Unix)))] have made you think hard and twice before you remove anything? In an age better and long before GTA and Marie Kondo.

So here is what I build myseld, a cowards esacpe. I use it sometimes when not decided enough go straight for the kill. My little `gm` alias, like garbage move, 

```sh
alias gm='move-to-trash'

move-to-trash ()
{ 
    if [ "$1"x = "x" ]; then
        echo "usage: $FUNCNAME <path> [ <more paths> ]";
        return;
    fi;
    d=$(dirname "$1");
    d="${d}/.trash";
    if [ ! -d "$d" ]; then
        mkdir "$d";
    fi;
    export log="$HOME/.gc_log";
    echo " -- $(date) : $(pwd)" >> "$log";
    echo "    $*" >> "$log";
    mv "$@" "$d"
}
```

I do not claim any quality of the shell coding here. This is old, very old. I do not think shell function, bash functions, zsh functions? are to be coded that whay any longer, but it worked for me. May it be inspirational at best. 

Once in while I walk down and review its log file. Trip down the memory lane then, of stuff I moved out of site. Most often then, at that point, I am ready to clean-up, remove them for real. But also, once in a while, I see something I forgot about, and pick it up, again. Nice.



ymmv, have fun, take care
