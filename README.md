# Rails One Click Install for Mac Os X (10.6 or higher)

Rails One Click is the perfect tool  for installing and managing rails
applications.

Rails One Click is targeted at beginner who have little or no
programming experience, or to developers who want to try rails but don't
want to bother about installing ruby and managing dependencies.

Rails one click creates a sandboxed Ruby environment accessible within
the app. When you're ready to move on simply delete the directory
created by Rails One Click.

### Project Status: ALPHA

This software is not ready!

Project Roadmap:

* Create manage your apps view. This view will include handy controls for
  managing your apps, starting the server, etc
* Create help sections and tips. Things will go wrong, help users when
  they're stuck
* Add a sample app
* Work on the UI

What's already there:

* Installation screen
* Ruby 1.9.3-p125 sandboxed inside Documents/rails_one_click/ruby
* Latest rails version ready to use
* Once ruby is installed, you'll be able to open a terminal window
  inside Documents/rails_one_click with Ruby and Rails already loaded.
(I will provide a better interface soon with server start and stop etc).

### Ruby sandbox

Ruby is installed inside Documents/rails_one_click. That way if you ever
mess up with something you'll just need to delete the ruby directory inside
that folder.

### Development

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


### Early Development screenshots

![Rails One Click](https://raw.github.com/oscardelben/RailsOneClick/master/screenshots/install.png)

![Rails One Click](https://raw.github.com/oscardelben/RailsOneClick/master/screenshots/installed.png)

![Rails One Click](https://raw.github.com/oscardelben/RailsOneClick/master/screenshots/console.png)
