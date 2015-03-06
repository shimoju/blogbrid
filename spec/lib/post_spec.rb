require 'spec_helper'
require 'post'

RSpec.describe Blogbrid::Post do
  let(:valid_post) { 'spec/fixtures/content/posts/2015-02-24-post-sample.md' }

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
