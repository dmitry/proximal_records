require 'spec_helper'


describe ProximalRecords do
  it 'normal' do
    a1 = Article.create!(title: '1')
    a2 = Article.create!(title: '2')
    a3 = Article.create!(title: '3')


    p, n = a3.proximal_records(Article.where(title: %w(1 2 3)))

    p.should eq a2
    n.should be_nil


    p, n = a3.proximal_records(Article.where(title: %w(1 2 3)).order('title DESC'))

    n.should eq a2
    p.should be_nil
  end
end