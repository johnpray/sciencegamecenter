# For reasons known and unknown, we're currently locked to Paperclip 3.0.3.
# It has an incompatibility with Rails 4.2, where the run_callbacks method's
# signature changed. So this monkeypatches Paperclip to use the new
# signature (with no `opts` argument).
# 3.0.3: https://github.com/thoughtbot/paperclip/blob/01406e1a4dad7819db896b477314b7f03aab3275/lib/paperclip/callbacks.rb#L26
# Current: https://github.com/thoughtbot/paperclip/blob/c769382c9b7078f3d1620b50ec2a70e91ba62ec4/lib/paperclip/callbacks.rb#L38
module Paperclip
  module Callbacks
    module Running
      def run_paperclip_callbacks(callback, opts = nil, &block)
        run_callbacks(callback, &block)
      end
    end
  end
end
