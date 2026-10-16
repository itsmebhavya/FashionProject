package com.fashionproject.dao;

import com.fashionproject.model.Cart;

public interface CartDAO {

    void clearCart(int cartId) throws Exception;

    boolean createCart(int userId);

    Cart getCartById(int cartId);

    Cart getCartByUserId(int userId);

    Cart getOrCreateCartByUserId(int userId);

    boolean deleteCart(int cartId);

    boolean cartExistsByUserId(int userId);
}