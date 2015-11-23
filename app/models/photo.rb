class Photo < ActiveRecord::Base

  belongs_to        :user
  belongs_to        :restaurant
  belongs_to        :stash
  has_one           :photo_pricetag
  has_one           :pricetag, through: :photo_pricetag
  has_many          :foodtags, through: :foodtag_photos
  has_many          :foodtag_photos

  has_attached_file :image,
                    #url: "/system/:hash.:extension",
                    #hash_secret: "abc123",
                    #preserve_files: "true",
                    styles: { thumb: ["64x64#", :jpg],
                              original: ['500x500>', :jpg] },
                    convert_options: { thumb: "-quality 75 -strip",
                                       original: "-quality 85 -strip" }
  validates_attachment :image, presence: true,
                       content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                       size: { in: 0..500.kilobytes }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


  def image_url
    self.image.url
  end

  def image_path
    image.path(:medium)
  end

  # def card_stats
  #   self.
  # end

  def associate_to_foodtags(tag_list)
    tag_list.each do |tag_name|
      new_tag = Foodtag.find_or_create_by(description: tag_name.strip)
      unless self.foodtags.include?(new_tag)
        self.foodtags << new_tag
      end
    end
  end

end
