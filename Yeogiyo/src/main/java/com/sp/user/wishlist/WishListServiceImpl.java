package com.sp.user.wishlist;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;
import com.sp.user.hotel.Hotel;

@Service("user.wishlist.wishlistService")
public class WishListServiceImpl implements WishListService{

	@Autowired
	private CommonDAO dao;

	@Override
	public int wishlistCount(Map<String, Object> map) {
		int count=0;
		
		try {
			count = dao.selectOne("user.wishlist.wishlistCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return count;
	}
	
	@Override
	public List<WishList> list(Map<String, Object> map) {
		List<WishList> list = null;
		try {
			list = dao.selectList("user.wishlist.wishlistList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void deletewishlist(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("user.wishlist.wishlistDelete",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int insertwishlist(Map<String, Object> map) throws Exception {
		int result=0;
		try {
			result=dao.insertData("user.wishlist.wishlistInsert",map);
			
			} catch (Exception e) {
			
				if(e.toString().indexOf("ORA-00001")!=-1) {
						deletewishlist(map);
				}
			}
		return result;	
	}

	@Override
	public List<Hotel> checkuserIdlist(String userId) {
		List<Hotel> list = null;
		try {
			list=dao.selectList("user.wishlist.checkuserIdlist", userId);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return list;
	}
}
