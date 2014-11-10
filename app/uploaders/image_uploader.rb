# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  include Cloudinary::CarrierWave
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process :scale => [400]
  # process :convert => 'png'
  
  def scale(width, height)
    # do something
  end

  def public_id
   Cloudinary::PreloadedFile.split_format(original_filename).first + "_" + Cloudinary::Utils.random_public_id[0,6]
  end
  #Later I guess you can change this to the title of the photo

  # Create different versions of your uploaded files:
  version :thumb do
    # process :resize_to_fit => [50, 50]
    process :resize_to_limit => [100, 100]
  end

  version :bright_face do
    cloudinary_transformation :effect => "brightness:30", :radius => 20,
      :width => 100, :height => 150, :crop => :thumb, :gravity => :face
  end

  # version :moustache_face do
  #   cloudinary_transformation :sign_url => true, :overlay => "FunnyGlasses_xljond", 
  #   :width => 1.7, :flags => "region_relative", :gravity => "rek_eyes", :y => 20
  # end

  version :moustache_face do
    cloudinary_transformation :sign_url => true, :overlay => "moustacheBrown_nv8jae", 
    :width => 0.7, :flags => "region_relative", :gravity => "face", :y => 50
  end

  version :glasses_face do
    cloudinary_transformation :sign_url => true, :overlay => "FunnyGlasses_xljond", 
    :width => 0.9, :flags => "region_relative", :gravity => "face"
  end

  version :glasses_facev2 do
    cloudinary_transformation :sign_url => true, :overlay => "FunnyGlasses_xljond", 
    :width => 1.7, :flags => "region_relative", :gravity => "rek_eyes", :y => 10
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
