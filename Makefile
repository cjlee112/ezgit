
STATUSDIR=conf/status
PUBKEYFILE=$(HOME)/.ssh/id_rsa.pub
MYBRANCH=$(USER)

# config Git user name, email
${STATUSDIR}/gitconfig: 
	git config user.name `getent passwd $(USER)|cut -d: -f5`
	git config user.email `cut -d' ' -f3 $(PUBKEYFILE)`
	touch $@
	@echo "Successfully setup basic Git configuration"

.PHONY: pull push update setup help

# initial setup
setup: $(STATUSDIR)/gitconfig update


# simple wrapper for push/pull 
pull:
	git pull origin master
	@echo "Successfully retrieved latest data"

push: setup $(STATUSDIR)/gitg
	@echo "First commit your changes using the Gitg tool, by clicking"
	@echo "on the Commit tab, typing a Commit message explaining your"
	@echo "changes, then clicking the Commit button, and closing the"
	@echo "Gitg window.  Then your committed changes will be pushed"
	@echo "to the repository."
	@echo
	@echo "Press Enter when your changes are ready to commit in Gitg:"
	@head -1 >/dev/null
	git add --all
	gitg
	git push origin master:$(MYBRANCH)
	@echo "Successfully synchronized your commit(s) to the repository."

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
