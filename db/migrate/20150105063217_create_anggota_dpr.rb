class CreateAnggotaDpr < ActiveRecord::Migration
  def change
    create_table :anggota_dprds do |t|
      t.string  :id_provinsi
      t.string  :nama
      t.string  :tempat_lahir
      t.string  :tanggal_lahir
      t.string  :jabatan
      t.string  :fraksi
      t.string  :alamat
      t.string  :keterangan
    end
  end
end
