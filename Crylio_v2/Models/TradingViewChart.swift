//
//  TradingViewChartView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 05/05/2021.
//

import Foundation

class TradingViewChart {
    
    static let firstPart = """
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0">

    <div class="tradingview-widget-container">
      <div id="tradingview_bab73"></div>
      <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/symbols/NASDAQ-AAPL/" rel="noopener" target="_blank"><span class="blue-text">AAPL Chart</span></a> by TradingView</div>
      <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
      <script type="text/javascript">
      new TradingView.widget(
    """
    
    static let secondPart = """
       );
       </script>
     </div>
     """

    static func getChart(exchange: String, symbol: String, interval: String, theme: String) -> String {
        
        let params = ["autosize":true, "symbol":exchange + ":" + symbol, "interval":interval, "timezone":"Etc/UTC", "theme":theme, "style":"1", "local":"en", "toolbar_bg":"#f1f3f6", "enable_publishing":false, "hide_top_toolbar":true, "hide_legend": true, "save_image": false, "container_id": "tradingview_bab73"] as [String : Any]
        
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
