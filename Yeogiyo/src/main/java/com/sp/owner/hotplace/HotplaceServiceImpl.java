package com.sp.owner.hotplace;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("owner.hotplace.hotplaceServiceImpl")
public class HotplaceServiceImpl implements HotplaceService{

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager filemanager;
	
	@Override
	public void insertHotplace(Hotplace dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("owner.hotplace.seq");
			dto.setPlaceNum(seq);

			if(! dto.getUpload().isEmpty()) {
				MultipartFile mf = dto.getUpload();
				String saveFilename = filemanager.doFileUpload(mf, pathname);
				if(saveFilename!=null) {
					dto.setPlacePhoto(saveFilename);
				}
					
			}
			
			dao.insertData("owner.hotplace.insertHotplace", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Hotplace> listHotplace(Map<String, Object> map){
		List<Hotplace> list = null;
		
		try {
			list = dao.selectList("owner.hotplace.selectHotplace", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("owner.hotplace.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteHotplace(int placeNum, String placePhoto, String pathName) throws Exception {
		try {
			//파일 지우기
			filemanager.doFileDelete(placePhoto,pathName);
			
			//디비의 파일정보 삭제
			dao.deleteData("owner.hotplace.deleteHotplace", placeNum);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Hotplace readHotplace(int placeNum) {
		Hotplace dto = null;
		try {
			dto = dao.selectOne("owner.hotplace.readHotplace", placeNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateHotplace(Hotplace dto, String pathname) throws Exception {
		try {
			
			
			if(! dto.getUpload().isEmpty()) {
				filemanager.doFileDelete(dto.getPlacePhoto(),pathname);
				MultipartFile mf = dto.getUpload();
				String saveFilename = filemanager.doFileUpload(mf, pathname);
				
				if(saveFilename!=null) {
					dto.setPlacePhoto(saveFilename);
				}
				
			}
			dao.updateData("owner.hotplace.updateHotplace",dto);	
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
