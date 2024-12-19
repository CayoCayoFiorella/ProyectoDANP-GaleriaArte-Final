//
//  GaleriaViewController.swift
//  Conexion
//
//  Created by Fiorella on 9/12/24.
//

import Foundation
import UIKit
class GaleriaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var galerias: [Galeria] = []  // Aquí almacenaremos las galerías obtenidas
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchGalerias()  // Llamamos a la función para obtener las galerías
    }
    
    // Función para obtener las galerías de Supabase
    private func fetchGalerias() {
        let client = Manager.shared.client
        
        client.from("galerias").select(columns: ["id", "nombre"]).execute { result in
            switch result {
            case .success(let response):
                // Mapeamos la respuesta a objetos Galeria
                if let galeriasData = response.data as? [[String: Any]] {
                    self.galerias = galeriasData.compactMap { data in
                        guard let id = data["id"] as? Int,
                              let nombre = data["nombre"] as? String else { return nil }
                        return Galeria(id: id, nombre: nombre, autor: "", urlImagen: "")
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()  // Recargamos la tabla
                }
            case .failure(let error):
                print("Error al obtener galerías: \(error.localizedDescription)")
            }
        }
    }
    
    // Métodos de UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galerias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GaleriaCell", for: indexPath)
        let galeria = galerias[indexPath.row]
        cell.textLabel?.text = galeria.nombre
        return cell
    }
    
    // Método para manejar la selección de una galería (opcional)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGaleria = galerias[indexPath.row]
        print("Seleccionaste la galería: \(selectedGaleria.nombre)")
    }
}
