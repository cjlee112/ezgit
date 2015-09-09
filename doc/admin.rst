################################
Secure repository Admin guide
################################

Prerequisites
--------------

* to use this for secure, private data sharing, you need access
  to a secure Git repository server, and the ability to add
  access rights to specific ssh public keys provided by your users.
* for deploying the respository in an encrypted virtual machine,
  your users need a hypervisor (such as VirtualBox) installed,
  and enough free disk space.  Although a virtual machine can be
  installed in 10 GB or less, default allocations are typically
  20 GB, to provide 10+ GB space for your repository data.


Setting up a secure data repository
-------------------------------------

Clone the base repository::

  git clone https://github.com/cjlee112/ezgit.git MYREPO

where MYREPO should be replaced by whatever name you want to assign
to this repository (remember to substitute the name you chose,
wherever you see MYREPO in commands below).  
The base repository only contains the basic makerules for
implementing its "simplified Git interface".

Next, add your data files to the repository, e.g. something like::

  cd MYREPO
  cp /some/path/to/my/data/MYFILE .
  git add MYFILE
  git commit -m 'added our important data'

Push the changes to your own secure repository server (e.g. gitosis), e.g.::

  git remote add datarepo SERVERURL
  git push datarepo master

where ``datarepo`` is the name we are assigning to the remote server,
and ``SERVERURL`` is its Git URL.  Whatever you push to ``master`` will
be what your users see when they double-click **pull**.

.. note::
   Note that users will pull from the ``master`` branch of the secure
   repository, and push to a branch name matching the username they chose in
   their VM.

Adding access for a new user
--------------------------------------

* Send users a link to the basic user setup instructions, which will lead
  them to send you the SSH public key (created in their new virtual machine).

* Once you get the user's ssh public key, add it to your secure repository
  server to grant them Read+Write access to your secure data repository.

* Notify the user they can proceed with the rest of the setup 
  instructions (basically, ``git clone`` and double-clicking **setup**).

Merging data changes from users
------------------------------------

* To see updates from users::

    git fetch datarepo

  (assuming you named your remote ``datarepo``) and use your preferred tool
  (e.g. gitg) to view their branches.
* Use your preferred Git tool / merge method to merge the changes that
  you want to ``master``.
* To distribute the changes to users, push them to the secure repository::

    git push datarepo master


Adding software requirements to the repository
-------------------------------------------------

* To specify required software, add Makerules that invoke
  standard tools such as ``apt-get``, and add those makerule targets
  to the ``INSTALLS`` target list in the ``Makefile``.
