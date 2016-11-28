require "spec"
require "kemal"
require "spec-kemal"
require "../src/kave"

Spec.before_each do
  Kave.reset_config!
end
