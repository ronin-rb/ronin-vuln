require 'spec_helper'
require 'ronin/vulns/cli/printing'

require 'ronin/vulns/cli/command'
require 'ronin/vulns/lfi'
require 'ronin/vulns/rfi'
require 'ronin/vulns/sqli'
require 'ronin/vulns/ssti'
require 'ronin/vulns/reflected_xss'
require 'ronin/vulns/open_redirect'

describe Ronin::Vulns::CLI::Printing do
  let(:url) { 'https://example.com/page.php?id=1' }

  module TestCLIPrinting
    class TestCommand < Ronin::Vulns::CLI::Command
      include Ronin::Vulns::CLI::Printing
    end
  end

  let(:command_class) { TestCLIPrinting::TestCommand }
  subject { command_class.new }

  describe "#vuln_type" do
    context "when given a Ronin::Vulns::LFI object" do
      let(:vuln) { Ronin::Vulns::LFI.new(url) }

      it "must return 'LFI'" do
        expect(subject.vuln_type(vuln)).to eq('LFI')
      end
    end

    context "when given a Ronin::Vulns::RFI object" do
      let(:vuln) { Ronin::Vulns::RFI.new(url) }

      it "must return 'RFI'" do
        expect(subject.vuln_type(vuln)).to eq('RFI')
      end
    end

    context "when given a Ronin::Vulns::SQLI object" do
      let(:vuln) { Ronin::Vulns::SQLI.new(url) }

      it "must return 'SQLi'" do
        expect(subject.vuln_type(vuln)).to eq('SQLi')
      end
    end

    context "when given a Ronin::Vulns::SSTI object" do
      let(:vuln) { Ronin::Vulns::SSTI.new(url) }

      it "must return 'SSTI'" do
        expect(subject.vuln_type(vuln)).to eq('SSTI')
      end
    end

    context "when given a Ronin::Vulns::OpenRedirect object" do
      let(:vuln) { Ronin::Vulns::OpenRedirect.new(url) }

      it "must return 'Open Redirect'" do
        expect(subject.vuln_type(vuln)).to eq('Open Redirect')
      end
    end

    context "when given a Ronin::Vulns::ReflectedXSS object" do
      let(:vuln) { Ronin::Vulns::ReflectedXSS.new(url) }

      it "must return 'reflected XSS'" do
        expect(subject.vuln_type(vuln)).to eq('reflected XSS')
      end
    end
  end

  describe "#print_vuln" do
    context "when given a Ronin::Vulns::LFI object" do
      context "and the #query_param attribute is set" do
        let(:query_param) { 'id' }
        let(:vuln) { Ronin::Vulns::LFI.new(url, query_param: query_param) }

        it "must print 'Found LFI on <url> via query param <query_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found LFI on #{url} via query param #{query_param}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #header_name attribute is set" do
        let(:header_name) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::LFI.new(url, header_name: header_name) }

        it "must print 'Found LFI on <url> via Header <header_name>!'" do
          expect(subject).to receive(:puts).with(
            "Found LFI on #{url} via Header #{header_name}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #cookie_param attribute is set" do
        let(:cookie_param) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::LFI.new(url, cookie_param: cookie_param) }

        it "must print 'Found LFI on <url> via Cookie param <cookie_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found LFI on #{url} via Cookie param #{cookie_param}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #form_param attribute is set" do
        let(:form_param) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::LFI.new(url, form_param: form_param) }

        it "must print 'Found LFI on <url> via form param <form_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found LFI on #{url} via form param #{form_param}!"
          )

          subject.print_vuln(vuln)
        end
      end
    end

    context "when given a Ronin::Vulns::RFI object" do
      context "and the #query_param attribute is set" do
        let(:query_param) { 'id' }
        let(:vuln) { Ronin::Vulns::RFI.new(url, query_param: query_param) }

        it "must print 'Found RFI on <url> via query param <query_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found RFI on #{url} via query param #{query_param}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #header_name attribute is set" do
        let(:header_name) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::RFI.new(url, header_name: header_name) }

        it "must print 'Found RFI on <url> via Header <header_name>!'" do
          expect(subject).to receive(:puts).with(
            "Found RFI on #{url} via Header #{header_name}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #cookie_param attribute is set" do
        let(:cookie_param) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::RFI.new(url, cookie_param: cookie_param) }

        it "must print 'Found RFI on <url> via Cookie param <cookie_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found RFI on #{url} via Cookie param #{cookie_param}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #form_param attribute is set" do
        let(:form_param) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::RFI.new(url, form_param: form_param) }

        it "must print 'Found RFI on <url> via form param <form_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found RFI on #{url} via form param #{form_param}!"
          )

          subject.print_vuln(vuln)
        end
      end
    end

    context "when given a Ronin::Vulns::SQLI object" do
      context "and the #query_param attribute is set" do
        let(:query_param) { 'id' }
        let(:vuln) { Ronin::Vulns::SQLI.new(url, query_param: query_param) }

        it "must print 'Found SQLI on <url> via query param <query_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found SQLi on #{url} via query param #{query_param}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #header_name attribute is set" do
        let(:header_name) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::SQLI.new(url, header_name: header_name) }

        it "must print 'Found SQLI on <url> via Header <header_name>!'" do
          expect(subject).to receive(:puts).with(
            "Found SQLi on #{url} via Header #{header_name}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #cookie_param attribute is set" do
        let(:cookie_param) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::SQLI.new(url, cookie_param: cookie_param) }

        it "must print 'Found SQLI on <url> via Cookie param <cookie_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found SQLi on #{url} via Cookie param #{cookie_param}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #form_param attribute is set" do
        let(:form_param) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::SQLI.new(url, form_param: form_param) }

        it "must print 'Found SQLI on <url> via form param <form_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found SQLi on #{url} via form param #{form_param}!"
          )

          subject.print_vuln(vuln)
        end
      end
    end

    context "when given a Ronin::Vulns::SSTI object" do
      context "and the #query_param attribute is set" do
        let(:query_param) { 'id' }
        let(:vuln) { Ronin::Vulns::SSTI.new(url, query_param: query_param) }

        it "must print 'Found SSTI on <url> via query param <query_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found SSTI on #{url} via query param #{query_param}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #header_name attribute is set" do
        let(:header_name) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::SSTI.new(url, header_name: header_name) }

        it "must print 'Found SSTI on <url> via Header <header_name>!'" do
          expect(subject).to receive(:puts).with(
            "Found SSTI on #{url} via Header #{header_name}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #cookie_param attribute is set" do
        let(:cookie_param) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::SSTI.new(url, cookie_param: cookie_param) }

        it "must print 'Found SSTI on <url> via Cookie param <cookie_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found SSTI on #{url} via Cookie param #{cookie_param}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #form_param attribute is set" do
        let(:form_param) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::SSTI.new(url, form_param: form_param) }

        it "must print 'Found SSTI on <url> via form param <form_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found SSTI on #{url} via form param #{form_param}!"
          )

          subject.print_vuln(vuln)
        end
      end
    end

    context "when given a Ronin::Vulns::OpenRedirect object" do
      context "and the #query_param attribute is set" do
        let(:query_param) { 'id' }
        let(:vuln) { Ronin::Vulns::OpenRedirect.new(url, query_param: query_param) }

        it "must print 'Found Open Redirect on <url> via query param <query_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found Open Redirect on #{url} via query param #{query_param}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #header_name attribute is set" do
        let(:header_name) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::OpenRedirect.new(url, header_name: header_name) }

        it "must print 'Found Open Redirect on <url> via Header <header_name>!'" do
          expect(subject).to receive(:puts).with(
            "Found Open Redirect on #{url} via Header #{header_name}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #cookie_param attribute is set" do
        let(:cookie_param) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::OpenRedirect.new(url, cookie_param: cookie_param) }

        it "must print 'Found Open Redirect on <url> via Cookie param <cookie_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found Open Redirect on #{url} via Cookie param #{cookie_param}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #form_param attribute is set" do
        let(:form_param) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::OpenRedirect.new(url, form_param: form_param) }

        it "must print 'Found Open Redirect on <url> via form param <form_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found Open Redirect on #{url} via form param #{form_param}!"
          )

          subject.print_vuln(vuln)
        end
      end
    end

    context "when given a Ronin::Vulns::ReflectedXSS object" do
      context "and the #query_param attribute is set" do
        let(:query_param) { 'id' }
        let(:vuln) { Ronin::Vulns::ReflectedXSS.new(url, query_param: query_param) }

        it "must print 'Found reflected XSS on <url> via query param <query_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found reflected XSS on #{url} via query param #{query_param}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #header_name attribute is set" do
        let(:header_name) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::ReflectedXSS.new(url, header_name: header_name) }

        it "must print 'Found reflected XSS on <url> via Header <header_name>!'" do
          expect(subject).to receive(:puts).with(
            "Found reflected XSS on #{url} via Header #{header_name}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #cookie_param attribute is set" do
        let(:cookie_param) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::ReflectedXSS.new(url, cookie_param: cookie_param) }

        it "must print 'Found reflected XSS on <url> via Cookie param <cookie_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found reflected XSS on #{url} via Cookie param #{cookie_param}!"
          )

          subject.print_vuln(vuln)
        end
      end

      context "and the #form_param attribute is set" do
        let(:form_param) { 'X-Foo' }
        let(:vuln) { Ronin::Vulns::ReflectedXSS.new(url, form_param: form_param) }

        it "must print 'Found reflected XSS on <url> via form param <form_param>!'" do
          expect(subject).to receive(:puts).with(
            "Found reflected XSS on #{url} via form param #{form_param}!"
          )

          subject.print_vuln(vuln)
        end
      end
    end
  end
end
