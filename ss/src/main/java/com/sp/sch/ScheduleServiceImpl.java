package com.sp.sch;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("sch.scheduleService")
public class ScheduleServiceImpl implements ScheduleService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertSchedule(Schedule dto) throws Exception {
		try {
			dto.setSday(dto.getSday().replaceAll("-", ""));
			dto.setEday(dto.getEday().replaceAll("-", ""));
			dto.setStime(dto.getStime().replaceAll(":", ""));
			dto.setEtime(dto.getEtime().replaceAll(":", ""));
			if(dto.getAllDay()!=null) {
				dto.setStime("");
				dto.setEtime("");
			}
			
			if(dto.getStime().length()==0&&dto.getEtime().length()==0&&dto.getSday().equals(dto.getEday()))
				dto.setEday("");
			
			if(dto.getRepeat_cycle()!=0) {
				dto.setEday("");
				dto.setStime("");
				dto.setEtime("");
			}
			
			dao.insertData("sch.insertSchedule", dto);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<Schedule> listMonth(Map<String, Object> map) throws Exception{
		List<Schedule> list=null;
		try {
			list=dao.selectList("sch.listMonth", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public List<Schedule> listDay(Map<String, Object> map) throws Exception{
		List<Schedule> list=null;
		try {
			list=dao.selectList("sch.listDay", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public Schedule readSchedule(int num) throws Exception{
		Schedule dto=null;
		try {
			dto=dao.selectOne("sch.readSchedule", num);
			if(dto!=null) {
				String s;
				s=dto.getSday().substring(0, 4)+"-"+dto.getSday().substring(4,6)+"-"+dto.getSday().substring(6);
				dto.setSday(s);
				if(dto.getEday()!=null&&dto.getEday().length()==8) {
					s=dto.getEday().substring(0, 4)+"-"+dto.getEday().substring(4,6)+"-"+dto.getEday().substring(6);
					dto.setEday(s);
				}
				if(dto.getStime()!=null&&dto.getStime().length()==4) {
					s=dto.getStime().substring(0,2)+":"+dto.getStime().substring(2);
					dto.setStime(s);
				}
				if(dto.getEtime()!=null&&dto.getEtime().length()==4) {
					s=dto.getEtime().substring(0,2)+":"+dto.getEtime().substring(2);
					dto.setEtime(s);
				}
				
				String period = dto.getSday();
				if(dto.getStime()!=null&&dto.getStime().length()!=0) {
					period+=" "+dto.getStime();
				}
				if(dto.getEday()!=null&&dto.getEday().length()!=0) {
					period += " ~ " + dto.getEday();
				}
				if(dto.getEtime()!=null&&dto.getEtime().length()!=0) {
					period+=" "+dto.getEtime();
				}
				dto.setPeriod(period);
			}
		} catch (Exception e) {
			throw e;
		}
		return dto;
	}

	@Override
	public void updateSchedule(Schedule dto) throws Exception{
		try {
			dto.setSday(dto.getSday().replaceAll("-", ""));
			dto.setEday(dto.getEday().replaceAll("-", ""));
			dto.setStime(dto.getStime().replaceAll(":", ""));
			dto.setEtime(dto.getEtime().replaceAll(":", ""));
			if(dto.getAllDay()!=null) {
				dto.setStime("");
				dto.setEtime("");
			}
			
			if(dto.getStime().length()==0&&dto.getEtime().length()==0&&dto.getSday().equals(dto.getEday()))
				dto.setEday("");
			
			if(dto.getRepeat_cycle()!=0) {
				dto.setEday("");
				dto.setStime("");
				dto.setEtime("");
			}
			dao.updateData("sch.updateSchedule", dto);
		} catch (Exception e) {
			throw e;
		}

	}

	@Override
	public void deleteSchedule(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("sch.deleteSchedule", map);
		} catch (Exception e) {
			throw e;
		}
	}
}
