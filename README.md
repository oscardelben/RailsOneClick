# Rails One Click Install for Mac Os X (10.6 or higher)

This software allows one click install of Ruby 1.9.3 and Rails (the most
recent version).

This software is not ready! I'm still working out some major problems.

Current problems/features to add:

* Doesn't tell if the installation fails. I'm working on this!
* Add a log interface for the installation.
* Add a better interface for managing rails apps
* The UI sucks!

What's already there:

* Ruby 1.9.3-p125 sandboxed inside Documents/rails_one_click/ruby
* Latest rails version ready to use
* Once ruby is installed, you'll be able to open a terminal window
  inside Documents/rails_one_click with Ruby and Rails already loaded.
(I will provide a better interface soon with server start and stop etc).

### Ruby sandbox

Ruby is installed inside Documents/rails_one_click. That way if you ever
mess up something you'll just need to delete the ruby directory inside
that folder.

### Project status

This project is alpha. I'm looking for contributors and especially
testers. Your help is much apreciated.

Developers note: rvm will conflict with Rails one click. It is
recommended that you temporarily comment it out in your profile file
while you test this project.

### How to run it

Right now, download the xcode project, build and run and follow
instructions!

### History

Yehuda Katz has recently announced the need for a Rails one click installer
for Mac Os X. He even got some founding for his project, which means the
community really needs it. With Rails one
click I want to create a first step toward that vision that Yehuda had.
I really hope this project will be useful to Yehuda and eventually for
the Ruby community itself.


### Early Development screenshots

![Rails One Click](https://raw.github.com/oscardelben/RailsOneClick/master/screenshots/install.png)

![Rails One Click](https://raw.github.com/oscardelben/RailsOneClick/master/screenshots/installed.png)

![Rails One Click](https://raw.github.com/oscardelben/RailsOneClick/master/screenshots/console.png)
