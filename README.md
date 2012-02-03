# ciphersurfer

ciphersurfer is a tool written for the early stages of a penetration test
activities. While gathering information about an host, it's important to
evaluate how strong is the cryptography applied to the HTTP traffic. This is
the ciphersurfer goal.

The tool tries for every SSL protocols it supports to connect to the host with
all ciphers saving the ones the server supports.

This information used with certificate key lenght and the list of supported
protocols by the server it's used to evaluate how strong is the target HTTPS
configuration. This gives the penetration test an information about how secure
is the communication between clients and the target machine.

## Some disclaimer

ciphersurfer performs neither of the followings:

* denial of service attacks
* cross site scripting or injection attempts
* data manipulation or leakage

The requests the tool makes are just an HTTP GET / of target website to ensure
the server accept an HTTP communication given a SSL protocol and cipher
proposed by the client. No more. Really, ciphersurer won't hurt your webserver,
nor your business. 

If you don't trust this disclaimer, just check the source code.

## Installing ciphersurfer

ciphersurfer is deployed as standard gem served by
[rubygems](http://rubygems.org). 

To install latest ciphersurfer stable release, just issue this command:

```
gem install ciphersurfer
```

If you want to install a _pre_ release, such as a _release candidate_ you can do it this way:

```
gem install ciphersurfer --pre
```

I recommend you to install [rvm](https://rvm.beginrescueend.com/) in order to
have your gem binaries tool installed in your home directory, otherwise
ciphersurfer will try to install itself in standard /usr/bin directory if no
other flags are passed to gem command.

## Using ciphersurfer

After ciphersurfer has been installed, using it it's very simple.

To evaluate secure communication with the target host _test-this.com_ at the
standard HTTPS port, you just give the tool the target name as option:

``` 
ciphersurfer test-this.com
``` 

As output you will see an evaluation for HTTPS test-this.com configuration. 
The evaluation scale is:

* A: _prime class_ HTTPS configuration. Servers handling **very** sensitive
  information
* B: strong HTTPS configuration, suitable for must production servers
* C: quite goot HTTPS configuration. If your web server is a private server and
  for development or testing purposes, it can be acceptable. If your server is
  exposed to the Internet, you want to improve your SSL configuration.
* D: poor HTTPS configuration. Suitable **only** for development machines.
* E: weak HTTPS configuration. You really don't want to have this score

If your HTTPS server is listening to a non standard port, you can supply the
port number (e.g. 4433) this way:

``` 
ciphersurfer test-this.com:4433
``` 

You can also just listen ciphers supported by your web server instead of having
an SSL evaluation:

``` 
$ ciphersurfer -l gmail.com 

"Evaluating secure communication with gmail.com:443"
"[+] accepted RC4-MD5"
"[+] accepted AES256-SHA"
"[+] accepted DES-CBC3-SHA"
"[+] accepted AES128-SHA"
"[+] accepted RC4-SHA"
``` 

## Certificate signin request support

This is an aside feature I wanted to introduce if you have to inspect a CSR
file. The idea here is to help sysadmin to understand with their certificate is
invalid starting from the very beginning, the Certificate Signin Request.

This feature usage is easy. Just do this:

```
$ ciphersurfer --csr your_csr.csr
   CN : a_cn
    O : your_organization
    C : IT
   ST : Milan
    L : Milan
CSR is valid
```

## Some theory behind ciphersurfer

### SSLabs

For the SSL security evaluation, we use [SSLabs
document](https://www.ssllabs.com/downloads/SSL_Server_Rating_Guide_2009.pdf)
as reference.

### OWASP Testing guide 

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

