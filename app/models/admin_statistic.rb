class AdminStatistic < ApplicationRecord
    EVENTS = {
        total_users: "TOTAL_USERS",
        total_questions: "TOTAL_QUESTIONS"
    }

    # Scopes
    scope :total_users, -> {
        find_by_event(EVENTS[:total_users]).value
    }

    scope :total_questions, -> {
        find_by_event(EVENTS[:total_questions]).value
    }

    # Class Methods
    def self.set_event(event)
        admins_statistic = AdminStatistic.find_or_create_by(event: event)
        admins_statistic.value += 1
        admins_statistic.save
    end
end
