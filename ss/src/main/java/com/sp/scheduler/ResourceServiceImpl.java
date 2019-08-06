package com.sp.scheduler;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("scheduler.resourceService")
public class ResourceServiceImpl implements ResourceService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertResourceGroup(Resource dto) throws Exception {
		try {
			dao.insertData("scheduler.insertResourceGroup", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateResourceGroup(Resource dto) throws Exception {
		try {
			dao.updateData("scheduler.updateResourceGroup", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteResourceGroup(int groupNum) throws Exception {
		try {
			dao.deleteData("scheduler.deleteResourceGroup", groupNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Resource readResourceGroup(int groupNum) {
		Resource dto=null;
		try{
			dto=dao.selectOne("scheduler.readResourceGroup", groupNum);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public List<Resource> listResourceGroup() {
		List<Resource> list=null;
		try {
			list=dao.selectList("scheduler.listResourceGroup");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void insertResourceList(Resource dto) throws Exception {
		try {
			dao.insertData("scheduler.insertResourceList", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateResourceList(Resource dto) throws Exception {
		try {
			dao.updateData("scheduler.updateResourceList", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteResourceList(int resourceNum) throws Exception {
		try {
			dao.deleteData("scheduler.deleteResourceList", resourceNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Resource readResourceList(int resourceNum) {
		Resource dto=null;
		try{
			dto=dao.selectOne("scheduler.readResourceList", resourceNum);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public List<ResourceJSON> listResourceList() {
		List<ResourceJSON> list=null;
		try {
			list=dao.selectList("scheduler.listResourceList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Resource> listResourceList(int groupNum) {
		List<Resource> list=null;
		try {
			list=dao.selectList("scheduler.listResourceList2", groupNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public void insertResourceScheduler(Resource dto) throws Exception {
		try {
			dao.insertData("scheduler.insertResourceScheduler", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateResourceScheduler(Resource dto) throws Exception {
		try {
			dao.updateData("scheduler.updateResourceScheduler", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteResourceScheduler(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("scheduler.deleteResourceScheduler", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Resource readResourceScheduler(int num) {
		Resource dto=null;
		try{
			dto=dao.selectOne("scheduler.readResourceScheduler", num);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public List<ResourceJSON> listResourceScheduler(Map<String, Object> map) {
		List<ResourceJSON> list=null;
		try {
			list=dao.selectList("scheduler.listResourceScheduler", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
