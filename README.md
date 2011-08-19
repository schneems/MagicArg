MagicArg
======

  Use MagicArg to order and parse your overloaded arguments in ruby. I know you're pretty excited, keep reading it just gets better. 

Example
-------------

````ruby
  def build_key(*args)
    keys, options = MagicArg.parse(args, "*keys, options = {}")
  end
````

Pass the args you get directly to `MagicArg.parse` then tell it how you want your arguments returned (in this case `*keys, options = {}`) and MagicArg will do the rest.
  
This is essentially the same as defining the method `build_key(*keys, options={})` (which you can't do in ruby right now).
  
MagicArg lets you give your consumer the interface you want. 
  
```ruby
  build_key(:put, :whatever, :you, :want, :then => "pass in a hash", :as => "options"
```

MagicArg also allows us to "type" our input arguments. Just put the class name in square brackets. Like this:

```ruby
    foo, bar = MagicArg.parse(args, "*foo[Numeric], *bar[Symbol]")

    foo, bar = MagicArg.parse(args, "foo = {}, bar[String]")
    
    foo, bar = MagicArg.parse(args, "foo, bar")
    
    #...
```

This is my [_why day project ](http://whyday.org/) hope you enjoy it. No Gem cut yet, let me know if you're interested.

My Other Fun Projects
==================
- [Keytar](http://github.com/schneems/keytar) helps you manage keys
- [JohnnyCache](http://github.com/schneems/johnny_cache) is method level caching for Rails


Contribution
============

Fork away. If you want to chat about a feature idea, or a question you can find me on the twitters [@schneems](http://twitter.com/schneems).  Put any major changes into feature branches. Make sure all tests stay green, and make sure your changes are covered. 


licensed under MIT License
Copyright (c) 2011 Schneems. See LICENSE.txt for
further details.

Chunky Bacon
============

It's awesome

      $$\      $$\                     $$\            $$$$$$\                      
      $$$\    $$$ |                    \__|          $$  __$$\                     
      $$$$\  $$$$ | $$$$$$\   $$$$$$\  $$\  $$$$$$$\ $$ /  $$ | $$$$$$\   $$$$$$\  
      $$\$$\$$ $$ | \____$$\ $$  __$$\ $$ |$$  _____|$$$$$$$$ |$$  __$$\ $$  __$$\ 
      $$ \$$$  $$ | $$$$$$$ |$$ /  $$ |$$ |$$ /      $$  __$$ |$$ |  \__|$$ /  $$ |
      $$ |\$  /$$ |$$  __$$ |$$ |  $$ |$$ |$$ |      $$ |  $$ |$$ |      $$ |  $$ |
      $$ | \_/ $$ |\$$$$$$$ |\$$$$$$$ |$$ |\$$$$$$$\ $$ |  $$ |$$ |      \$$$$$$$ |
      \__|     \__| \_______| \____$$ |\__| \_______|\__|  \__|\__|       \____$$ |
                             $$\   $$ |                                  $$\   $$ |
                             \$$$$$$  |                                  \$$$$$$  |
                              \______/                                    \______/ 
