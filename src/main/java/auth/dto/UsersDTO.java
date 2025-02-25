package auth.dto;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.ResolverStyle;
import java.util.regex.Pattern;

public class UsersDTO {
    
    private String id; // 아이디 추가
    private String pw;
    private String name; // 이름 추가
    private String nickname;
    private String phone;
    private String email;
    private String rnum;
    private Timestamp joinDate;
    private int warningCount;
    private int withdraw;
    private int status;
    private int isAdmin;
    private Timestamp lastLogin;
    
    public UsersDTO() {
    	
    }
    
    public UsersDTO(String id, String pw,  String nickname,String name, String phone, String email, String rnum,
			int warningCount, int withdraw, int status, int isAdmin) {
		super();
		this.id = id;
		this.pw = pw;
		this.nickname = nickname;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.rnum = rnum;
		this.warningCount = 0;
		this.withdraw = 0;
		this.status = 0;
		this.isAdmin = 0;
	}


    public UsersDTO(String id, String pw, String nickname, String name, String phone, String email, String rnum,
			Timestamp joinDate, int warningCount, int withdraw, int status, int isAdmin,
			Timestamp lastLogin) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.nickname = nickname;
		this.phone = phone;
		this.email = email;
		this.rnum = rnum;
		this.joinDate = joinDate;
		this.warningCount = warningCount;
		this.withdraw = withdraw;
		this.status = status;
		this.isAdmin = isAdmin;
		this.lastLogin = lastLogin;
	}
    
    

	public String getId() {
		return id;
	}

	public String getPw() {
		return pw;
	}
	
	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public String getNickname() {
		return nickname;
	}
	
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}

	public String getRnum() {
		return rnum;
	}
	
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}

	public Timestamp getJoinDate() {
		return joinDate;
	}

	public int getWarningCount() {
		return warningCount;
	}

	public int getWithdraw() {
		return withdraw;
	}

	public int getStatus() {
		return status;
	}

	public int getIsAdmin() {
		return isAdmin;
	}

	public Timestamp getLastLogin() {
		return lastLogin;
	}


	// 유효성 검사 메서드
	public void validate() throws IllegalArgumentException {
	    if (!isValidId(this.id)) {
	        throw new IllegalArgumentException("아이디는 6자 이상, 영어 대소문자와 숫자만 가능합니다.");
	    }
	    if (!isValidPassword(this.pw)) {
	        throw new IllegalArgumentException("비밀번호는 8자 이상, 대소문자와 특수문자를 포함해야 합니다.");
	    }
	    if (!isValidName(this.name)) {
	        throw new IllegalArgumentException("이름은 한글 2~4자여야 합니다.");
	    }
	    if (!isValidNickname(this.nickname)) {
	        throw new IllegalArgumentException("닉네임은 공백과 특수문자를 포함할 수 없습니다.");
	    }
	    if (!isValidPhone(this.phone)) {
	        throw new IllegalArgumentException("핸드폰 번호는 010-XXXX-YYYY 또는 010XXXXXXXX 형식이어야 합니다.");
	    }
	    if (!isValidEmail(this.email)) {
	        throw new IllegalArgumentException("이메일 형식이 올바르지 않습니다.");
	    }
	    if (!isValidRnum(this.rnum)) {
	        throw new IllegalArgumentException("생년월일이 유효하지 않습니다.");
	    }
	}


    //정규표현식 수정 예정 
    //아이디 유효성 검사 (영어 대소문자 구분 없이 숫자 포함 6자 이상)
    private boolean isValidId(String id) {
        return id != null && id.matches("^[a-zA-Z0-9]{6,}$");
    }

    //비밀번호 유효성 검사 (대소문자, 특수문자 포함 8자 이상)
    private boolean isValidPassword(String pw) {
        return pw != null && pw.matches("^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$");
    }

    //이름 유효성 검사 (한글 2~4자)
    private boolean isValidName(String name) {
        return name != null && name.matches("^[가-힣]{2,4}$");
    }

    //닉네임 유효성 검사 (특수문자, 공백 불가능)
    private boolean isValidNickname(String nickname) {
        return nickname != null && nickname.matches("^[a-zA-Z0-9가-힣]{2,10}$");
    }
    
    //핸드폰 번호 유효성 검사 (010-XXXX-YYYY 또는 010XXXXXXXX)
    private boolean isValidPhone(String phone) {
        return phone != null && phone.matches("^01[016789]-?\\d{3,4}-?\\d{4}$");
    }

    //이메일 유효성 검사 (RFC 5322 기반)
    private boolean isValidEmail(String email) {
        return email != null && Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$").matcher(email).matches();
    }

    // YYMMDD 형식의 생년월일 유효성 검사
    public static boolean isValidRnum(String rnum) {
        // 1. null 체크 및 정규식 검사 (6자리 숫자)
        if (rnum == null || !Pattern.compile("^[0-9]{6}$").matcher(rnum).matches()) {
            return false;
        }

        try {
            // 2. YYMMDD → LocalDate 변환 (정확한 날짜 검증)
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd")
                    .withResolverStyle(ResolverStyle.STRICT); // 엄격한 날짜 유효성 검사
            LocalDate birthDate = LocalDate.parse(rnum, formatter);

            // 3. 미래 날짜 방지
            LocalDate today = LocalDate.now();
            if (birthDate.isAfter(today)) {
                return false;
            }

            return true; // 모든 검증 통과
        } catch (Exception e) {
            return false; // 날짜 변환 실패 시 (예: 990230 → 존재하지 않는 날짜)
        }
    }

    // DB 중복 검사 관련 로직은 DAO에서 처리
}
