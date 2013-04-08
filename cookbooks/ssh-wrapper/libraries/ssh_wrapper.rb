require 'fileutils'
require 'erubis'

# SshWrapper.generate writes an SSH private key and wrapper script
# suitable for use with git as $GIT_SSH
module SshWrapper
  module_function

  KEYS = [:user, :group, :private_key, :prefix]

  # generate an ssh-wrapper script and private key file according to opts.
  # all opts must be provided -
  #   :user  - owner of generated files
  #   :group - group of generated files
  #   :private_key - ssh private key in a string
  #   :prefix - private key will be written to prefix + "_identity"
  #           - ssh-wrapper script will be written to prefix + "_ssh_wrapper"
  def generate(opts)
    check_opts(opts)

    identity_file = opts[:prefix] + "_identity"
    ssh_wrapper_script_file = opts[:prefix] + "_ssh_wrapper"

    File.open(identity_file, "w") do |io|
      io << opts[:private_key]
    end
    FileUtils.chmod(0600, identity_file)
    FileUtils.chown(opts[:user], opts[:group], identity_file)

    File.open(ssh_wrapper_script_file, "w") do |io|
      io << template.result(:identity=>identity_file)
    end
    FileUtils.chmod(0755, ssh_wrapper_script_file)
    FileUtils.chown(opts[:user], opts[:group], ssh_wrapper_script_file)
  end

  def check_opts(opts)
    unknown = opts.keys - KEYS
    raise "unknown opts: #{unknown.inspect}" if !unknown.empty?
    missing = KEYS - opts.keys
    raise "missing opts: #{missing.inspect}" if !missing.empty?
  end

  def template_string
    s = <<-EOF
#!/usr/bin/env bash
#
# Deploy SSH Wrapper
#
# Rendered by Chef - local changes will be replaced

/usr/bin/env ssh -o "StrictHostKeyChecking=no" -i "<%= identity %>" $1 $2
EOF
  end

  def template
    Erubis::Eruby.new(template_string)
  end
end
