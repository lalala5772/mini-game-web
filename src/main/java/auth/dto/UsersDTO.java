package auth.dto;

import java.sql.Timestamp;

import java.util.regex.Pattern;

import auth.enums.Status;

public class UsersDTO {
    
    private String id; // 아이디 추가
    private String pw;
    private String name; // 이름 추가
    private String nickname;
    private String phone;
    private String email;
    private String rnum;
    private Timestamp birthDate; // 생년월일 추가
    private Timestamp joinDate;
    private int warningCount;
    private String withdraw;
    private int status;
    private Boolean isAdmin;
    private Timestamp lastLogin;



    public UsersDTO(String id, String pw, String name, String nickname, String phone, String email, String rnum,
			Timestamp birthDate, Timestamp joinDate, int warningCount, String withdraw, int status, Boolean isAdmin,
			Timestamp lastLogin) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.nickname = nickname;
		this.phone = phone;
		this.email = email;
		this.rnum = rnum;
		this.birthDate = birthDate;
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

	public String getName() {
		return name;
	}

	public String getNickname() {
		return nickname;
	}

	public String getPhone() {
		return phone;
	}


	public String getEmail() {
		return email;
	}

	public String getRnum() {
		return rnum;
	}

	public Timestamp getBirthDate() {
		return birthDate;
	}

	public Timestamp getJoinDate() {
		return joinDate;
	}

	public int getWarningCount() {
		return warningCount;
	}

	public String getWithdraw() {
		return withdraw;
	}

	public int getStatus() {
		return status;
	}

	public Boolean getIsAdmin() {
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
        if (!isValidBirthDate(this.birthDate)) {
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

    //생년월일 유효성 검사 (Timestamp로 저장)
    private boolean isValidBirthDate(Timestamp birthDate) {
        return birthDate != null && birthDate.getTime() <= System.currentTimeMillis(); // 현재 시간 이전이어야 함
    }

    // DB 중복 검사 관련 로직은 DAO에서 처리
}
