SMODS.Joker {
    key = "notbaddragon",
    atlas = "hc_jokers",
    pos = { x = 2, y = 4 },
    hotpot_credits = {
        art = {"cg223"},
        code = {"Nxkoo"},
        team = {"Horsechicot"}
    },
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 3,
    config = { extra = { mult_per_joker = 3, chips_per_joker = 20 } },
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'hc_nxko_comment2', set = 'Other' }
        local valid_jokers = 0
        if G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card and not (joker.ability.extra and type(joker.ability.extra) == "table" and joker.ability.extra.hpot_mood) then
                    valid_jokers = valid_jokers + 1
                end
            end
        end
        
        return {
            vars = {
                card.ability.extra.mult_per_joker,
                card.ability.extra.chips_per_joker,
                valid_jokers,
                card.ability.extra.mult_per_joker * valid_jokers,
                card.ability.extra.chips_per_joker * valid_jokers
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local valid_jokers = 0
            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card and not (joker.ability.extra and joker.ability.extra.hpot_mood) then
                    valid_jokers = valid_jokers + 1
                end
            end
            return {
                mult = card.ability.extra.mult_per_joker * valid_jokers,
                chips = card.ability.extra.chips_per_joker * valid_jokers
            }
        end
    end
}