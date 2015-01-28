module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :anggota do
      desc "Return all Anggota DPRD 2014"
      get do
        anggota_dprd = Array.new

        # Prepare conditions based on params
        valid_params = {
          provinsi: 'id_provinsi'
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        # Set default limit
        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 1000 : params[:limit]

        AnggotaDprd.includes(:province)
          .where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |anggota|
            anggota_dprd << {
              id: anggota.id,
              provinsi: anggota.province,
              nama: anggota.nama,
              tempat_lahir: anggota.tempat_lahir,
              tanggal_lahir: anggota.tanggal_lahir,
              alamat_kantor: anggota.alamat,
              keterangan: anggota.keterangan
            }
        end

        {
          results: {
            count: anggota_dprd.count,
            total: AnggotaDprd.where(conditions).count,
            anggota: anggota_dprd
          }
        }
      end

    end
  end
end