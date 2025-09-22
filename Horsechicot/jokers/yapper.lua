SMODS.Joker {
    key = "yapper",
    hotpot_credits = Horsechicot.credit("cg223", "lord.ruby", "cg223"),
    rarity = 1,
    cost = 4,
    config = {
        current = HPJTTT.text[1],
        amt = 2
    },
    atlas = "hc_jokers",
    pos = { x = 0, y = 4 },
    loc_vars = function (self, info_queue, card)
        if not G.jokers or G.SETTINGS.paused then
            return self:collection_loc_vars(info_queue, card)
        end
        return {vars = { card.ability.amt, card.ability.current or HPJTTT.text[1], string.len(card.ability.current) * card.ability.amt}}
    end,
    collection_loc_vars = function(self, info_queue, card)
        local str = pseudorandom_element(HPJTTT.text, "hc_yapper_collection")
        return {vars = { card.ability.amt, str, string.len(str) * card.ability.amt}}
    end,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    calculate = function (self, card, context)
        if context.after then
            card.ability.current = pseudorandom_element(HPJTTT.text, "hc_yapper")
            return {
                message = localize("k_hotpot_reset_ex")
            }
        elseif context.joker_main then
            return {
                mult = string.len(card.ability.current) * card.ability.amt
            }
        end
    end
}