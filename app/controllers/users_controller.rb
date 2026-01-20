class UsersController < ApplicationController
  before_action :authenticate_user!, except: [ :track_cv ]

  def settings
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update_with_password(password_params)
      bypass_sign_in(@user)
      redirect_to admin_settings_path, notice: "Password berhasil diperbarui!"
    else
      render :settings, status: :unprocessable_entity
    end
  end

def update_contacts
  @user = current_user
  if @user.update(params.require(:user).permit(:whatsapp, :linkedin, :github_url_admin))
    redirect_to admin_settings_path, notice: "Kontak berhasil diperbarui!"
  else
    redirect_to admin_settings_path, alert: "Gagal memperbarui kontak."
  end
end

def update_cv
  @user = current_user
  if params[:user] && params[:user][:cv_file].present?
    if @user.update(params.require(:user).permit(:cv_file))
      @user.update(cv_clicks_count: 0)
      redirect_to admin_settings_path, notice: "CV berhasil diperbarui!"
    end
  else
    redirect_to admin_settings_path, alert: "Mohon pilih file PDF terlebih dahulu."
  end
end

def delete_cv
  @user = current_user
  if @user.cv_file.attached?
    @user.cv_file.purge
    @user.update(cv_clicks_count: 0)

    redirect_to admin_settings_path, notice: "CV berhasil dihapus dan statistik klik telah di-reset."
  else
    redirect_to admin_settings_path, alert: "Tidak ada CV untuk dihapus."
  end
end

  def track_cv
  @admin = User.first
  if @admin&.cv_file&.attached?
    @admin.increment!(:cv_clicks_count) unless user_signed_in?# Tambah angka 1
    redirect_to url_for(@admin.cv_file), allow_other_host: true
  else
    redirect_to root_path, alert: "CV tidak ditemukan."
  end
  end

def update_avatar
  @user = current_user
  if params[:user] && params[:user][:avatar].present?
    if @user.update(params.require(:user).permit(:avatar))
      redirect_to admin_settings_path, notice: "Foto profil berhasil diperbarui!"
    end
  else
    redirect_to admin_settings_path, alert: "Mohon pilih file gambar terlebih dahulu."
  end
end

def delete_avatar
  @user = current_user
  @user.avatar.purge if @user.avatar.attached?
  redirect_to admin_settings_path, notice: "Foto profil telah dihapus."
end

  private

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
