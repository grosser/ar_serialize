Dry de/serialize nested Hashes/Arrays of ActiveRecords

Strips unnecessary info like attributes/associations from infinetly deep Hashes/Arrays.

Install
=======
    sudo gem install ar_serialize
Or

    rails plugin install git://github.com/grosser/ar_serialize.git

Usage
=====

    {:foo => <User>}.to_yaml --> tons of stuff including asociations and attriutes
    ArSerialize.seriazlize(:foo => <User>) --> {:foo => "ActiveRecord:User:15"}
    ArSerialize.deseriazlize(:foo => 'ActiveRecord:User:15') --> {:foo => <User>}


Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
Hereby placed under public domain, do what you want, just do not hold me accountable...
