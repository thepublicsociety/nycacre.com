class AddSubcontentToSnippets < ActiveRecord::Migration
  def self.up
    add_column :snippets, :subcontent_title, :string
    add_column :snippets, :subcontent, :text
  end

  def self.down
    remove_column :snippets, :subcontent
    remove_column :snippets, :subcontent_title
  end
end
