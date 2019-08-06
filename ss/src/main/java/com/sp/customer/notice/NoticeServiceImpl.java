package com.sp.customer.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("customer.noticeService")
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertNotice(Notice dto, String pathname) throws Exception {
		try {
			int seq=dao.selectOne("notice.seq");
			dto.setNum(seq);

			dao.insertData("notice.insertNotice", dto);
			
			// 파일 업로드
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						String originalFilename=mf.getOriginalFilename();
						long fileSize=mf.getSize();
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						dto.setFileSize(fileSize);
						
						insertFile(dto);
					}
				}
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
			result=dao.selectOne("notice.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Notice> listNotice(Map<String, Object> map) {
		List<Notice> list=null;
		
		try {
			list=dao.selectList("notice.listNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<Notice> listNoticeTop() {
		List<Notice> list=null;
		
		try {
			list=dao.selectList("notice.listNoticeTop");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Notice readNotice(int num) {
		Notice dto=null;

		try {
			dto=dao.selectOne("notice.readNotice", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("notice.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Notice preReadNotice(Map<String, Object> map) {
		Notice dto=null;

		try {
			dto=dao.selectOne("notice.preReadNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Notice nextReadNotice(Map<String, Object> map) {
		Notice dto=null;

		try {
			dto=dao.selectOne("notice.nextReadNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateNotice(Notice dto, String pathname) throws Exception {
		try {
			dao.updateData("notice.updateNotice", dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						String originalFilename=mf.getOriginalFilename();
						long fileSize=mf.getSize();
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						dto.setFileSize(fileSize);
						
						insertFile(dto);
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteNotice(int num, String pathname) throws Exception {
		try {
			// 파일 지우기
			List<Notice> listFile=listFile(num);
			if(listFile!=null) {
				for(Notice dto:listFile) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			// 파일 테이블 내용 지우기
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("field", "num");
			map.put("num", num);
			deleteFile(map);
			
			dao.deleteData("notice.deleteNotice", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertFile(Notice dto) throws Exception {
		try {
			dao.insertData("notice.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public List<Notice> listFile(int num) {
		List<Notice> listFile=null;
		
		try {
			listFile=dao.selectList("notice.listFile", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listFile;
	}

	@Override
	public Notice readFile(int fileNum) {
		Notice dto=null;
		
		try {
			dto=dao.selectOne("notice.readFile", fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("notice.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
