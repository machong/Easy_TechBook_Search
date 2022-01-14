# -*- encoding: utf-8 -*-
# stub: baidu_translate 0.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "baidu_translate".freeze
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Simon Nizov".freeze]
  s.bindir = "exe".freeze
  s.date = "2016-09-21"
  s.description = "Wrapper gem for the Baidu Translate API.".freeze
  s.email = ["simon.nizov@gmail.com".freeze]
  s.homepage = "https://github.com/kaipule-tech/baidu_translate".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Wrapper gem for the Baidu Translate API.".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.12"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_development_dependency(%q<vcr>.freeze, [">= 0"])
    s.add_development_dependency(%q<byebug>.freeze, [">= 0"])
    s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<faraday>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<json>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.12"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_dependency(%q<vcr>.freeze, [">= 0"])
    s.add_dependency(%q<byebug>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<faraday>.freeze, [">= 0"])
    s.add_dependency(%q<json>.freeze, [">= 0"])
  end
end
