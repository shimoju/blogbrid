require 'spec_helper'
require 'content'

RSpec.describe Content do
  let(:markdown) { 'spec/fixtures/markdown.md' }
  let(:front_matter) { 'spec/fixtures/front_matter.md' }
  let(:empty_front_matter) { 'spec/fixtures/empty_front_matter.md' }

  describe '#body' do
    context 'Front Matterがないファイルのとき' do
      let(:content) { Content.new(markdown) }

      it 'ファイルの内容をそのまま返すこと' do
        orig = File.read(markdown)
        expect(content.body).to eq(orig)
      end
    end

    context 'Front Matterがあるファイルのとき' do
      let(:content) { Content.new(front_matter) }

      it 'Front Matterを取り除いたテキストを返すこと' do
        expect(content.body).not_to match(/---/)
      end
    end

    context '空のFront Matterがあるファイルのとき' do
      let(:content) { Content.new(empty_front_matter) }

      it 'Front Matterを取り除いたテキストを返すこと' do
        expect(content.body).not_to match(/---/)
      end
    end
  end

  describe '#data' do
    context 'Front Matterがないファイルのとき' do
      let(:content) { Content.new(markdown) }

      it 'nilを返すこと' do
        expect(content.data).to be_nil
      end
    end

    context 'Front Matterがあるファイルのとき' do
      let(:content) { Content.new(front_matter) }

      it 'Front Matterをパースしたオブジェクトを返すこと' do
        expect(content.data['test']).to eq('front matter')
      end
    end

    context '空のFront Matterがあるファイルのとき' do
      let(:content) { Content.new(empty_front_matter) }

      it '空のオブジェクトを返すこと' do
        expect(content.data).to be_empty
      end
    end
  end

  describe '#name' do
    let(:content) { Content.new(markdown) }

    it 'ファイル名から拡張子を除いた文字列を返すこと' do
      expect(content.name).to eq('markdown')
    end
  end

  describe '#title' do
    context 'Front Matterでタイトルが設定されていないとき' do
      let(:content) { Content.new(empty_front_matter) }

      it 'ファイル名から拡張子を除いた文字列を返すこと' do
        expect(content.title).to eq('empty_front_matter')
      end
    end

    context 'Front Matterでタイトルが設定されているとき' do
      let(:content) { Content.new(front_matter) }

      it '設定されたタイトルを返すこと' do
        expect(content.title).to eq('Title')
      end
    end
  end
end
