package com.sp.owner.jungsanM;

import java.util.List;
import java.util.Map;

public interface JungsanMService {
	public void insert(Map<String, Object> map) throws Exception;
	public List<JungsanM> select(Map<String, Object> map);
	public List<JungsanM> selectDay(Map<String, Object> map);
}
