Only get sub-folder from a GIANT git
------------------------------------

Sure git should not have binary artifacts....
But that does not mean that some repos do not.

My colleague warned me that a complete checkout 
would be expensive.... he was right! :)

So in the case you need to:

```bash
mkdir REPO && cd REPO
git init .
git remote add -f origin GITURL
git config core.sparseCheckout true
echo "FOLDER" >> .git/info/sparse-checkout
git pull origin master
```

Now if you really want to get advanced, read the link below.

Links/Sources
=============
 - https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository