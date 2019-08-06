package com.sp.owner.reservation;

import java.util.List;
import java.util.Map;

public interface ReservationService {
	public List<Reservation> select(Map<String, Object> map);
}
