######################################################
ezgit: an easy deployment / synchronization tool
######################################################

Documentation is available at http://cjlee112.github.io/ezgit


What is Ezgit?
-----------------

Ezgit is a simple wrapper for giving users the
benefits of secure repository sharing via Git, without the complexities of 
dealing directly with Git.  For example, we use this to provision
a fully encrypted virtual machine container with a shared data
repository that we could not share using the usual cloud services.
The interface consists of two basic steps: the user can double-click
**pull** to get the latest data updates, or **push** to share their
own changes back to others.

Totally standard tools make this easy for an adminstrator to manage:

* Git + ssh for repository sharing: if you've already got a Git server,
  you can use this immediately.  Use your repository's master branch to
  control what gets shared to users.  Their *pushes* will show up as
  named branches which you can merge to master to share with the whole
  group.

* Makefile for deployment automation: if you want to deploy not just data updates but other things, e.g. automatically install specific software tools for working with the data, you can automate that by simply adding a make-rule.

* (optional) Pair this with a virtual machine container (e.g. using
  VirtualBox), and an easy-to-use distro such as Linux Mint installed
  with LUKS encryption, and you'll have a reasonably secure repository
  container deployed to users' computers.  Even if a user's laptop is
  stolen, data in the VM container won't be accessible (unless the
  attacker obtains its encryption password).

Who might want to try this?
-----------------------------

You might want to try this if

* you need to share data securely among a group of users, and your 
  security requirements preclude just telling them to put it on
  Dropbox, Google Drive etc.
* you'd like to take advantage of some "security by isolation", by
  isolating the repo in an encrypted virtual machine, both so the
  data won't be accessible even if a computer is physically stolen,
  and also it will be as inaccessible as possible to the user's
  other (risky) activities on their computer (such as web browsing, email,
  downloading files, installing software etc.).
* you (the repo admin) like Git as a management mechanism, but your users
  aren't ready to deal with Git directly.
* you prefer a really simple solution built on strong, standard
  foundations: ezgit is basically nothing but a Git repo with a
  Makefile and a couple trivial scripts for users to double-click.


Overview
-------------

Client (user) Setup
......................

For a new user to obtain the secure repository, they:

* install linux guest in VirtualBox, VMWare or whatever (using LUKS full
  disk encryption).
* create a new ssh key in guest VM and send new public key to
  the secure repository administrator
  (who adds it to the repository access list).
* git clone the secure repository using the URL provided by the administrator.

Client Usage
................

To do initial config, install required software etc., the user just
double-clicks **setup** in the ezgit folder.

To get the latest data or additional required software, a user
double-clicks **pull** in the ezgit folder.

To make their changes to the data
available to others (via the secure repository), the user 
double-clicks **push** in the ezgit folder.
This guides the user through several steps:

* automatically stages all modified repository files
  for commit.
* Launches graphical tool (``gitg``) for the user to view the changes,
  write a commit message, and do the commit.  The user can optionally
  drag new files (from Unstaged to Staged) to add them to the commit.
* Pushes the commit(s) to the user's secure remote.

If software requirements have changed in the latest data,
the user can install the latest software required, by
double-clicking **update** in the ezgit folder.


