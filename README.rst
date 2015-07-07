######################################################
ezgit: an easy deployment / synchronization tool
######################################################

Goal
-----

deploy a secure data repository to multiple users with a
simple, standard synchronization mechanism. 

Setup
--------

For a new user to obtain the secure repository:

* install linux guest in VirtualBox, VMWare or whatever (using LUKS full
  disk encryption).  Please enter your correct full name (e.g. John Smith),
  and a recognizable username (e.g. jsmith), because this will be used
  to label all data changes you share with others.
* create a new ssh key in guest VM and send new public key to
  the secure repository administrator
  (who adds it to the repository access list).  Please enter your correct
  email address when requested by ``ssh-keygen``, as this will be used
  to label all data changes you share with others.
* git clone the secure repository using the URL provided by the administrator.

Usage
--------

To do initial config, install required software etc., the user just types::

  make setup

To get the latest data or additional required software, a user types::

  make pull

To make their changes to the data
available to others (via the secure repository), the user types::

  make push

This guides the user through several steps:

* automatically stages all modified or new files (not excluded by .gitignore)
  for commit.
* Launches graphical tool (``gitg``) for the user to view the changes,
  write a commit message, and do the commit.
* Pushes the commit(s) to the user's secure remote.

If software requirements have changed in the latest data,
install the latest software required by typing::

  make update

Secure repository Admin guide
---------------------------------

Setting up a secure data repository
.......................................

* The base repository only contains the basic makerules for
  implementing the above "simplified Git interface".
* Add data files to the repository, and push the changes to your own 
  secure repository server (e.g. gitosis).
* Note that users will pull from the ``master`` branch of the secure
  repository, and push to a branch name matching their username in
  their VM.

Adding access for a new user
.............................

* once you get the user's ssh public key, add it to your secure repository
  server to grant them Read+Write access to your secure data repository.

Merging data changes from users
..................................

* Initial setup: on a computer account with ssh access to the secure
  Git repository, ``git clone`` the repository.
* To see updates type ``git fetch origin``, and use your preferred tool
  (e.g. gitg) to view their branches.
* Use your preferred Git tool / merge method to merge the changes that
  you want to ``master``.
* To distribute the changes to users, push them to the secure repository::

    git push origin master


Adding software requirements to the repository
................................................

* To specify required software, add Makerules that invoke
  standard tools such as ``apt-get``, and add those makerule targets
  to the ``INSTALLS`` target list in the ``Makefile``.
