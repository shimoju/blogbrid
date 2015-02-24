require 'spec_helper'
require 'post'

RSpec.describe Post do
  let(:valid_post) { 'spec/fixtures/2015-02-24-post-sample.md' }

  describe '#name' do
    let(:post) { Post.new(valid_post) }

    it 'ファイル名から日付部分と拡張子を除いた文字列を返すこと' do
      expect(post.name).to eq('post-sample')
    end
  end
end
