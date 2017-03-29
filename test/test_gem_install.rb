require "minitest/autorun"

class TestGemInstall < Minitest::Test
  def test_gem_install
    res = system <<-EOT.gsub("\n", "&")
cd test/helper/testgem
gem build testgem.gemspec
gem install testgem-1.0.0.gem --verbose
    EOT
    assert_equal true, res, "shell commands should succeed"

    out = IO.popen("ruby -rtestgem -e \"puts Libguess.determine_encoding('abc', 'Greek')\"", &:read)
    assert_match(/UTF-8/, out)

    out = IO.popen("ed --version", &:read)
    assert_match(/GNU ed/, out)
  end
end
