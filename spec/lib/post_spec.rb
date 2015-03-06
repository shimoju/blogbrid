require 'spec_helper'
require 'post'

RSpec.describe Blogbrid::Post do
  before(:context) do
    @base_path = 'spec/fixtures/content/posts'
    Blogbrid::Post.base_path = @base_path
  end

  let(:valid_post) { '2015-02-24-post-sample.md' }

  describe '#name' do
    let(:post) { Blogbrid::Post.new(valid_post) }

    it 'ファイル名から日付部分と拡張子を除いた文字列を返すこと' do
      expect(post.name).to eq('post-sample')
    end
  end

  describe '#date' do
    let(:post) { Blogbrid::Post.new(valid_post) }

    it 'ファイル名の日付部分を読み取ってDateオブジェクトを返すこと' do
      expect(post.date).to eq(Date.new(2015, 2, 24))
    end
  end
end
