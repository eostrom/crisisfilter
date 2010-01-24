SimpleSearch
============
Sometimes, for whatever reason, you might have a hard time installing that uber search engine of yours. You need something to get
you going quickly. Thats where this plugin comes in. 

This is just a simple way to query a database object based on some pre-determined fields, using the in-built find_by_sql
but without worry about having to sanitize before hand. Due to the fact its essentially a SQL query, I wouldn't use this plugin in cases where its going to be used a lot
or if you want to really have some *smart* searching. It's basically, a really simple search tool to get you going until you can think of something better to replace it with. :-)

Example
=======

You have a User model you want to do some query action on. It has a number of fields including name, email, and zip_code.
Enter this in your User model:

simple_search :fields => [:name, :email, :zip_code]

Now you have a simple_search method on your User model:

User.simple_search_query("foo") #=> [#<User id:1, email:"foo@foo.com">]

You can pass in the order options like this...

User.simple_search_query("foo", :order => "name DESC")

&copy 2009 RubyMiner LLC, released under the MIT license
================================================================
