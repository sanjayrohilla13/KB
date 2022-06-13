// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © sanjayrohilla

//@version=4
strategy("Bullish-Engulfing", overlay=true)

//Get user input
tradeQty = input(title="Trade Qty", type=input.integer, defval=50)

//Entry Conditions
threeRed = close[1] < open[1] and close[2] < open[2] and close[3] < open[3]

oneRed = close[1] < open[1]

bullishEng = close > open and close >= open[1] and open <= close[1] 

//Exit Variables
tradeDay5 = close[5] > open[5] and close[5] >= open[6] and open[5] <= close[6]

buySignal1 = oneRed and bullishEng and not threeRed
sl=low
buySignal3 = threeRed and bullishEng

//Execute the trade
var day_count = 1
var exitPosition = false

strategy.entry(id="long", long=strategy.long, qty=tradeQty, when = buySignal3)
if strategy.position_size != 0
    day_count  := day_count  + 1
    
exitPosition := day_count == 5 or low < sl

//strategy.exit(id="exit_long", from_entry="long", qty=tradeQty, stop=sl, limit=close, when = day_count == 5)
strategy.exit(id="exit_long", from_entry="long", qty=tradeQty, stop=sl, limit=close, when = exitPosition)
if strategy.position_size == 0
    day_count  := 1



---------------------------------------
// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © sanjayrohilla

//@version=5
strategy("momentum-investing")

//Get user input
tradeQty = input(title="Trade Qty", type=input.integer, defval=100)

myCMO = ta.cmo(close, 10)

exitTrade = myCMO < -25
enterTrade = myCMO > -25

strategy.entry("long", strategy.long, qty=tradeQty, when = enterTrade)
strategy.exit("Exit Long", from_entry="long",qty=tradeQty, limit=close, when = exitTrade)

plot (myCMO)