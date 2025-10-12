SMODS.Joker {
    key = "antidsestablishmentarianism",
    rarity = 2,
    cost = 4,
    config = {
        extra = {
        }
    },
    atlas = "hc_jokers",
    pos = {x = 0, y = 1},
    loc_vars = function(self, info_queue, card)
    end,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    hotpot_credits = {
        art = {"pangaea47"},
        code = {"Nxkoo"},
        team = {"Horsechicot"}
    },
    calculate = function(self, card, context)
        if context.after and context.main_eval and not context.blueprint then
            if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
                local all_debuffed = true
                for _, played_card in ipairs(G.play.cards) do
                    if not played_card.debuff then
                        all_debuffed = false
                        break
                    end
                end
                if all_debuffed and #G.play.cards > 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if to_big(G.GAME.chips - G.GAME.blind.chips) >= to_big(0) then return true end
                            G.GAME.blind:disable()
                            play_sound('tarot1', 1.0)
                            card:juice_up(0.5, 0.5)
                            return true
                        end
                    }))
                    return {
                        message = localize('ph_boss_disabled'),
                        colour = G.C.RED,
                        delay = 0.7
                    }
                end
            end
        end
    end
}