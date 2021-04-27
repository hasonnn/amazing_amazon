require 'rails_helper'

RSpec.describe NewsArticle, type: :model do
  def news_article
    @news_article ||= NewsArticle.new(
      title: 'Random Title',
      description: 'This is a really good article'
    )
  end

  describe 'validations' do
    it 'has a title' do
      n = FactoryBot.build(:news_article, title: nil) #Using FactoryBot
      n.valid?
      expect(n.errors).to have_key(:title)
    end

    it 'has a unique title' do 
      n = news_article
      n.save
      n2 = NewsArticle.new(title: 'Random Title')
      n2.valid?
      expect(n2.errors).to have_key(:title)
    end

    it 'has a description' do
      n = news_article
      n.description = nil
      n.valid?
      expect(n.errors).to have_key(:description)
    end

    it 'ensures the published_at is after created_at' do
      n = news_article
      n.save
      n.published_at = n.created_at
      n.valid?
      expect(n.errors).to have_key(:published_at)
    end
  end

  describe '#titleize_title' do
    it 'titleizes the title' do
      n = news_article
      n.title = "a unique title"
      n.save
      expect(NewsArticle.last.title).to eq("A Unique Title")
    end
  end

  describe '#publish' do
    it 'sets published_at to the current date' do
      n = news_article
      n.save
      n.publish
      expect(n.published_at.to_i).to eq(Time.zone.now.to_i)
    end
  end

  describe '.published' do
    it 'returns the published articles' do
      n1 = NewsArticle.create(title: 'article 1', description: "testing published")
      n2 = NewsArticle.create(title: 'article 2', description: "testing published")
      n3 = NewsArticle.create(title: 'article 3', description: "testing published")
      n1.publish
      n2.publish
      expect([n1, n2]).to eq(NewsArticle.published)
    end
  end
end
