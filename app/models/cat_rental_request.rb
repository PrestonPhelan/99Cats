class CatRentalRequest < ApplicationRecord
  STATUS_OPTIONS = %w(PENDING APPROVED DENIED)

  validates :status, inclusion: { in: STATUS_OPTIONS }
  validates :cat_id, :start_date, :end_date, :status, presence: true

  # CUSTOM VALIDATION
  # Request cannot overlap another approved request for same cat
  validate :does_not_overlap_approved_request

  belongs_to :cat

  def pending?
    self.status == "PENDING"
  end

  def approve!
    self.transaction do
      self.status = "APPROVED"
      self.save!
      self.overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  def overlapping_requests
    self.cat.cat_rental_requests
      .where.not([
        "end_date < :start_date OR start_date > :end_date",
        { start_date: self.start_date, end_date: self.end_date }
      ]).where.not(id: self.id)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def does_not_overlap_approved_request
    return if self.status == "DENIED"
    if overlapping_approved_requests.any?
      errors[:base] << "Cat is not available for those dates"
    end
  end
end
