import Foundation

// MARK: - Configuración de la URL y la solicitud POST
let url = URL(string: "https://apple.com")! // URL de Apple (o cualquier otra API)
var request = URLRequest(url: url)
request.httpMethod = "POST"
request.setValue("application/json", forHTTPHeaderField: "Content-Type")

// MARK: - Datos a enviar en el cuerpo de la solicitud
let parameters: [String: Any] = [
    "key1": "value1",
    "key2": "value2"
]

do {
    // Serialización de parámetros a JSON
    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
} catch let error {
    print("Error al serializar parámetros: \(error)")
}

// MARK: - Ejecución de la solicitud POST
let task = URLSession.shared.dataTask(with: request) { data, response, error in
    
    // MARK: - Manejo de errores de la solicitud
    if let error = error {
        print("Error en la solicitud: \(error)")
        return
    }
    
    // Verifica que los datos hayan sido recibidos
    guard let data = data else {
        print("Datos no recibidos")
        return
    }
    
    // MARK: - Verificación del tipo de contenido de la respuesta
    if let httpResponse = response as? HTTPURLResponse,
       let contentType = httpResponse.allHeaderFields["Content-Type"] as? String {
        print("Content-Type de la respuesta: \(contentType)")
        
        // MARK: - Decodificación de la respuesta según el tipo de contenido
        if contentType.contains("application/json") {
            // Si la respuesta es JSON, intenta decodificarla
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                print("Respuesta JSON o fragmento: \(jsonResponse)")
            } catch let jsonError {
                print("Error al decodificar JSON: \(jsonError)")
            }
        } else {
            // Si la respuesta no es JSON, intenta decodificarla como texto
            if let responseString = String(data: data, encoding: .utf8) {
                print("Respuesta en texto plano: \(responseString)")
            } else {
                print("No se pudo decodificar la respuesta como texto.")
            }
        }
    }
}

// MARK: - Inicio de la tarea de red
task.resume()
