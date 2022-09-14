## Good Tutos
- <https://docs.julialang.org/en/v1/manual/types/>
  - Actually, you can read the Julia docs offline! For example, on Linux, go to
    the folder that you have downloaded and extracted from Julia's official website
    (e.g. I have put mine under `.local/bin/julia-1.7.1/`). Inside that directory,
    one can find `share/doc/julia/html/en/index.html`. Then just open your browser
    and type in the URL to that directory/HTML file and you're good to go.


## Download and Verification
```bash
$ ls ~/downloads/julia*
/home/phunc20/downloads/julia-1.8.1-linux-x86_64.tar.gz
/home/phunc20/downloads/julia-1.8.1-linux-x86_64.tar.gz.asc
/home/phunc20/downloads/juliareleases.asc
$ cd ~/downloads/
$ gpg --import juliareleases.asc  # if you haven't already imported this
$ gpg --verify julia-1.8.1-linux-x86_64.tar.gz.asc
gpg: assuming signed data in 'julia-1.8.1-linux-x86_64.tar.gz'
gpg: Signature made Wed 07 Sep 2022 05:30:14 AM +07
gpg:                using RSA key 3673DF529D9049477F76B37566E3C7DC03D6E495
gpg: Good signature from "Julia (Binary signing key) <buildbot@julialang.org>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 3673 DF52 9D90 4947 7F76  B375 66E3 C7DC 03D6 E495
```


## Todo
01. Julia's plot for Dark Reader
02. Make environment easier for users of this repo. More concretely,
  - If keep `~/.config/julia/projects/oft/`, then at least put it in some `constant.jl` file and call it.
  - If not to keep it, try to make sth like a `requirements.txt` or `environment.yml` file in Python, to allow reproduction of the environment.
