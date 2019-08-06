package com.sp.scheduler;

import java.util.List;
import java.util.Map;

public interface ResourceService {
	public void insertResourceGroup(Resource dto) throws Exception;
	public void updateResourceGroup(Resource dto) throws Exception;
	public void deleteResourceGroup(int groupNum) throws Exception;
	public Resource readResourceGroup(int groupNum);
	public List<Resource> listResourceGroup();
	
	public void insertResourceList(Resource dto) throws Exception;
	public void updateResourceList(Resource dto) throws Exception;
	public void deleteResourceList(int resourceNum) throws Exception;
	public Resource readResourceList(int resourceNum);
	public List<ResourceJSON> listResourceList();
	public List<Resource> listResourceList(int groupNum);
	
	public void insertResourceScheduler(Resource dto) throws Exception;
	public void updateResourceScheduler(Resource dto) throws Exception;
	public void deleteResourceScheduler(Map<String, Object> map) throws Exception;
	public Resource readResourceScheduler(int num);
	public List<ResourceJSON> listResourceScheduler(Map<String, Object> map);
}
