package com.productos.negocio;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Carrito implements Serializable {
    public static class Item implements Serializable {
        private int idProducto;
        private String nombre;
        private int cantidad;
        private double precio;
        private double valorOferta;
        private boolean enOferta;

        public Item(int idProducto, String nombre, int cantidad, double precio, double valorOferta, boolean enOferta) {
            this.idProducto = idProducto;
            this.nombre = nombre;
            this.cantidad = cantidad;
            this.precio = precio;
            this.valorOferta = valorOferta;
            this.enOferta = enOferta;
        }
        // Getters y setters
        public int getIdProducto() { return idProducto; }
        public String getNombre() { return nombre; }
        public int getCantidad() { return cantidad; }
        public double getPrecio() { return precio; }
        public double getValorOferta() { return valorOferta; }
        public boolean isEnOferta() { return enOferta; }
        public void setCantidad(int cantidad) { this.cantidad = cantidad; }
    }

    private List<Item> items;

    public Carrito() {
        items = new ArrayList<>();
    }

    public void agregarProducto(int idProducto, String nombre, int cantidad, double precio, double valorOferta, boolean enOferta) {
        // Si el producto ya está en el carrito, suma la cantidad
        for (Item item : items) {
            if (item.getIdProducto() == idProducto) {
                item.setCantidad(item.getCantidad() + cantidad);
                return;
            }
        }
        items.add(new Item(idProducto, nombre, cantidad, precio, valorOferta, enOferta));
    }

    public List<Item> getItems() {
        return items;
    }

    public void limpiar() {
        items.clear();
    }

    public void eliminarProducto(int idProducto) {
        items.removeIf(item -> item.getIdProducto() == idProducto);
    }

    public double getTotal() {
        double total = 0;
        for (Item item : items) {
            if (item.isEnOferta()) {
                total += item.getValorOferta() * item.getCantidad();
            } else {
                total += item.getPrecio() * item.getCantidad();
            }
        }
        return total;
    }
}
