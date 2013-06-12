
begin
  unless tagged?("vantrix-deployed")

    package "spotxde-trx" do
        action :install
    end

    service "trx" do
        action [:enable, :start]
    end

   tag("vantrix-deployed")
   end
rescue
    untag("vantrix-deployed")
end
