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

    def network template_path, params
      ip = params[:ip]
      gateway = params[:gateway]
      netmask = params[:netmask]
      dns = params[:dns]
      if host?(ip) && host?(gateway) && host?(netmask) && host?(dns)
        content = File.open(template_path).read
        template = ERB.new(content)
        template.result({ip: ip,
                         gateway: gateway,
                         netmask: netmask,
                         dns: dns})
      else
        raise HostInvalid.new
      end
    end

    def ip
    end

    def netmask
    end

    def gateway
    end

    def dns
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
