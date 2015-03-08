require 'spec_helper'
require 'page'

RSpec.describe Blogbrid::Page do
  before(:context) do
    @base_path = 'spec/fixtures/content/pages'
    Blogbrid::Page.base_path = @base_path
  end

  let(:markdown) { 'markdown.md' }
  let(:front_matter) { 'front_matter/present.md' }
  let(:empty_front_matter) { 'front_matter/empty.md' }

  describe '#body' do
    context 'Front Matterがないファイルのとき' do
      let(:page) { Blogbrid::Page.new(markdown) }

      it 'ファイルの内容をそのまま返すこと' do
        orig = File.read(File.expand_path(markdown, @base_path))
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

      it '空のオブジェクトを返すこと' do
        expect(page.data).to be_empty
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

  describe '#exist?' do
    let(:page) { Blogbrid::Page.new(markdown) }
    let(:not_exist_page) { Blogbrid::Page.new('.not_exist.md') }

    it 'ファイルが存在すればtrueを、しなければfalseを返すこと' do
      expect(page.exist?).to be true
      expect(not_exist_page.exist?).to be false
    end
  end

  describe '#name' do
    let(:page) { Blogbrid::Page.new(markdown) }

    it 'ファイル名から拡張子を除いた文字列を返すこと' do
      expect(page.name).to eq('markdown')
    end
  end

  describe '#title' do
    context 'Front Matterがないファイルのとき' do
      let(:page) { Blogbrid::Page.new(markdown) }

      it 'ファイル名から拡張子を除いた文字列を返すこと' do
        expect(page.title).to eq('markdown')
      end
    end

    context 'Front Matterでタイトルが設定されていないとき' do
      let(:page) { Blogbrid::Page.new(empty_front_matter) }

      it 'ファイル名から拡張子を除いた文字列を返すこと' do
        expect(page.title).to eq('empty')
      end
    end

    context 'Front Matterでタイトルが設定されているとき' do
      let(:page) { Blogbrid::Page.new(front_matter) }

      it '設定されたタイトルを返すこと' do
        expect(page.title).to eq('Title')
      end
    end
  end

  describe '#url' do
    let(:page) { Blogbrid::Page.new(markdown) }
    let(:page_in_dir) { Blogbrid::Page.new(front_matter) }

    it 'ファイル名からURLに変換すること' do
      expect(page.url).to eq('/markdown/')
      expect(page_in_dir.url).to eq('/front_matter/present/')
    end
  end

  describe '.url_to_filename' do
    let(:url) { '/front_matter/present/' }
    let(:url_without_slash) { 'front_matter/present' }
    let(:url_simple) { '/markdown/' }

    it '渡されたURLをファイル名に変換すること' do
      expect(Blogbrid::Page.url_to_filename(url_simple)).to eq('markdown.md')
      converted_filename = Blogbrid::Page.url_to_filename(url)
      expect(converted_filename).to eq('front_matter/present.md')
      expect(Blogbrid::Page.url_to_filename(url_without_slash)).to eq(converted_filename)
    end
  end

  describe '.base_path' do
    after(:example) do
      Blogbrid::Page.base_path = @base_path
    end

    it 'ベースパスを設定・取得できること' do
      expect(Blogbrid::Page.base_path).to eq(@base_path)
      Blogbrid::Page.base_path = 'base_path/test'
      expect(Blogbrid::Page.base_path).to eq('base_path/test')
    end
  end
end
