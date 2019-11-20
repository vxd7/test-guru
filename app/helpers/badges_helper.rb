module BadgesHelper
  BADGE_IMAGES = Dir.glob("#{Rails.root}/public/images/badges/*").map do |p|
    Pathname(p).basename.to_s
  end

  def avaliable_pictures
    BADGE_IMAGES.map do |img_name|
      File.join('badges', img_name)
    end
  end

  def avaliable_rules
    full_descr = BadgesService::RULES.map do |rule|
      [I18n.t(".badges.badges_service.rules.#{rule}"), rule]
    end
  end
end
