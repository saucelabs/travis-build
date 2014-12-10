require 'travis/build/addons/base'
require 'jwt'

module Travis
  module Build
    class Addons
      class Jwt < Base
        SUPER_USER_SAFE = true

        def before_before_script
          pull_request = self.data.pull_request ? self.data.pull_request : ""
          payload = {"slug" => self.data.slug,
                     "pull-request" => pull_request,
                     "iat" => Time.now.to_i()}

          token = JWT.encode(payload, "this_will_need_to_come_from_secure")

          sh.fold 'addons_jwt' do
            sh.echo 'Initializing JWT', ansi: :yellow
            #sh.export 'TRAVIS_JWT_TOKEN', 'true', echo: false
          end
        end
      end
    end
  end
end
