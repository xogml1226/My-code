package com.sp.user.wishlist;

import java.util.List;
import java.util.Map;

import com.sp.user.hotel.Hotel;

public interface WishListService {
	public List<WishList> list(Map<String, Object> map);
	public List<Hotel> checkuserIdlist(String userId);
	public int wishlistCount(Map<String, Object> map);
	
	
	public void deletewishlist(Map<String, Object> map) throws Exception;
	public int insertwishlist(Map<String, Object> map) throws Exception;
	
}
