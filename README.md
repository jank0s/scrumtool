TPO11 - Scrum
=========
Scrum tool: http://ltpo2.fri1.uni-lj.si/tpo/scrum/

DevVM
=========
Ubuntu 13.10 64bit with rvm, ruby2.1.0, rails4.0.3,...:
https://mega.co.nz/#!qIxV0YKS!BNGJme9LKAVhZ5ykfo3wfgJnwH3L-_UeLuVwAvhi3Ck
https://dl.dropboxusercontent.com/u/3021629/tpo11VM.zip

Run
=========
Fork https://bitbucket.org/tpo11/tpo11/

	git clone https://username@bitbucket.org/username/tpo11.git
	cd tpo11
	git remote add upstream https://jk0s@bitbucket.org/tpo11/tpo11.git
	bundle install --without production
	bundle update
	bundle install

	rails server
