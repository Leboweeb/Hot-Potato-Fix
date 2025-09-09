SMODS.Joker {
    key = "folded",
    atlas = "hc_jokers",
    pos = {x=4,y=0},
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { unscoring = 3, mult = 20 } },
    calculate = function(self, card, context)
        if context.joker_main and (#context.full_hand - #context.scoring_hand) > card.ability.extra.unscoring then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.mult,
            card.ability.extra.unscoring
        }}
    end,
    hotpot_credits = Horsechicot.credit("Lily Felli"),
    pixel_size = { w = 71, h = 62 },
}