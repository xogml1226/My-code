package com.sp.owner.jungsanD;

import java.util.List;
import java.util.Map;

public interface JungsanDService {
	public void insert(Map<String, Object> map) throws Exception;
	public List<JungsanD> select(Map<String, Object> map);
	public List<JungsanD> selectDay(Map<String, Object> map);
}
