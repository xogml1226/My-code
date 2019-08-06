package com.sp.user.bbs;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("user.bbs.bbsService")
public class BbsServiceImpl implements BbsService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertBbs(Bbs dto) throws Exception {
		try {
			int bbsSeq=dao.selectOne("user.bbs.bbsSeq");
			dto.setNum(bbsSeq);
			dao.insertData("user.bbs.insertBbs", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Bbs> listBbs(Map<String, Object> map) {
		List<Bbs> list=null;
		try {
			list=dao.selectList("user.bbs.listBbs", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("user.bbs.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Bbs readBbs(int num) {
		Bbs dto=null;
		try {
			dto=dao.selectOne("user.bbs.readBbs", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("user.bbs.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Bbs preReadBbs(Map<String, Object> map) {
		Bbs dto=null;
		try {
			dto=dao.selectOne("user.bbs.preReadBbs", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Bbs nextReadBbs(Map<String, Object> map) {
		Bbs dto=null;
		try {
			dto=dao.selectOne("user.bbs.nextReadBbs", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updataBbs(Bbs dto) throws Exception {
		try {
			dao.updateData("user.bbs.updateBbs", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteBbs(int num) throws Exception {
		try {
			dao.updateData("user.bbs.deleteBbs", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertBbsLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("user.bbs.insertBbsLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int bbsLikeCount(int num) {
		int result=0;
		try {
			result=dao.selectOne("user.bbs.bbsLikeCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			int bbsReplySeq=dao.selectOne("user.bbs.bbsReplySeq");
			dto.setReplyNum(bbsReplySeq);
			dao.insertData("user.bbs.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list=null;
		try {
			list=dao.selectList("user.bbs.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(int num) {
		int result=0;
		try {
			result=dao.selectOne("user.bbs.replyCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("user.bbs.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list=null;
		try {
			list=dao.selectList("user.bbs.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result=0;
		try {
			result=dao.selectOne("user.bbs.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("user.bbs.insertReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int replyLikeCount(int replyNum) {
		int result=0;
		try {
			result=dao.selectOne("user.bbs.replyLikeCount", replyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
