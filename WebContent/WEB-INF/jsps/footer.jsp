<%@page import="java.util.Calendar"%>
<%@page import="model.FamilySiteModel"%>
<%@page import="java.util.List"%>
<%@page import="model.SetupModel"%>
<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserDAO uDao = new UserDAO();
	SetupModel setup = uDao.selectSetup();
	List<FamilySiteModel> listFS = uDao.selectListFamilySite();
	uDao.dbClose();
	
	Calendar cal = Calendar.getInstance();
	String curDate = String.format("%04d-%02d-%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1, cal.get(Calendar.DAY_OF_MONTH));
%>
<head>

<script type="text/javascript">
$(function(){
	$.datepicker.regional['ko'] = {
		closeText: '닫기',
		prevText: '이전',
		nextText: '다음',
		currentText: '오늘',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true,
		changeMonth: true,
		changeYear: true,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#rec_request_date").datepicker();
	$("#rec_request_date").datepicker('setDate', '<%=curDate %>');

});


</script>
</head>
	<footer>
       <div class="inner">
           <div class="wrap clearfix">
               <div class="list-wrap clearfix">
                   <div class="col">
                       <h5>기타문의</h5>
                       <ul>
                           <li><button class="master-btn" type="button">마스터 지원하기</button></li>
                           <li><a href="mailto:<%=setup.getEmail()%>">비즈니스 및 제휴</a></li>
                       </ul>
                   </div>
                   <div class="col">
                       <h5>고객센터</h5>
                       <ul>
                           <li>전화 : <%=setup.getContact() %> (월-금 09:30~18:30시)</li>
                           <li>이메일 : <a href="mailto:<%=setup.getEmail()%>"><%=setup.getEmail() %> </a></li>
                       </ul>
                   </div>
               </div>
               <div class="select-box">
                   <div class="wrap">
                       <span>Family Site</span>
                       <img src="./images/arrow-down-gr.png" alt="이미지">
                   </div>
                   <ul class="select-list">
                       <li class="close">
                           <div class="wrap">
                               <span>Family Site</span>
                               <img src="./images/arrow.png" alt="이미지">
                           </div>
                       </li>
                       <%for(int i=0; i<listFS.size(); i++){ %>
                       		<li><a href="<%=listFS.get(i).getLink() %>" target="_blank" ><%=listFS.get(i).getName() %></a></li>
                       <%} %>
                   </ul>
               </div>
           </div>
           <div class="wrap clearfix">
               <div class="infor-wrap">
                   <p><%=setup.getCompanyName() %> | 사업자등록번호 : <%=setup.getCompanyNum() %> | 대표 : 김태영<br>
                      <%=setup.getAddress() %></p>
                   <ul class="clearfix">
                       <li><a href="information">개인정보처리방침</a></li>
                   </ul>
               </div>
               <div class="newsletter">
                   <p>프로업의 최신정보를 메일로 받아보세요.</p>
                   <div style="height: 5px;"></div>
                       <input type="email" id="subscribe_email" name="newsletter-email" placeholder="이메일을 입력해주세요.">
                       <button type="button" onclick="javascript: subscribeSubmit();">SEND</button>
                   
               </div>
           </div>
       </div>
   </footer>
   
   <div class="quick-btn">
        <div class="wrap clearfix">
            <div class="icon">
                <img src="./images/mail.png" alt="문의하기">
            </div>
            <span>문의하기</span>
        </div>
    </div>
    
    <div class="quick-contents-back modal-back">
        <div class="quick-contents modal">
            <img class="quick-close-btn close-btn" src="./images/close-modal.png" alt="닫기">
            <div class="inner">
                <h2>문의하기</h2>
                <input type="text" id="contact_name" name="name" placeholder="성명">
                <input type="text" id="contact_company" name="company" placeholder="회사명">
                <input type="text" id="contact_email" name="mail" placeholder="이메일">
                <input type="text" id="contact_contact" name="number" placeholder="연락처">
                <input type="text" id="contact_target" name="target" placeholder="교육대상자">
                <textarea name="text-contens" id="contact_content" placeholder="문의내용"></textarea>
                <div class="terms-wrap">
                    <input class="checkbox a11y" type="checkbox" id="termscheck">
                    <label for="termscheck">
                        <span></span>
                    </label>
                    <a href="javascript: contactAgree();" >개인정보 및 이용약관에 동의합니다.</a>
                </div>
                <button class="submit-btn" type="button" onclick="javascript: contactSubmit();">문의하기</button>
            </div>
        </div>
    </div>
    
    
    
    
    <!-- 교육 제안서 -->
    <div class="master-back modal-back">
        <div class="master-contents modal">
            <img class="master-close-btn close-btn" src="images/close-modal.png" alt="닫기">
            <div class="inner">
                <ul class="pagination clearfix">
                    <li class="active" id="modal_step_master_1"></li>
                    <li id="modal_step_master_2"></li>
                    <li id="modal_step_master_3"></li>
                    <li id="modal_step_master_4"></li>
                </ul>
               
                <div class="modal-wrap">
                    <ul class="modal-ul clearfix" id="modal_ul_master">
                        <li class="modal-li">
                            <h2>마스터 등록</h2>
                            <div class="modal-container">
                                <div class="col">
                                    <p class="onepg-text">나누고 싶은 <strong>지식과 전문성</strong>을<br>
                                        보유하고 있다면 누구나<br>
                                        프로스쿨의 <strong>마스터</strong>가 될 수 있습니다.</p>
                                </div>
                                <a href="javascript: modalNextBtnM();" class="modal-next-btn">다음</a>
                            </div>
                        </li>
                        <li class="modal-li">
                            <h2>CO-WORK PROCESS</h2>
                            <div class="modal-container">
                                <div class="col">
                                    <ul class="list-wrap clearfix">
                                        <li>
                                            <div class="text-wrap">
                                                <p class="step">STEP 01</p>
                                                <p class="title">등록하기</p>
                                                <p class="contents">강의분야, 주요이력, 학력, 저서,
                                                    주요활동 등의 내용이 포함된
                                                    프로필을 첨부파일로 등록</p>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="text-wrap">
                                                <p class="step">STEP 02</p>
                                                <p class="title">사전미팅</p>
                                                <p class="contents">프로필 내부 검토 후1차 미팅을
                                                    통해 실무협의 진행</p>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="text-wrap">
                                                <p class="step">STEP 03</p>
                                                <p class="title">계약체결</p>
                                                <p class="contents">서비스 유형, 범위, 기간 등
                                                    상호협력을 위한 계약체결</p>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="text-wrap">
                                                <p class="step">STEP 04</p>
                                                <p class="title">콘텐츠 브랜딩</p>
                                                <p class="contents">서비스 유형에 따라 교육
                                                    콘텐츠 초기 전략 기획부터
                                                    5단계 프로세스를 통한
                                                    콘텐츠 기획, 개발 검증
                                                    절차 실행</p>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="text-wrap">
                                                <p class="step">STEP 05</p>
                                                <p class="title">홍보 마케팅</p>
                                                <p class="contents">프로스쿨 사이트 외
                                                    다양한 채널을 통한
                                                    홍보마케팅 / 세일즈</p>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="text-wrap">
                                                <p class="step">STEP 05</p>
                                                <p class="title">매니지먼트</p>
                                                <p class="contents">평가 시스템을 통한
                                                    콘텐츠 품질 관리</p>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <a href="javascript: modalNextBtnM();" class="modal-next-btn">다음</a>
                            </div>
                        </li>
                        <li class="modal-li">
                            <h2>MASTER BENEFIT</h2>
                            <div class="modal-container">
                                <div class="col">
                                    <ul class="list-wrap clearfix">
                                        <li>
                                            <div class="text-wrap">
                                                <img src="images/benefit01.png" alt="아이콘">
                                                <p class="title">BRANDING</p>
                                                <p class="contents">전략적 교육 콘텐츠
                                                    개발을 통한
                                                    마스터 브랜딩 완성</p>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="text-wrap">
                                                <img src="images/benefit02.png" alt="아이콘">
                                                <p class="title">MARKETING</p>
                                                <p class="contents">다양한 온오프라인
                                                    채널을 통한
                                                    홍보 마케팅 / 세일즈 전략</p>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="text-wrap">
                                                <img src="images/benefit03.png" alt="아이콘">
                                                <p class="title">ASSET VALUE</p>
                                                <p class="contents">암호화폐 ‘프로토큰’
                                                    보상체계를 통한
                                                    경제적 자산 가치 상승</p>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="text-wrap">
                                                <img src="images/benefit04.png" alt="아이콘">
                                                <p class="title">MANAGEMENT</p>
                                                <p class="contents">프로스쿨의 전문 기획자와
                                                    협력하여 지속적인 콘텐츠
                                                    Develop & Management
                                                    서비스 제공</p>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <a href="javascript: modalNextBtnM();" class="modal-next-btn">다음</a>
                            </div>
                        </li>
                        <li class="modal-li">
                            <h2>마스터 지원하기</h2>
                            <div class="modal-container">
                                <div class="col">
                                    <input type="text" id="apply_name" name="apply_name" placeholder="성명">
                                    <input type="text" id="apply_company" name="apply_company" placeholder="회사명">
                                    <input type="text" id="apply_email" name="apply_email" placeholder="이메일">
                                    <input type="text" id="apply_contact" name="apply_contact" placeholder="연락처">
                                    <input type="text" id="apply_target" name="apply_target" placeholder="교육대상자">
                                    <div class="file-wrap clearfix">
                                        <input class="upload-name" value="파일선택" disabled="disabled">
                                        <input class="upload-hidden a11y" type="file" id="file" name="file" onchange="javascript: applyFileUpload('file');">
                                        <input type="hidden" id="file_data">
                                        <label for="file">업로드</label>
                                    </div>
                                    <div class="terms-wrap">
                                        <input class="checkbox a11y" type="checkbox" id="termscheck_">
                                        <label for="termscheck_">
                                            <span></span>
                                        </label>
                                        <a href="javascript: applyAgree();" >개인정보 및 이용약관에 동의합니다.</a>
                                    </div>

                                </div>
                                <a href="javascript: applySubmit();" class="modal-next-btn submit-btn">등록하기</a>
                                <div class="notice">
                                    <p>※ 유의사항</p>
                                    <ul class="notice-wrap">
                                        <li>
                                            1. 마스터 파일첨부에는 (협력가능한 강의분야, 주요 이력, 학력, 경력, 저서, 교육 프로그램 간단 소개) 등의 내용을
                                            포함하여 첨부파일로 제출해주시기 바랍니다.
                                        </li>
                                        <li>
                                            2. 등록이 완료된 마스터 정보는 내부 절차를 통해 검토 후 선별적으로 연락 드립니다.
                                        </li>
                                        <li>
                                            3. 당사에 제공된 프로필 정보는 내부 검토용으로 사용될 뿐 외부로 공개되지 않습니다.
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                
            </div>
        </div>
    </div>
    
    
    
    
    
    
    
    
    <div class="education-back modal-back a11y">
        <div class="education-contents modal">
            <img class="education-close-btn close-btn" src="images/close-modal.png" alt="닫기">
            <div class="inner">
                <ul class="pagination clearfix">
                    <li class="active" id="modal_step_1"></li>
                    <li id="modal_step_2"></li>
                    <li id="modal_step_3"></li>
                    <li id="modal_step_4"></li>
                    <li id="modal_step_5"></li>
                    <li id="modal_step_6"></li>
                </ul>
               
                 <div class="modal-wrap">
                     <ul class="modal-ul clearfix" id="modal_ul">
                         <li class="modal-li">
                             <h2>교육 추천 받기</h2>
                             <div class="modal-container">
                                 <div class="col">
                                     <p class="title">01. 강의 분야</p>
                                     <div class="radio-list">
                                         <input class="radio a11y" type="radio" id="education0101"
                                             name="rec_category" value="디지털 혁신">
                                         <label for="education0101">
                                             <span class="btn"></span>
                                             <span>디지털 혁신</span>
                                         </label>
                                     </div>
                                     <div class="radio-list">
                                         <input class="radio a11y" type="radio" id="education0102"
                                             name="rec_category" value="직무역량">
                                         <label for="education0102">
                                             <span class="btn"></span>
                                             <span>직무역량</span>
                                         </label>
                                     </div>
                                     <div class="radio-list">
                                         <input class="radio a11y" type="radio" id="education0103"
                                             name="rec_category" value="라이프">
                                         <label for="education0103">
                                             <span class="btn"></span>
                                             <span>라이프</span>
                                         </label>
                                     </div>
                                     <p class="title">02. 교육 목적</p>
                                     <textarea name="text-contens" id="rec_purpose" placeholder="내용을 입력해주세요."></textarea>
                                 </div>
                                 <a href="javascript: modalNextBtn(1);" class="modal-next-btn">다음</a>
                             </div>
                         </li>
                         <li class="modal-li">
                             <div class="modal-container">
                                 <div class="col">
                                     <p class="title">03. 교육 대상자</p>
                                     <ul class="radio-wrap">
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0301"
                                                     name="rec_target" value="사원">
                                                 <label for="education0301">
                                                     <span class="btn"></span>
                                                     <span>사원</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0302"
                                                      name="rec_target" value="부장">
                                                 <label for="education0302">
                                                     <span class="btn"></span>
                                                     <span>부장</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0303"
                                                      name="rec_target" value="대리">
                                                 <label for="education0303">
                                                     <span class="btn"></span>
                                                     <span>대리</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0304"
                                                      name="rec_target" value="임원">
                                                 <label for="education0304">
                                                     <span class="btn"></span>
                                                     <span>임원</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0305"
                                                      name="rec_target" value="과장">
                                                 <label for="education0305">
                                                     <span class="btn"></span>
                                                     <span>과장</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0306"
                                                      name="rec_target" value="기타">
                                                 <label class="other-label" for="education0306">
                                                     <span class="btn"></span>
                                                     <span>기타</span>
                                                 </label>
                                                 <input class="other-input" type="text" placeholder="내용입력"
                                                      id="rec_target_other" >
                                             </div>
                                         </li>
                                     </ul>
                                     <p class="title">04. 교육 대상자 직무</p>
                                     <textarea name="text-contens" id="rec_target_position" placeholder="내용을 입력해주세요."></textarea>
                                 </div>
                                 <a href="javascript: modalNextBtn(2);" class="modal-next-btn">다음</a>
                             </div>
                         </li>
                         <li class="modal-li">
                             <div class="modal-container">
                                 <div class="col">
                                     <p class="title">05. 교육 시간</p>
                                     <ul class="radio-wrap width-auto">
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0701"
                                                     name="rec_hour" value="1H">
                                                 <label for="education0701">
                                                     <span class="btn"></span>
                                                     <span>1H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0702"
                                                     name="rec_hour" value="2H">
                                                 <label for="education0702">
                                                     <span class="btn"></span>
                                                     <span>2H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0703"
                                                     name="rec_hour" value="3H">
                                                 <label for="education0703">
                                                     <span class="btn"></span>
                                                     <span>3H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0704"
                                                     name="rec_hour" value="4H">
                                                 <label for="education0704">
                                                     <span class="btn"></span>
                                                     <span>4H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0705"
                                                     name="rec_hour" value="5H">
                                                 <label for="education0705">
                                                     <span class="btn"></span>
                                                     <span>5H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0706"
                                                     name="rec_hour" value="6H">
                                                 <label for="education0706">
                                                     <span class="btn"></span>
                                                     <span>6H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0707"
                                                     name="rec_hour" value="7H">
                                                 <label for="education0707">
                                                     <span class="btn"></span>
                                                     <span>7H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0708"
                                                     name="rec_hour" value="8H">
                                                 <label for="education0708">
                                                     <span class="btn"></span>
                                                     <span>8H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0710"
                                                     name="rec_hour" value="9H">
                                                 <label for="education0710">
                                                     <span class="btn"></span>
                                                     <span>9H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0711"
                                                     name="rec_hour" value="10H">
                                                 <label for="education0711">
                                                     <span class="btn"></span>
                                                     <span>10H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0712"
                                                     name="rec_hour" value="11H">
                                                 <label for="education0712">
                                                     <span class="btn"></span>
                                                     <span>11H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0713"
                                                     name="rec_hour" value="12H">
                                                 <label for="education0713">
                                                     <span class="btn"></span>
                                                     <span>12H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0714"
                                                     name="rec_hour" value="13H">
                                                 <label for="education0714">
                                                     <span class="btn"></span>
                                                     <span>13H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0715"
                                                     name="rec_hour" value="14H">
                                                 <label for="education0715">
                                                     <span class="btn"></span>
                                                     <span>14H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0716"
                                                     name="rec_hour" value="15H">
                                                 <label for="education0716">
                                                     <span class="btn"></span>
                                                     <span>15H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0717"
                                                     name="rec_hour" value="16H">
                                                 <label for="education0717">
                                                     <span class="btn"></span>
                                                     <span>16H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0718"
                                                     name="rec_hour" value="17H">
                                                 <label for="education0718">
                                                     <span class="btn"></span>
                                                     <span>17H</span>
                                                 </label>
                                             </div>
                                         </li>
                                         <li class="radio-li">
                                             <div class="radio-list">
                                                 <input class="radio a11y" type="radio" id="education0719"
                                                     name="rec_hour" value="기타">
                                                 <label class="other-label hour-label" for="education0719">
                                                     <span class="btn"></span>
                                                     <span>기타</span>
                                                 </label>
                                                 <input class="other-input hour-other" id="rec_hour_other" type="text" placeholder="내용입력">
                                             </div>
                                         </li>
                                     </ul>
                                 </div>
                                 <a href="javascript: modalNextBtn(3);" class="modal-next-btn">다음</a>
                             </div>
                         </li>
                         <li class="modal-li">
                             <div class="modal-container">
                                 <div class="col">
                                     <p class="title">06. 교육비 예산</p>
                                     <textarea name="text-contens" id="rec_price" placeholder="내용을 입력해주세요."></textarea>
                                     <p class="title">07. 교육 장소</p>
                                     <textarea name="text-contens" id="rec_place" placeholder="내용을 입력해주세요."></textarea>
                                     <p class="title">08. 교육 요청일</p>
                                     <div class="datepicker-wrap">
                                         <input type="text" id="rec_request_date">
                                     </div>
                                 </div>
                                 <a href="javascript: modalNextBtn(4);" class="modal-next-btn">다음</a>
                             </div>
                         </li>
                         <li class="modal-li">
                             <div class="modal-container">
                                 <div class="col">
                                     <p class="title">09. 교육 운영</p>
                                     <div class="radio-list">
                                         <input class="radio a11y" type="radio" id="education1101"
                                             name="rec_manage" value="직접운영">
                                         <label for="education1101">
                                             <span class="btn"></span>
                                             <span>직접운영</span>
                                         </label>
                                     </div>
                                     <div class="radio-list">
                                         <input class="radio a11y" type="radio" id="education1102"
                                             name="rec_manage" value="위탁운영">
                                         <label for="education1102">
                                             <span class="btn"></span>
                                             <span>위탁운영</span>
                                         </label>
                                     </div>
                                     <p class="title">10. 요청사항</p>
                                     <textarea name="text-contens" id="rec_request" placeholder="내용을 입력해주세요."></textarea>
                                     <p class="title">11. 회사명</p>
                                     <input class="email" type="text" id="rec_company" name="target" placeholder="회사명을 입력해주세요.">
                                     <p class="title">12. 연락처</p>
                                     <input class="email" type="text" id="rec_contact" name="target" placeholder="연락처를 입력해주세요.">
                                     <p class="title">13. 이메일</p>
                                     <input class="email" type="text" id="rec_email" name="target" placeholder="이메일을 입력해주세요.">
                                     <div class="terms-wrap">
                                         <input class="checkbox a11y" type="checkbox" id="termscheck_ed">
                                         <label for="termscheck_ed" >
                                             <span></span>
                                         </label>
                                         <a href="javascript: recommandAgree();" >개인정보 및 이용약관에 동의합니다.</a>
                                     </div>
                                 </div>
                                 <a href="javascript: modalNextBtn(5);" class="modal-next-btn">다음</a>
                             </div>
                         </li>
                         <li class="modal-li last-li">
                             <div class="modal-container">
                                 <div class="col">
                                     <img src="images/check.png" alt="체크">
                                     <p class="complete">제안서 요청이 완료되었습니다.</p>
                                     <p class="notice"><%=setup.getRecommand() %></p>
									
                                     <div class="swiper-container modal-slider">
                                         <div class="swiper-wrapper" id="modal_swiper_masters">
                                             
                                         </div>
                                         <div class="swiper-pagination"></div>
                                     </div>
                                 </div>
                                 <a href="javascript: void(0);" class="modal-next-btn submit-btn">종료하기</a>
                             </div>
                         </li>
                     </ul>
                 </div>
               
            </div>
        </div>
    </div>
    
    