//
//  TradingViewChartView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 05/05/2021.
//

import Foundation


fileprivate let firstPart = """
    
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0">

    <body style="background-color:rgba(18,23,34,255);">
    
    <div class="tradingview-widget-container">
      <div id="tradingview_bab73"></div>
      <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/symbols/NASDAQ-AAPL/" rel="noopener" target="_blank"><span class="blue-text">AAPL Chart</span></a> by TradingView</div>
      <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
      <script type="text/javascript">
      new TradingView.widget(
    """

fileprivate let secondPart = """
       );
       </script>
     </div>
     </body>
     """

enum TradingViewChartInterval: String {
    
    case minute1 = "1"
    case minute3 = "3"
    case minute5 = "5"
    case minute15 = "15"
    case minute30 = "30"
    case hour1 = "60"
    case hour2 = "120"
    case hour3 = "180"
    case hour4 = "240"
    case day = "D"
    case week = "W"
}

enum TradingViewChartExchange: String {
    
    case binance = "BINANCE"
    case bitfinex = "BITFINEX"
    case coinbase = "COINBASE"
}

enum TradingViewChartTheme: String {
    
    case dark = "dark"
    case light = "light"
}


class TradingViewChart {
    
    var symbol: String!
    var theme: TradingViewChartTheme!
    var exchange: TradingViewChartExchange!
    var interval: TradingViewChartInterval
    
    init(symbol: String, exchange: TradingViewChartExchange, theme: TradingViewChartTheme, interval: TradingViewChartInterval) {
        
        self.symbol = symbol
        self.exchange = exchange
        self.theme = theme
        self.interval = interval
    }

    func getMinimizedChart() -> String {
        
        let params = ["autosize":true, "symbol":exchange.rawValue + ":" + symbol, "interval":interval.rawValue, "timezone":"Etc/UTC", "theme":theme.rawValue, "style":"1", "local":"en", "toolbar_bg":"#f1f3f6", "enable_publishing":false, "hide_top_toolbar":true, "hide_legend": true, "save_image": false, "container_id": "tradingview_bab73"] as [String : Any]
        
        do {
            let json = try params.toJson()
            
            print(firstPart + json + secondPart)
            return firstPart + json + secondPart
        } catch {
            return ""
        }
    }
    
    func getFullChart() -> String {
        
        let params = ["autosize":true, "symbol":exchange.rawValue + ":" + symbol, "interval":interval.rawValue, "timezone":"Etc/UTC", "theme":theme.rawValue, "style":"1", "local":"en", "toolbar_bg":"#f1f3f6", "enable_publishing":false, "withdateranges": true, "hide_legend":false, "hide_top_toolbar": true, "save_image":true, "container_id": "tradingview_bab73",
                      "studies":["MACD@tv-basicstudies"]] as [String : Any]
        do {
            let json = try params.toJson()
            
            print(firstPart + json + secondPart)
            return firstPart + json + secondPart
        } catch {
            return ""
        }
    }
    
    
}


extension Dictionary {
    
    /// Convert Dictionary to JSON string
    /// - Throws: exception if dictionary cannot be converted to JSON data or when data cannot be converted to UTF8 string
    /// - Returns: JSON string
    func toJson() throws -> String {
        let data = try JSONSerialization.data(withJSONObject: self)
        if let string = String(data: data, encoding: .utf8) {
            return string
        }
        throw NSError(domain: "Dictionary", code: 1, userInfo: ["message": "Data cannot be converted to .utf8 string"])
    }
}


//{
//"autosize": true,
//"symbol": "BINANCE:VETUSDT",
//"interval": "D",
//"timezone": "Etc/UTC",
//"theme": "light",
//"style": "1",
//"locale": "en",
//"toolbar_bg": "#f1f3f6",
//"enable_publishing": false,
//"hide_top_toolbar": true,
//"hide_legend": true,
//"save_image": false,
//"container_id": "tradingview_bab73"
//}


