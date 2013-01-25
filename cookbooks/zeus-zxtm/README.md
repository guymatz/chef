Description
===========

Chef recipe for installing the Zeus (now Stingray) Traffic Manager.

Author
======
Kos Media, LLC
Jeremy Bingham <jeremy@dailykos.com>

Requirements
============

This has been tested on Debian, but should work on any Unix-like system that Zeus Traffic Manager supports. You would need to change the "tarball_url", "checksum", and "tarball_dir" attributes as needed to reflect the different file names and directories the Zeus installation will use.

Attributes
==========

The file zeus-zxtm/attributes/default.rb should be fairly self-explanatory. You need to set "tarball_url" to the location where you're keeping the Zeus installation tarball (Zeus doesn't make it easy to download automatically, so you should probably put it somewhere safe for your use). If you are installing a different version of Zeus Traffic Manager than 9.0r3, you will need to adjust the tarball dir (where the Zeus installation tarball extracts to) and the checksum as needed.

You also need to make a data bag called "zeus", and create an encrypted data bag item named "items" within it. In this data bag, you need to add entries for the admin password (as "password") and your Zeus license file (as "license". Remember to replace all newlines with "\n" in the data bag).

If you're installing this on an ec2 node, or somewhere else where ping is disabled by default, set "ec2" to a true value. Otherwise, the Zeus installer will cry bitter tears over not being able to ping the gateway or local ip address, and refuse to install.

Usage
=====

Run the cookbook on the server you want to run Zeus Traffic Manager. It will perform the installation and basic configuration for you. For more advanced configuration, or loading saved Zeus configs onto the server, at this time you will need to go into the Traffic Manager and take care of that yourself.
