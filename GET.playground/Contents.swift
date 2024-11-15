import Foundation

// MARK: - Configuración de la URL y la solicitud
let url = URL(string: "https://apple.com")!
var request = URLRequest(url: url)
request.httpMethod = "GET"

// MARK: - Ejecución de la solicitud
let task = URLSession.shared.dataTask(with: request) { data, response, error in
    
    // MARK: - Manejo de errores
    // Verifica si hay errores
    if let error = error {
        print("Error en la solicitud: \(error)")
        return
    }
    
    // Verifica que haya recibido datos
    guard let data = data else {
        print("Datos no recibidos")
        return
    }
    
    // MARK: - Manejo del tipo de contenido de la respuesta
    // Verifica el tipo de contenido de la respuesta
    if let httpResponse = response as? HTTPURLResponse,
       let contentType = httpResponse.allHeaderFields["Content-Type"] as? String {
        print("Content-Type de la respuesta: \(contentType)")
    }
    
    // MARK: - Decodificación de la respuesta
    // Intenta decodificar los datos como texto en lugar de JSON
    if let responseString = String(data: data, encoding: .utf8) {
        print("Respuesta en texto plano: \(responseString)")
    } else {
        print("No se pudo decodificar la respuesta como texto.")
    }
}

// MARK: - Inicio de la tarea de red
task.resume()
