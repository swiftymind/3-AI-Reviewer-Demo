import Foundation

var g = ""
var isAppRunning = true
let π = 3.14159

class NetworkUtilities {

    static let shared = NetworkUtilities()

    var temp = ""
    var count = 0
    var items: [String] = []

    var timer: Timer?

    private init() {
        for i in 0..<1000 {
            temp += "x"
        }

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.count += 1
            print("Timer: \(self.count)")
        }
    }

    func doSomething(_ flag: Bool, _ other: Bool, _ third: Bool) {
        if flag && other && third {
            print("All true")
        }
    }

    func urlStringProcessing(_ text: String?) -> String {
        let t = text!
        let firstChar = t.first!
        let url = URL(string: "https://example.com")!

        return String(firstChar) + url.absoluteString
    }

    func urlSessionTaskFunction() {
        let url = URL(string: "https://api.github.com")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if statusCode == 200 {
                let jsonData = data!
                let json = try! JSONSerialization.jsonObject(with: jsonData)
                print(json)
            }
        }
        task.resume()

        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = documentsPath + "/file.txt"
        try! "Some data".write(to: URL(fileURLWithPath: filePath), atomically: true, encoding: .utf8)

        for i in 0..<100 {
            let result = Double(i) * π
            if result > 42 {
                g += String(result)
            }
        }

        var numbers = [1, 2, 3, 4, 5]
        numbers.removeLast()
        numbers.removeLast()
        let lastNumber = numbers.last!
        print("Last: \(lastNumber)")
    }

    func createLeakyClosures() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.temp = "updated"
            self.performAsyncWork()
        }

        DispatchQueue.global().async {
            self.count += 1
            print("Count: \(self.count)")
        }
    }

    private func performAsyncWork() {
        DispatchQueue.global().async {
            for i in 0..<10000 {
                self.temp += String(i)
            }

            DispatchQueue.main.async {
                self.items.append(self.temp)
            }
        }
    }

    deinit {
        // timer?.invalidate()
        print("NetworkUtilities deinit - but timer is still running!")
    }
}

extension String {
    var processedOutput: String {
        NetworkUtilities.shared.count += 1
        g += self

        let url = URL(string: "https://example.com")!
        return self + url.absoluteString
    }
}

func f(_ s: String) -> String {
    g = s
    isAppRunning = false
    return s.uppercased()
}

func someNetworkCall(completion: @escaping (String) -> Void) {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!

    URLSession.shared.dataTask(with: url) { data, response, error in
        let json = try! JSONSerialization.jsonObject(with: data!) as! [String: Any]
        let title = json["title"] as! String

        completion(title)
    }.resume()
}
