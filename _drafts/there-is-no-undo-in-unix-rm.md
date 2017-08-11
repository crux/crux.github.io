---
layout: post
title: There is no Undo in Unix rm Command
excerpt_separator: <!--end-of-excerpt-->
---
And that's the way I like it!

```sh
$ rm only-copy-of-my-thesis.doc
```

and flush, it's gone. Gone **forever**. There is no way of getting it back. Not from the trash, not from the disk. Technically, and this is the bitter beauty of it, all this bits which make up your to importend, now lost, master piece are still there. 

<!--end-of-excerpt-->
In theory you could walk down and debug the filesystem to recover the deleted index reference to your file. Scan the `inode` table in the kernel to track down the fragments of your work. In practice this is really really hard. Like hard hard. To make it worse, your unix is a living breathing thing, dozends and dozends of activites are running in the background. All of this generates disk activity and every next `write` system call could wipe out your genious bits. With the `rm` command your file is just `unlink`'ed. Means the system just throws away the reference where to find it. The file itself is untouched, but its space on disk is defined as free. The next `process` coming along needing some space, voila, gets a free run over and through your intellectual property. 

You can plug the power cord to stop all process activites and hope the filesystem survices the crash. This would stop all programms from writing over your data. Only problem then, you also can't access the disk anymore. Need to bring it up in read only mode on your system or on another machine. And still, this doesn't make it any easier to actully debug the filesystem to recover the lost `inodes`. Isn't it all beatiful? How the [wise gods of operating systems] have make think hard and twice before you remove it? And at the same time keep you from hording myriads of old an rotten files in some not yet deleted trash containers. 


```sh
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
