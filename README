Blankslate
==========

Blank slate is ActionView Helper that makes it simple for you to generate blank slates for your views
as well as keeping the noise out and the code clean in your views. [37signals has a decent talk about
blank slates here](http://37signals.com/svn/posts/90-design-decisions-backpack-page-blank-slate).


Example
=======

Here's how you might've written your view code before blankslate:

      if @users.blank?
        <p>There are no users</p>
      else
        <p>This is where my users are</p>
      end

Compare that to the blankslate version:

      output_unless @users.blank?, :message => "<p>There are no users</p>" do
        <p>This is where my users are</p>
      end

Isn't that cleaner?, The great thing about blankslate is that it automatically detects special 
partials in a the views/blank_slates directory and will use them instead of the message. There are 
rake tasks which can help you in generating blank slates:

      rake generate:blank_slates FOR=controller/action
      
This gives you the flexibility to create and design your blank slates in a modular fashion. Here are
some other examples:

Outputting the default:

      # will output "There are no records" as the default message
      output_unless @users.blank? do
        <p>This is where my users are</p>
      end
      
Don't want to use the default setup? Then you can use your own partial if you like:

      # will use the partial at users/blank_slate instead of blank_slates/users/index:
      output_unless @users.blank?, :partial => "users/blank_slate" do
        <p>This is where my users are</p>
      end

Usage
=====

blank_slate condition, options={}
---------------------------------

Options:

- :message = The message to output if the condition is satisfied, this defaults to: 
  'There are no records'
- :partial = The partial that you want to use instead of the default *blank_slates/controller/action* 
  location
  
Tasks
=====

generate:blank_slates FOR='controller/action'
---------------------------------------------

Will generate a blank slate in the blank_slates directory for the controller and action and will 
open up in textmate if you are using osx.

Copyright (c) 2009 Vann Ek, released under the MIT license
