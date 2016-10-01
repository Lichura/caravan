class ChangeNumeroInRemitos < ActiveRecord::Migration[5.0]
  def up
   connection.execute(%q{
    alter table remitos
    alter column numero
    type integer using cast(numero as integer)
  })
  end

  def down
    change_column :remitos, :numero, :string
  end
end
