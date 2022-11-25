package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Member;

public class MemberDao {
	
	// 관리자 : 멤버레벨수정
	public int updateMemberLevel(Member member) throws Exception {
	
		return 0;
	}
	
	// 관리자 : 멤버수
	public int selectMemberCount() throws Exception {
		
		return  0;
	}
	
	// 관리자 : 멤버 리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception {
		/*
		 ORDER BY createdate DESC
		 */
		return  null;
	}
	
	// 관리자 멤버 강퇴
	public int deleteMemberByAdmin(Member member) throws Exception {
		
		return 0;
	}
	
	//로그인
	public Member login(Member paramMember) throws Exception {
		Member resultMember = null;
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook", "root", "java1234");
		-> DB를 연결하는 코드(명령들)가 Dao 메서드를 거의 공통으로 중복된다.
		-> 중복되는 코드를 하나의 이름(메서드)으로 만들자
		-> 입력값과 반환값 결정해야한다
		-> 입력값X, 반환값은 Connection타입의 결과값이 남아야한다.
		*/
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
			resultMember.setMemberName(rs.getString("memberName"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return resultMember;
	}

	// 회원가입 1.중복확인 2.회원가입
	// 반환값 t:중복 , f:사용가능
	public boolean memberIdCk(String memberId) throws Exception {
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			result = true;
		}
		dbUtil.close(rs, stmt, conn);
		return result;
	}
	// 회원가입
	public int insertMember(Member member) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());

		row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("회원가입 성공");
		} 
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// 비밀번호 확인
	public int pwCk(String memberId, String memberPw) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT * FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, memberPw);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = 1;
			System.out.println("비밀번호 일치---");
		}
		dbUtil.close(rs, stmt, conn);
		return row;
	}
	// 비밀번호 수정 
	public int updatePw(String memberId, String newPw) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ?";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, memberId);
		

		row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("변경 성공---");
		} 

		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// 회원탈퇴
	public int deleteMember(Member member) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		
		row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("탈퇴 성공---");
		} 

		dbUtil.close(null, stmt, conn);
		return row;
	}
	
}