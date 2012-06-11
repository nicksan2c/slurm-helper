slurm-helper
============

Bunch of helper files for the Slurm resource manager

Vim syntax file
---------------

The Vim syntax file renders the Slurm batch submission scripts easier to read and to spot errors in the submission options. 

As submission scripts are indeed shell scripts, and all Slurm options are actually Shell comments, it can be difficult to spot errors in the options. 

This syntax file allows vim to understand the Slurm option and highlight them accordingly. Whenever possible, the syntax rules check the validity of the options and put in a special color what is not recognized as a valid option, or valid parameters values. 

__Installation__

Under Linux or MacOS, simply copy the file in the directory

    .vim/after/syntax/sh/

or whatever shell other than ``sh`` you prefer. 

The syntax file is then read and applied on a Shell script after the usual syntax file has been processed. 

__Known issues__

* Some regex needed to validate options or parameter values are not exactly correct, but should work in most cases. 
* Any new option unknown to the syntax file will be spotted as an error. 

Emacs syntax file
-----------------

The Emacs syntax file highlights SBATCH comments in a font distinct from other comments. 

__Installation__

Under Linux or MacOS, simply copy the file in your emacs path directory, e.g.

    .emacs.d

and add

    (add-to-list 'load-path "~/.emacs.d/")

    (require 'slurm-mode)
    (add-hook 'sh-mode-hook 'turn-on-slurm-mode)

to your .emacs file

__Known issues__

* Very basic syntax highlighting without any syntax checking, contrarily to the Vim version.

Bash completion
---------------

The Bash completion script offers <TAB> completion for Slurm commands. 

At present the following Slurm commands are considered
* scontrol
* sreport

__Instalation__

Simply source the script in your .bashrc or .profile

__Knwon issues__

Keyword arguments are not auto-compelted beyond the first one.
