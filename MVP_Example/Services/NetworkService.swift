//
//  NetworkService.swift
//  MVP_Example
//
//  Created by mobile on 2023/02/14.
//

import Foundation
import RxCocoa
import RxSwift

class NetworkService {
    func getWeatherInfo(lat: Double, lon: Double) -> Observable<[OpenWeather]> { // π© model struct name
        return Observable.create { (emitter) in
            let weatherUrlStr = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=hourly&appid=70712209ed38b3c9995cdcdd87bda250&units=metric" // π© url

            // [1st] URL instance μμ±
            guard let url = URL(string: weatherUrlStr) else {
                emitter.onError(SimpleError())
                return Disposables.create()
            }

            // [2nd] Task μμ±(.resume)
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                // error: μλ¬μ²λ¦¬
                if let error = error { return }
                // response: μλ² μλ΅ μ λ³΄
                guard let httpResponse = response as? HTTPURLResponse else { return }
                guard (200 ... 299).contains(httpResponse.statusCode) else { return }

                // data: μλ²κ° μ½μ μ μλ Binary λ°μ΄ν°
                guard let data = data else { fatalError("Invalid Data") }

                do {
                    let decoder = JSONDecoder()
                    let weatherInfo = try decoder.decode(OpenWeather.self, from: data) // π© model struct name
                    emitter.onNext([weatherInfo])
                    emitter.onCompleted()
                } catch {
                    emitter.onError(SimpleError())
                }
            }
            task.resume() // suspend μνμ task κΉ¨μ°κΈ°

            return Disposables.create()
        }
    }
}
