SMODS.Voucher {
    key = "bitcoin_miner",
    config = {
        bitcoins = 0.5
    },
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.bitcoins
            }
        }
    end,
    atlas = "hc_vouchers",
    pos = {x = 0, y = 0},
    calc_crypto_bonus = function(self, card)
        if G.GAME.blind_on_deck == "Boss" then
            return card.ability.bitcoins
        end
    end,
    Horsechicot.credit("lord.ruby", "lord.ruby", "lord.ruby")
}

SMODS.Voucher {
    key = "crypto_farm",
    config = {
        bitcoins = 0.5
    },
    atlas = "hc_vouchers",
    pos = {x = 1, y = 0},
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.bitcoins
            }
        }
    end,
    calc_crypto_bonus = function(self, card)
        if G.GAME.blind_on_deck ~= "Boss" then
            return card.ability.bitcoins
        end
    end,
    requires = {'v_hpot_bitcoin_miner'},
    Horsechicot.credit("lord.ruby", "lord.ruby", "lord.ruby")
}

function Horsechicot.spawning_blocked(center)
    if G.GAME.ante_banned and G.GAME.ante_banned[center.key] then return true end
    return center and G.GAME.spawning_blocked and G.GAME.spawning_blocked[center.key] or nil
end

SMODS.Voucher {
    key = "antibodies",
    atlas = "hc_vouchers",
    pos = {x = 0, y = 1},
    redeem = function()
       G.GAME.spawning_blocked = G.GAME.spawning_blocked or {}
       G.GAME.spawning_reset = "round"
    end,
    Horsechicot.credit("lord.ruby", "lord.ruby", "cg223")
}

SMODS.Voucher {
    key = "vaccination",
    atlas = "hc_vouchers",
    pos = {x = 1, y = 1},
    redeem = function()
       G.GAME.spawning_blocked = G.GAME.spawning_blocked or {}
       G.GAME.spawning_reset = "ante"
    end,
    requires = {'v_hpot_antibodies'},
    Horsechicot.credit("lord.ruby", nil, "cg223")
}

local create_cardref = create_card
function create_card(...)
    local card = create_cardref(...)
    if card.config.center.set == "Joker" and G.GAME.spawning_blocked then
        G.GAME.spawning_blocked[card.config.center_key] = true
    end
    return card
end


--main implementation for these is in the black_market.lua file
SMODS.Voucher {
    key = "hc_dark_connections",
    atlas = "hc_vouchers",
    pos = {x = 0, y = 2},
    hotpot_credits = Horsechicot.credit("cg223"),
    config = {
        pct = 25
    },
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.pct}}
    end,
    redeem = function (self, voucher)
        G.GAME.dark_connections = true
        for i, v in pairs((G.market_jokers or {}).cards or {}) do
            v:set_cost()
        end
    end,
}

SMODS.Voucher {
    key = "hc_underground_control",
    atlas = "hc_vouchers",
    pos = {x = 1, y = 2},
    hotpot_credits = Horsechicot.credit("cg223"),
    config = {
        pct = 25
    },
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.pct}}
    end,
    redeem = function (self, voucher)
        G.GAME.underground_control = true
    end,
    requires = {'v_hpot_hc_dark_connections'}
}

--main functionality for these is located in the nursery files
SMODS.Voucher {
    key = "hc_parthenogenesis", 
    hotpot_credits = Horsechicot.credit("cg223", "lord.ruby"),
    redeem = function (self, voucher)
        G.GAME.guaranteed_breed_center = "mother"
    end,
    atlas = "hc_vouchers",
    pos = {x = 0, y = 3},
}

SMODS.Voucher {
    key = "hc_incubator",
    hotpot_credits = Horsechicot.credit("cg223", "lord.ruby"),
    redeem = function (self, voucher)
        G.GAME.quick_preggo = true
    end,
    requires = {"v_hpot_hc_parthenogenesis"},
    atlas = "hc_vouchers",
    pos = {x = 1, y = 3},
}