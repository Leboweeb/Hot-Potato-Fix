SMODS.Joker {
    key = "iou",
    config = {
        extra = {
            bitcoins = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.bitcoins
            }
        }
    end,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 4,
    atlas = "hc_jokers",
    pos = {x = 7, y = 0},
    pixel_size = {w = 71, h = 71},
    hotpot_credits = {
        art = {"pangaea47"},
        code = {"Nxkoo"},
        team = {"Horsechicot"}
    },
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            return {
                remove = true,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            ease_cryptocurrency(2)
                            return true
                        end
                    }))
                end
            }
        end
    end
}
