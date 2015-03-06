require 'spec_helper'
require 'page'

RSpec.describe Blogbrid::Page do
  let(:markdown) { 'spec/fixtures/markdown.md' }
  let(:front_matter) { 'spec/fixtures/front_matter.md' }
  let(:empty_front_matter) { 'spec/fixtures/empty_front_matter.md' }

  describe '#body' do
    context 'Front Matterがないファイルのとき' do
      let(:page) { Blogbrid::Page.new(markdown) }

      it 'ファイルの内容をそのまま返すこと' do
        orig = File.read(markdown)
        expect(page.body).to eq(orig)
      end
    end

    context 'Front Matterがあるファイルのとき' do
      let(:page) { Blogbrid::Page.new(front_matter) }

      it 'Front Matterを取り除いたテキストを返すこと' do
        expect(page.body).not_to match(/---/)
      end
    end

    context '空のFront Matterがあるファイルのとき' do
      let(:page) { Blogbrid::Page.new(empty_front_matter) }

      it 'Front Matterを取り除いたテキストを返すこと' do
        expect(page.body).not_to match(/---/)
      end
    end
  end

  describe '#data' do
    context 'Front Matterがないファイルのとき' do
      let(:page) { Blogbrid::Page.new(markdown) }

      it 'nilを返すこと' do
        expect(page.data).to be_nil
      end
    end

    context 'Front Matterがあるファイルのとき' do
      let(:page) { Blogbrid::Page.new(front_matter) }

      it 'Front Matterをパースしたオブジェクトを返すこと' do
        expect(page.data['test']).to eq('front matter')
      end
    end

    context '空のFront Matterがあるファイルのとき' do
      let(:page) { Blogbrid::Page.new(empty_front_matter) }

      it '空のオブジェクトを返すこと' do
        expect(page.data).to be_empty
      end
    end
  end

  describe '#name' do
    let(:page) { Blogbrid::Page.new(markdown) }

    it 'ファイル名から拡張子を除いた文字列を返すこと' do
      expect(page.name).to eq('markdown')
    end
  end

  describe '#title' do
    context 'Front Matterでタイトルが設定されていないとき' do
      let(:page) { Blogbrid::Page.new(empty_front_matter) }

      it 'ファイル名から拡張子を除いた文字列を返すこと' do
        expect(page.title).to eq('empty_front_matter')
      end
    end

    context 'Front Matterでタイトルが設定されているとき' do
      let(:page) { Blogbrid::Page.new(front_matter) }

      it '設定されたタイトルを返すこと' do
        expect(page.title).to eq('Title')
      end
    end
  end
end
