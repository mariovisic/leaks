# Leaks

Leaks loops your rpsec tests and monitors process RAM usage to detect memory leaks. Processes with continiously growing usage could protentially have a leak in them.
I was inspired to create leaks after reading [a blog post by Timothy Elliott](http://holymonkey.com/how-to-find-and-fix-a-memory-leak-in-a-ruby-c-extension.html) about a technique for hunting down memory leaks in rails apps.

## Compatability

- Works with RSpec (patches for minitest and test unit are welcome)
- Works on OSX and Linux (Patches for Windows welcome)
- Tested on Ruby MRI 1.9.3 (patches for other ruby interpreters welcome)

## Installation

Add this line to your application's Gemfile:

    gem 'leaks'

And then execute:

    $ bundle

## Usage

### Rails

After adding leaks to your gemfile, fire up the rails console in a test environment:

```
rails c test
```

Now simply point leaks to a given spec directory (leave blank to use your entire test suite):

```
Leaks::Runner.run
# or
Leaks::Runner.run('/path/to/spec')
```

You can pass a single folder, or even an array of folders, for example:

```
Leaks::Runner.run(['spec/models', 'spec/controllers'])
```

You can run leaks in verbose mode to see the output of your tests (careful it can get noisy):

```
Leaks::Runner.run('spec', true)
```

Now watch the output, the RAM usage will most likely grow for a while. If after a few minutes it's still growing it could be an indication of a problem. Please take note of your test suite size, if your test suite takes 10 minutes to run then be sure to let it run through once or twice before verifying the output.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
