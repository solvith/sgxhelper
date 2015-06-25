<h1>SGX Helper for useful Retail investor analytics</h1>
Contact me at james@solvith.com<br/>
http://www.solvith.com

<h2>Getting package</h2>
require("devtools")<br/>
require("TTR")<br/>
require("XML")<br/>
require("quantmod")<br/>
require("rjson")<br/>


install_github("solvith/sgxhelper")


<br/><br/>
<h2>Features</h2>
<ul>
<li>getSGXStocks() - Get list of stocks and ticker from SGX market</li>
<li>
getYahooPrice  - get historical adjusted price for a stock
e<-new.env()<br/>
getYahooPrice(e,Symbols = "Z74.SI",from = "2015-01-01")<br/>
e$Z74.SI
</li>
<li>
getGooglePrice(symbol = "Z74",period = "1d",freq = 60) - Get Intraday price of singtel , 60s interval
</li>
</ul>