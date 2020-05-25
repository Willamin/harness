require "stdimp/string/puts"
require "stdimp/string/append"

module Harness
  VERSION = "0.1.0"
end

annotation Harness::Subcommand
end

class Harness::Cli
  class_getter program_name : String = "harness"

  class_getter stdin : IO = STDIN
  class_getter stdout : IO = STDOUT
  class_getter stderr : IO = STDERR

  @@error_messages = [] of String

  def self.add_error(message : String)
    @@error_messages << message
  end

  def self.setup(@@stdin, @@stdout, @@stderr); end

  def error(message : String? = nil)
    [
      message,
      @@error_messages,
    ]
      .flatten
      .compact
      .join("\n")
      .append("\n")
      .colorize(:red)
      .to_s
      .puts(Harness::Cli.stderr)

    {% if @type.has_method?("help") %}
      help(1)
    {% else %}
    "TODO: override help(error_code : Int32)"
      .puts(Harness::Cli.stdout)
    exit(1)
    {% end %}
  end

  def main(argv : Array(String))
    command = argv[0]? || "help"
    args = argv[1..-1]? || [] of String

    {% begin %}
      {% subcommands = (@type.methods + @type.ancestors.map(&.methods).reduce([] of ASTNode) { |a, x| a + x }).select { |m| m.annotation(Harness::Subcommand) }.map(&.name) %}
      subcommands = {{subcommands.empty? ? "[] of String".id : subcommands.map(&.stringify)}}

      case command
      {% for command in subcommands %}
      when {{command.stringify}} then {{command.id}}
      {% end %}
      else error("unknown command '#{command}'")
      end
    {% end %}
  end
end
