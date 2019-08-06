package com.sp.owner.hotplace;

import java.util.List;
import java.util.Map;

public interface HotplaceService {
	public void insertHotplace(Hotplace dto, String pathname) throws Exception;
	public List<Hotplace> listHotplace(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public void deleteHotplace(int placeNum, String placePhoto, String pathName) throws Exception;
	public Hotplace readHotplace(int placeNum);
	public void updateHotplace(Hotplace dto, String pathname) throws Exception;
}
