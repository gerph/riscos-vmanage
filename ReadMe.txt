Quick intro
-----------

The 'commit' script is intended to be used with CVS components in order to
maintain a standardised task-based version numbering system. This script has
been used successfully on both RISC OS and Unix, but it is on Unix that the
script is used by myself. More information about the use of the tool can
be found with 'commit -help'.


Example usage
-------------

Create a new component:
  prompt> cd ComponentDirectory
  prompt> commit -new -name <component-name-without-spaces>
  Initial version number ? <enter the initial version number, usually 0.00>
  <the VersionNum file will be added and committed to the repository; you
  must commit all the other files after adding them>

Adding files to the component:
  prompt> cvs add <files>
  <ie same as usual CVS>

Commit changes to the component:
  prompt> commit
  <editor opens prompting you to enter your change information on exit the
  text will be used for all files>

Commit a minor correction which shouldn't update the version number:
  prompt> commit -noupdate
  <editor opens prompting you to enter your change information on exit the
  text will be used for all files>

Check what versions are present on a component:
  prompt> cvs log VersionNum
  <lists the log for VersionNum, which will have been updated for every
  change to the component>
