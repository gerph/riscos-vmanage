# Commit script for VersionNum management script

## Summary

The `vmanage` script is intended to be used with RISC OS sources in order to
maintain a standardised task-based version numbering system. This script is
intended to be used on RISC OS and POSIX-like systems, but has only been
tested on OSX.

More information about the use of the tool can be found with `vmanage -help`.


## Example usage

Initialise the VersionNum file with a default version number:

    prompt> cd ComponentDirectory
    prompt> vmanage init
    <the VersionNum file will be created with the version 0.00>

Initialise the VersionNum file with a specific version number:

    prompt> cd ComponentDirectory
    prompt> vmanage init -version <x.yy>
    <the VersionNum files will be created with the specified version>

Increment the VersionNum file:

    prompt> cd ComponentDirectory
    prompt> vmanage inc
    <the VersionNum files will have their version incremented and dates updated>

Set the version in the VersionNum file to a specific value:

    prompt> cd ComponentDirectory
    prompt> vmanage set <x.yy>
    <the VersionNum files will have their version set and dates updated>

Update the date stamp in the VersionNum file:

    prompt> cd ComponentDirectory
    prompt> vmanage update
    <the VersionNum files will all be updated with the current date and version>

Create a VersionBas BASIC file containing the same details:

    prompt> cd ComponentDirectory
    prompt> touch VersionBas,ffb
    prompt> vmanage update
    <the VersionBas file is created and will be updated each time the version is changed>

Create a VersionAsm assembler header containing the same details:

    prompt> cd ComponentDirectory
    prompt> touch VersionAsm
    prompt> vmanage update
    <the VersionAsm file is created and will be updated each time the version is changed>


## Use with CMHG/CMunge

The CMHG and CMunge tools have the ability to preprocess their content. This
allows the header to include the `VersionNum` files and use its values. To make
the tools apply the pre-processor, specify the `-p` option on their command line.

A simple command invocation might look like this:

    cmhg -p -o o.mymodule cmhg.mymodule

In a Makefile this might look like this:

    CMHGflags = -depend !Depend -throwback -p

    .cmhg.o:;    cmhg $(cmhgflags) -o $@ $<

The CMHG file itself would contain an include and help-string definition thus:

    #include "VersionNum"

    help-string:  OmniDisc Module_MajorVersion_CMHG Module_MinorVersion_CMHG

In a C file you might include the version string in your help message, something like this:

    #include "VersionNum"

    void print_version(void)
    {
        printf("MyTool " Module_FullVersionAndDate " (C) Future Gadget Labs\n");
    }
