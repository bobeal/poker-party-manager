# Installation #

## From the sources ##

In order to run PPM from the sources, you have to install [Grails 0.4.2](http://grails.org/Installation).

Once Grails is installed, check out the PPM's sources :
```
svn checkout http://poker-party-manager.googlecode.com/svn/trunk/ poker-party-manager
```

Go to the project's root directory and launch PPM :
```
cd poker-party-manager
grails init
grails -Dgrails.env=demo run-app
```

# Test #

Go to http://localhost:8080/poker-party-manager, follow the instructions to create the first administrator and have fun !