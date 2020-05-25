# harness

***Warning**: This tool is a work in progress. It has severe limitations. I'm working on this project in conjunction with another, extracting pieces of functionality that can belong in this package, able to be reused.*


Quickly helps setup an opinionated CLI harness.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     harness:
       github: Willamin/harness
   ```

2. Run `shards install`

## Usage

```crystal
require "harness"

class MyApp::Cli < Harness::Cli
  @[Harness::Subcommand]
  def version
    STDOUT.puts("myapp 1.0.0")
  end
end
```

Create a subclass of the type `Harness::Cli`. This will get you setup with a harness for subcommand-style CLIs. To add a subcommand, write a method with the name of the subcommand and add the annotation `@[Harness::Subcommand]`. This tells the harness to listen for this subcommand.

## Contributing

1. Fork it (<https://github.com/Willamin/harness/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Will Lewis](https://github.com/Willamin) - creator and maintainer
