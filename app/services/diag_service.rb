class DiagService
  class << self
    def ping host
      execute_with_host host, "ping -c 3 #{host} 2>&1"
    end

    def traceroute host
      execute_with_host host, "traceroute -n #{host} 2>&1"
    end

    def dig host
      execute_with_host host, "dig #{host} 2>&1"
    end

    def connection host, port
      if number? port
        execute_with_host host, "nc -zv #{host} #{port} 2>&1"
      else
        raise PortInvalid.new
      end
    end

    def read_network
        filename = ENV['NETWORK_CONFIG']
        values = {}
        File.open(filename, "r") do |f|
          while(line = f.gets)
            args = line.split(' ') unless line.start_with?('#')
            unless args.nil? || args[0].nil?
              values[args[0]] = args[1]
            end
          end
          return values
        end
    end

    def network template_path, params
      ip = params[:ip]
      gateway = params[:gateway]
      netmask = params[:netmask]
      dns = params[:dns]
      if host?(ip) && host?(gateway) && host?(netmask) && host?(dns)
        content = File.open(template_path).read
        template = ERB.new(content)
        res = template.result(binding)

        File.open(ENV['NETWORK_CONFIG'], "w+") do |f|
          f.write(res)
        end
      else
        raise HostInvalid.new
      end
    end

    def ip
      read_network['address']
    end

    def netmask
      read_network['netmask']
    end

    def gateway
      read_network['gateway']
    end

    def dns
      read_network['dns-nameservers']
    end

    private

    def execute_with_host host, cmd
      if host? host
        execute(cmd)
      else
        raise HostInvalid.new
      end
    end

    def execute(command)
      `#{command}`
    end
    def host? host
      /^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$/.match(host)
    end
    def number?(object)
      true if Float(object) rescue false
    end

  end
end

class HostInvalid < StandardError
end

class PortInvalid < StandardError
end
