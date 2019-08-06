package com.sp.owner.hotel;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.common.FileManager;
import com.sp.user.member.SessionInfo;

@Controller("owner.hotel.hotelController")
public class HotelController {

	@Autowired
	private HotelService service;

	@RequestMapping(value = "/owner/hotel/viewInfo", method = RequestMethod.GET)
	public String hotelViewInfo(String hotelId, Model model) throws Exception {
		try {
			Hotel dto = service.selectAll(hotelId);
			model.addAttribute("dto", dto);
		} catch (Exception e) {
			model.addAttribute("message", "호텔 정보를 불러오는 데에 실패했습니다.");
			return ".owner.errorSuccess.error";
		}
		return ".owner.hotel.viewInfo";
	}

	@RequestMapping(value = "/owner/hotelRegister/register1", method = RequestMethod.GET)
	public String hotelRegisterForm1(Model model) throws Exception {
		return ".user.hotelRegister.register1";
	}

	@RequestMapping(value = "/owner/hotelRegister/register1", method = RequestMethod.POST)
	public String hotelRegisterSession1(HotelSessionInfo hinfo, Model model, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		try {
			if(info!=null)
				hinfo.setHotelId(info.getUserId());
			session.setMaxInactiveInterval(30 * 60);
			session.setAttribute("basicInfo", hinfo);
			
			System.out.println("Register1");
			System.out.println("호텔 종류: "+hinfo.getTypeNum());
			System.out.println("호텔 크기: "+hinfo.getHotelSize());
			System.out.println("호텔 체크인 시간: "+hinfo.getCheckIn());
			System.out.println("호텔 체크아웃 시간: "+hinfo.getCheckOut());
			System.out.println("호텔 전화번호: "+hinfo.getHotelTel());
			System.out.println("호텔 등급: "+hinfo.getGrade());
			System.out.println("호텔 사업자번호: "+hinfo.getBusinessNum());
			System.out.println();
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "호텔등록 중 오류가 발생했습니다. 다시 시도해주세요.");
			return ".owner.errorSuccess.error";
		}
		return ".user.hotelRegister.register2";
	}
	
	@RequestMapping(value = "/owner/hotelRegister/register2", method = RequestMethod.GET)
	public String hotelRegisterForm2(Model model) throws Exception {
		return ".user.hotelRegister.register2";
	}
	
	@RequestMapping(value = "/owner/hotelRegister/register2", method = RequestMethod.POST)
	public String hotelRegisterSession2(HotelSessionInfo hinfo, Model model, HttpSession session) throws Exception {
		try {
			session.setAttribute("location", hinfo);
			
			System.out.println("Register2");
			System.out.println("호텔 우편번호: "+hinfo.getPostCode());
			System.out.println("호텔 기본 주소: "+hinfo.getAddr1());
			System.out.println("호텔 상세 주소: "+hinfo.getAddr2());
			System.out.println();
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "호텔등록 중 오류가 발생했습니다. 다시 시도해주세요.");
			return ".user.errorSuccess.error";
		}
		return ".user.hotelRegister.register3";
	}
	
	@RequestMapping(value = "/owner/hotelRegister/register3", method = RequestMethod.GET)
	public String hotelRegisterForm3(Model model) throws Exception {
		return ".user.hotelRegister.register3";
	}

	@RequestMapping(value = "/owner/hotelRegister/register3", method = RequestMethod.POST)
	public String hotelRegisterSession3(HotelSessionInfo hinfo, Model model, HttpSession session) throws Exception {
		try {
			session.setAttribute("description", hinfo);
			
			System.out.println("Register3");
			System.out.println("호텔 이름: "+hinfo.getHotelName());
			System.out.println("호텔 소개: "+hinfo.getDetail());
			System.out.println("호텔 준비사항: "+hinfo.getPrepareContent());
			System.out.println();
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "호텔등록 중 오류가 발생했습니다. 다시 시도해주세요.");
			return ".owner.errorSuccess.error";
		}
		return ".user.hotelRegister.register4";
	}

	@RequestMapping(value = "/owner/hotelRegister/register4", method = RequestMethod.GET)
	public String hotelRegisterForm4(Model model) throws Exception {
		return ".user.hotelRegister.register4";
	}
	
	@RequestMapping(value = "/owner/hotelRegister/register4", method = RequestMethod.POST)
	public String hotelRegisterSession4(HotelSessionInfo hinfo, Model model, HttpSession session) throws Exception {
		try {
			session.setAttribute("convenient", hinfo);
			
			System.out.println("Register4");
			for(int i = 0; i < hinfo.getRecommendation().size(); i ++) {
				System.out.println("추천사항: "+hinfo.getRecommendation().get(i));
			}
			
			for(int i = 0; i < hinfo.getInternet().size(); i ++) {
				System.out.println("인터넷: "+hinfo.getInternet().get(i));
			}
			
			for(int i = 0; i < hinfo.getAccess().size(); i ++) {
				System.out.println("접근/출입편의: "+hinfo.getAccess().get(i));
			}
			
			for(int i = 0; i < hinfo.getKitchen().size(); i ++) {
				System.out.println("주방: "+hinfo.getKitchen().get(i));
			}
			
			for(int i = 0; i < hinfo.getConvenient().size(); i ++) {
				System.out.println("편의시설 및 서비스: "+hinfo.getConvenient().get(i));
			}
			
			for(int i = 0; i < hinfo.getSafety().size(); i ++) {
				System.out.println("안전시설: "+hinfo.getSafety().get(i));
			}
			
			for(int i = 0; i < hinfo.getOthers().size(); i ++) {
				System.out.println("기타: "+hinfo.getOthers().get(i));
			}
			
			for(int i = 0; i < hinfo.getOthers().size(); i ++) {
				System.out.println("기타: "+hinfo.getOthers().get(i));
			}
			
			for(int i = 0; i < hinfo.getNotFree().size(); i ++) {
				System.out.println("유료 서비스: "+hinfo.getNotFree().get(i));
			}
			
			for(int i = 0; i < hinfo.getConPrices().size(); i ++) {
				System.out.println("가격: "+hinfo.getConPrices().get(i));
			}
			System.out.println();
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "호텔등록 중 오류가 발생했습니다. 다시 시도해주세요.");
			return ".owner.errorSuccess.error";
		}
		return ".user.hotelRegister.register5";
	}

	@RequestMapping(value = "/owner/hotelRegister/register5", method = RequestMethod.GET)
	public String hotelRegisterForm5(Model model) throws Exception {
		return ".user.hotelRegister.register5";
	}
	
	@RequestMapping(value = "/owner/hotelRegister/register5", method = RequestMethod.POST)
	public String hotelRegisterSession5(HotelSessionInfo hinfo, Model model, HttpSession session) throws Exception {
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if(info!=null)
				hinfo.setHotelId(info.getUserId());
			
			// mainPhoto 이름 어떻게? detail에 넣어야 하는데 어떻게? 세션에 저장하지 말고 바로 인서트
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+"uploads"+File.separator+"photo";
			// service.insertHotelPhoto(hinfo, pathname);
						
			System.out.println("Register6");
			for(int i = 0; i < hinfo.getUploads().size(); i ++) {
				System.out.println("사진: "+hinfo.getUploads().get(i));
			}
			System.out.println("대표 사진: "+hinfo.getMainUpload());
			System.out.println();
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "호텔등록 중 오류가 발생했습니다. 다시 시도해주세요.");
			return ".owner.errorSuccess.error";
		}
		return ".user.hotelRegister.register6";
	}

	@RequestMapping(value = "/owner/hotelRegister/register6", method = RequestMethod.GET)
	public String hotelRegisterForm6(Model model) throws Exception {
		return ".user.hotelRegister.register6";
	}
	
	// NPE 뜸 뭐가 null인지 확인 해보고 그 부분 고치기
	@RequestMapping(value = "/owner/hotelRegister/register6", method = RequestMethod.POST)
	@Transactional
	public String hotelRegisterSubmit(Model model, HttpSession session) throws Exception {
		try {
			Hotel hotel = new Hotel();
			HotelSessionInfo hinfo = new HotelSessionInfo();
			
			// 세션의 배열 HotelSessionInfo 자료형에 저장						
			HotelSessionInfo convenientSession = (HotelSessionInfo) session.getAttribute("convenient");
			hinfo.setRecommendation(convenientSession.getRecommendation());
			hinfo.setInternet(convenientSession.getInternet());		
			hinfo.setAccess(convenientSession.getAccess());						
			hinfo.setKitchen(convenientSession.getKitchen());		
			hinfo.setConvenient(convenientSession.getConvenient());					
			hinfo.setSafety(convenientSession.getSafety());			
			hinfo.setOthers(convenientSession.getOthers());		
			hinfo.setNotFree(convenientSession.getNotFree());		
			hinfo.setConPrices(convenientSession.getConPrices());
			

			// 숙소 종류, 숙소 크기,  체크인 시간, 체크아웃 시간, 전화번호, 숙소 등급, 사업자번호
			HotelSessionInfo basicInfo = (HotelSessionInfo) session.getAttribute("basicInfo");
			hotel.setTypeNum(basicInfo.getTypeNum());
			hotel.setHotelSize(basicInfo.getHotelSize());
			hotel.setCheckIn(basicInfo.getCheckIn());
			hotel.setCheckOut(basicInfo.getCheckIn());
			hotel.setHotelTel(basicInfo.getCheckIn());
			hotel.setGrade(basicInfo.getGrade());
			hotel.setBusinessNum(basicInfo.getBusinessNum());
			hotel.setHotelId(basicInfo.getHotelId());

			// 우편번호, 기본 주소, 상세 주소
			HotelSessionInfo location = (HotelSessionInfo) session.getAttribute("location");
			hotel.setPostCode(location.getPostCode());
			hotel.setAddr1(location.getAddr1());
			hotel.setAddr2(location.getAddr2());
			
			// 숙소명, 숙소 소개, 숙소 준비사항
			HotelSessionInfo description = (HotelSessionInfo) session.getAttribute("description");
			hotel.setHotelName(description.getHotelName());
			hotel.setDetail(description.getDetail());
			hotel.setPrepareContent(description.getPrepareContent());
			
			// 호텔 사진, 호텔 대표 사진
			HotelSessionInfo photo = (HotelSessionInfo)session.getAttribute("photo");
			hotel.setMainUpload(photo.getMainUpload());
			hinfo.setUploads(photo.getUploads());
			
			// 세션 삭제하기
			//session.invalidate();
			session.removeAttribute("basicInfo");
			session.removeAttribute("location");
			session.removeAttribute("description");
			session.removeAttribute("convenient");
			session.removeAttribute("photo");
			
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+"uploads"+File.separator+"photo";
			
			service.insertHotel(hotel);
			service.insertHotelPrepare(hotel);
			service.insertHotelDetail(hotel);
			service.insertConvenient(hotel, hinfo);
			service.insertHotelAddOpt(hotel, hinfo);	

		} catch (Exception e) {
			// 오우너 메인 페이지 넣을 예정 어떻게 어디에 만들지?
			e.printStackTrace();
			model.addAttribute("message", "호텔등록 중 오류가 발생했습니다. 다시 시도해주세요.");
			return ".user.errorSuccess.error";
		}
		model.addAttribute("message", "호텔등록을 성공적으로마쳤습니다. 관리자의 승인을 기다려주세요.");
		return ".owner.errorSuccess.success";
	}

	@RequestMapping(value = "/owner/hotel/editInfo", method = RequestMethod.GET)
	public String hotelEditInfoForm(Model model) {
		return ".owner.hotel.editInfo";
	}

	@RequestMapping(value = "/owner/hotel/editInfo", method = RequestMethod.POST)
	public String hotelEditInfoSubmit(Hotel hotel, Model model) {
		try {
			service.updateHotel(hotel);
			service.updateHotelAddOpt(hotel);
			service.updateHotelDetail(hotel);
			// service.updateHotelPhoto(hotel);
			service.updateHotelPrepare(hotel);
			service.updateConvenient(hotel);
			service.updateRoom(hotel);
			service.updateRoomDetail(hotel);
			// service.updateRoomPhoto(hotel);
		} catch (Exception e) {
			model.addAttribute("message", "호텔정보를 갱신하는 데에 실패했습니다.");
			return ".owner.errorSuccess.error";
		}
		return ".owner.hotel.viewInfo";
	}

	@RequestMapping(value = "/owner/hotel/exit", method = RequestMethod.GET)
	public String hotelExitForm(Model model) {
		return ".owner.hotel.exit";
	}

	@RequestMapping(value = "/owner/hotel/exit", method = RequestMethod.POST)
	public String hotelExitSubmit(String hotelId, Model model) {
		try {
			service.updateRequest(hotelId);
		} catch (Exception e) {
			model.addAttribute("message", "탈퇴신청 도중 문제가 발생했습니다.");
			return ".owner.errorSuccess.error";
		}
		return ".owner.hotel.viewInfo";
	}
	
	@RequestMapping(value = "/owner/errorSuccess/error", method = RequestMethod.GET)
	public String error(Model model) throws Exception {
		return ".owner.errorSuccess.error";
	}
	
	@RequestMapping(value = "/owner/errorSuccess/success", method = RequestMethod.GET)
	public String success(Model model) throws Exception {
		return ".owner.errorSuccess.success";
	}
	
	@RequestMapping(value="/owner/hotelDetail/roomDetail", method= RequestMethod.GET)
	public String roomDetail() {
		return ".owner.hotelDetail.roomDetail";
	}
}
