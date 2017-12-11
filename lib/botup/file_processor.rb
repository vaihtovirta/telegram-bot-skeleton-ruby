require 'fileutils'
require 'erb'
require 'ostruct'

module Botup
  class FileProcessor
    FILE_NAMES_TO_SKIP = ['.', '..', 'core_file.erb'].freeze

    attr_reader :base_name

    def initialize(base_name)
      @base_name = base_name
    end

    def call
      prepare_files
      populate_basic_templates(templates_folder, output_main_folder)
      populate_bot_named_files("#{templates_folder}/core_file.erb", "#{output_lib_folder}/#{base_name}.rb")
      populate_bot_named_files("#{bin_folder}/exec.erb", "#{output_folder}/bin/#{base_name}")
      FileUtils.chmod('+x', "#{output_folder}/bin/#{base_name}")
    end

    private

    def prepare_files
      FileUtils.mkdir_p(output_main_folder)
      FileUtils.mkdir_p("#{output_folder}/bin/")
      FileUtils.cp("#{config_folder}/Gemfile", output_folder)
      FileUtils.cp("#{config_folder}/.env", output_folder)
    end

    def populate_basic_templates(from, to)
      Dir.foreach(from) do |file_name|
        current_path =  "#{from}/#{file_name}"

        next if FILE_NAMES_TO_SKIP.include?(file_name)

        erb = ERB.new(File.read(current_path))
        result = erb.result(namespace.instance_eval { binding })

        ruby_file_path = "#{to}/#{File.basename(file_name, '.erb')}.rb"

        File.open(ruby_file_path, 'w') << result
      end
    end

    def populate_bot_named_files(source, output)
      erb = ERB.new(File.read(source))
      result = erb.result(namespace.instance_eval { binding })
      File.open(output.to_s, 'w') << result
    end

    def bin_folder
      "#{__dir__}/bin"
    end

    def config_folder
      "#{__dir__}/config"
    end

    def templates_folder
      "#{__dir__}/templates"
    end

    def core_file
      "#{templates_folder}/bot.erb"
    end

    def output_lib_folder
      "#{output_folder}/lib/"
    end

    def output_folder
      "#{current_dir}/#{base_name}"
    end

    def output_main_folder
      "#{output_folder}/lib/#{base_name}"
    end

    def current_dir
      Dir.pwd
    end

    def namespace
      OpenStruct.new(class_name: class_name,
                     snake_case_name: base_name)
    end

    def class_name
      base_name.split('_').collect(&:capitalize).join
    end
  end
end
