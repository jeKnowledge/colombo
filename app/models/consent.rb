class Consent < ApplicationRecord
  TYPES = {
    0 => "Terms",
    1 => "Contract",
    2 => "Cookies"
  }
end
