package com.sp.photo;

import java.util.List;
import java.util.Map;

public interface PhotoService {
	public void insertPhoto(Photo dto, String pathname) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Photo> listPhoto(Map<String, Object> map);
	public Photo readPhoto(int num);
	public Photo preReadPhoto(Map<String, Object> map);
	public Photo nextReadPhoto(Map<String, Object> map);
	public void updatePhoto(Photo dto, String pathname) throws Exception;
	public void deletePhoto(int num, String pathname, String userId) throws Exception;
}
