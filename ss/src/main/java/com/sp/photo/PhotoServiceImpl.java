package com.sp.photo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("photo.photoServiceImpl")
public class PhotoServiceImpl implements PhotoService {
	@Autowired
	private CommonDAO  dao;
	@Autowired
	private FileManager fileManager;

	@Override
	public void insertPhoto(Photo dto, String pathname) throws Exception {
		try {
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setImageFilename(saveFilename);

				dao.insertData("photo.insertPhoto", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("photo.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Photo> listPhoto(Map<String, Object> map) {
		List<Photo> list=null;
		
		try {
			list=dao.selectList("photo.listPhoto", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Photo readPhoto(int num) {
		Photo dto=null;
		
		try {
			dto=dao.selectOne("photo.readPhoto", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Photo preReadPhoto(Map<String, Object> map) {
		Photo dto=null;
		
		try {
			dto=dao.selectOne("photo.preReadPhoto", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Photo nextReadPhoto(Map<String, Object> map) {
		Photo dto=null;
		
		try {
			dto=dao.selectOne("photo.nextReadPhoto", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updatePhoto(Photo dto, String pathname) throws Exception {
		try {
			// 업로드한 파일이 존재한 경우
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
		
			if (saveFilename != null) {
				// 이전 파일 지우기
				if(dto.getImageFilename().length()!=0) {
					fileManager.doFileDelete(dto.getImageFilename(), pathname);
				}
					
				dto.setImageFilename(saveFilename);
			}
			
			dao.updateData("photo.updatePhoto", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deletePhoto(int num, String pathname, String userId) throws Exception {
		try {
			Photo dto=readPhoto(num);
			if(dto==null || (! userId.equals("admin") && ! userId.equals(dto.getUserId())))
				return;
			
			if(dto.getImageFilename()!=null)
				fileManager.doFileDelete(dto.getImageFilename(), pathname);
			
			// 게시물지우기
			dao.deleteData("photo.deletePhoto", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
