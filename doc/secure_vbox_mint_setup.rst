###############################################################
Setting up Secure Repository Access Using VirtualBox + Mint
###############################################################


Prerequisites
---------------

You need:

* VirtualBox installed on your computer
* Downloaded ISO image for Linux Mint (17.1 MATE 64 bit recommended).

Instructions
------------------

You can see a video of the general process: https://youtu.be/lPLVnhMj7QM

**Note** the instructions in **this document** are correct and up-to-date, so 
please follow the instructions here rather than the video,
if the video differs in some detail(s).

1) Launch VirtualBox.


2) Create a new virtual machine:

        - Click **New**
	- Enter a name for your new VM (e.g. "securerepo")
	- Select the VM OS: Linux, Ubuntu (64 bit)
	- Select RAM amount to dedicate to the VM (e.g. 1 GB)
	- Create hard drive for VM with default settings and desired size


3) Mount ISO image of Linux Mint, by clicking **Settings - Storage - Controller IDE Empty - CD/DVD Drive - Select your image**.

4) Start the VM. 

5) Installation:

        - Double-click **Install Linux Mint**.
	- Select install language
	- Select "Encrypt installation" to encrypt the whole virtual machine.
	- Enter a passpharase for encryption

          .. warning::
             Remember your passphrase or you will NOT be able to access
             this virtual machine or its contents!!

	- Select timezone
	- Select input language
	- Enter a username and password

          .. warning::
             * choose a username that other users of the repository will
               easily recognize as you, as this username will be used
               for pushing updates you make, to the shared repository.
             * to keep things easy to remember, we suggest you re-use
               your disk encryption passphrase as your user password
               (i.e. use the same password for both purposes, so that
               you only have to remember one password).


6) When the installation finishes, click **Restart now**.

7) Enter your encryption passphrase to gain access to your virtual machine.

8) Login with username and password.

9) Start a terminal by clicking **Menu - Terminal**, and type the following
   command to create a security key::
 
	ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

   where `your_email@example.com` is your email address.  When it asks
   you to enter a security passphrase, simply
   enter the same passphrase you used as your disk encryption passphrase
   / user password.  That way you will only have to remember one
   passphrase.

   Copy the public key you just created, by typing the following command::

        cat ~/.ssh/id_rsa.pub

   Use your mouse to select the key text (starting from ``ssh-rsa``, down to
   your email address), then choose **Edit - Copy** from the Terminal window.


10) Within your Virtual Machine, start a web browser by clicking
    **Menu - Favorites - Firefox**, log in to your email via the web,
    and send your public key, by pasting it into an email,
    to your secure repository server administrator.

Once your repository administrator has added your key to the
repository access list, they will give you a repository URL for
you to gain access to the secure repository.

Accessing the Secure Repository for the first time
-----------------------------------------------------

1. Start your Virtual Machine and log in as in Steps 7-8 above.

2. Start a terminal by clicking **Menu - Terminal**, and type the following
   command to clone the secure repository to your virtual machine::

     git clone YOUR_URL

   where ``YOUR_URL`` is the repository URL given to you by your 
   repository administrator.  It will ask you for your passphrase:
   type your passphrase and press Enter.

   It will create a new directory in your home folder, containing the
   cloned repository files.  Note the name of this new repository directory.

3. Open a file browser by clicking **Menu - Home Folder**, double-click the
   repository folder, and double-click **ezgit_setup.sh** to run the 
   necessary steps for setting up all the tools needed for your
   repository.

Working with data files in the repository
-------------------------------------------

Please understand that the data in your repository is intended
to be kept strictly secure, by keeping it inside a virtual machine
that is isolated from the rest of your physical computer.  That
means you view and edit the data solely within the secure virtual
machine.  If you copy data outside of the secure virtual machine,
all security guarantees are void.

* within the file browser you can double click a file or folder
  to open it, view and edit the data.
* note that some data files are "back-end data files" not intended
  to be directly opened by users.


Guidelines for Keeping Your Copy of the Repository Secure
------------------------------------------------------------

When your Virtual Machine is shut down, no one can access its
data without your encryption passphrase, even if they steal your
computer.

* Always shut down your Virtual Machine (**Menu - Quit - Shut Down**)
  whenever you are not actually using it.  If you need to take a break or
  work on something else, save your files and shutdown the Virtual Machine.

* Never suspend / put to sleep your physical computer while the Virtual Machine
  is running -- always shut down the Virtual Machine first.

* Never use your Virtual Machine for anything that could compromise its
  security, e.g. anything that involves traffic with the outside world such 
  as web browsing, email, downloading files, or installing software not
  mandated by your repository administrator.  Always conduct such activities
  **outside** the Virtual Machine (if you *really* want to safeguard your
  repository, such activities should only be performed on a separate
  computer).  Only use the Virtual Machine for its one intended purpose --
  analyzing data in the repository.

* All data transmissions with the secure
  repository server (clone, pull, push) are automatically encrypted.

Getting the Latest Data Updates
----------------------------------

Open a file browser as described above, and double-click the
**ezgit_pull.sh** tool to pull the latest updates from the secure
repository server.

Sharing your new or modified data to other users
-----------------------------------------------------------

If you modify data files in the repository, or add new data
files, and want to share your changes to others, 
open a file browser as described above, and double-click the
**ezgit_push.sh** tool to push your changes to the secure
repository server.  Follow the on-screen instructions to
choose what new files if any to include in your "committed" changes.
Once you commit your changes, they will be pushed to the
secure repository server.

