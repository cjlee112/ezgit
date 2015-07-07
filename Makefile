
STATUSDIR=conf/status
PUBKEYFILE=$(HOME)/.ssh/id_rsa.pub
MYREMOTE=mine
REMOTEFILE=conf/remotes.txt

# basic Git setup: user name, email and push-remote
${STATUSDIR}/myremote: 
	$(STATUSDIR)/add_my_remote.sh $(MYREMOTE) $(PUBKEYFILE) $(REMOTEFILE)
	touch $@
	@echo "Successfully setup basic Git configuration"

.PHONY: pull push update


# simple wrapper for push/pull 
pull: $(STATUSDIR)/myremote
	git pull origin master
	@echo "Successfully retrieved latest data"

push: $(STATUSDIR)/myremote $(STATUSDIR)/gitg
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
	git push $(MYREMOTE) master
	@echo "Successfully synchronized your commit(s) to the repository."

#############################################################
# install rules

INSTALLS=$(STATUSDIR)/gitg

update: $(INSTALLS)
	@echo "All required software is installed."

${STATUSDIR}/gitg:
	sudo apt-get install gitg
	touch $@

