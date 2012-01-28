# ciphersurfer

ciphersurfer is a tool to enumerate a website for ciphers it supports. It can
be used for testing pourposes and to evaluate te security configuration for an
SSL configured web server.

## Installing ciphersurfer

Installing ciphersurfer is easy. Just follow the standard ruby gem way:

  gem install ciphersurfer

Now you've got a ciphersurfer executable you can invoke using your command line.

## SSLabs

For the SSL security evaluation, we use [SSLabs
document](https://www.ssllabs.com/downloads/SSL_Server_Rating_Guide_2009.pdf)
as reference.

## OWASP Testing guide 

ciphersurfer goal is to make tests described in the [Owasp Testing
guide](https://www.owasp.org/index.php/Testing_for_SSL-TLS_(OWASP-CM-001\))


## Contributing to ciphersurfer
 
* Check out the latest master to make sure the feature hasn't been implemented
  or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it
  and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to
  have your own version, or is otherwise necessary, that is fine, but please
  isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Paolo Perego. See LICENSE for
further details.

