
STATUSDIR=conf/status
PUBKEYFILE=$(HOME)/.ssh/id_rsa.pub
MYBRANCH=$(USER)

${STATUSDIR}: 
	mkdir $(STATUSDIR)

# config Git user name, email
${STATUSDIR}/gitconfig: $(STATUSDIR)
	git config user.name `getent passwd $(USER)|cut -d: -f5`
	git config user.email `cut -d' ' -f3 $(PUBKEYFILE)`
	touch $@
	@echo "Successfully setup basic Git configuration"

.PHONY: pull push update setup help

# initial setup
setup: $(STATUSDIR) $(STATUSDIR)/gitconfig update


# simple wrapper for push/pull 
pull:
	git pull origin master
	@echo "Successfully retrieved latest data"

push: setup $(STATUSDIR)/gitg
	@echo "1. Make sure your changed files are saved."
	@echo
	@echo "2. Commit your changes using the Gitg tool, by clicking"
	@echo "   on the Commit tab, typing a Commit message (in the center"
	@echo "   of the Commit pane) explaining your changes, optionally"
	@echo "   adding new files, then clicking the Commit button,"
	@echo "   and closing the Gitg window."
	@echo "   NOTE: all changed repository files will by default be"
	@echo "   included for the commit (Staged, listed on the right"
	@echo "   side of the Commit pane).  If there are NEW file(s) that you"
	@echo "   want permanently added to the repository and shared to all"
	@echo "   users, drag them from the Unstaged area (on the left side of"
	@echo "   the pane) to the Staged area, BEFORE clicking the Commit button."
	@echo
	@echo "3. Once you close the Gitg window, your committed changes"
	@echo "   will be pushed to the shared repository."
	@echo
	@echo "Once your changes are saved, press Enter to launch the Gitg tool:"
	@head -1 >/dev/null
	git add --update
	gitg
	git push origin master:$(MYBRANCH)
	@echo "Successfully pushed your commit(s) to the repository."

#############################################################
# install rules

INSTALLS=$(STATUSDIR)/gitg

update: $(INSTALLS)
	@echo "All required software is installed."

${STATUSDIR}/gitg:
	sudo apt-get install gitg
	touch $@

############################################################
# help message
help:
	@echo "Commands you can type:"
	@echo "make setup: setup initial Git config and install required software if any"
	@echo "make pull: get the latest data from the shared repository"
	@echo "make push: commit and share your data changes to the shared repository"
	@echo "make update: install new software requirements if any" 
