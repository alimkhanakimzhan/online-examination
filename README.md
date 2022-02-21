Appendix
config.php
1.	<?php  
2.	#configure the shortcut name  
3.	DEFINE ('BASE_URL', 'index.php?'); #change this if needed  
4.	//DEFINE ('BASE_URL', 'http://localhost/online_exam_by_alimkhan/index.php?'); #change this if needed  
5.	DEFINE ('HOME_DIR', dirname( realpath(__FILE__)) );  
6.	DEFINE ('BASE_DIR', basename(HOME_DIR));  
7.	DEFINE ('LIB_DIR', HOME_DIR . '/libraries');  
8.	DEFINE ('CLASS_DIR', LIB_DIR . '/classes/');  
9.	DEFINE ('MODEL_DIR', HOME_DIR . '/models/');  
10.	DEFINE ('VIEW_DIR', HOME_DIR . '/views/');  
11.	DEFINE ('CONTROLLER_DIR', HOME_DIR . '/controllers/');  
12.	DEFINE ('DATABASE_DIR', LIB_DIR . '/database/');  
13.	DEFINE ('CONT_EXT','Controller.php');  
14.	DEFINE ('CORE_DIR',LIB_DIR . '/core/');  
15.	DEFINE ('EXT', '.php');  
16.	#DATABASE CONFIGURATION  
17.	DEFINE ('DB_HOST','localhost');  
18.	DEFINE ('DB_USER','root');  
19.	DEFINE ('DB_PASS','');  
20.	DEFINE ('DB_NAME','online_exam');  
21.	DEFINE ('DB_PORT','3306');  
22.	#DATABASE PREFIX  
23.	//DEFINE ('cool_forum', 'cool_school_');  
24.	#DEFAULT CONTROLLER / ACTION  
25.	DEFINE ('default_controller','index');   
26.	DEFINE ('default_action','mainAction');   
27.	#load libraries needed  
28.	require_once (CLASS_DIR . 'Session' . EXT);  
29.	require_once (CORE_DIR . 'Common' . EXT);  
30.	require_once (DATABASE_DIR . 'Db' . EXT);  
31.	require_once (CORE_DIR . 'Controller' . EXT);  
32.	require_once (CORE_DIR . 'Router' . EXT);  
33.	?>  
index.php
1.	<?php  
2.	include_once 'config.php';  
3.	class request_handler{  
4.	    public function request_handler(){  
5.	        //require_once (LIB_DIR . 'config' .EXT);  
6.	        $route = new Router;  
7.	        $session = new Session;  
8.	        $segments = $route->urlRoute();  
9.	        #check if controller/action exist  
10.	        #if not use default_controller / default_action  
11.	        if( count($segments) == 0 || count($segments) == 1 ){  
12.	            include_class_method( default_controller , default_action );  
13.	        }else{  
14.	        #if controller/action exist in the url  
15.	        #then check the controller if it's existed in the file  
16.	            if( file_exists( CONTROLLER_DIR . $segments[0] . CONT_EXT ) )  
17.	            {  
18.	                #check for segments[1] = actions  
19.	                #if segments[1] exist, logically segments[0] which is the controller is also exist!!  
20.	                //if( isset($segments[1]) ){  
21.	                    include_class_method( $segments[0], $segments[1] . 'Action' );  
22.	                //}  
23.	            }else{  
24.	                errorHandler(CONTROLLER_DIR . $segments[0] . CONT_EXT);  
25.	            }  
26.	        }  
27.	    }  
28.	}  
29.	$rh = new request_handler;  
30.	?>  
adminController.php
1.	<?php  
2.	Class adminController extends _Controller {  
3.	    /*for users*/  
4.	    public function indexAction(){  
5.	  
6.	    }  
7.	    public function usersAction(){  
8.	        $this->load->view('scripts/admin/users');  
9.	          
10.	    }  
11.	  
12.	    public function usersaddAction(){  
13.	        //  $menu = $this->load->model('LayoutModel');  
14.	        $admin = $this->load->model('adminModel');  
15.	        $result = $admin->loadDepartmentandRole();  
16.	        $this->load->view('scripts/admin/usersadd',$result);  
17.	    }  
18.	  
19.	    public function saveusernewAction(){  
20.	        $admin = $this->load->model('adminModel');  
21.	        $user_fname =  $this->set->post('fname');  
22.	        $user_lname =  $this->set->post('lname');  
23.	        $user_name =  $this->set->post('user_name');  
24.	        $user_password = md5( $this->set->post('password'));  
25.	        $role_id = $this->set->post('role_id');  
26.	        $department_id =  $this->set->post('dept_id');  
27.	        $enabled =   isset($_POST['u_enable']) ? 1 : 0;  
28.	        $ischecker = isset($_POST['u_examchecker']) ? 1 : 0;  
29.	        $user_id = $_SESSION['user_id'];  
30.	        $admin->addnewuser($user_fname,$user_lname,$user_name,$user_password,$role_id,$department_id,$enabled,$user_id,$ischecker);  
31.	          
32.	    }  
33.	    public function userupdateAction(){  
34.	        $admin = $this->load->model('adminModel');  
35.	        $user_fname =  $this->set->post('fname');  
36.	        $user_lname =  $this->set->post('lname');  
37.	        $user_name =  $this->set->post('user_name');  
38.	        $role_id = $this->set->post('role_id');  
39.	        $department_id =  $this->set->post('dept_id');  
40.	        $enabled =   isset($_POST['u_enable']) ? 1 : 0;  
41.	        $ischecker = isset($_POST['u_examchecker']) ? 1 : 0;  
42.	        $user_id = $_SESSION['user_id'];  
43.	        $edit_id = $this->set->post('edit_id');  
44.	        $admin->userupdate($user_fname,$user_lname,$user_name,$role_id,$department_id,$enabled,$user_id,$edit_id,$ischecker);  
45.	    }  
46.	    public function userupdate2Action(){  
47.	        $admin = $this->load->model('adminModel');  
48.	        $edit_id = $this->set->post('edit_id');  
49.	        $change_pass = $this->set->post('change_pass');  
50.	        $admin->userupdate2($edit_id, $change_pass);  
51.	  
52.	    }  
53.	    public function userslistAction(){  
54.	        $admin = $this->load->model('adminModel');  
55.	        $result = $admin->loadUsers();  
56.	        $this->load->view('scripts/admin/index',$result);  
57.	    }  
58.	    public function usereditAction(){  
59.	        $admin = $this->load->model('adminModel');  
60.	        $user_id = $this->set->get('user_id');  
61.	        $result = $admin->loadDepartmentandRole();  
62.	        $result['user'] = $admin->selectuser($user_id);  
63.	        $result['user_id'] = $user_id;  
64.	        $this->load->view('scripts/admin/users-edit',$result);  
65.	    }  
66.	  
67.	    public function userdeleteAction(){  
68.	        $admin = $this->load->model('adminModel');  
69.	        $user_id = $this->set->get('user_id');  
70.	        $admin->userdelete($user_id);  
71.	    }  
72.	  
73.	    /* end users */  
74.	    /*sign up*/  
75.	    public function signupnewAction(){  
76.	        $admin = $this->load->model('adminModel');  
77.	        $result['department'] = $admin->loadDepartment();  
78.	        $this->load->view('scripts/admin/sign-up',$result);  
79.	    }  
80.	    public function signupaddAction(){  
81.	        $admin = $this->load->model('adminModel');  
82.	        $user_fname =  sanitize($this->set->post('fname'));  
83.	        $user_lname =  sanitize($this->set->post('lname'));  
84.	        $user_name =  sanitize($this->set->post('user_name'));  
85.	        $department_id =  sanitize($this->set->post('dept_id'));  
86.	        $user_password = md5(sanitize($this->set->post('password')));  
87.	        $admin->signupadd($user_fname,$user_lname,$user_name,$user_password,$department_id);  
88.	        //header("Location:" . BASE_URL);  
89.	    }  
90.	    /* end sign up*/  
91.	    /*for department*/  
92.	    public function departmentsAction(){  
93.	        $this->load->view('scripts/admin/departments');  
94.	    }  
95.	    public function departmentsaddAction(){  
96.	        $this->load->view('scripts/admin/departments-add');  
97.	    }  
98.	    public function savedepartmentnewAction(){  
99.	        $admin = $this->load->model('adminModel');  
100.	        $department_code = $this->set->post('department_code');  
101.	        $department_name = $this->set->post('department_name');  
102.	        $admin->savedepartmentnew($department_code,$department_name);  
103.	    }  
104.	    public function departmentlistAction(){  
105.	        $admin = $this->load->model('adminModel');  
106.	        $result = $admin->loadDepartment();  
107.	        $this->load->view('scripts/admin/department_list',$result);  
108.	    }  
109.	    public function departmenteditAction(){  
110.	        $admin = $this->load->model('adminModel');  
111.	        $department_id = $this->set->get('department_id');  
112.	        $result = $admin->departmentedit($department_id);  
113.	        $this->load->view('scripts/admin/departments-edit',$result);  
114.	    }  
115.	    public function departmentupdateAction(){  
116.	        $admin = $this->load->model('adminModel');  
117.	        $department_id = $this->set->post('department_id');  
118.	        $department_name = $this->set->post('department_name');  
119.	        $admin->departmentupdate($department_id, $department_name);  
120.	    }  
121.	    public function departmentdeleteAction(){  
122.	        $admin = $this->load->model('adminModel');  
123.	        $department_id = $this->set->get('department_id');  
124.	        $admin->departmentdelete($department_id);  
125.	    }  
126.	    /*end department*/  
127.	    /*for exam */  
128.	    public function examsAction(){  
129.	        $this->load->view('scripts/admin/exams');  
130.	    }  
131.	    public function examsaddAction(){  
132.	        $admin = $this->load->model('adminModel');  
133.	        $result['department'] = $admin->loadDepartment();  
134.	        $this->load->view('scripts/admin/exams-add',$result);  
135.	    }  
136.	    public function saveexamsnewAction(){  
137.	        $admin = $this->load->model('adminModel');  
138.	        $exam_name = $this->set->post('exam_name');  
139.	        $exam_from = $this->set->post('exam_from');  
140.	        $exam_to = $this->set->post('exam_to');  
141.	        $user_id = $_SESSION['user_id'];  
142.	        $total_points = $this->set->post('total_points');  
143.	        $passing_grade = $this->set->post('passing_grade');  
144.	        $time = ($this->set->post('hrs') * 3600) + ($this->set->post('mins') * 60);  
145.	        $dept_id = $this->set->post('dept_id');  
146.	        $admin->saveexamsnew($exam_name,$exam_from,$exam_to,$user_id,$total_points,$time,$passing_grade,$dept_id);  
147.	    }  
148.	    public function saveexamsupdateAction(){  
149.	        $admin = $this->load->model('adminModel');  
150.	        $exam_name = $this->set->post('exam_name');  
151.	        $exam_from = $this->set->post('exam_from');  
152.	        $exam_to = $this->set->post('exam_to');  
153.	        $exam_id = $this->set->post('exam_id');  
154.	        $department_id = $this->set->post('dept_id');  
155.	        $user_id = $_SESSION['user_id'];  
156.	        $total_points = $this->set->post('total_points');  
157.	        $passing_grade = $this->set->post('passing_grade');  
158.	        $time = ($this->set->post('hrs') * 3600) + ($this->set->post('mins') * 60);  
159.	        $admin->saveexamsupdate($exam_name,$exam_from,$exam_to,$user_id,$total_points,$time,$exam_id,$passing_grade,$department_id);  
160.	    }  
161.	    public function examslistAction(){  
162.	        $admin = $this->load->model('adminModel');  
163.	        $from = $this->set->post('from');  
164.	        $to = $this->set->post('to');  
165.	        $result = $admin->loadExams( $from, $to );  
166.	        if ( $from == '' && $to == '' ){  
167.	            //$this->load->view('scripts/admin/examsresult',$result);   
168.	        }else{  
169.	            //$this->load->view('scripts/admin/examsresult_data',$result);      
170.	        }  
171.	          
172.	        $this->load->view('scripts/admin/exams_list',$result);  
173.	    }  
174.	    public function exameditAction(){  
175.	        $admin = $this->load->model('adminModel');  
176.	        $exam_id = $this->set->get('exam_id');  
177.	        $result = $admin->examedit($exam_id);  
178.	        $result['department'] = $admin->loadDepartment();  
179.	        $result['exam_id'] = $exam_id;  
180.	        $this->load->view('scripts/admin/exams-edit',$result);  
181.	    }  
182.	    public function examsresultAction(){      
183.	        $admin = $this->load->model('adminModel');  
184.	        $from = $this->set->post('from');  
185.	        $to = $this->set->post('to');  
186.	        $result=$admin->examsresult($from, $to);  
187.	        if ( $from == '' && $to == '' ){  
188.	            $this->load->view('scripts/admin/examsresult',$result);     
189.	        }else{  
190.	            $this->load->view('scripts/admin/examsresult_data',$result);    
191.	        }  
192.	    }  
193.	  
194.	    public function checkresultAction(){  
195.	        $admin = $this->load->model('adminModel');  
196.	        $exam_id = $this->set->get('exam_id');  
197.	        $user_id = $this->set->get('user_id');  
198.	        $result = $admin->checkresult($exam_id, $user_id);  
199.	        $result['exam_id'] = $exam_id;  
200.	        $result['user_id'] = $user_id;  
201.	        $this->load->view('scripts/admin/checkresults',$result);  
202.	    }  
203.	    public function rateAction(){  
204.	        $admin = $this->load->model('adminModel');  
205.	        $transaction_dtl_id = $this->set->get('transaction_dtl_id');  
206.	        //$result = $transaction_dtl_id;  
207.	        $result['exam_id'] = $this->set->get('exam_id');  
208.	        $result['user_id'] = $this->set->get('user_id');  
209.	        $result = $admin->rate($transaction_dtl_id);  
210.	        $this->load->view('scripts/admin/essay_rate',$result);  
211.	    }  
212.	    public function rateupdateAction(){  
213.	        $admin = $this->load->model('adminModel');  
214.	        $transaction_dtl_id = $this->set->post('transaction_dtl_id');  
215.	        $score = $this->set->post('score');  
216.	        $checked_by = $_SESSION['user_id'];  
217.	        $result = $admin->rateupdate($transaction_dtl_id,$score, $checked_by);  
218.	        //$this->load->view('scripts/admin/essay_rate',$result);  
219.	    }  
220.	    public function checkstatusAction(){  
221.	        $admin = $this->load->model('adminModel');  
222.	        $status = $this->set->post('status');  
223.	        $user_id = $this->set->post('user_id');  
224.	        $exam_id = $this->set->post('exam_id');  
225.	        $admin->checkstatus($status,$user_id,$exam_id);  
226.	    }  
227.	    /*for question */  
228.	    public function questionsAction(){  
229.	        $q_id = $this->set->get('exam_id');  
230.	        $this->load->view('scripts/admin/questions',$q_id);  
231.	    }  
232.	    public function questionaddAction(){  
233.	        $q_id = $this->set->get('exam_id');  
234.	        $this->load->view('scripts/admin/questions-add2',$q_id);  
235.	    }  
236.	    public function questionexamsnewAction(){  
237.	        $exam_id = $this->set->post('exam_id');  
238.	        $question = $this->set->post('question');  
239.	        $question_type = $this->set->post('question_type');  
240.	        $admin = $this->load->model('adminModel');  
241.	        $user_id = $_SESSION['user_id'];  
242.	        $admin->questionexamsnew($exam_id, $question, $question_type, $this->set->get('data_'),$user_id);  
243.	    }  
244.	    public function questionaddinsertAction(){  
245.	        $exam_id = $this->set->post('exam_id');  
246.	        $question = $this->set->post('question_name');  
247.	        $user_id = $_SESSION['user_id'];  
248.	        $question_type = $this->set->post('question_type');  
249.	        $essay_points = $this->set->post('essay_points');  
250.	        $admin = $this->load->model('adminModel');  
251.	        $admin->questionaddinsert($exam_id,$question,$question_type,$user_id,$essay_points);  
252.	  
253.	    }  
254.	    public function questionlistAction(){  
255.	        $admin = $this->load->model('adminModel');  
256.	        $exam_id = $this->set->get('exam_id');  
257.	        $result = $admin->loadQuestion($exam_id);  
258.	        $result['exam_id1'] = $this->set->get('exam_id');  
259.	        $this->load->view('scripts/admin/questions_list',$result);  
260.	    }  
261.	  
262.	  
263.	    public function questioneditAction(){  
264.	        $admin = $this->load->model('adminModel');  
265.	        $question_id = $this->set->get('question_id');  
266.	        $result['question'] = $admin->questionedit($question_id);  
267.	        $result['question_id'] = $question_id;  
268.	        $result['exam_id'] = $this->set->get('exam_id');  
269.	        $this->load->view('scripts/admin/questions-edit2',$result);  
270.	    }  
271.	    public function questionupdateAction(){  
272.	        $admin = $this->load->model('adminModel');  
273.	        $question_name = $this->set->post('question_name');  
274.	        $question_type = $this->set->post('question_type');  
275.	        $question_id = $this->set->post('question_id');  
276.	        $essay_points = $this->set->post('essay_points');  
277.	        $admin->questionupdate($question_name,$question_type,$question_id,$essay_points);  
278.	    }  
279.	    public function questiondeleteAction(){  
280.	        $admin = $this->load->model('adminModel');  
281.	        $exam_id = $this->set->get('exam_id');  
282.	        $admin->questiondelete($exam_id);  
283.	    }  
284.	    /*for answer */  
285.	    public function answereditAction(){  
286.	        $admin = $this->load->model('adminModel');  
287.	        $answer_id = $this->set->get('answer_id');  
288.	        $result = $admin->answeredit($answer_id);  
289.	        $result['exam'] = $this->set->get('exam_id');  
290.	        $result['answer_id'] = $answer_id;  
291.	        $result['question_id'] = $this->set->get('question_id');  
292.	        $this->load->view('scripts/admin/answer-edit',$result);  
293.	    }  
294.	    public function answerupdateAction(){  
295.	        $admin = $this->load->model('adminModel');  
296.	        $answer_id = $this->set->post('answer_id');  
297.	        $answer_name = $this->set->post('answer_name');  
298.	        $flag = $this->set->post('flag');  
299.	        $question_id = $this->set->post('question_id');  
300.	        $admin->answerupdate($answer_id, $answer_name,$flag, $question_id);  
301.	  
302.	    }  
303.	    public function answeraddAction(){  
304.	        //$admin = $this->load->model('adminModel');  
305.	        //$answer_name = $this->set->post('answer_name');  
306.	        //$flag = $this->set->post('flag');  
307.	        $result['question_id'] = $this->set->get('question_id');  
308.	        $result['exam_id'] = $this->set->get('exam_id');  
309.	        $this->load->view('scripts/admin/answer-add',$result);  
310.	        //$admin->answeradd($answer_name,$flag, $question_id);  
311.	    }  
312.	    public function answeraddinsertAction(){  
313.	        $admin = $this->load->model('adminModel');  
314.	        $answer_name = $this->set->post('answer_name');  
315.	        $flag = $this->set->post('flag');  
316.	        $question_id = $this->set->post('question_id');  
317.	        //$answer_name,$flag,$question_id  
318.	        $admin->answeraddinsert($answer_name,$flag,$question_id);  
319.	    }  
320.	    public function answerdeleteAction(){  
321.	        $admin = $this->load->model('adminModel');  
322.	        $answer_id = $this->set->get('answer_id');  
323.	        $admin->answerdelete($answer_id);  
324.	    }  
325.	}  
326.	?>  
authenticateController.php
1.	<?php  
2.	Class authenticateController extends _Controller {  
3.	    public function verifyAction(){  
4.	        if ( !isset($_SESSION['user_id']) ){  
5.	            $user_name = sanitize($this->set->post('user_name'));  
6.	            $user_password = md5(sanitize($this->set->post('user_password')));  
7.	            $model = $this->load->model('authenticateModel');  
8.	            if( !EMPTY($user_name) && !EMPTY($user_password) ){  
9.	                $result = $model->login( $user_name, $user_password );  
10.	            }  
11.	            if ( is_array($result) ){  
12.	                //print_r($result);  
13.	                if ( $result[0]['user_enabled'] == 1 ) {  
14.	                    $_SESSION['user_id'] = $result[0]['user_id'];  
15.	                    $_SESSION['role_id'] = $result[0]['role_id'];  
16.	                    header("Location:" . BASE_URL);  
17.	                }else{  
18.	                    header("Location:" . BASE_URL . 'authenticate/failed&err=0');  
19.	                }  
20.	            }else{  
21.	                header("Location:" . BASE_URL . 'authenticate/failed&err=1');  
22.	            }  
23.	        }else{  
24.	            header("Location:" . BASE_URL );  
25.	        }  
26.	      
27.	    }  
28.	    public function failedAction(){  
29.	          
30.	        $result['nav'] = $this->load->tmpl_view('scripts/login/login-failed');  
31.	        $this->load->view('mainLayouts/layouts', $result);  
32.	    }  
33.	    public function logoutAction(){  
34.	        session_destroy();  
35.	        /* 
36.	        unset($_SESSION['user_id']); 
37.	        unset($_SESSION['role_id']); 
38.	        */  
39.	        header("Location:" . BASE_URL);  
40.	    }  
41.	}  
42.	?>  
indexController.php
1.	<?php  
2.	Class indexController extends _Controller {  
3.	    public function mainAction(){  
4.	  
5.	        if ( isset($_SESSION['user_id']) ){  
6.	            if ( $_SESSION['role_id'] == 1  ){  
7.	                $result['nav'] = $this->load->tmpl_view('scripts/admin/navigation');  
8.	                $this->load->view('mainLayouts/layouts', $result);  
9.	            }else{ //exam  
10.	                $admin = $this->load->model('adminModel');  
11.	                $result = $admin->allowedtocheck( $_SESSION['user_id'] );  
12.	  
13.	                $result['nav'] = $this->load->tmpl_view('scripts/staff/navigation', $result);  
14.	                $this->load->view('mainLayouts/layouts2', $result);  
15.	            }  
16.	        }else{  
17.	            $result['nav'] = $this->load->tmpl_view('scripts/login/index');  
18.	            $this->load->view('mainLayouts/layouts', $result);  
19.	              
20.	        }  
21.	          
22.	    }  
23.	}  
24.	?>  
staffController.php
1.	<?php  
2.	Class staffController extends _Controller {  
3.	    public function indexAction(){  
4.	        $staff = $this->load->model('staffModel');  
5.	        $result = $staff->exam_list($_SESSION['user_id']);  
6.	        $this->load->view('scripts/staff/index',$result);  
7.	    }  
8.	    public function examAction(){  
9.	        unset($_SESSION['answer_id']);  
10.	        unset($_SESSION['question_id']);  
11.	        unset($_SESSION['answer']);  
12.	        $staff = $this->load->model('staffModel');  
13.	        $exam_id = $this->set->get('exam_id');  
14.	        $isTaken = $staff->alreadytaken($_SESSION['user_id'],$exam_id);  
15.	        if (!is_array($isTaken)){  
16.	            $result = $staff->getexamfirst($exam_id);  
17.	            $result['exam_id'] = $exam_id;  
18.	            $this->load->view('scripts/staff/exam',$result);    
19.	        }else{  
20.	            header("Location:" . BASE_URL.'index/main');  
21.	        }  
22.	          
23.	    }  
24.	    public function getexamnextAction(){  
25.	        $staff = $this->load->model('staffModel');  
26.	        $exam_id = $this->set->get('exam_id');  
27.	        $start = $this->set->get('start');  
28.	        $result = $staff->getexamnext($exam_id, $start);  
29.	        $result['question_id'] = $this->set->get('question_id');  
30.	        if (isset($_SESSION['question_id'])){  
31.	            if (isset($_GET['answer_id'])){  
32.	                $_SESSION['answer_id'][$start] = $this->set->get('answer_id');  
33.	                $_SESSION['question_id'][$_SESSION['answer_id'][$start]] = $this->set->get('question_id');  
34.	                $_SESSION['answer'][$_SESSION['answer_id'][$start]] = mysql_real_escape_string(sanitize($this->set->get('answer')));  
35.	            }else{  
36.	                $_SESSION['answer_id'][$start] = $this->set->get('question_id');  
37.	                $_SESSION['question_id'][$_SESSION['answer_id'][$start]] = $this->set->get('question_id');  
38.	                $_SESSION['answer'][$_SESSION['answer_id'][$start]] = mysql_real_escape_string(sanitize($this->set->get('answer')));  
39.	            }  
40.	        }else{  
41.	            if (isset($_GET['answer_id'])){  
42.	                $_SESSION['answer_id'][$start] = $this->set->get('answer_id');  
43.	                $_SESSION['question_id'][$_SESSION['answer_id'][$start]] = $this->set->get('question_id');  
44.	                $_SESSION['answer'][$_SESSION['answer_id'][$start]] = mysql_real_escape_string(sanitize($this->set->get('answer')));  
45.	            }else{  
46.	                $_SESSION['answer_id'][$start] = $this->set->get('question_id');  
47.	                $_SESSION['question_id'][$_SESSION['answer_id'][$start]] = $this->set->get('question_id');  
48.	                $_SESSION['answer'][$_SESSION['answer_id'][$start]] = mysql_real_escape_string(sanitize($this->set->get('answer')));  
49.	            }  
50.	          
51.	        }  
52.	        $this->load->view('scripts/staff/exam-next',$result);  
53.	    }  
54.	    public function submitresult2Action(){  
55.	        $staff = $this->load->model('staffModel');  
56.	        $exam_id = $this->set->get('exam_id');  
57.	        $time_consumed = $this->set->get('time_consumed');  
58.	        $result = $staff->submitresult( $_SESSION['user_id'], $exam_id, $time_consumed );  
59.	          
60.	        unset($_SESSION['answer_id']);  
61.	        unset($_SESSION['question_id']);  
62.	        unset($_SESSION['answer']);  
63.	    }  
64.	    public function submitresultAction(){  
65.	        $staff = $this->load->model('staffModel');  
66.	        $exam_id = $this->set->get('exam_id');  
67.	        //$answer = $this->set->get('answer');  
68.	        $time_consumed = $this->set->get('time_consumed');  
69.	        $start = $this->set->get('start');  
70.	        $result = $staff->getexamnext($exam_id, $start);  
71.	        if (isset($_SESSION['question_id'])){  
72.	            if (isset($_GET['answer_id'])){  
73.	                $_SESSION['answer_id'][$start] = $this->set->get('answer_id');  
74.	                $_SESSION['question_id'][$_SESSION['answer_id'][$start]] = $this->set->get('question_id');  
75.	                $_SESSION['answer'][$_SESSION['answer_id'][$start]] = mysql_real_escape_string(sanitize($this->set->get('answer')));  
76.	            }else{  
77.	                $_SESSION['answer_id'][$start] = $this->set->get('question_id');  
78.	                $_SESSION['question_id'][$_SESSION['answer_id'][$start]] = $this->set->get('question_id');  
79.	                $_SESSION['answer'][$_SESSION['answer_id'][$start]] = mysql_real_escape_string(sanitize($this->set->get('answer')));  
80.	            }  
81.	        }else{  
82.	            if (isset($_GET['answer_id'])){  
83.	                $_SESSION['answer_id'][$start] = $this->set->get('answer_id');  
84.	                $_SESSION['question_id'][$_SESSION['answer_id'][$start]] = $this->set->get('question_id');  
85.	                $_SESSION['answer'][$_SESSION['answer_id'][$start]] = mysql_real_escape_string(sanitize($this->set->get('answer')));  
86.	            }else{  
87.	                $_SESSION['answer_id'][$start] = $this->set->get('question_id');  
88.	                $_SESSION['question_id'][$_SESSION['answer_id'][$start]] = $this->set->get('question_id');  
89.	                $_SESSION['answer'][$_SESSION['answer_id'][$start]] = mysql_real_escape_string(sanitize($this->set->get('answer')));  
90.	            }  
91.	          
92.	        }  
93.	        $result = $staff->submitresult( $_SESSION['user_id'], $exam_id, $time_consumed );  
94.	        unset($_SESSION['answer_id']);  
95.	        unset($_SESSION['question_id']);  
96.	        unset($_SESSION['answer']);  
97.	        //header("Location:" . BASE_URL.'staff/thankyou');  
98.	        //$this->load->view('index.php?staff/thankyou')  
99.	    }  
100.	    public function viewresultsAction(){  
101.	        $staff = $this->load->model('staffModel');  
102.	        $exam_id = $this->set->get('exam_id');  
103.	        $user_id = $_SESSION['user_id'];  
104.	        $result = $staff->viewresults($exam_id, $user_id);  
105.	        $this->load->view('scripts/staff/view-results',$result);  
106.	    }  
107.	    public function viewresults2Action(){  
108.	        $staff = $this->load->model('staffModel');  
109.	        $exam_id = $this->set->get('exam_id');  
110.	        $user_id = $_SESSION['user_id'];  
111.	        $result = $staff->viewresults($exam_id, $user_id);  
112.	        $this->load->view('scripts/staff/view-results2',$result);  
113.	    }  
114.	    public function thankyouAction(){  
115.	        $this->load->view('scripts/staff/thankyou');  
116.	    }  
117.	    public function examsresultAction(){      
118.	        $staff = $this->load->model('staffModel');  
119.	        $exam_id = $this->set->get('exam_id');  
120.	        $result = $staff->examsresult($exam_id);  
121.	        $this->load->view('scripts/staff/examsresult',$result);     
122.	  
123.	    }  
124.	    public function examslistAction(){  
125.	        $admin = $this->load->model('staffModel');  
126.	        $from = $this->set->post('from');  
127.	        $to = $this->set->post('to');  
128.	        $result = $admin->loadExams( $from, $to );  
129.	        if ( $from == '' && $to == '' ){  
130.	            //$this->load->view('scripts/admin/examsresult',$result);   
131.	        }else{  
132.	            //$this->load->view('scripts/admin/examsresult_data',$result);      
133.	        }  
134.	        $this->load->view('scripts/staff/exams_list',$result);  
135.	    }  
136.	  
137.	}  
138.	?>  
Pagination.php
1.	<?php  
2.	  
3.	  
4.	Class Pagination{  
5.	    var $base_url;  
6.	    var $per_page;  
7.	    var $total_page;  
8.	    var $display;  
9.	    var $current_page;  
10.	      
11.	    public function set_up( $base_url, $display = 5,  $per_page = 0, $total_page = 0, $current_page = 1 ){  
12.	        $this->base_url = $base_url;  
13.	        $this->per_page = $per_page;  
14.	        $this->total_page = $total_page;  
15.	        $this->display = $display;  
16.	        $this->current_page = $current_page;  
17.	    }  
18.	      
19.	    public function create_anchor_reload(){  
20.	        $count = 0;  
21.	        $anchor='';  
22.	        $d=0;  
23.	        $e=0;  
24.	        $f=0;  
25.	        $i=0;  
26.	        $z=0;  
27.	        $y=0;  
28.	        $total_pagination = ceil($this->total_page / $this->per_page);  
29.	        $z = $this->per_page;      
30.	        if ( $total_pagination > $this->display )  
31.	        {  
32.	            for ( $page = 1; $page <=  $total_pagination; $page ++ )  
33.	            {  
34.	                $d = $this->current_page % $this->display;  
35.	                $e = $this->current_page;  
36.	                for($loop=0; $loop <= $this->display; $loop ++){  
37.	                    if ($d == 0){  
38.	                        $f = $e - $this->display;  
39.	                    }elseif ($d == $loop){  
40.	                        $f = $e - $loop;  
41.	                    }  
42.	                }  
43.	  
44.	                if ($page > $f)  
45.	                {  
46.	                    $count+=1;  
47.	                    if ($count <= $this->display)  
48.	                    {  
49.	                        if ( $page == $this->current_page )  
50.	                        {  
51.	                            $anchor .= " [<b>$page</b>] ";  
52.	                        }else  
53.	                        {  
54.	                            $i = $page * $this->per_page;  
55.	                            $anchor .= " <a href = $this->base_url/$i>$page</a> ";  
56.	                        }  
57.	                        $i += $this->per_page;  
58.	                        $y += $this->per_page;  
59.	                        $z = ((($i - $y) / $this->per_page) - $this->display) * $this->per_page;  
60.	                        if($z < 0){  
61.	                            $z = $this->per_page;  
62.	                        }  
63.	                    }  
64.	                }  
65.	            }  
66.	        }else{  
67.	            for ( $page = 1; $page <= $total_pagination; $page ++ )   
68.	            {  
69.	                $i = $page * $this->per_page;  
70.	                $anchor .= " <a href = $this->base_url/$i>$page</a> ";  
71.	            }  
72.	            $i += $this->per_page;     
73.	        }  
74.	        $anchor .= " <a href = $this->base_url/$i>>></a> ";  
75.	        return " <a href = $this->base_url/$z><<</a> ".$anchor;  
76.	    }  
77.	      
78.	    public function create_anchor_ajax(){  
79.	      
80.	    }  
81.	}  
82.	?>  
Session.php
1.	<?php  
2.	  
3.	  
4.	Class Session{  
5.	  
6.	    public function __construct(){  
7.	        session_start();  
8.	    }  
9.	      
10.	    public function setdata( $session = array() ){  
11.	        if (is_array( $session )){  
12.	            foreach ( $session as $sess_name => $sess_data ){  
13.	                $_SESSION[$sess_name] = $sess_data;  
14.	            }  
15.	        }  
16.	    }  
17.	      
18.	    public function destroy(){  
19.	        session_destroy();  
20.	    }  
21.	      
22.	    public function _unset($session_name){  
23.	        unset($_SESSION[$session_name]);  
24.	    }  
25.	}  
26.	?>  
Common.php
1.	<?php  
2.	  
3.	  
4.	    function load_class( $class, $directory = '' ){  
5.	        if( file_exists( $directory . $class . EXT ) )  
6.	        {  
7.	            include_once( $directory . $class . EXT );  
8.	            if( class_exists( $class ) ) {  
9.	                return new $class;  
10.	            }  
11.	        }  
12.	    }  
13.	  
14.	    function include_class_method( $class, $method ){  
15.	        $class = load_class( $class.'Controller', CONTROLLER_DIR );  
16.	        if( method_exists($class, $method) ){  
17.	            $class->$method();  
18.	        }else{  
19.	            redirect_home();  
20.	        }  
21.	    }  
22.	      
23.	    function sanitize( $string ){  
24.	        $replace = array ("'",";","/","%");  
25.	        return str_replace( $replace, "", $string );  
26.	    }  
27.	      
28.	    function _unset( $unset ){  
29.	        foreach( explode(',',$unset) as $var ){  
30.	            unset($var);  
31.	        }  
32.	    }  
33.	      
34.	    function limit_str ( $data, $num ){  
35.	        $char = '';  
36.	        $char_complete = $data;  
37.	        $char = substr($data, 0 , $num);  
38.	        return array($char, $char_complete);  
39.	    }  
40.	      
41.	    function format_time ( $time ){  
42.	        //$time = "12:00 AM";  
43.	        if ( strlen($time) > 0 ) {  
44.	            list($hour , $min) = explode(':' , $time);  
45.	            $state = explode(' ' , $min);  
46.	            $var['PM'] = array('12=12', '1=13', '2=14', '3=15','4=16','5=17','6=18','7=19','8=20','9=21','10=22','11=23');  
47.	            $var['AM'] = array('12=24', '1=1', '2=2', '3=3','4=4','5=5','6=6','7=7','8=8','9=9','10=10','11=11');  
48.	              
49.	            $vT = count($var[$state[1]]);  
50.	            for ( $i = 0; $i < $vT; $i++){  
51.	                list ( $variable , $value ) = explode('=', $var[$state[1]][$i]);  
52.	                if ( $variable == $hour ){  
53.	                    $sethr = $value * 3600;  
54.	                    $setmin = $min * 60;  
55.	                    $hm = $sethr + $setmin;  
56.	                }  
57.	            }  
58.	            return $hm;  
59.	        }  
60.	    }  
61.	      
62.	    function errorHandler($err){  
63.	          
64.	        echo " 404! Not found </br>";  
65.	        //echo $err;  
66.	        /* 
67.	        switch ( $err_no ){ 
68.	            case 404: 
69.	                echo " ERROR 404 NOT FOUND, CONTACT THE ADMINISTRATOR FOR THIS !!"; 
70.	                break; 
71.	            case 403:  
72.	            break;   
73.	        }*/  
74.	    }  
75.	      
76.	    function redirect_home(){  
77.	        header("Location:" . BASE_URL );  
78.	    }  
79.	  
80.	?>  
Controller.php
1.	<?php  
2.	  
3.	  
4.	Class _Controller {  
5.	    public function __construct(){  
6.	        $this->load = load_class('Loader',CORE_DIR);  
7.	        $this->set  = load_class('Set', CORE_DIR);  
8.	    }  
9.	}  
10.	?>  
Loader.php
1.	<?php  
2.	  
3.	  
4.	  
5.	Class Loader{  
6.	    public function model( $model_name ){  
7.	        $model_name = load_class( $model_name , MODEL_DIR );  
8.	        return $model_name;  
9.	    }  
10.	      
11.	    public function view( $view_file , $data = array() ){  
12.	        if ( !file_exists(VIEW_DIR . $view_file. EXT) ) { errorHandler(VIEW_DIR . $view_file. EXT); }  
13.	        ob_start();  
14.	        include( VIEW_DIR . $view_file . EXT );  
15.	        ob_end_flush();  
16.	    }  
17.	      
18.	    public function library ( $lib_name, $lib_directory ){  
19.	        $library = load_class( $lib_name, $lib_directory );  
20.	        return $library;  
21.	    }  
22.	      
23.	    public function tmpl_view( $template, $data = array() ) {  
24.	        ob_start();  
25.	        include( VIEW_DIR . $template . EXT );  
26.	        $result = ob_get_contents();  
27.	        ob_end_clean();  
28.	        return $result;  
29.	    }  
30.	}  
31.	?>  
Router.php
1.	<?php  
2.	  
3.	  
4.	  
5.	Class Router{  
6.	    #load URI  
7.	    public function __construct(){  
8.	        $this->uri = load_class('URI', CORE_DIR);  
9.	    }  
10.	      
11.	    public function urlRoute(){  
12.	        return $this->segments = $this->uri->getURI();  
13.	    }  
14.	      
15.	    public function urlParams(){  
16.	      
17.	    }  
18.	}  
19.	?>  
Set.php
1.	<?php  
2.	  
3.	Class Set{    
4.	    public function post( $post ){  
5.	        if ( !EMPTY($_POST[$post]) ){  
6.	            return $_POST[$post];  
7.	        }  
8.	    }  
9.	      
10.	    public function get( $get ) {  
11.	        if ( !EMPTY ($get) ){  
12.	            return $_GET[$get];  
13.	        }  
14.	    }  
15.	      
16.	}  
17.	?>  
URI.php
1.	<?php  
2.	  
3.	  
4.	  
5.	Class URI{  
6.	    var $uri;  
7.	    var $segments = array();  
8.	    var $params   = array();  
9.	      
10.	    public function __construct(){  
11.	        $this->uri = $_SERVER['QUERY_STRING'];  
12.	    }  
13.	      
14.	    public function getURI(){  
15.	        if ( isset($this->uri) ){  
16.	            //echo $this->validate_URI($this->uri);  
17.	            //$this->uri = $this->validate_URI( $this->uri );  
18.	            foreach ( explode('/', $this->validate_URI( $this->uri )) as $val )  
19.	            {  
20.	                if ( $val != '' )  
21.	                {  
22.	                        $var = explode('&', $val);  
23.	                        $this->segments[] = $var[0];  
24.	                }  
25.	            }  
26.	            return $this->segments;  
27.	        }  
28.	    }  
29.	      
30.	    public function validate_URI( $URI ){  
31.	        if (!EMPTY ( $URI )){  
32.	            //$find = array("'",";","@","*","(",")","^");  
33.	            $find = array("'",";","*","(",")","^","%");  
34.	            return str_replace($find ,"/", $URI);  
35.	        }  
36.	    }  
37.	      
38.	      
39.	    public function getParams( $segments ){  
40.	      
41.	    }  
42.	      
43.	}  
44.	?>  
Db.php
1.	<?php  
2.	  
3.	  
4.	Class _Db{  
5.	    private $user;  
6.	    private $pass;  
7.	    private $host;  
8.	    private $dbnm;  
9.	    private $cn;  
10.	    private $mysql_result;  
11.	      
12.	    public function __construct()  
13.	    {  
14.	        $this->user = DB_USER;  
15.	        $this->pass = DB_PASS;  
16.	        $this->host = DB_HOST;  
17.	        $this->dbnm = DB_NAME;  
18.	          
19.	    }  
20.	  
21.	    public function connect(){  
22.	    //$dbConnection = mysql_pconnect( $myHostname, $myUsername, $myPassword  );  
23.	        $this->cn = mysql_connect( $this->host, $this->user, $this->pass ) or die('error connection');  
24.	        mysql_select_db ( $this->dbnm , $this->cn );  
25.	        //if ( !mysql_ping( $this->cn ) )  
26.	        //{  
27.	            //echo 'this';  
28.	           //$this->cn = mysql_pconnect( $this->host, $this->user ) or die('error connection');  
29.	           //mysql_select_db ( $this->dbname , $this->cn );  
30.	        //}  
31.	  
32.	    }  
33.	      
34.	    public function query( $str , $assoc_type = 'assoc' ){  
35.	        $this->connect();  
36.	        if( strpos(strtolower($str), 'select') === 0 ){  
37.	          
38.	        $this->mysql_result = mysql_query( $str );  
39.	            if ( $this->mysql_result && mysql_error() == '' ){  
40.	                    switch ( $assoc_type )  
41.	                    {  
42.	                        case 'assoc':  
43.	                            while( $row= mysql_fetch_assoc( $this->mysql_result ) ) {  
44.	                                $result[] =  $row;  
45.	                            }  
46.	                        break;  
47.	                          
48.	                        case 'fetch_row':  
49.	                            $result = mysql_fetch_row( $this->mysql_result );  
50.	                        break;  
51.	                    }  
52.	            }else{  
53.	                return mysql_error();  
54.	            }  
55.	        }else{  
56.	            mysql_query( $str );  
57.	        }  
58.	        if ( isset($result) ) return $result;  
59.	          
60.	    }  
61.	      
62.	    public function insert( $table, $values ) {  
63.	        $fields = implode(",", array_keys($values) );  
64.	        $val = implode("," , array_values($values) );  
65.	        //echo "INSERT INTO ".$table. "(".$fields.") VALUES (".$val .")";  
66.	        $this->query("INSERT INTO ".$table. "(".$fields.") VALUES (".$val .")");  
67.	    }  
68.	    /* 
69.	    public function update( $table, $values, $where = null ){ 
70.	        for($fields = 0; $fields < count(array_keys($values)); $fields ++){ 
71.	            $fields_val = isset( $fields_val ) ? $fields_val  . array_keys($values)[$fields] . '=' :   array_keys($values)[$fields] . '='; 
72.	            for($val = $fields; $val <= $fields; $val++){ 
73.	                //$fields_val .= ( $val== count(array_keys($values)) - 1  ) ? array_values($values)[$val] : array_values($values)[$val] . ','; 
74.	            } 
75.	        } 
76.	        $this->query("UPDATE {$table} SET $fields_val {$where}"); 
77.	    } 
78.	    */  
79.	    public function delete( $table, $where = null ){  
80.	        $this->query("DELETE FROM {$table} {$where}");  
81.	    }  
82.	  
83.	    public function fetch_all_rows( $sql, $assoc_type = 'assoc' ){  
84.	        return $this->query($sql, $assoc_type);  
85.	    }  
86.	}  
87.	?>  
adminModel.php
1.	<?php  
2.	  
3.	Class adminModel extends _Db {  
4.	    /* for users */  
5.	  
6.	    public function addnewuser($user_fname, $user_lname, $user_name, $user_password, $role_id, $department_id, $enabled=0, $user_id, $ischecker) {  
7.	        $this->insert('users', array('user_fname' => "'$user_fname'", 'user_lname' => "'$user_lname'", 'user_name' => "'$user_name'",  
8.	            'user_password' => "'$user_password'", 'role_id' => $role_id, 'department_id' => $department_id,  
9.	            'user_enabled' => $enabled, 'user_createdby' => $user_id, 'exam_checker' => $ischecker));  
10.	    }  
11.	      
12.	      
13.	  
14.	    public function userupdate($user_fname, $user_lname, $user_name, $role_id, $department_id, $enabled=0, $current_user_id, $edit_id, $ischecker=0) {  
15.	        if (!isset($enabled)) {  
16.	            $enabled = 0;  
17.	        }  
18.	        if (!isset($ischecker)) {  
19.	            $ischecker = 0;  
20.	        }  
21.	        $modify_date = date("Y-m-d", time());  
22.	          
23.	        echo $sql;  
24.	        $this->query($sql);  
25.	        $sql = "UPDATE users SET user_fname = '$user_fname', user_lname='$user_lname',  
26.	                                 user_name='$user_name',role_id=$role_id,department_id=$department_id,  
27.	                                 user_enabled=$enabled,user_modifiedby=$current_user_id,user_modifiedon='$modify_date',  
28.	                                 exam_checker = $ischecker  
29.	                                 WHERE user_id = $edit_id";  
30.	        //                           echo $sql;  
31.	        $this->query($sql);  
32.	    }  
33.	  
34.	    public function userupdate2($edit_id , $change_pass){  
35.	        $modify_date = date("Y-m-d", time());  
36.	        $change_pass = md5($change_pass);  
37.	        $sql = "UPDATE users SET user_password = '$change_pass', user_modifiedon='$modify_date' WHERE user_id = $edit_id";  
38.	        $this->query($sql);  
39.	    }  
40.	  
41.	    public function loadDepartmentandRole() {  
42.	        $result['department'] = $this->fetch_all_rows('select * from department');  
43.	        $result['role'] = $this->fetch_all_rows('select * from user_roles');  
44.	        return $result;  
45.	    }  
46.	  
47.	    public function loadUsers() {  
48.	        return $this->fetch_all_rows('select * from users LEFT join department on users.department_id = department.department_id Left Join user_roles a ON users.role_id = a.role_id Order by user_enabled asc');  
49.	    }  
50.	  
51.	    public function selectuser($user_id) {  
52.	        return $this->fetch_all_rows('select * from users where user_id =' . $user_id);  
53.	    }  
54.	  
55.	    public function userdelete($user_id) {  
56.	        $sql = "delete from users where user_id = $user_id";  
57.	        $this->query($sql);  
58.	    }  
59.	  
60.	    public function signupadd($user_fname, $user_lname, $user_name, $user_password, $department_id) {  
61.	        $sql = "SELECT * FROM users WHERE user_name ='$user_name'";  
62.	        $result = $this->query($sql);  
63.	        if (is_array($result)) {  
64.	            //echo json_encode(array('value'=>'error'));  
65.	            echo "1";  
66.	        } else {  
67.	            $this->insert('users', array('user_fname' => "'$user_fname'", 'user_lname' => "'$user_lname'", 'user_name' => "'$user_name'",  
68.	                'user_password' => "'$user_password'", 'department_id'=>$department_id));  
69.	            echo "0";  
70.	            //echo json_encode(array('value'=>'ok'));  
71.	        }  
72.	    }  
73.	  
74.	    /* for department */  
75.	  
76.	    public function savedepartmentnew($department_code, $department_name) {  
77.	        $this->insert('department', array('department_code' => "'$department_code'", 'department_name' => "'$department_name'"));  
78.	    }  
79.	  
80.	    public function loadDepartment() {  
81.	        return $this->fetch_all_rows('select * from department');  
82.	    }  
83.	  
84.	    public function departmentedit($department_id) {  
85.	        return $this->fetch_all_rows("select * from department where department_id = $department_id");  
86.	    }  
87.	  
88.	    public function departmentupdate($department_id, $department_name) {  
89.	        $sql = "UPDATE department SET department_name ='$department_name' WHERE department_id = $department_id";  
90.	        $this->query($sql);  
91.	    }  
92.	  
93.	    public function departmentdelete($department_id) {  
94.	        $this->query("DELETE FROM department WHERE department_id = $department_id");  
95.	    }  
96.	  
97.	    /* for exams */  
98.	  
99.	    public function saveexamsnew($exam_name, $exam_from, $exam_to, $user_id, $total_points, $time, $passing_grade, $department_id) {  
100.	        $this->insert('exams', array('exam_name' => "'$exam_name'", 'exam_from' => "'$exam_from'", 'exam_to' => "'$exam_to'",  
101.	            'exam_created_by' => $user_id, 'passing_score' => $total_points, 'exam_time_limit' => $time, 'passing_grade' => $passing_grade, 'department_id' => $department_id));  
102.	    }  
103.	  
104.	    public function saveexamsupdate($exam_name, $exam_from, $exam_to, $user_id, $total_points, $time, $exam_id, $passing_grade,$department_id) {  
105.	        $sql = "UPDATE exams SET exam_name='$exam_name',exam_from ='$exam_from',   
106.	                exam_to='$exam_to',exam_modified_by=$user_id,passing_score=$total_points,  
107.	                exam_time_limit=$time,passing_grade=$passing_grade, department_id = $department_id  
108.	                WHERE exam_id = $exam_id";  
109.	        echo $sql;  
110.	        $this->query($sql);  
111.	    }  
112.	  
113.	    public function loadExams($from, $to) {  
114.	        if ($from != '' && $to != '') {  
115.	            $WHERE = " LEFT JOIN department ON exams.department_id = department.department_id WHERE exam_from >= '$from' AND exam_to <= '$to'  ORDER BY exam_id ASC";  
116.	        } else {  
117.	            $WHERE = " LEFT JOIN department ON exams.department_id = department.department_id WHERE CURDATE() BETWEEN exam_from AND exam_to ORDER BY exam_id ASC";  
118.	        }  
119.	        $sql = "select * from exams $WHERE ";  
120.	        return $this->fetch_all_rows($sql);  
121.	    }  
122.	  
123.	    public function generate_uuid() {  
124.	        $sql = "SELECT UUID()";  
125.	        return $this->fetch_all_rows($sql);  
126.	    }  
127.	  
128.	    public function examedit($exam_id) {  
129.	        $sql = "select * from exams  LEFT JOIN department ON exams.department_id = department.department_id WHERE exam_id = $exam_id";  
130.	        return $this->fetch_all_rows($sql);  
131.	    }  
132.	  
133.	    public function examsresult($from = '', $to = '') {  
134.	        //return $this->fetch_all_rows('select * from exams WHERE NOW() BETWEEN exam_from AND exam_to ORDER BY exam_id ASC');  
135.	        if ($from != '' && $to != '') {  
136.	            $WHERE = " WHERE exam_from >= '$from' AND exam_to <= '$to' ORDER BY exams.exam_id, transaction.user_id ASC";  
137.	        } else {  
138.	            $WHERE = " WHERE CURDATE() BETWEEN exam_from AND exam_to ORDER BY exams.exam_id, transaction.user_id ASC";  
139.	        }  
140.	        $sql = "SELECT * FROM transaction   
141.	                INNER JOIN users ON transaction.user_id = users.user_id  
142.	                INNER JOIN exams ON transaction.exam_id = exams.exam_id   
143.	                $WHERE";  
144.	       // echo $sql;  
145.	        $result['exam'] = $this->fetch_all_rows($sql);  
146.	        if (is_array($result['exam'])) {  
147.	            foreach ($result['exam'] as $row) {  
148.	                $sql = "SELECT SUM(score) AS 'score' FROM transaction_dtl WHERE user_id = $row[user_id]  AND exam_id = $row[exam_id] ORDER BY exam_id, user_id ASC";  
149.	                $result[$row['user_id']][$row['exam_id']] = $this->fetch_all_rows($sql);  
150.	                // echo $row['user_id'] . ' - ' . $row['exam_id'] . '</br>';  
151.	                //echo $result[$row['user_id']][$row['exam_id']][0]['score'].'</br>';  
152.	            }  
153.	            
154.	        }  
155.	        return $result;  
156.	        /* 
157.	          $sql = 'SELECT distinct exams.exam_id, users.user_id,exam_name, user_fname, user_lname from exams 
158.	          INNER JOIN transaction ON exams.exam_id = transaction.exam_id 
159.	          INNER JOIN users ON users.user_id = transaction.user_id 
160.	          WHERE NOW() BETWEEN exam_from AND exam_to ORDER BY exams.exam_id ASC'; 
161.	          $result['exam'] = $this->fetch_all_rows($sql); 
162.	          if (is_array($result['exam'])){ 
163.	          foreach($result['exam'] as $row){ 
164.	          $sql = "SELECT * FROM exams_question 
165.	          INNER JOIN exams_answers ON exams_question.question_id = exams_answers.question_id 
166.	          INNER JOIN transaction ON exams_answers.question_id = transaction.question_id 
167.	          WHERE exams_question.exam_id = $row[exam_id] AND user_id = $row[user_id] ORDER BY exams_answers.question_id ASC"; 
168.	          $result[$row['exam_id']] = $this->fetch_all_rows($sql); 
169.	          } 
170.	          return $result; 
171.	          } 
172.	         */  
173.	    }  
174.	  
175.	    public function checkresult($exam_id, $user_id) {  
176.	        $sql = "SELECT * FROM exams WHERE exam_id = $exam_id";  
177.	        $result['exam_name'] = $this->fetch_all_rows($sql);  
178.	  
179.	        $sql = "SELECT *   
180.	        FROM transaction_dtl  
181.	        INNER JOIN transaction ON transaction_dtl.user_id = transaction.user_id AND transaction_dtl.exam_id = transaction.exam_id  
182.	        INNER JOIN exams_question ON transaction_dtl.question_id = exams_question.question_id  
183.	        INNER JOIN users ON  transaction_dtl.user_id = users.user_id  
184.	        LEFT JOIN exams_answers ON transaction_dtl.transaction_answer_id = exams_answers.answer_id  
185.	  
186.	        WHERE transaction_dtl.user_id = $user_id AND transaction_dtl.exam_id = $exam_id ORDER BY exams_question.question_id ASC";  
187.	        //echo $sql;  
188.	        $result['transaction_dtl'] = $this->query($sql);  
189.	        //print_r($result);  
190.	  
191.	        return $result;  
192.	        /* () 
193.	          $sql = "SELECT * FROM transaction_dtl WHERE exam_id = $exam_id and user_id = $user_id"; 
194.	          return $this->fetch_all_rows($sql); 
195.	         */  
196.	    }  
197.	  
198.	    public function rate($transaction_dtl_id) {  
199.	        //$sql = "UPDATE transaction_dtl SET score = $score WHERE transaction_dtl_id = $transaction_dtl_id";  
200.	        $sql = "SELECT * FROM transaction_dtl WHERE transaction_dtl_id = $transaction_dtl_id";  
201.	        return $this->query($sql);  
202.	    }  
203.	  
204.	    public function rateupdate($transaction_dtl_id, $score, $checked_by) {  
205.	        if (!isset($score)) {  
206.	            $score = 0;  
207.	        }  
208.	        $sql = "UPDATE transaction_dtl SET score = $score, israted=1, checked_by =$checked_by WHERE transaction_dtl_id = $transaction_dtl_id";  
209.	        //$sql = "SELECT * FROM transaction_dtl WHERE transaction_dtl_id = $transaction_dtl_id";  
210.	        $this->query($sql);  
211.	    }  
212.	    public function checkstatus($status, $user_id, $exam_id ){  
213.	        if ( !isset($status) ){  
214.	            $status = 0;  
215.	        }  
216.	        $sql = "UPDATE transaction SET check_status = $status WHERE user_id = $user_id AND exam_id = $exam_id";  
217.	        $this->query($sql);  
218.	    }  
219.	    /* question */  
220.	  
221.	    public function questionexamsnew($exam_id, $question_name, $question_type = 0, $data, $user_id) {  
222.	        if (!isset($question_type)) {  
223.	            $question_type = 0;  
224.	        }  
225.	        $question_code = $this->generate_uuid();  
226.	        $question_code = substr($question_code[0]['UUID()'], 0, 8);  
227.	        $this->insert('exams_question', array('exam_id' => $exam_id, 'question_name' => "'$question_name'", 'question_code' => "'$question_code'", 'question_type' => $question_type, 'question_created_by' => $user_id));  
228.	        $result = $this->fetch_all_rows("select * from exams_question WHERE question_code = '$question_code'");  
229.	        //$result[0]['question_id'];  
230.	        foreach (explode(',', $data) as $val) {  
231.	            if ($val != '') {  
232.	                $var = explode(':', $val);  
233.	                $right = explode('@', $var[1]);  
234.	  
235.	                if (isset($right[1])) {  
236.	  
237.	                    $this->insert('exams_answers', array('question_id' => $result[0]['question_id'], 'answer_name' => "'$right[0]'", 'answer_flag' => 1));  
238.	                } else {  
239.	                    $this->insert('exams_answers', array('question_id' => $result[0]['question_id'], 'answer_name' => "'$var[1]'"));  
240.	                }  
241.	            }  
242.	        }  
243.	    }  
244.	  
245.	    public function questionaddinsert($exam_id, $question_name, $question_type, $user_id, $essay_points) {  
246.	        if (!isset($question_type)) {  
247.	            $question_type = 0;  
248.	        }  
249.	        if (!isset($essay_points)) {  
250.	            $essay_points = 0;  
251.	        }  
252.	        $this->insert('exams_question', array('exam_id' => $exam_id, 'question_name' => "'$question_name'", 'question_type' => $question_type, 'question_created_by' => $user_id, 'essay_points' => $essay_points));  
253.	    }  
254.	  
255.	    public function loadQuestion($exam_id) {  
256.	        $sql = "SELECT  * FROM users   
257.	                LEFT JOIN exams ON users.user_id = exams.exam_created_by   
258.	                LEFT JOIN exams_question ON exams.exam_id = exams_question.exam_id   
259.	                WHERE exams.exam_id =" . $exam_id . " ORDER BY exams_question.question_id ASC";  
260.	        $result['exam'] = $this->fetch_all_rows($sql);  
261.	        if (is_array($result['exam'])) {  
262.	            foreach ($result['exam'] as $row) {  
263.	                $sql = "SELECT * FROM exams_answers WHERE question_id = $row[question_id] order by answer_id asc";  
264.	                $result[$row['question_id']] = $this->fetch_all_rows($sql);  
265.	            }  
266.	        }  
267.	  
268.	  
269.	        return $result;  
270.	        //print_r($result['here']);  
271.	    }  
272.	  
273.	    public function questionedit($question_id) {  
274.	        /* 
275.	          return $this->fetch_all_rows('select * from exams_question 
276.	          LEFT join exams_answers on exams_question.question_id =  exams_answers.question_id 
277.	          where exams_answers.question_id ='.$question_id . ' order by answer_id'); 
278.	         */  
279.	        $sql = 'select * from exams_question WHERE question_id=' . $question_id;  
280.	  
281.	        return $this->fetch_all_rows($sql);  
282.	    }  
283.	  
284.	    public function questionupdate($question_name, $question_type, $question_id, $essay_points) {  
285.	        if (!isset($question_type)) {  
286.	            $question_type = 0;  
287.	        }  
288.	        $sql = "UPDATE exams_question SET question_name ='$question_name', question_type = $question_type, essay_points = $essay_points WHERE question_id =" . $question_id;  
289.	  
290.	        $this->query($sql);  
291.	        //$admin->questionupdate($question_name,$question_type,$question_id);  
292.	    }  
293.	  
294.	    public function questiondelete($exam_id) {  
295.	        //$sql = "UPDATE exams SET isdeleted = 1 WHERE exam_id  = $exam_id";  
296.	        $sql = "DELETE FROM exams WHERE exam_id = $exam_id";  
297.	        $this->query($sql);  
298.	    }  
299.	  
300.	    //for answers  
301.	    public function answeredit($answer_id) {  
302.	        return $this->fetch_all_rows('select * from exams_answers where answer_id =' . $answer_id);  
303.	    }  
304.	  
305.	    public function answerupdate($answer_id, $answer_name, $flag, $question_id) {  
306.	        if ($flag == 1) {  
307.	            $this->query("UPDATE exams_answers SET answer_flag = 0 WHERE question_id = " . $question_id);  
308.	  
309.	            $sql = "UPDATE exams_answers   
310.	                    SET answer_name ='$answer_name', answer_flag = 1   
311.	                    WHERE answer_id = " . $answer_id;  
312.	        } else {  
313.	            $sql = "UPDATE exams_answers SET answer_name ='$answer_name' WHERE answer_id = " . $answer_id;  
314.	        }  
315.	  
316.	        $this->query($sql);  
317.	    }  
318.	  
319.	    public function answeraddinsert($answer_name, $flag, $question_id) {  
320.	        if (isset($flag)) {  
321.	            $this->query("UPDATE exams_answers SET answer_flag = 0 WHERE question_id = " . $question_id);  
322.	        } else {  
323.	            $flag = 0;  
324.	        }  
325.	        $this->insert('exams_answers', array('answer_name' => "'$answer_name'", 'question_id' => $question_id, 'answer_flag' => $flag));  
326.	    }  
327.	  
328.	    public function answerdelete($answer_id) {  
329.	        $this->query("DELETE FROM exams_answers WHERE answer_id = $answer_id");  
330.	    }  
331.	  
332.	    /* check if the user is allowed to check exam */  
333.	  
334.	    public function allowedtocheck($user_id) {  
335.	        return $this->query("SELECT * FROM users WHERE user_id = $user_id");  
336.	    }  
337.	  
338.	}  
authenticateModel.php
1.	<?php  
2.	Class authenticateModel extends _Db{  
3.	    public function login($user_name, $user_password){  
4.	        //return $this->fetch_all_rows("SELECT * FROM users WHERE user_name ='$user_name' AND user_password = '$user_password' AND user_enabled = 1");  
5.	        return $this->fetch_all_rows("SELECT * FROM users WHERE user_name ='$user_name' AND user_password = '$user_password'");  
6.	    }  
7.	}  
8.	  
9.	?>  
staffModel.php
1.	<?php  
2.	Class staffModel extends _Db{  
3.	    public function exam_list($user_id){  
4.	        $sql = "SELECT * FROM exams   
5.	                INNER JOIN  users ON exams.department_id = users.department_id  
6.	                WHERE /*CURDATE() BETWEEN exam_from AND exam_to  
7.	                AND*/  users.user_id = $user_id ORDER BY exam_id ASC";  
8.	        $result['exam'] = $this->fetch_all_rows($sql);  
9.	        if(is_array($result['exam'])){  
10.	            foreach($result['exam'] as $row){  
11.	  
12.	                if ($row['isdeleted'] == 0){  
13.	                    $sql = "SELECT * FROM transaction_dtl where user_id=$user_id and exam_id =".$row['exam_id'] . " ORDER BY exam_id ASC" ;  
14.	                    //echo $sql . '</br>';  
15.	                    $result[$row['exam_id']] = $this->fetch_all_rows($sql);    
16.	                }  
17.	            }     
18.	        }  
19.	        return $result;  
20.	        //return $this->fetch_all_rows($sql);  
21.	    }  
22.	  
23.	    public function getexamfirst($exam_id){  
24.	        $sql = "SELECT *, count(exams.exam_id) FROM exams   
25.	                LEFT JOIN exams_question ON exams.exam_id = exams_question.exam_id  
26.	                WHERE exams.exam_id = $exam_id GROUP BY exams.exam_id ORDER BY question_id ASC ";  
27.	        $result['count'] = $this->fetch_all_rows($sql);  
28.	        $sql = "SELECT * FROM exams   
29.	                INNER JOIN exams_question ON exams.exam_id = exams_question.exam_id  
30.	                WHERE exams.exam_id = $exam_id order by question_id ASC LIMIT 0,1";  
31.	        $result['exam'] = $this->fetch_all_rows($sql);  
32.	        if (is_array($result['exam'])){  
33.	            foreach($result['exam'] as $row){  
34.	                $sql = "SELECT * FROM exams_answers WHERE question_id = $row[question_id] order by answer_id asc";  
35.	                $result[$row['question_id']] = $this->fetch_all_rows($sql);  
36.	            }  
37.	        }  
38.	        return $result;  
39.	    }  
40.	    public function alreadytaken($user_id, $exam_id){  
41.	        $sql = "SELECT * FROM transaction_dtl WHERE user_id = $user_id AND exam_id = $exam_id";  
42.	        return $this->fetch_all_rows($sql);  
43.	    }  
44.	    public function getexamnext($exam_id, $start){  
45.	        $sql = "SELECT * FROM exams   
46.	                LEFT JOIN exams_question ON exams.exam_id = exams_question.exam_id  
47.	                WHERE exams.exam_id = $exam_id order by question_id ASC LIMIT ". $start. ",1";  
48.	  
49.	        $result['exam'] = $this->fetch_all_rows($sql);  
50.	        if (is_array($result['exam'])){  
51.	            foreach($result['exam'] as $row){  
52.	                $sql = "SELECT * FROM exams_answers WHERE question_id = $row[question_id] order by answer_id asc";  
53.	                $result[$row['question_id']] = $this->fetch_all_rows($sql);  
54.	            }  
55.	        }  
56.	          
57.	        return $result;  
58.	    }  
59.	    public function submitresult( $user_id, $exam_id, $time_consumed ){  
60.	        $sql = "SELECT UUID()";  
61.	        $uuid = $this->query($sql);  
62.	        $uuid = substr($uuid[0]['UUID()'],0,8);  
63.	        $date = date("Y-m-d");  
64.	        $this->insert('transaction',array('transaction_date'=>"'$date'",'transaction_code'=>"'$uuid'",'user_id'=>$user_id,'exam_id'=>$exam_id,'time_consumed'=>$time_consumed));  
65.	        if (isset($_SESSION['question_id'])){  
66.	            foreach($_SESSION['answer_id'] as $row){  
67.	                if (isset($_SESSION['answer'][$row])){  
68.	                    $answer = $_SESSION['answer'][$row];  
69.	                }else{  
70.	                    $answer='null';  
71.	                }  
72.	                $qtype = $_SESSION['question_id'][$row];  
73.	                $question_type = $this->query("SELECT * FROM exams_question WHERE question_id = $qtype");  
74.	                //print_r($question_type);  
75.	                $question_type = $question_type[0]['question_type'];  
76.	                $sql = "SELECT * FROM exams_answers WHERE answer_id = $row";  
77.	                $correct = $this->fetch_all_rows($sql);  
78.	                //print_r($correct);  
79.	                $score = 0;   
80.	                $israted=0;  
81.	                if ($correct[0]['answer_flag']==1){  
82.	                    $score = 1;  
83.	                }  
84.	                if ( $question_type==0 ){  
85.	                    $israted=1;  
86.	                }  
87.	                $this->insert('transaction_dtl',array('user_id'=>$user_id,'question_id'=>$_SESSION['question_id'][$row],  
88.	                                                      'transaction_answer_id'=>$row,  
89.	                                                      'exam_id'=>$exam_id,'essay'=>"'$answer'",'transaction_code'=>"'$uuid'",  
90.	                                                      'transaction_question_type'=>$question_type,'score'=>$score,'israted'=>$israted));  
91.	            }     
92.	        }else{  
93.	            $this->insert('transaction_dtl',array('user_id'=>$user_id,'question_id'=>0,'transaction_answer_id'=>0,'exam_id'=>$exam_id,'transaction_code'=>"'$uuid'",'israted'=>0));  
94.	        }  
95.	          
96.	    }  
97.	    public function viewresults( $exam_id,$user_id){  
98.	        $sql = "SELECT * FROM exams WHERE exam_id = $exam_id";  
99.	        $result['exam_name'] = $this->fetch_all_rows($sql);  
100.	  
101.	        $sql = "SELECT *   
102.	                FROM transaction_dtl  
103.	                INNER JOIN exams_question ON transaction_dtl.question_id = exams_question.question_id  
104.	                LEFT JOIN exams_answers ON transaction_dtl.transaction_answer_id = exams_answers.answer_id  
105.	                WHERE user_id = $user_id AND transaction_dtl.exam_id = $exam_id ORDER BY exams_question.question_id ASC";  
106.	        $result['transaction_dtl'] = $this->query($sql);  
107.	        return $result;  
108.	    }  
109.	    public function examsresult($from = '', $to = '') {  
110.	        //return $this->fetch_all_rows('select * from exams WHERE NOW() BETWEEN exam_from AND exam_to ORDER BY exam_id ASC');  
111.	        if ($from != '' && $to != '') {  
112.	            $WHERE = " WHERE exam_from >= '$from' AND exam_to <= '$to' ORDER BY exams.exam_id, transaction.user_id ASC";  
113.	        } else {  
114.	            $WHERE = " WHERE CURDATE() BETWEEN exam_from AND exam_to ORDER BY exams.exam_id, transaction.user_id ASC";  
115.	        }  
116.	        $sql = "SELECT * FROM transaction   
117.	                INNER JOIN users ON transaction.user_id = users.user_id  
118.	                INNER JOIN exams ON transaction.exam_id = exams.exam_id   
119.	                $WHERE";  
120.	       // echo $sql;  
121.	        $result['exam'] = $this->fetch_all_rows($sql);  
122.	        if (is_array($result['exam'])) {  
123.	            foreach ($result['exam'] as $row) {  
124.	                $sql = "SELECT SUM(score) AS 'score' FROM transaction_dtl WHERE user_id = $row[user_id]  AND exam_id = $row[exam_id] ORDER BY exam_id, user_id ASC";  
125.	                $result[$row['user_id']][$row['exam_id']] = $this->fetch_all_rows($sql);  
126.	            }  
127.	            
128.	        }  
129.	        return $result;  
130.	    }  
131.	    public function loadExams($from, $to) {  
132.	        if ($from != '' && $to != '') {  
133.	            $WHERE = " LEFT JOIN department ON exams.department_id = department.department_id WHERE exam_from >= '$from' AND exam_to <= '$to'  ORDER BY exam_id ASC";  
134.	        } else {  
135.	            $WHERE = " LEFT JOIN department ON exams.department_id = department.department_id /*WHERE CURDATE() BETWEEN exam_from AND exam_to*/ ORDER BY exam_id ASC";  
136.	        }  
137.	        $sql = "select * from exams $WHERE ";  
138.	        return $this->fetch_all_rows($sql);  
139.	    }  
140.	}  
141.	  
142.	?>  
layouts.php
1.	<html>  
2.	    <head>  
3.	        <meta http-equiv="content-language" content="en"/>  
4.	        <meta http-equiv="content-style-type" content="text/css"/>  
5.	        <meta http-equiv="content-script-type" content="text/javascript"/>  
6.	        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>  
7.	  
8.	        <link rel="stylesheet" type="text/css" href="public/css/layout-z.css">  
9.	        <link rel="stylesheet" type="text/css" href="public/css/jquery.ui.datepicker.css">  
10.	        <!--  
11.	        <script type="text/javascript" src="public/js/jquery-1.6.2.js"></script>  
12.	  
13.	        -->  
14.	        <script src="public/js/jquery.min.js"></script>  
15.	        <script src="public/js/jquery-ui.min.js"></script>  
16.	        <link href="public/css/jquery-ui.css" rel="stylesheet" type="text/css"/>  
17.	  
18.	  
19.	        <title> Online Exam </title>  
20.	<p style="text-align: center; font-size: 20px; font-weight: bold;">ONLINE EXAMINATION</p>  
21.	        <script language="javascript">  
22.	            $(document).ready(function(){  
23.	                //$("#exam_from2").datepicker();  
24.	<?php  
25.	if (isset($_SESSION['user_id'])) {  
26.	    ?>  
27.	                loadPage('index.php?admin/exams');  
28.	    <?php  
29.	}  
30.	?>  
31.	          
32.	    });  
33.	    function loadPage( url ){  
34.	        //alert(url);  
35.	        $('.body_data').load( url );  
36.	    }  
37.	  
38.	    function deleteData( url, loadBack ){  
39.	        if (confirm("Do you want to delete this??")){  
40.	            $.post(url,function(){  
41.	                $('.body_data').load( loadBack );  
42.	            })  ;  
43.	        }  
44.	    }  
45.	          
46.	        </script>  
47.	  
48.	    </head>  
49.	    <body>  
50.	        <div id="fb-root"></div>  
51.	        <script>  
52.	            (function(d, s, id) {  
53.	              var js, fjs = d.getElementsByTagName(s)[0];  
54.	              if (d.getElementById(id)) return;  
55.	              js = d.createElement(s); js.id = id;  
56.	              js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&appId=735682916475167&version=v2.0";  
57.	              fjs.parentNode.insertBefore(js, fjs);  
58.	            }(document, 'script', 'facebook-jssdk'));  
59.	        </script>  
60.	        <form action="index.php?authenticate/verify" method="post">  
61.	            <div class="wrapper" style="margin-top: 25px;">  
62.	                <?php  
63.	                //echo date('g:i A ',$data['data'][0]['lecture_time_from']);  
64.	                //echo 5400  
65.	                ?>  
66.	                <div class="bodycontainer" style="">  
67.	                    <div class="left_menu" style="width: 990px;margin-top: 10px;">  
68.	                        <?php  
69.	                        echo $data['nav'];  
70.	                        ?>  
71.	                    </div>  
72.	                    <div class="contentcontainer" style="">  
73.	                        <div class="right_menu" style="width: 990px; height: auto;overflow:hidden; float: left;">  
74.	                            <div class="body_data" style="width: auto; height: auto; overflow: hidden; margin-top: 5px;">  
75.	                            </div>  
76.	                        </div>  
77.	                    </div>  
78.	                </div>  
79.	            </div>      
80.	  
81.	        </form>  
82.	                    <div style="margin-top: 30px; text-align: center;">  
83.	                <div id="fbpage" style="">  
84.	                The website was created and designed by <a href="https://instagram.com/alimkh_n" class="font-size: 14px;">Alimkhan Akimzhan</a>.  
85.	                <br>Do you have any problems?  Send me a direct message in Instagram.</br>  
86.	                  
87.	                    <!-- <div>  
88.	                        <span style="font-size: 20px; font-weight: bold;"> This Project Is Open Source!</br>You can use this for any particular purpose for FREE!</br>Because human knowledge belongs to the world!</br></br>Please show your support by LIKING this <a target="_blank" href="https://www.facebook.com/reviewhype">Facebook Page.</a></span></br>  
89.	                    </div>  
90.	                    <div class="fb-like-box" data-href="https://www.facebook.com/reviewhype" data-colorscheme="light" data-show-faces="true" data-header="false" data-stream="false" data-show-border="false" data-height="300"></div> -->                </div>  
91.	            </div>  
92.	    </body>  
93.	</html>  
layouts2.php
1.	<html>  
2.	<head>  
3.	    <meta http-equiv="content-language" content="en"/>  
4.	    <meta http-equiv="content-style-type" content="text/css"/>  
5.	    <meta http-equiv="content-script-type" content="text/javascript"/>  
6.	    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>  
7.	  
8.	    <link rel="stylesheet" type="text/css" href="public/css/layout-z.css">  
9.	    <link rel="stylesheet" type="text/css" href="public/css/jquery.ui.datepicker.css">  
10.	    <!--  
11.	    <script type="text/javascript" src="public/js/jquery-1.6.2.js"></script>  
12.	  
13.	-->  
14.	    <script src="public/js/jquery.min.js"></script>  
15.	    <script src="public/js/jquery-ui.min.js"></script>  
16.	    <link href="public/css/jquery-ui.css" rel="stylesheet" type="text/css"/>  
17.	    <title> Online Exam </title>  
18.	<p style="text-align: center; font-size: 20px; font-weight: bold;">ONLINE EXAMINATION</p>  
19.	    <script language="javascript">  
20.	    function loadPage( url ){  
21.	        //alert(url);  
22.	        $('.body_data').load( url );  
23.	    }  
24.	    function deleteData( url, loadBack ){  
25.	        if (confirm("Do you want to delete this??")){  
26.	            $.post(url,function(){  
27.	                $('.body_data').load( loadBack );  
28.	            })  ;  
29.	        }  
30.	    }  
31.	    $(document).ready(function(){  
32.	        //$("#exam_from2").datepicker();  
33.	        loadPage('index.php?staff/index');  
34.	    });       
35.	    </script>  
36.	      
37.	</head>  
38.	<body>  
39.	<div id="fb-root"></div>  
40.	<script>  
41.	    (function(d, s, id) {  
42.	      var js, fjs = d.getElementsByTagName(s)[0];  
43.	      if (d.getElementById(id)) return;  
44.	      js = d.createElement(s); js.id = id;  
45.	      js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&appId=735682916475167&version=v2.0";  
46.	      fjs.parentNode.insertBefore(js, fjs);  
47.	    }(document, 'script', 'facebook-jssdk'));  
48.	</script>  
49.	<form action="index.php?authenticate/verify" method="post">  
50.	<div class="wrapper" style="margin-top:25px;">  
51.	    <?php   
52.	    //echo date('g:i A ',$data['data'][0]['lecture_time_from']);  
53.	    //echo 5400  
54.	    ?>  
55.	    <div class="bodycontainer" style="">  
56.	        <div class="left_menu" style="width: 990px; height: auto;">  
57.	            <?php   
58.	                echo $data['nav'];  
59.	            ?>  
60.	        </div>  
61.	        <div class="contentcontainer" style="">  
62.	  
63.	            <div class="right_menu" style="width: 990px; height: auto;overflow:hidden; float: left;">  
64.	                <div class="body_data" style="width: auto; height: auto; overflow: hidden; margin-top: 5px;">  
65.	                          
66.	                </div>  
67.	            </div>  
68.	        </div>  
69.	    </div>  
70.	</div>      
71.	</form>  
72.	  
73.	<div style="margin-top: 30px; text-align: center;">  
74.	    <div id="fbpage" style="">  
75.	    The website was created and designed by <a href="https://instagram.com/alimkh_n" class="font-size: 14px;">Alimkhan Akimzhan</a>.  
76.	                    <br>Do you have any problems?  Send me a direct message in Instagram.</br>  
77.	       <!--  <div>  
78.	            <span style="font-size: 20px; font-weight: bold;"> This Project Is Open Source!</br>You can use this for any particular purpose for FREE!</br>Because human knowledge belongs to the world!</br></br>Please show your support by LIKING this <a target="_blank" href="https://www.facebook.com/reviewhype">Facebook Page.</a></span></br>  
79.	        </div>  
80.	        <div class="fb-like-box" data-href="https://www.facebook.com/reviewhype" data-colorscheme="light" data-show-faces="true" data-header="false" data-stream="false" data-show-border="false" data-height="300"></div>  
81.	    </div> -->  
82.	</div>  
83.	</body>  
84.	</html>  
answer-add.php
1.	<script language="javascript">  
2.	$(document).ready(function(){  
3.	    $('#cancel').click(function(){  
4.	        loadPage('index.php?admin/questionlist&exam_id='+ $('#exam_id').val());  
5.	    });  
6.	    $('#save').click(function(){  
7.	        var flag = 0;  
8.	        if ($('#right_answer').attr('checked')){  
9.	            flag = 1;  
10.	        }  
11.	  
12.	        $.post('index.php?admin/answeraddinsert',{'answer_name': $('#answer_name').val(), 'flag':flag, 'question_id' : $('#question_id').val()}, function(){  
13.	            loadPage('index.php?admin/questionlist&exam_id='+ $('#exam_id').val());  
14.	        });  
15.	          
16.	      
17.	    });  
18.	});  
19.	</script>  
20.	<style>  
21.	.mcstyle{  
22.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
23.	}  
24.	</style>  
25.	<div style="width: 730px; height: 675px;">  
26.	<table>  
27.	<tr>  
28.	    <td class="mcstyle"> Answer : </td>  
29.	    <td class="mcstyle">   
30.	        <input type="text" id="answer_name" class="user_input"/>   
31.	        <input type="checkbox" id="right_answer"/> Correct Answer  
32.	    </td>  
33.	</tr>  
34.	<tr>  
35.	    <td> <input type='button' id="save" name="save" value="Save"/></td>  
36.	    <td> <input type='button' id="cancel" name="cancel" value="Cancel"/></td>  
37.	</tr>   
38.	<input type="hidden" id="question_id" value="<?php echo $data['question_id'];?>">  
39.	<input type="hidden" id="exam_id" value="<?php echo $data['exam_id'];?>">  
40.	</table>  
41.	</div>  
answer-edit.php
1.	<script language="javascript">  
2.	$(document).ready(function(){  
3.	    $('#cancel').click(function(){  
4.	        loadPage('index.php?admin/questionlist&exam_id='+ $('#exam_id').val());  
5.	    });  
6.	    $('#save').click(function(){  
7.	        var flag = 0;  
8.	        if ($('#right_answer').attr('checked')){  
9.	            flag = 1;  
10.	        }  
11.	  
12.	        $.post('index.php?admin/answerupdate',{'answer_id' : $('#answer_id').val(), 'answer_name': $('#answer_name').val(), 'flag':flag, 'question_id' : $('#question_id').val()}, function(){  
13.	            loadPage('index.php?admin/questionlist&exam_id='+ $('#exam_id').val());  
14.	        });  
15.	          
16.	      
17.	    });  
18.	});  
19.	</script>  
20.	<style>  
21.	.mcstyle{  
22.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
23.	}  
24.	</style>  
25.	<div style="width: 730px; height: 675px;">  
26.	<table>  
27.	<tr>  
28.	    <td class="mcstyle"> Answer : </td>  
29.	    <td class="mcstyle">   
30.	        <input type="text" id="answer_name" class="user_input" value="<?php echo $data[0]['answer_name'];?>"/>   
31.	        <input type="checkbox" <?php echo ($data[0]['answer_flag']) == 1 ? 'checked' :''; ?> id="right_answer"/> Correct Answer  
32.	    </td>  
33.	</tr>  
34.	<tr>  
35.	    <td> <input type='button' id="save" name="save" value="Save"/></td>  
36.	    <td> <input type='button' id="cancel" name="cancel" value="Cancel"/></td>  
37.	</tr>  
38.	<input type="hidden" id="exam_id" value="<?php print_r($data['exam']);//echo $data['exam'][0];?>">   
39.	<input type="hidden" id="answer_id" value="<?php echo $data['answer_id'] ;?>">   
40.	<input type="hidden" id="question_id" value="<?php echo $data['question_id'];?>">  
41.	</table>  
42.	</div>  
checkresults.php
1.	<script language="javascript">  
2.	    $(document).ready(function(){  
3.	        $('#back').click(function(){  
4.	            loadPage('index.php?admin/examsresult');  
5.	        });  
6.	        $('.Update').click(function(){  
7.	            id = $(this).attr('id');  
8.	            if ( $(this).val() == 'Edit' ){  
9.	                $('#'+id+'txt').attr('disabled',false);  
10.	                $(this).val('Update');  
11.	            }else{  
12.	                if ( $('#'+id+'txt').val() != '' ){  
13.	                    $.post('index.php?admin/rateupdate',{'score': $('#'+id+'txt').val(),'transaction_dtl_id':$(this).attr('id')},function(){  
14.	                        loadPage('index.php?admin/checkresult&exam_id='+$('#exam_id').val()+'&user_id='+$('#user_id').val());  
15.	                    });  
16.	                }else{  
17.	                    alert('Input Score');  
18.	                }  
19.	              
20.	            }  
21.	        });  
22.	        $('#check_status').change(function(){  
23.	            $.post('index.php?admin/checkstatus',{'status': $(this).val(), 'user_id':$('#user_id').val(), 'exam_id': $('#exam_id').val()});  
24.	  
25.	            //alert($(this).val());  
26.	        });   
27.	    });  
28.	    function isNumberKey(evt){  
29.	        var charCode = (evt.which) ? evt.which : event.keyCode  
30.	        if (charCode > 31 && (charCode < 48 || charCode > 57))  
31.	            return false;  
32.	        return true;  
33.	    }  
34.	</script>  
35.	<style>  
36.	    .table-new {border:1px solid #00688B;text-align: center; margin-left:50px;}  
37.	    .table-new tbody{border: 1px solid #00688B;}  
38.	    .line {text-align: left;border-right: 1px solid #00688B;padding-right: 2px;margin-right: 5px;border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
39.	    .line1{border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
40.	    .line2{border-right: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important; font-weight:bold;}  
41.	  
42.	  
43.	    .error-msg{  
44.	        overflow:hidden;  
45.	        width:900px;   
46.	    }  
47.	    .error-msg h5{  
48.	        overflow:hidden;  
49.	        color:#F00;  
50.	        text-transform:uppercase;  
51.	        background: white;  
52.	    }  
53.	    .mcstyle{  
54.	        font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
55.	    }  
56.	</style>  
57.	<table width="90%" style="margin-left:50px;font-size: 16px; color: #535353;">  
58.	  
59.	    <tr>  
60.	        <td>  
61.	            Examinee Name : <?php echo '<b>' . $data['transaction_dtl'][0]['user_lname'] . ', ' . $data['transaction_dtl'][0]['user_fname'] . '</b>'; ?>  
62.	        </td>  
63.	        <td align="right"> <b> Check Status :</b>  
64.	        <select id="check_status">  
65.	            <option <?php echo ( $data['transaction_dtl'][0]['check_status'] == 1 ) ? 'selected' :'' ; ?> value="1"> Checked </option>   
66.	            <option <?php echo ( $data['transaction_dtl'][0]['check_status'] == 0 ) ? 'selected' :'' ; ?> value="0"> Not Yet </option>   
67.	        </select>  
68.	        </td>  
69.	        <td align="right">  
70.	            <input type="button" value="Back" id="back">  
71.	        </td>  
72.	    </tr>  
73.	</table>  
74.	  
75.	<table width="90%" class="table-new" border="0" cellspacing="0" cellpadding="5">  
76.	    <tr class="tr-head">  
77.	        <td width="250" align="center" class="line2"><b> Questions  </b></td>  
78.	        <td width="100" align="center" class="line2"><b> Answers </b></td>  
79.	        <td width="100" align="center" class=""><b> Scores </b></td>  
80.	    </tr>  
81.	    <?php  
82.	    $cnt = 0;  
83.	    $correct = 0;  
84.	    if (is_array($data['transaction_dtl'])) {  
85.	        foreach ($data['transaction_dtl'] as $row) {  
86.	            $cnt++;  
87.	            if ($row['israted'] <> 0) {  
88.	                $correct += $row['score'];  
89.	            }  
90.	            ?>  
91.	            <tr>  
92.	                <td align="" class="line" width="350"> <?php echo $cnt . '. ' . $row['question_name']; ?> <?php //echo ($row['question_type'] == 1 ? "<span style='color:red;'> (essay) </span>" : '');   ?> </td>  
93.	                <?php  
94.	                if ($row['israted'] == 0) {  
95.	                    ?>  
96.	                    <td class="line" width="650"> <span style="color: black"><?php echo $row['essay']; ?> </span></td>  
97.	                    <?php  
98.	                } else {  
99.	                    ?>  
100.	                    <td class="line" width="650"> <span style="<?php echo ($row['score'] == 0 ? 'color: red' : 'color:green'); ?>"><?php echo ($row['answer_name'] != '' ? $row['answer_name'] : $row['essay']); ?> </span></td>  
101.	                    <?php  
102.	                }  
103.	                ?>  
104.	                <?php  
105.	                $transaction_dtl_id = $row['transaction_dtl_id'];  
106.	                $url = 'index.php?admin/rate&transaction_dtl_id=' . $transaction_dtl_id . '&exam_id=' . $data['exam_id'][0] . '&user_id=' . $data['user_id'][0];  
107.	                ?>  
108.	                <td align="center" class="line1" width="130">  
109.	                    <?php  
110.	                    if ($row['israted'] == 0) {  
111.	                        //echo $row['essay_points'];  
112.	                        if ($row['essay_points'] > 0) {  
113.	                            echo "<select disabled  id='" . $row['transaction_dtl_id'] . 'txt' . "'>";  
114.	                            for ($i = 0; $i <= $row['essay_points']; $i++) {  
115.	  
116.	                                echo "<option value=$i> $i  </option>";  
117.	                            }  
118.	                            echo "</select>";  
119.	                        }  
120.	                        ?>  
121.	                        <input type="button" value="Edit" class="Update" id="<?php echo $row['transaction_dtl_id']; ?>" style="width: 54px; height:25px;">  
122.	                        <!--  
123.	                                <input type="text" disabled id="<?php // echo $row['transaction_dtl_id'] . 'txt';   ?>" style="width:30px;height:25px;" onkeypress="return isNumberKey(event)">  
124.	                                <input type="button" class="correct" value="Correct" id="<?php //echo $row['transaction_dtl_id'];    ?>">   
125.	                                <input type="button" class="wrong" value="Wrong" id="<?php //echo $row['transaction_dtl_id'];    ?>">  
126.	                        -->  
127.	                        <?php  
128.	                    } else {  
129.	                        echo '<center>' . $row['score'] . '</center>';  
130.	                    }  
131.	                    ?>  
132.	                </td>  
133.	            </tr>  
134.	            <?php  
135.	        }  
136.	    }  
137.	    ?>  
138.	</table>  
139.	<div style="float:right; padding-right: 40px; margin-right:10px;" class="mcstyle">  
140.	    <table class="mcstyle" style="font-size: 13px;">  
141.	        <tr>  
142.	            <td align="right"> <b> Score: </b></td>  
143.	            <td> <b> <?php echo $correct . ' out of ' . $data['exam_name'][0]['passing_score']; ?></b> </td>  
144.	        </tr>  
145.	        <tr>  
146.	            <td align="right"> <b>Grade: </b> </td>  
147.	            <td>   
148.	                <b>  
149.	                    <?php  
150.	                    $grade = ($correct / $data['exam_name'][0]['passing_score']) * 100;  
151.	                    echo $grade . '%';  
152.	                    ?>    
153.	                </b>   
154.	            </td>  
155.	        </tr>  
156.	        <tr>  
157.	            <td align="right"> <b> Remark: </b></td>  
158.	            <td>   
159.	                <?php  
160.	                if ($grade >= $data['exam_name'][0]['passing_grade']) {  
161.	                    echo "<span style='color: green;'><b>Passed</b></span>";  
162.	                } else {  
163.	                    echo "<span style='color: red;'><b>Failed</b></span>";  
164.	                }  
165.	                ?>  
166.	            </td>  
167.	        </tr>  
168.	    </table>  
169.	</div>  
170.	  
171.	<input type="hidden" id="exam_id" value="<?php print_r($data['exam_id']); ?>">  
172.	<input type="hidden" id="user_id" value="<?php print_r($data['user_id']); ?>">  
department_list.php
1.	<style>  
2.	    .table-new {border:1px solid #00688B;text-align: center; margin-left:50px;}  
3.	    .table-new tbody{border: 1px solid #00688B;}  
4.	    .line {border-right: 1px solid #00688B;padding-right: 2px;margin-right: 5px;border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
5.	    .line1{border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
6.	    .line2{border-right: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important; font-weight:bold;}  
7.	  
8.	  
9.	    .error-msg{  
10.	        overflow:hidden;  
11.	        width:900px;   
12.	    }  
13.	    .error-msg h5{  
14.	        overflow:hidden;  
15.	        color:#F00;  
16.	        text-transform:uppercase;  
17.	        background: white;  
18.	    }  
19.	    .mcstyle{  
20.	        font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
21.	    }  
22.	</style>  
23.	<div style="width: 100%; height: auto;">  
24.	    <table width="90%" class="table-new" border="0" cellspacing="0" cellpadding="5">  
25.	        <tr class="tr-head">  
26.	            <td width="300" class="line2"> Department Level </td>  
27.	            <td widt="100" class="" > Action </td>  
28.	        </tr>  
29.	        <?php  
30.	        if (is_array($data)) {  
31.	            foreach ($data as $row) {  
32.	                ?>  
33.	                <tr>  
34.	                    <td class="line"> <?php echo $row['department_name']; ?> </td>  
35.	                    <td width="100" align="center" class="line1">  
36.	                        <a href="javascript:loadPage('index.php?admin/departmentedit&department_id=<?php echo $row['department_id']; ?>');"> Edit</a> |  
37.	                        <a href="javascript:deleteData('index.php?admin/departmentdelete&department_id=<?php echo $row['department_id']; ?>','index.php?admin/departments');"> Delete</a>  
38.	                        <!--  
39.	                        <input type="button" id="edit" name="edit" value="Edit" style="width:50px; height: 25px;"/>  
40.	                        <input type="button" id="delete" name="delete" value="Delete" style="width: 50px; height: 25px;"/>  
41.	                        -->  
42.	                    </td>  
43.	                </tr>  
44.	                <?php  
45.	            }  
46.	        }  
47.	        ?>  
48.	    </table>  
49.	</div>  
departments.php
1.	<script language="javascript">  
2.	$(document).ready(function(){  
3.	      
4.	    $.get('index.php?admin/departmentlist',function(data){  
5.	        $('#dept_list').html(data);  
6.	    })  
7.	    /* 
8.	    $('#add').click(function(){ 
9.	        $('#departments').load('index.php?admin/departmentsadd'); 
10.	    }); 
11.	    */  
12.	});  
13.	</script>  
14.	<style>  
15.	a{  
16.	  text-decoration: none;  
17.	  font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.9em;  
18.	}  
19.	  a:hover {  
20.	  text-decoration: underline;  
21.	}  
22.	</style>  
23.	<div id="departments" class="users" style="width: 100%; height: auto; margin-bottom:10px;">  
24.	    <div style="margin-left:50px;">  
25.	        <a href="javascript:loadPage('index.php?admin/departmentsadd');">Add new </a>  
26.	        <!--  
27.	        <input type="button" style="width: 150px; height: 25px;" value="Add New" id="add">  
28.	    -->  
29.	    </div><br />  
30.	    <div id="dept_list" class="dept_list">  
31.	  
32.	    </div>  
33.	</div>  
departments-add.php
1.	<script language="javascript">  
2.	  
3.	$(document).ready(function(){  
4.	    $('#cancel').click(function(){  
5.	        $('#department').load('index.php?admin/departments');  
6.	    })  
7.	    $('#save').click(function(){  
8.	        var error ="Please fill up the requirement below \r\n----------------------------------------\r\n";  
9.	        var msg = error;  
10.	        if( $('#department_name').val() == '' ){  
11.	            msg += '*Department Level \r\n';  
12.	        }  
13.	        if (msg == error){  
14.	            $.post('index.php?admin/savedepartmentnew',$("#dept_add").serialize(),function(data){  
15.	                $('#department').load('index.php?admin/departments');  
16.	            });   
17.	              
18.	        }else{  
19.	            alert(msg);   
20.	        }  
21.	    });  
22.	});  
23.	</script>  
24.	<style>  
25.	.mcstyle{  
26.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
27.	}  
28.	</style>  
29.	<div id="department" class="department" style="width: 100%; height: 675px;">  
30.	    <div class="dept_add_data">  
31.	    <form name="dept_add" id="dept_add">  
32.	    <table width="30%%">  
33.	    <tr>  
34.	        <td class="mcstyle"> Department Code : </td>  
35.	        <td> <input type="text" id="department_code" name="department_code" class="user_input"/> </td>  
36.	    </tr>  
37.	    <tr>  
38.	        <td class="mcstyle"> Department Level :</td>  
39.	        <td> <input type="text" id="department_name" name="department_name" class="user_input"/> </td>  
40.	    </tr>  
41.	    <tr>  
42.	        <td> <input type="button" id="save" class="e_button" value="Save"></td>  
43.	        <td> <input type="button" id="cancel" class="e_button" value="Cancel"></td>  
44.	    </tr>  
45.	    </table>  
46.	    </form>  
47.	    </div>  
48.	</div>  
departments-edit.php
1.	<script language="javascript">  
2.	  
3.	$(document).ready(function(){  
4.	    $('#cancel').click(function(){  
5.	        $('#department').load('index.php?admin/departments');  
6.	    })  
7.	    $('#save').click(function(){  
8.	        var error ="Please fill up the requirement below \r\n----------------------------------------\r\n";  
9.	        var msg = error;  
10.	        if( $('#department_name').val() == '' ){  
11.	            msg += '*Department Level \r\n';  
12.	        }  
13.	        if (msg == error){  
14.	            $.post('index.php?admin/departmentupdate',$("#dept_add, :hidden").serialize(),function(data){  
15.	                $('#department').load('index.php?admin/departments');  
16.	            });   
17.	              
18.	        }else{  
19.	            alert(msg);   
20.	        }  
21.	    });  
22.	});  
23.	</script>  
24.	<style>  
25.	.mcstyle{  
26.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
27.	}  
28.	</style>  
29.	<div id="department" class="department" style="width: 100%; height: 675px;">  
30.	    <div class="dept_add_data">  
31.	    <form name="dept_add" id="dept_add">  
32.	    <table width="30%%">  
33.	    <tr>  
34.	        <td class="mcstyle"> Department Level :</td>  
35.	        <td class="mcstyle"> <input type="text" id="department_name" name="department_name" class="user_input" value="<?php echo $data[0]['department_name'];?>"/> </td>  
36.	    </tr>  
37.	    <tr>  
38.	        <td> <input type="button" id="save" class="e_button" value="Save"></td>  
39.	        <td> <input type="button" id="cancel" class="e_button" value="Cancel"></td>  
40.	    </tr>  
41.	    </table>  
42.	    <input type="hidden" id="department_id" name="department_id" value="<?php echo $data[0]['department_id'];?>">  
43.	    </form>  
44.	    </div>  
45.	</div>  
essay_rate.php
1.	<script language="javascript">  
2.	$(document).ready(function(){  
3.	    $('#save').click(function(){  
4.	        $.post('index.php?admin/rateupdate',{'score':$('#score').val(),'transaction_dtl_id':$('#dtl_id').val()},function(){  
5.	            loadPage('index.php?admin/checkresult&exam_id='+$('#exam_id').val()+'&user_id='+$('#user_id').val());  
6.	        });  
7.	    });  
8.	  
9.	});  
10.	</script>  
11.	<style>  
12.	  
13.	.mcstyle{  
14.	        font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.9em; color: #535353!important;  
15.	}  
16.	</style>  
17.	  
18.	<div style="margin: 0 auto;">  
19.	<table>  
20.	<tr>  
21.	    <td class="mcstyle"> Rate : </td>  
22.	    <td class="mcstyle"> <input type="text" id="score" value="<?php echo $data[0]['score'];?>"></td>  
23.	</tr>  
24.	<tr>  
25.	    <td> </td>  
26.	    <td> <input type="button" id="save" value="save"> </td>  
27.	</tr>  
28.	</table>  
29.	<div>  
30.	  
31.	<input type="hidden" id="dtl_id" value="<?php echo $data[0]['transaction_dtl_id'];?>">  
32.	<input type="hidden" id="exam_id" value="<?php echo $data[0]['exam_id'];?>">  
33.	<input type="hidden" id="user_id" value="<?php echo $data[0]['user_id'];?>">  
exams.php
1.	<script language="javascript">  
2.	$(document).ready(function(){  
3.	    $("#range_from").datepicker({dateFormat: 'yy-mm-dd'});  
4.	    $("#range_to").datepicker({dateFormat: 'yy-mm-dd'});  
5.	    $('#range_from').change(function(){  
6.	        //alert($(this).val());  
7.	        if ( $('#range_to').val().length > 1 ) {  
8.	            $.post('index.php?admin/examslist',{ 'from' : $('#range_from').val(), 'to' : $('#range_to').val() },  
9.	            function( data ){  
10.	                $('#exam_list').html( data );  
11.	            })  
12.	        }  
13.	    });  
14.	    $('#range_to').change(function(){  
15.	        if ( $('#range_from').val().length > 1 ) {  
16.	            $.post('index.php?admin/examslist',{ 'from' : $('#range_from').val(), 'to' : $('#range_to').val() },  
17.	            function( data ){  
18.	                $('#exam_list').html( data );  
19.	            })  
20.	        }  
21.	    });  
22.	    $.get('index.php?admin/examslist',function(data){  
23.	        $('#exam_list').html(data);  
24.	    })  
25.	  
26.	    $('#add').click(function(){  
27.	        $('#exam').load('index.php?admin/examsadd');  
28.	    });  
29.	});  
30.	</script>  
31.	<style>  
32.	a{  
33.	  text-decoration: none;  
34.	  font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.9em;;  
35.	}  
36.	  a:hover {  
37.	  text-decoration: underline;  
38.	}  
39.	</style>  
40.	  
41.	<div id="exam" class="users" style="width: 100%; height: auto; margin-bottom:10px;">  
42.	    <div style="height: 30px;">  
43.	    <table style="margin: 0 auto; width: 90%;">  
44.	    <tr>  
45.	        <td><a href="javascript:loadPage('index.php?admin/examsadd');">Add new</a></td>  
46.	        <td width="330">  </td>  
47.	  
48.	        <td class="mcstyle" align="right">   
49.	            Exam From   
50.	            <input maxlength="10" id="range_from" name="range_from" class="user_input" type="text" value="2013-04-03">  
51.	                 
52.	             Exam To   
53.	            <input maxlength="10" id="range_to" name="range_to" class="user_input" type="text">  
54.	        </td>  
55.	    </tr>  
56.	    </table>  
57.	    </div>  
58.	    <div id="exam_list" class="exam_list" style="margin: 0 auto; width: 100%;">  
59.	  
60.	    </div>  
61.	</div>  
exams_list.php
1.	<script language="javascript">  
2.	    $(document).ready(function(){  
3.	        /* 
4.	        $('.question').click(function(){ 
5.	                loadPage('index.php?admin/questions&exam_id='+ $(this).attr('id')); 
6.	        }); 
7.	         */  
8.	        $('.edit').click(function(){  
9.	            //alert($(this).attr('id'));  
10.	            loadPage('index.php?admin/questionlist&exam_id='+ $(this).attr('id'));  
11.	        });  
12.	    });  
13.	</script>  
14.	  
15.	<style>  
16.	    .table-new {border:1px solid #00688B;text-align: center; margin-left:50px; margin-bottom:15px;}  
17.	    .table-new tbody{border: 1px solid #00688B;}  
18.	    .line {border-right: 1px solid #00688B;padding-right: 2px;margin-right: 5px;border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
19.	    .line1{border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
20.	    .line2{border-right: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important; font-weight:bold;}  
21.	  
22.	  
23.	    .error-msg{  
24.	        overflow:hidden;  
25.	        width:900px;   
26.	    }  
27.	    .error-msg h5{  
28.	        overflow:hidden;  
29.	        color:#F00;  
30.	        text-transform:uppercase;  
31.	        background: white;  
32.	    }  
33.	    .mcstyle{  
34.	        font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
35.	    }  
36.	</style>  
37.	  
38.	<div style="width: 90%; height: auto;">  
39.	  
40.	    <table width="100%" class="table-new" border="0" cellspacing="0" cellpadding="5">  
41.	        <tr class="tr-head">  
42.	            <td width="270" class="line2"><b> Exam Name </b></td>  
43.	            <td width="120" class="line2"> <b>Exam Period </b></td>  
44.	            <td width="30" class="line2"> <b>Department Level </b></td>  
45.	            <td widt="150" class="">Action</td>  
46.	        </tr>  
47.	        <?php  
48.	        if (is_array($data)) {  
49.	            foreach ($data as $row) {  
50.	                // index.php?admin/examedit&exam_id=23  
51.	                //$link = "javascript:loadPage('index.php?admin/examedit&exam_id=".$row['exam_id']."')";  
52.	                $link = "javascript:loadPage('index.php?admin/questionlist&exam_id=" . $row['exam_id'] . "')";  
53.	                ?>  
54.	                <tr>  
55.	                    <td class="line"> <?php echo "<a href=$link>" . $row['exam_name'] . "</a>"; ?> </td>  
56.	                    <td class="line"> <?php echo date('m-d-Y', strtotime($row['exam_from'])) . ' - ' . date('m-d-Y', strtotime($row['exam_to'])); ?> </td>  
57.	                    <td class="line"> <?php echo $row['department_name'];?></td>  
58.	                    <td width="100" align="center" class="line1">  
59.	                        <!--  
60.	        <input type="button" id="<?php //echo //$row['exam_id']; ?>" class="edit" name="edit" value="Edit" style="width:50px; height: 25px;"/>  
61.	        <input type="button" id="delete" class="delete" name="delete" value="Delete" style="width: 50px; height: 25px;"/>  
62.	                        -->  
63.	                        <a href="javascript:loadPage('index.php?admin/examedit&exam_id=<?php echo $row['exam_id'] ?>');"> Edit</a> |  
64.	                        <a href="javascript:deleteData('index.php?admin/questiondelete&exam_id=<?php echo $row['exam_id'] ?>','index.php?admin/exams');"> Delete</a>  
65.	                    </td>  
66.	                </tr>  
67.	                <?php  
68.	            }  
69.	        }  
70.	        ?>  
71.	    </table>  
72.	</div>  
exams-add.php
1.	<script language="javascript">  
2.	  
3.	$(document).ready(function(){  
4.	    $("#exam_from").datepicker({dateFormat: 'yy-mm-dd'});  
5.	    $("#exam_to").datepicker({dateFormat: 'yy-mm-dd'});  
6.	    $('#cancel').click(function(){  
7.	        $('#exams').load('index.php?admin/exams');  
8.	    })  
9.	    $('#save').click(function(){  
10.	        var error ="Please fill up the requirement below \r\n----------------------------------------\r\n";  
11.	        var msg = error;  
12.	        if( $('#exam_name').val() == '' ){  
13.	            msg += '* Exam Name \r\n';  
14.	        }  
15.	        if( $('#exam_from').val() == '' ){  
16.	            msg += '* Date From \r\n';  
17.	        }  
18.	        if( $('#exam_to').val() == '' ){  
19.	            msg += '* Date To \r\n';  
20.	        }  
21.	        if( $('#dept_id').val() == '' ){  
22.	            msg += '* Department Level \r\n';  
23.	        }  
24.	        if( $('#passing_score').val() == '' ){  
25.	            msg += '* Passing score  \r\n';  
26.	        }  
27.	        if( $('#hrs').val() == '' ){  
28.	            msg += '* Hours  \r\n';  
29.	        }  
30.	        if( $('#mins').val() == '' ){  
31.	            msg += '* Mins  \r\n';  
32.	        }  
33.	        if (msg == error){  
34.	            $.post('index.php?admin/saveexamsnew',$("#exams_add").serialize(),function(data){  
35.	                $('#exams').load('index.php?admin/exams');  
36.	            });   
37.	              
38.	        }else{  
39.	            alert(msg);   
40.	        }  
41.	    });  
42.	});  
43.	function isNumberKey(evt){  
44.	    var charCode = (evt.which) ? evt.which : event.keyCode  
45.	    if (charCode > 31 && (charCode < 48 || charCode > 57))  
46.	        return false;  
47.	    return true;  
48.	}  
49.	</script>  
50.	<style>  
51.	.mcstyle{  
52.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
53.	}  
54.	 </style>  
55.	  
56.	<div id="exams" class="exams" style="width: 100%; height: auto;">  
57.	    <div class="exams_add_data">  
58.	    <form name="exams_add" id="exams_add">  
59.	    <table width="30%%">  
60.	    <tr>  
61.	        <td class="mcstyle"> Exam Name :</td>  
62.	        <td><input type="text" id="exam_name" name="exam_name" class="user_input"></td>  
63.	    </tr>  
64.	    <tr>  
65.	        <td class="mcstyle">From : </td>  
66.	        <td><input maxlength="10" id="exam_from" name="exam_from" class="user_input" type="text"></td>  
67.	    </tr>  
68.	    <tr>  
69.	        <td class="mcstyle"> To:</td>  
70.	        <td> <input maxlength="10" id="exam_to" name="exam_to" class="user_input" type="text"></td>  
71.	    </tr>  
72.	    <tr>  
73.	        <td class="mcstyle">Department Level : </td>  
74.	        <td>  
75.	            <select id="dept_id" name="dept_id">  
76.	                <option value=""> </option>  
77.	                <?php  
78.	                if (is_array($data['department'])){  
79.	                    foreach($data['department'] as $row){  
80.	                ?>  
81.	                <option value="<?php echo $row['department_id']; ?>"> <?php echo $row['department_name'];?> </option>  
82.	                <?php  
83.	                        }  
84.	                    }  
85.	                ?>  
86.	            </select>  
87.	        </td>  
88.	    </tr>  
89.	    <tr>  
90.	        <td class="mcstyle"> Total Points :</td>  
91.	        <td class="mcstyle"><input type="text" id="total_points" name="total_points" class="user_input" onkeypress="return isNumberKey(event)" value=""></td>  
92.	    </tr>  
93.	    <tr>  
94.	        <td class="mcstyle"> Passing Grade :</td>  
95.	        <td class="mcstyle"><input type="text" id="passing_grade" name="passing_grade" class="user_input" onkeypress="return isNumberKey(event)" value=""></td>  
96.	    </tr>  
97.	    <tr>  
98.	        <td class="mcstyle"> Time Limit :</td>  
99.	        <td class="mcstyle">  
100.	            Hrs : <input type='text' id='hrs' name='hrs' value="" style="width:20px;" onkeypress="return isNumberKey(event)">  
101.	            Mins : <input type='text' id='mins' name='mins' value="" style="width:20px;"  onkeypress="return isNumberKey(event)">  
102.	  
103.	        </td>  
104.	    </tr>  
105.	    <tr>  
106.	        <td>   
107.	            <input type="button" id="save" class="e_button" value="Save">  
108.	        </td>  
109.	        <td>  
110.	            <input type="button" id="cancel" class="e_button" value="Cancel">  
111.	        </td>  
112.	    </tr>  
113.	  
114.	    </table>  
115.	    </form>  
116.	    </div>  
117.	</div>  
exams-edit.php
1.	<script language="javascript">  
2.	  
3.	$(document).ready(function(){  
4.	    $("#exam_from").datepicker({dateFormat: 'yy-mm-dd'});  
5.	    $("#exam_to").datepicker({dateFormat: 'yy-mm-dd'});  
6.	    $('#cancel').click(function(){  
7.	        loadPage('index.php?admin/questionlist&exam_id='+ $('#exam_id').val());  
8.	    })  
9.	    $('#save').click(function(){  
10.	        var error ="Please fill up the requirement below \r\n----------------------------------------\r\n";  
11.	        var msg = error;  
12.	        if( $('#exam_name').val() == '' ){  
13.	            msg += '* Exam Name \r\n';  
14.	        }  
15.	        if( $('#exam_from').val() == '' ){  
16.	            msg += '* Date From \r\n';  
17.	        }  
18.	        if( $('#exam_to').val() == '' ){  
19.	            msg += '* Date To \r\n';  
20.	        }  
21.	        if( $('#dept_id').val() == '' ){  
22.	            msg += '* Department Level \r\n';  
23.	        }  
24.	        if( $('#passing_score').val() == '' ){  
25.	            msg += '* Passing score  \r\n';  
26.	        }  
27.	        if( $('#hrs').val() == '' ){  
28.	            msg += '* Hours  \r\n';  
29.	        }  
30.	        if( $('#mins').val() == '' ){  
31.	            msg += '* Mins  \r\n';  
32.	        }  
33.	        if (msg == error){  
34.	            $.post('index.php?admin/saveexamsupdate',$("#exams_add, :hidden").serialize(),function(data){  
35.	                //$('#exams').load('index.php?admin/questionlist&exam_id='+ $('#exam_id').val());  
36.	                loadPage('index.php?admin/questionlist&exam_id='+ $('#exam_id').val());  
37.	            });   
38.	              
39.	        }else{  
40.	            alert(msg);   
41.	        }  
42.	    });  
43.	  
44.	});  
45.	function isNumberKey(evt){  
46.	    var charCode = (evt.which) ? evt.which : event.keyCode  
47.	    if (charCode > 31 && (charCode < 48 || charCode > 57))  
48.	        return false;  
49.	    return true;  
50.	}  
51.	</script>  
52.	<style>  
53.	.mcstyle{  
54.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
55.	}  
56.	 </style>  
57.	  
58.	<div id="exams" class="exams" style="width: 100%; height: auto;">  
59.	    <div class="exams_add_data">  
60.	    <form name="exams_add" id="exams_add">  
61.	    <table width="30%%">  
62.	    <tr>  
63.	        <td class="mcstyle"> Exam Name :</td>  
64.	        <td class="mcstyle"><input type="text" id="exam_name" name="exam_name" class="user_input" value="<?php echo $data[0]['exam_name'];?>"></td>  
65.	    </tr>  
66.	    <tr>  
67.	        <td class="mcstyle">From : </td>  
68.	        <td class="mcstyle"><input maxlength="10" id="exam_from" name="exam_from" class="user_input" type="text" value="<?php echo $data[0]['exam_from'];?>"></td>  
69.	    </tr>  
70.	    <tr>  
71.	        <td class="mcstyle"> To:</td>  
72.	        <td class="mcstyle"> <input maxlength="10" id="exam_to" name="exam_to" class="user_input" type="text" value="<?php echo $data[0]['exam_to'];?>"></td>  
73.	    </tr>  
74.	    <tr>  
75.	        <td class="mcstyle">Department Level: </td>  
76.	        <td>  
77.	            <select id="dept_id" name="dept_id">  
78.	                <option value=""> </option>  
79.	                <?php  
80.	                if (is_array($data['department'])){  
81.	                    foreach($data['department'] as $row){  
82.	                ?>  
83.	                <option <?php echo ($data[0]['department_id'] == $row['department_id'] ? 'selected' : ''); ?> value="<?php echo $row['department_id']; ?>"> <?php echo $row['department_name'];?> </option>  
84.	                <?php  
85.	                        }  
86.	                    }  
87.	                ?>  
88.	            </select>  
89.	        </td>  
90.	    </tr>  
91.	    <tr>  
92.	        <td class="mcstyle"> Total Points :</td>  
93.	        <td class="mcstyle"><input type="text" id="total_points" name="total_points" class="user_input" onkeypress="return isNumberKey(event)" value="<?php echo $data[0]['passing_score'];?>"></td>  
94.	    </tr>  
95.	    <tr>  
96.	        <td class="mcstyle"> Passing Grade :</td>  
97.	        <td class="mcstyle"><input type="text" id="passing_grade" name="passing_grade" class="user_input" onkeypress="return isNumberKey(event)" value="<?php echo $data[0]['passing_grade'];?>"></td>  
98.	    </tr>  
99.	    <tr>  
100.	        <td class="mcstyle"> Time Limit :</td>  
101.	        <td class="mcstyle">  
102.	            Hrs : <input type='text' id='hrs' name='hrs' style="width:20px;" onkeypress="return isNumberKey(event)" value="<?php echo ($data[0]['exam_time_limit'] > 3600 ? (($data[0]['exam_time_limit'] - $data[0]['exam_time_limit'] % 3600) / 3600) : '00' );?>">  
103.	            Mins : <input type='text' id='mins' name='mins'  style="width:20px;"  onkeypress="return isNumberKey(event)" value="<?php echo intval(($data[0]['exam_time_limit'] % 3600) / 60);?>">  
104.	  
105.	        </td>  
106.	    </tr>  
107.	    <tr>  
108.	        <td>   
109.	            <input type="button" id="save" class="e_button" value="Save">  
110.	        </td>  
111.	        <td>  
112.	            <input type="button" id="cancel" class="e_button" value="Cancel">  
113.	        </td>  
114.	    </tr>  
115.	  
116.	    </table>  
117.	    <input type="hidden" name="exam_id" id="exam_id" value="<?php echo $data[0]['exam_id'];?>"/>  
118.	    </form>  
119.	    </div>  
120.	</div>  
examsresult.php
1.	<script language="javascript">  
2.	    $(document).ready(function(){  
3.	        $("#range_from").datepicker({dateFormat: 'yy-mm-dd'});  
4.	        $("#range_to").datepicker({dateFormat: 'yy-mm-dd'});  
5.	        $('#range_from').change(function(){  
6.	            //alert($(this).val());  
7.	            if ( $('#range_to').val().length > 1 ) {  
8.	                $.post('index.php?admin/examsresult',{ 'from' : $('#range_from').val(), 'to' : $('#range_to').val() },  
9.	                function( data ){  
10.	                    $('#result').html( data );  
11.	                })  
12.	            }  
13.	        });  
14.	        $('#range_to').change(function(){  
15.	            if ( $('#range_from').val().length > 1 ) {  
16.	                $.post('index.php?admin/examsresult',{ 'from' : $('#range_from').val(), 'to' : $('#range_to').val() },  
17.	                function( data ){  
18.	                    $('#result').html( data );  
19.	                })  
20.	            }  
21.	        });  
22.	    });  
23.	</script>  
24.	  
25.	<style>  
26.	    .table-new {border:1px solid #00688B;text-align: center; margin-left:50px; margin-bottom:15px;}  
27.	    .table-new tbody{border: 1px solid #00688B;}  
28.	    .line {border-right: 1px solid #00688B;padding-right: 2px;margin-right: 5px;border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
29.	    .line1{border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
30.	    .line2{border-right: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important; font-weight:bold;}  
31.	  
32.	  
33.	    .error-msg{  
34.	        overflow:hidden;  
35.	        width:900px;   
36.	    }  
37.	    .error-msg h5{  
38.	        overflow:hidden;  
39.	        color:#F00;  
40.	        text-transform:uppercase;  
41.	        background: white;  
42.	    }  
43.	    .mcstyle{  
44.	        font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
45.	    }  
46.	</style>  
47.	  
48.	<div style="width: 90%; height: auto;">  
49.	    <table width="100%">  
50.	        <tr>  
51.	            <td class="mcstyle" align="right">   
52.	                Exam From   
53.	                <input maxlength="10" id="range_from" name="range_from" class="user_input" type="text" value="2013-04-03">  
54.	                     
55.	                Exam To   
56.	                <input maxlength="10" id="range_to" name="range_to" class="user_input" type="text">  
57.	            </td>  
58.	        </tr>  
59.	    </table>  
60.	    <div id="result" style="width: 100%; margin: 0 auto;">  
61.	        <table width="100%" class="table-new" border="0" cellspacing="0" cellpadding="5">  
62.	            <tr class="tr-head">  
63.	                <td widt="100" align="center" class="line2">  Examinees Name </td>  
64.	                <td width="300" align="center" class="line2">Exam Name </td>  
65.	                <td width="10" align="center" class="line2">Scores </td>  
66.	                <td width="50" align="center" class="line2">Exam </br>Remarks </td>  
67.	                <td width="60" align="center" class="line2">Check </br> Status  </td>  
68.	                <td align="center" class="">  View </td>  
69.	            </tr>  
70.	  
71.	            <?php  
72.	            //print_r($data);  
73.	            if (is_array($data['exam'])) {  
74.	                foreach ($data['exam'] as $row) {  
75.	                    ?>  
76.	                    <tr>  
77.	                        <td align="center" class="line"> <?php echo $row['user_lname'] . ', ' . $row['user_fname']; ?></td>  
78.	                        <td align="center" class="line"> <?php echo $row['exam_name']; ?></td>  
79.	                        <td align="center" class="line"> <?php echo ( $data[$row['user_id']][$row['exam_id']][0]['score'] == $row['passing_score'] ) ? 'PERFECT' : $data[$row['user_id']][$row['exam_id']][0]['score'] . ' over '. $row['passing_score']; ?> </td>  
80.	                        <td align="center" class="line">  
81.	                            <?php  
82.	                           // echo $data[$row['user_id']][$row['exam_id']][0]['score'];  
83.	                              
84.	                            if ((($data[$row['user_id']][$row['exam_id']][0]['score'] / $row['passing_score']) * 100 ) >= $row['passing_grade']) {  
85.	                                echo "<span style='color: green;'><b>Passed</b></span>";  
86.	                            } else {  
87.	                                echo "<span style='color: red;'><b>Failed</b></span>";  
88.	                               //echo  ($data[$row['user_id']][0]['score'] / $row['passing_score']) * 100;  
89.	                                //echo $data[$row['user_id']][0]['score'];  
90.	                            }  
91.	                              
92.	                            ?>   
93.	                        </td>  
94.	                        <td align="center" class="line"> <?php echo ($row['check_status'] == 1 ) ? '<b>Checked</b>' : "<span style='color: red;'><b><i>Not Yet</i></b></span>";?> </td>  
95.	                        <td align="center" class="line1"> <a href="javascript:loadPage('index.php?admin/checkresult&exam_id=<?php echo $row['exam_id']; ?>' + '&user_id=<?php echo $row['user_id']; ?>');"> Check Results</a></td>  
96.	  
97.	                    </tr>  
98.	                    <?php  
99.	                }  
100.	            }  
101.	            ?>  
102.	  
103.	        </table>  
104.	    </div>  
105.	</div>  
examsresult_data.php
1.	<style>  
2.	    .table-new {border:1px solid #00688B;text-align: center; margin-left:50px; margin-bottom:15px;}  
3.	    .table-new tbody{border: 1px solid #00688B;}  
4.	    .line {border-right: 1px solid #00688B;padding-right: 2px;margin-right: 5px;border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
5.	    .line1{border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
6.	    .line2{border-right: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important; font-weight:bold;}  
7.	  
8.	  
9.	    .error-msg{  
10.	        overflow:hidden;  
11.	        width:900px;   
12.	    }  
13.	    .error-msg h5{  
14.	        overflow:hidden;  
15.	        color:#F00;  
16.	        text-transform:uppercase;  
17.	        background: white;  
18.	    }  
19.	.mcstyle{  
20.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
21.	}  
22.	 </style>  
23.	<table width="100%" class="table-new" border="0" cellspacing="0" cellpadding="5">  
24.	    <tr class="tr-head">  
25.	        <td widt="100" align="center" class="line2">  Examinees Name </td>  
26.	        <td width="300" align="center" class="line2">Exam Name </td>  
27.	        <td width="100" align="center" class="line2">Remarks </td>  
28.	        <td align="center" class="line2">  View </td>  
29.	    </tr>  
30.	  
31.	    <?php  
32.	        if(is_array($data['exam'])){  
33.	            foreach($data['exam'] as $row){  
34.	    ?>  
35.	    <tr>  
36.	        <td align="center" class="line"> <?php echo $row['user_lname'] . ', ' . $row['user_fname'];?></td>  
37.	        <td align="center" class="line"> <?php echo $row['exam_name']; ?></td>  
38.	    <?php  
39.	    ?>  
40.	        <td align="center" class="line">   
41.	            <?php   
42.	                //print_r($data);  
43.	                //echo $data[$row['user_id']][$row['exam_id']][0]['score'];  
44.	                if ( (($data[$row['user_id']][$row['exam_id']][0]['score'] / $row['passing_score']) * 100 ) >= $row['passing_grade'] ) {  
45.	                    echo "<span style='color: green;'><b>Passed</b></span>";  
46.	                }else{  
47.	                    echo "<span style='color: red;'><b>Failed</b></span>";  
48.	                }  
49.	            ?>   
50.	        </td>  
51.	        <td align="center" class="line1"> <a href="javascript:loadPage('index.php?admin/checkresult&exam_id=<?php echo $row['exam_id'];?>' + '&user_id=<?php echo $row['user_id'];?>');"> Check Results</a></td>  
52.	  
53.	    </tr>  
54.	    <?php  
55.	            }  
56.	        }  
57.	    ?>  
58.	  
59.	</table>  
navigation.php
1.	<style>  
2.	a{  
3.	  text-decoration: none;  
4.	  font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.9em;   
5.	}  
6.	  a:hover {  
7.	  text-decoration: underline;  
8.	}  
9.	</style>  
10.	<table style="font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.9em;;  
11.	">  
12.	<tr>  
13.	    <td> <a href="javascript:loadPage('index.php?admin/users');"> Users </a> </td>  
14.	    <td>   <a href="javascript:loadPage('index.php?admin/departments');"> Department Levels </a> </td>  
15.	    <td>  <a href="javascript:loadPage('index.php?admin/exams');"> Examinations </a> </td>  
16.	    <td>  <a href="javascript:loadPage('index.php?admin/examsresult');"> Examinations Results </a> </td>  
17.	    <td>  <a href="index.php?authenticate/logout"> Logout </a> </td>  
18.	</tr>  
19.	</table><br />  
questions.php
1.	<script language="javascript">  
2.	$(document).ready(function(){  
3.	  
4.	    $.get('index.php?admin/questionlist&exam_id='+$('#exam_id').val(),function(data){  
5.	        $('#questions_list').html(data);  
6.	    })  
7.	  
8.	    $('#add').click(function(){  
9.	        $('#questions').load('index.php?admin/questionadd&exam_id='+$('#exam_id').val());  
10.	    });  
11.	});  
12.	</script>  
13.	  
14.	<div id="questions" class="questions" style="width: 730px; height: 675px;margin-top: 15px;">  
15.	    <div>  
16.	        <input type="button" style="width: 150px; height: 25px;" value="Add New" id="add">  
17.	    </div>  
18.	    <div id="questions_list" class="questions_list">  
19.	  
20.	    </div>  
21.	    <input type="hidden"  name="exam_id" id="exam_id" value="<?php echo $data;?>"/>  
22.	</div>  
questions_list.php
1.	<script language="javascript">  
2.	$(document).ready(function(){  
3.	    $('.edit').click(function(){  
4.	        loadPage('index.php?admin/questionedit&question_id='+$(this).attr('id') + '&exam_id=' + $('#exam_id').val());  
5.	    });  
6.	    $('#back').click(function(){  
7.	        loadPage('index.php?admin/examslist');  
8.	    });  
9.	});  
10.	</script>  
11.	  
12.	<div style="width: 100%; height: auto;">  
13.	<div>  
14.	<style>  
15.	    .table-new {border:1px solid #00688B;text-align: center;}  
16.	    .table-new tbody{border: 1px solid #00688B;}  
17.	    .line {border-right: 1px solid #00688B;padding-right: 2px;margin-right: 5px;border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
18.	    .line1{border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
19.	    .line2{border-right: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important; font-weight:bold;}  
20.	  
21.	  
22.	    .error-msg{  
23.	        overflow:hidden;  
24.	        width:900px;   
25.	    }  
26.	    .error-msg h5{  
27.	        overflow:hidden;  
28.	        color:#F00;  
29.	        text-transform:uppercase;  
30.	        background: white;  
31.	    }  
32.	.mcstyle{  
33.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
34.	}  
35.	 </style>  
36.	  
37.	<table>  
38.	<tr>  
39.	    <?php  
40.	    ?>  
41.	    <td class="mcstyle"> Exam Name : </td>  
42.	    <td class="mcstyle"> <a href="javascript:loadPage('index.php?admin/examedit&exam_id=<?php echo $data['exam_id1'];?>');"><?php echo $data['exam'][0]['exam_name'];?></a></td>  
43.	</tr>  
44.	<tr>  
45.	    <td class="mcstyle"> Created by : </td>  
46.	    <td class="mcstyle"> <?php echo $data['exam'][0]['user_lname'] . ', ' . $data['exam'][0]['user_fname'];?></td>  
47.	</tr>  
48.	<tr>  
49.	    <td class="mcstyle"> Created on : </td>  
50.	    <td class="mcstyle"> <?php echo date('m-d-Y', strtotime($data['exam'][0]['exam_date_created']));?></td>  
51.	</tr>  
52.	<tr>  
53.	    <td class="mcstyle"> Exam Period : </td>  
54.	    <td class="mcstyle"> <?php echo date('m-d-Y', strtotime($data['exam'][0]['exam_from'])) . ' to ' . date('m-d-Y', strtotime($data['exam'][0]['exam_to']))  ?> </td>  
55.	</tr>  
56.	<tr>  
57.	    <td>  </td>  
58.	    <td>  </td>  
59.	</tr>  
60.	<tr>  
61.	    <td class="mcstyle"> <a href="javascript:loadPage('index.php?admin/questionadd&exam_id='+<?php  echo $data['exam_id1'];?>);"> Add new question </a></td>  
62.	</tr>  
63.	</table>  
64.	    <div style="float: right; margin-bottom:5px;">  
65.	        <input type="button" value="Back" id="back">  
66.	    </div>  
67.	</div>  
68.	<table width="100%" class="table-new" border="0" cellspacing="0" cellpadding="5">  
69.	<tr class="tr-head">  
70.	    <td width="300" align="center" class="line2" > <b> Questions </b></td>  
71.	    <td width="410" align="center" class="line2"> <b> Answers </b></td>  
72.	</tr>  
73.	<?php   
74.	  
75.	if (is_array($data['exam'])){  
76.	    foreach($data['exam'] as $row){  
77.	        //if(is_array($data[$row['question_id']])){   
78.	?>  
79.	<tr>  
80.	  
81.	    <td class="line">   
82.	        <div style="">  
83.	            <?php echo $row['question_name'] . ($row['question_type'] == 0 ? ' ( 1 Point )' : ( $row['essay_points'] == 1 ?  '( '. $row['essay_points'] . ' Point )' : '( '. $row['essay_points'] . ' Points )' )   ); ?>  
84.	            <a href="javascript:loadPage('index.php?admin/questionedit&question_id='+<?php echo $row['question_id'];?> +'&exam_id='+ <?php echo $row['exam_id']?>);"> Edit</a>  
85.	            </div>                               
86.	    </td>  
87.	  
88.	    <td>  
89.	        <div style="">  
90.	    <?php   
91.	    //print_r($data);  
92.	        if($row['question_type']== 0){  
93.	    ?>  
94.	             <table width="100%" class="table-new" border="0" cellspacing="0" cellpadding="5">  
95.	            <?php   
96.	            if(is_array($data[$row['question_id']])){  
97.	                foreach ($data[$row['question_id']] as $row2){  
98.	  
99.	                if($row['question_type']==0){  
100.	            ?>   
101.	                <tr>  
102.	                    <td width="350" class="line"> <span style="<?php echo ($row2['answer_flag'] == 1 ? 'color: green' : 'color: black' );?>"> <?php echo $row2['answer_name'] ?> </span></td>  
103.	                    <td class="line"> <a href="javascript:loadPage('index.php?admin/answeredit&answer_id='+<?php echo $row2['answer_id'];?> + '&exam_id='+ <?php echo $row['exam_id']; ?> + '&question_id=' + <?php echo $row['question_id'];?>);"> Edit </a></td>  
104.	                    <td class="line"><a href="javascript:deleteData('index.php?admin/answerdelete&answer_id=<?php echo $row2['answer_id']?>','index.php?admin/questionlist&exam_id=<?php echo $row['exam_id'];?>');"> Delete</a></td>  
105.	  
106.	                </tr>  
107.	            <?php  
108.	                    }  
109.	                }  
110.	            }  
111.	  
112.	            if($row['question_type']==0){  
113.	            ?>  
114.	  
115.	                <tr>  
116.	                    <td colspan="3" align="center" class="line"> <a href="javascript:loadPage('index.php?admin/answeradd&question_id='+<?php echo $row['question_id'];?> +'&exam_id='+<?php echo $row['exam_id'];?>);"> Add Answer </a></td>  
117.	                </tr>  
118.	            <?php  
119.	            }  
120.	            ?>  
121.	            </table>  
122.	    <?php  
123.	        }  
124.	    ?>  
125.	        </div>  
126.	    </td>  
127.	</tr>  
128.	<?php  
129.	    }  
130.	}  
131.	?>  
132.	</table>  
133.	</div>  
134.	<input type="hidden" id="exam_id" value="<?php echo $data['exam_id1'];?>">  
questions-add.php
1.	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
2.	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>  
3.	<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>  
4.	<script language="javascript">  
5.	var answer = 1;  
6.	$(document).ready(function(){  
7.	  
8.	    $('#exam_questions').load('index.php?admin/questionlist&exam_id=' + $('#exam_id').val());  
9.	    $('#remove').click(function(){  
10.	        $(".pos_check:checked").live().each(function() {  
11.	            id = $(this).attr('id');  
12.	            $('#pos'+id).remove();  
13.	        });  
14.	    });  
15.	    $('#add').click(function(){  
16.	        if ($('#txt_answer').val() != '') {                                                                                   
17.	            $('.answer').append("<div class='pos_answer' id=pos"+ answer +">" + $('#txt_answer').val() + "<input class='pos_check' id="+ answer+ " type='checkbox'>" + "<input type='hidden' class='hid_txt' id=hid" + answer+ " value=" + $('#txt_answer').val() + "></div>");  
18.	            answer++;  
19.	            $('#txt_answer').val('');  
20.	        }else{  
21.	            alert("input answer");  
22.	            return false;  
23.	        }  
24.	    });  
25.	    $('#save').click(function(){  
26.	        var cnt = 0;  
27.	        var data_='';  
28.	        var id;  
29.	  
30.	        $(".pos_check:checked").live().each(function() {  
31.	  
32.	            cnt+=1;  
33.	        });  
34.	  
35.	        if (cnt >1 ){  
36.	            alert('check only one');  
37.	            return false;  
38.	        }  
39.	        if (cnt == 0){  
40.	            alert('check one');  
41.	            return false;  
42.	        }  
43.	        $(".pos_check").live().each(function() {  
44.	            id = $(this).attr('id');  
45.	            var ck='';  
46.	            //if ($('#isAgeSelected').is(':checked')) {  
47.	            if ($(this).is(':checked')){  
48.	                ck='@';  
49.	            }  
50.	            if (data_.length == 0){  
51.	                //if ($('#isAgeSelected').is(':checked')) {  
52.	  
53.	                data_ = "hid" + id  +  ':' + $('#hid'+id).live().val()+ck;  
54.	            }else{  
55.	                data_ += ",hid" + id + ':' + $('#hid'+id).live().val()+ck ;  
56.	            }  
57.	        });  
58.	        //loadPage('index.php?admin/questions&exam_id='+ $(this).attr('id'));  
59.	        $.post('index.php?admin/questionexamsnew&data_=' + data_  +'&exam_id='+ $('#exam_id').val(), {'exam_id':$('#exam_id').val(), 'question': $('#question').val(), 'question_type' : $('input[name=question_type]:checked').val() },function(){  
60.	            $('#exam_questions').load('index.php?admin/questionlist&exam_id=' + $('#exam_id').val());  
61.	        });  
62.	    });  
63.	    $('#exam_from').live().datepicker({dateFormat: 'yy-mm-dd'});  
64.	    $('#exam_to').live().datepicker({dateFormat: 'yy-mm-dd'});  
65.	});  
66.	</script>  
67.	  
68.	<div id="questions" class="questions" style="width: 100%; height: 675px;">  
69.	    <div id="question_dtl" class="question_dtl" style="">  
70.	    <table>  
71.	    <tr>  
72.	        <td width="120" class="mcstyle"> Question Type : </td>  
73.	        <td width="130" class="mcstyle"> <input type="radio" id="0" id="question_type" name="question_type" checked value="0">Multiple Choice</td>  
74.	        <td width="80" class="mcstyle"> <input type="radio" id="1" id="question_type" name="question_type" value="1">Essay</td>  
75.	    </tr>  
76.	    </table>  
77.	        <div style="width: 340px; height:170px; border: 1px solid;float:left;">  
78.	        <table>  
79.	        <tr>  
80.	            <td class="mcstyle"> Question : </td>  
81.	        </tr>  
82.	        <tr>  
83.	            <td><textarea id="question" name="question" rows="6" cols="38">   
 
questions-add2.php
1.	<script language="javascript">  
2.	var answer = 1;  
3.	$(document).ready(function(){  
4.	    $('#cancel').click(function(){  
5.	        loadPage('index.php?admin/questionlist&exam_id='+$('#exam_id').val());  
6.	    });  
7.	    $('#save').click(function(){  
8.	        var essay_points = 0;  
9.	        if ( $('#essay_points').val() != '' ) {  
10.	            essay_points = $('#essay_points').val();  
11.	        }  
12.	        $.post('index.php?admin/questionaddinsert',{  
13.	            'question_name' : $('#question_name').val(),   
14.	                'question_type' :  $('#question_type :selected').val(), 'exam_id':$('#exam_id').val(), 'essay_points' : essay_points  
15.	            },function(){  
16.	                loadPage('index.php?admin/questionlist&exam_id='+$('#exam_id').val());  
17.	            });  
18.	    });  
19.	    $('#question_type').change(function(){  
20.	        if ( $(this).val() == 0 ){  
21.	            $('#points').css('display','none');  
22.	        }else{  
23.	            $('#points').css('display','block');  
24.	        }  
25.	    });  
26.	      
27.	});  
28.	function isNumberKey(evt)  
29.	{  
30.	    var charCode = (evt.which) ? evt.which : event.keyCode  
31.	    if (charCode > 31 && (charCode < 48 || charCode > 57))  
32.	        return false;  
33.	  
34.	    return true;  
35.	}   
36.	</script>  
37.	  
38.	<style>  
39.	.mcstyle{  
40.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
41.	}  
42.	</style>  
43.	  
44.	<div id="questions" class="questions" style="width: 730px; height: 675px;">  
45.	    <div id="question_dtl" class="question_dtl" style="">  
46.	    <table>  
47.	    <tr>  
48.	        <td class="mcstyle">  
49.	            Question :   
50.	              
51.	            <!--  
52.	            <input type="text" id="question_name" name="question_name" class="user_input"/>  
53.	        -->  
54.	        </td>  
55.	        <td>  
56.	            <textarea id="question_name" name="question_name" rows="6" cols="38">   
questions-edit.php
1.	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
2.	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>  
3.	<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>  
4.	<script language="javascript">  
5.	var answer = 1;  
6.	$(document).ready(function(){  
7.	  
8.	    $('#exam_questions').load('index.php?admin/questionlist&exam_id=' + $('#exam_id').val());  
9.	    answer = $('#count').val();  
10.	    $('#remove').click(function(){  
11.	        $(".pos_check:checked").live().each(function() {  
12.	            id = $(this).attr('id');  
13.	            $('#pos'+id).remove();  
14.	        });  
15.	    });  
16.	    $('#add').click(function(){  
17.	        if ($('#txt_answer').val() != '') {                                                                                   
18.	            $('.answer').append("<div class='pos_answer' id=pos"+ answer +">" + $('#txt_answer').val() + "<input class='pos_check' id="+ answer+ " type='checkbox'>" + "<input type='hidden' class='hid_txt' id=hid" + answer+ " value=" + $('#txt_answer').val() + "></div>");  
19.	            answer++;  
20.	            $('#txt_answer').val('');  
21.	        }else{  
22.	            alert("input answer");  
23.	            return false;  
24.	        }  
25.	    });  
26.	    $('#save').click(function(){  
27.	        var cnt = 0;  
28.	        var data_='';  
29.	        var id;  
30.	  
31.	        $(".pos_check:checked").live().each(function() {  
32.	  
33.	            cnt+=1;  
34.	        });  
35.	  
36.	        if (cnt >1 ){  
37.	            alert('check only one');  
38.	            return false;  
39.	        }  
40.	        if (cnt == 0){  
41.	            alert('check one');  
42.	            return false;  
43.	        }  
44.	        $(".pos_check").live().each(function() {  
45.	            id = $(this).attr('id');  
46.	            var ck='';  
47.	            //if ($('#isAgeSelected').is(':checked')) {  
48.	            if ($(this).is(':checked')){  
49.	                ck='@';  
50.	            }  
51.	            if (data_.length == 0){  
52.	                //if ($('#isAgeSelected').is(':checked')) {  
53.	  
54.	                data_ = "hid" + id  +  ':' + $('#hid'+id).live().val()+ck;  
55.	            }else{  
56.	                data_ += ",hid" + id + ':' + $('#hid'+id).live().val()+ck ;  
57.	            }  
58.	        });  
59.	        //loadPage('index.php?admin/questions&exam_id='+ $(this).attr('id'));  
60.	        $.post('index.php?admin/questionexamsnew&data_=' + data_  +'&exam_id='+ $('#exam_id').val(), {'exam_id':$('#exam_id').val(), 'question': $('#question').val(), 'question_type' : $('input[name=question_type]:checked').val() },function(){  
61.	            $('#exam_questions').load('index.php?admin/questionlist&exam_id=' + $('#exam_id').val());  
62.	        });  
63.	    });  
64.	    $('#exam_from').live().datepicker({dateFormat: 'yy-mm-dd'});  
65.	    $('#exam_to').live().datepicker({dateFormat: 'yy-mm-dd'});  
66.	});  
67.	</script>  
68.	  
69.	<div id="questions" class="questions" style="width: 730px; height: 675px;">  
70.	    <div id="question_dtl" class="question_dtl" style="">  
71.	    <table>  
72.	    <tr>  
73.	        <td width="120" class="mcstyle"> Question Type : </td>  
74.	        <td width="130" class="mcstyle"> <input type="radio" id="0" id="question_type" name="question_type" <?php  ?> value="0">Multiple Choice</td>  
75.	        <td width="80" class="mcstyle"> <input type="radio" id="1" id="question_type" name="question_type" <?php ?> value="1">Essay</td>  
76.	    </tr>  
77.	    </table>  
78.	        <div style="width: 340px; height:170px; border: 1px solid;float:left;">  
79.	        <table>  
80.	        <tr>  
81.	            <td class="mcstyle"> Question : </td>  
82.	        </tr>  
83.	        <tr>  
84.	            <td><textarea id="question" name="question" rows="6" cols="38"><?php echo $data[0]['question_name'];?>   
 
questions-edit2.php
1.	<script language="javascript">  
2.	var answer = 1;  
3.	$(document).ready(function(){  
4.	    $('#save').click(function(){  
5.	        var essay_points = 0;  
6.	        if ( $('#essay_points').val() != '' ) {  
7.	            essay_points = $('#essay_points').val();  
8.	        }  
9.	  
10.	        $.post('index.php?admin/questionupdate',{  
11.	            'question_name' : $('#question_name').val(),   
12.	                'question_type' :  $('#question_type :selected').val(), 'question_id':$('#question_id').val(), 'essay_points' : essay_points  
13.	            },function(){  
14.	                loadPage('index.php?admin/questionlist&exam_id='+$('#exam_id').val());  
15.	            });  
16.	  
17.	    });  
18.	    $('#question_type').change(function(){  
19.	        //alert($(this).val());  
20.	        if ( $(this).val() == 0 ){  
21.	            $('#points').css('display','none');  
22.	        }else{  
23.	            $('#points').css('display','block');  
24.	        }  
25.	    });  
26.	    $('#cancel').click(function(){  
27.	        loadPage('index.php?admin/questionlist&exam_id='+$('#exam_id').val());  
28.	    });  
29.	});  
30.	function isNumberKey(evt)  
31.	{  
32.	    var charCode = (evt.which) ? evt.which : event.keyCode  
33.	    if (charCode > 31 && (charCode < 48 || charCode > 57))  
34.	        return false;  
35.	  
36.	    return true;  
37.	}   
38.	</script>  
39.	<style>  
40.	.mcstyle{  
41.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
42.	}  
43.	</style>  
44.	<div id="questions" class="questions" style="width: 730px; height: 675px;">  
45.	    <div id="question_dtl" class="question_dtl" style="">  
46.	    <table>  
47.	    <tr>  
48.	        <td class="mcstyle">  
49.	            Question :   
50.	              
51.	            <!--  
52.	            <input type="text" id="question_name" name="question_name" value="<?php //echo $data['question'][0]['question_name'];?>" class="user_input"/>  
53.	        -->  
54.	        </td>  
55.	        <td>  
56.	            <textarea id="question_name" name="question_name" rows="6" cols="38"> <?php echo $data['question'][0]['question_name'];?>  
sign-up.php
1.	<html>  
2.	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
3.	<script language="javascript">  
4.	  
5.	$(document).ready(function(){  
6.	  
7.	    $('#cancel').click(function(){  
8.	        //$('#users').load('index.php?');  
9.	        $('#user_add').action="index.php?"  
10.	        $('#user_add').submit();  
11.	    })  
12.	    $('#save').click(function(){  
13.	        var error ="Please fill up the requirement below \r\n----------------------------------------\r\n";  
14.	        var msg = error;  
15.	        if( $('#fname').val() == '' ){  
16.	            msg += '*First name \r\n';  
17.	        }  
18.	        if( $('#lname').val() == '' ){  
19.	            msg += '*Last name \r\n';  
20.	        }  
21.	        if( $('#user_name').val() == '' ){  
22.	            msg += '*user name \r\n';  
23.	        }  
24.	        if( $('#password').val() == '' ){  
25.	            msg += '*Password \r\n';  
26.	        }  
27.	        if( $('#dept_id').val() == '' ){  
28.	            msg += '*Department Level \r\n';  
29.	        }  
30.	        if (msg == error){  
31.	              
32.	            $.post('index.php?admin/signupadd',$("#user_add").serialize(),function(data){  
33.	                if ( parseInt(data) == 0 ) {  
34.	                    alert('Your Registration is Success');  
35.	                    $('#user_add').submit();  
36.	                }else{  
37.	                    alert('Username is Already Exist');  
38.	                }  
39.	  
40.	                //alert(data);  
41.	                //$('#user_add').submit();  
42.	            });   
43.	              
44.	        }else{  
45.	            alert(msg);   
46.	        }  
47.	          
48.	          
49.	    });  
50.	});  
51.	</script>  
52.	<style>  
53.	.mcstyle{  
54.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
55.	}  
56.	</style>  
57.	<div id="users" class="users" style="width: 990px; height: 675px;">  
58.	    <div class="user_add_data" style="margin: 0 auto;">  
59.	    <form name="user_add" id="user_add" method="post" action="index.php?">  
60.	        <table width="100%">  
61.	        <tr>  
62.	            <td class="mcstyle" width="12%"> First name : </td>  
63.	            <td width="12%"> <input type="text" id="fname" name="fname" class="user_input" > </td>  
64.	            <td> </td>  
65.	        </tr>   
66.	        <tr>  
67.	            <td class="mcstyle"> Last name : </td>  
68.	            <td> <input type="text" id="lname" name="lname" class="user_input" > </td>  
69.	            <td> </td>  
70.	        </tr>   
71.	        <tr>  
72.	            <td class="mcstyle"> username : </td>  
73.	            <td> <input type="text" id="user_name" name="user_name" class="user_input" > </td>  
74.	            <td> </td>  
75.	        </tr>   
76.	        <tr>  
77.	            <td class="mcstyle"> password : </td>  
78.	            <td> <input type="password" id="password" name="password" class="user_input" > </td>  
79.	            <td> </td>  
80.	        </tr>   
81.	        <tr>  
82.	            <td class="mcstyle"> Department Level: </td>  
83.	            <td>   
84.	            <select id="dept_id" name="dept_id">  
85.	                <option value=""> </option>  
86.	                <?php  
87.	                if (is_array($data['department'])){  
88.	                    foreach($data['department'] as $row){  
89.	                ?>  
90.	                <option value="<?php echo $row['department_id']; ?>"> <?php echo $row['department_name'];?> </option>  
91.	                <?php  
92.	                        }  
93.	                    }  
94.	                ?>  
95.	            </select>  
96.	              
97.	            </td>  
98.	            <td width="">  
99.	                <span style="color:red;"><b> * Please choice your designated Department Level* </b></span>  
100.	            </td>  
101.	        </tr>  
102.	        <tr>  
103.	            <td> </td>  
104.	            <td> <input type="button" id="save" class="e_button" value="Save"><input type="button" id="cancel" class="e_button" value="Cancel"></td>  
105.	            <td> </td>  
106.	        </tr>  
107.	        </table>  
108.	    </form>  
109.	    </div>  
110.	</div>  
111.	</html>  
users.php
1.	<script language="javascript">  
2.	$(document).ready(function(){  
3.	    $.get('index.php?admin/userslist',function(data){  
4.	        $('#user_list').html(data);  
5.	    })  
6.	    /* 
7.	    $('#add').click(function(){ 
8.	        $('#users').load('index.php?admin/usersadd'); 
9.	    }); 
10.	    */  
11.	});  
12.	</script>  
13.	<style>  
14.	a{  
15.	  text-decoration: none;  
16.	  font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.9em;  
17.	}  
18.	  a:hover {  
19.	  text-decoration: underline;  
20.	}  
21.	</style>  
22.	  
23.	<div id="users" class="users" style="width: 100%; height: auto; overflow: hidden; margin-bottom:10px;">  
24.	    <div style="margin-left:50px;">  
25.	        <!--  
26.	        <input type="button" style="width: 150px; height: 25px;" value="Add New" id="add">  
27.	    -->  
28.	    <a href="javascript:loadPage('index.php?admin/usersadd');">Add new</a>  
29.	      </div><br />  
30.	    <div id="user_list" class="user_list" style="height: auto; overflow: hidden;">  
31.	  
32.	    </div>  
33.	</div>  
usersadd.php
1.	<script language="javascript">  
2.	  
3.	$(document).ready(function(){  
4.	    $('#cancel').click(function(){  
5.	        //$('#users').load('index.php?admin/users');  
6.	        loadPage('index.php?admin/users');  
7.	    })  
8.	    $('#save').click(function(){  
9.	        var error ="Please fill up the requirement below \r\n----------------------------------------\r\n";  
10.	        var msg = error;  
11.	        if( $('#fname').val() == '' ){  
12.	            msg += '*First name \r\n';  
13.	        }  
14.	        if( $('#lname').val() == '' ){  
15.	            msg += '*Last name \r\n';  
16.	        }  
17.	        if( $('#user_name').val() == '' ){  
18.	            msg += '*user name \r\n';  
19.	        }  
20.	        if( $('#password').val() == '' ){  
21.	            msg += '*Password \r\n';  
22.	        }  
23.	        if (msg == error){  
24.	              
25.	            $.post('index.php?admin/saveusernew',$("#user_add").serialize(),function(data){  
26.	                //$('#users').load('index.php?admin/users');  
27.	                loadPage('index.php?admin/users');  
28.	            });   
29.	              
30.	        }else{  
31.	            alert(msg);   
32.	        }  
33.	          
34.	          
35.	    });  
36.	});  
37.	</script>  
38.	<style>  
39.	.mcstyle{  
40.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
41.	}  
42.	</style>  
43.	<div id="users" class="users" style="width: 100%; height: 675px;">  
44.	    <div class="user_add_data">  
45.	    <form name="user_add" id="user_add" action="index.php?admin/saveusernew">  
46.	        <table width="30%%">  
47.	        <tr>  
48.	            <td class="mcstyle"> First name : </td>  
49.	            <td> <input type="text" id="fname" name="fname" class="user_input" > </td>  
50.	        </tr>   
51.	        <tr>  
52.	            <td class="mcstyle"> Last name : </td>  
53.	            <td> <input type="text" id="lname" name="lname" class="user_input" > </td>  
54.	        </tr>   
55.	        <tr>  
56.	            <td class="mcstyle"> username : </td>  
57.	            <td> <input type="text" id="user_name" name="user_name" class="user_input" > </td>  
58.	        </tr>   
59.	        <tr>  
60.	            <td class="mcstyle"> password : </td>  
61.	            <td> <input type="password" id="password" name="password" class="user_input" > </td>  
62.	        </tr>   
63.	        <tr>  
64.	            <td class="mcstyle"> Role : </td>  
65.	            <td>   
66.	                <select id="role_id" name="role_id">  
67.	                <?php   
68.	                if (is_array($data['role'])){  
69.	                    foreach($data['role'] as $row){  
70.	                ?>  
71.	                <option value="<?php echo $row['role_id']; ?>"> <?php echo $row['role_name']; ?></option>  
72.	                <?php  
73.	                    }  
74.	                }  
75.	                ?>  
76.	                </select>  
77.	            </td>  
78.	        </tr>  
79.	        <tr>  
80.	            <td class="mcstyle"> Department Level : </td>  
81.	            <td>   
82.	                <select id="dept_id" name="dept_id">  
83.	                    <?php  
84.	                    if (is_array($data['department'])){  
85.	                        foreach($data['department'] as $row){  
86.	                    ?>  
87.	                    <option value="<?php echo $row['department_id']; ?>"> <?php echo $row['department_name'];?> </option>  
88.	                    <?php  
89.	                            }  
90.	                        }  
91.	                    ?>  
92.	                </select>  
93.	            </td>  
94.	        </tr>  
95.	        <tr>  
96.	            <td class="mcstyle"> Exam Checker: </td>  
97.	            <td> <input type="checkbox" id="u_examchecker" name="u_examchecker"> </td>  
98.	        </tr>   
99.	        <tr>  
100.	            <td class="mcstyle"> Enable: </td>  
101.	            <td> <input type="checkbox" id="u_enable" name="u_enable"> </td>  
102.	        </tr>   
103.	        <tr>  
104.	            <td> <input type="button" id="save" class="e_button" value="Save"></td>  
105.	            <td> <input type="button" id="cancel" class="e_button" value="Cancel"></td>  
106.	        </tr>  
107.	        </table>  
108.	    </form>  
109.	    </div>  
110.	</div>  
 users-edit.php
1.	<script language="javascript">  
2.	  
3.	$(document).ready(function(){  
4.	  
5.	    $('#cancel').click(function(){  
6.	        //$('#users').load('index.php?admin/users');  
7.	        loadPage('index.php?admin/users');  
8.	    })  
9.	    $('#cancel2').click(function(){  
10.	        //$('#users').load('index.php?admin/users');  
11.	        loadPage('index.php?admin/users');  
12.	    })  
13.	    $('#save').click(function(){  
14.	        var error ="Please fill up the requirement below \r\n----------------------------------------\r\n";  
15.	        var msg = error;  
16.	        if( $('#fname').val() == '' ){  
17.	            msg += '*First name \r\n';  
18.	        }  
19.	        if( $('#lname').val() == '' ){  
20.	            msg += '*Last name \r\n';  
21.	        }  
22.	        if( $('#user_name').val() == '' ){  
23.	            msg += '*user name \r\n';  
24.	        }  
25.	        if( $('#password').val() == '' ){  
26.	            msg += '*Password \r\n';  
27.	        }  
28.	        if (msg == error){  
29.	              
30.	            $.post('index.php?admin/userupdate',$("#user_add").serialize(),function(data){  
31.	                //$('#users').load('index.php?admin/users');  
32.	                loadPage('index.php?admin/users');  
33.	            });   
34.	              
35.	        }else{  
36.	            alert(msg);   
37.	        }  
38.	    });  
39.	    $('#save2').click(function(){  
40.	          
41.	        if ( $('#change_pass').val() != $('#retype_pass').val() ){  
42.	            alert('Password should be match !!');  
43.	        }else{  
44.	  
45.	              
46.	            $.post('index.php?admin/userupdate2',{'edit_id':$('#edit_id').val(),'change_pass': $('#change_pass').val()},function(data){  
47.	                loadPage('index.php?admin/users');  
48.	            });   
49.	              
50.	        }  
51.	          
52.	    });  
53.	    $('#password_change').click(function(){  
54.	        $('#frame1').hide();  
55.	        $('#frame2').show();  
56.	    });  
57.	});  
58.	</script>  
59.	<style>  
60.	.mcstyle{  
61.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
62.	}  
63.	</style>  
64.	<div id="users" class="users" style="width: 100%; height: 675px;">  
65.	    <div class="user_add_data">  
66.	      
67.	        <div id="frame1">  
68.	            <form name="user_add" id="user_add" action="index.php?admin/saveusernew">  
69.	            <table width="100%">  
70.	            <tr>  
71.	                <td class="mcstyle"> First name : </td>  
72.	                <td> <input type="text" id="fname" name="fname" class="user_input" value="<?php echo $data['user'][0]['user_fname'];?>" > </td>  
73.	            </tr>   
74.	            <tr>  
75.	                <td class="mcstyle"> Last name : </td>  
76.	                <td> <input type="text" id="lname" name="lname" class="user_input" value="<?php echo $data['user'][0]['user_lname'];?>"> </td>  
77.	            </tr>   
78.	            <tr>  
79.	                <td class="mcstyle"> username : </td>  
80.	                <td> <input type="text" id="user_name" name="user_name" class="user_input" value="<?php echo $data['user'][0]['user_name'];?>"> </td>  
81.	            </tr>  
82.	            <tr>  
83.	                <td class="mcstyle"> Role : </td>  
84.	                <td>   
85.	                    <select id="role_id" name="role_id">  
86.	                    <?php   
87.	                    if (is_array($data['role'])){  
88.	                        foreach($data['role'] as $row){  
89.	                    ?>  
90.	                    <option <?php echo ( $data['user'][0]['role_id'] == $row['role_id'] ) ? 'selected' : '';?> value="<?php echo $row['role_id']; ?>"> <?php echo $row['role_name']; ?></option>  
91.	                    <?php  
92.	                        }  
93.	                    }  
94.	                    ?>  
95.	                    </select>  
96.	                </td>  
97.	            </tr>  
98.	            <tr>  
99.	                <td width="150" class="mcstyle"> Department Level : </td>  
100.	                <td>   
101.	                    <select id="dept_id" name="dept_id">  
102.	                        <?php  
103.	                        if (is_array($data['department'])){  
104.	                            foreach($data['department'] as $row){  
105.	                        ?>  
106.	                        <option <?php echo ( $data['user'][0]['department_id'] == $row['department_id'] ) ? 'selected' : '' ; ?> value="<?php echo $row['department_id']; ?>"> <?php echo $row['department_name'];?> </option>  
107.	                        <?php  
108.	                                }  
109.	                            }  
110.	                        ?>  
111.	                    </select>  
112.	                </td>  
113.	            </tr>   
114.	            <tr>  
115.	                <td class="mcstyle"> Exam Checker: </td>  
116.	                <td> <input type="checkbox" <?php echo ($data['user'][0]['exam_checker'] == 1) ? 'checked' : '' ;?> id="u_examchecker" name="u_examchecker"> </td>  
117.	            </tr>  
118.	            <tr>  
119.	                <td class="mcstyle"> Enable: </td>  
120.	                <td> <input type="checkbox" <?php echo ($data['user'][0]['user_enabled'] == 1) ? 'checked' : '' ;?>  id="u_enable" name="u_enable"> </td>  
121.	            </tr>   
122.	            <tr>  
123.	                <td> <input type="button" id="save" class="e_button" value="Save"></td>  
124.	                <td>  
125.	                    <input type="button" id="cancel" class="e_button" value="Cancel">  
126.	                    <input type="button" id="password_change" class="e_button" value="Change Password">  
127.	                </td>  
128.	            </tr>  
129.	            </table>  
130.	            </form>  
131.	        </div>  
132.	        <div id="frame2" style="display: none;">  
133.	            <table width="30%">  
134.	            <tr>  
135.	                <td class="mcstyle"> Change Password : </td>  
136.	                <td> <input type="password" id="change_pass" name="change_pass" class="user_input" value="" > </td>  
137.	            </tr>   
138.	            <tr>  
139.	                <td class="mcstyle"> Re-type password : </td>  
140.	                <td> <input type="password" id="retype_pass" name="retype_pass" class="user_input" value=""> </td>  
141.	            </tr>   
142.	            <tr>  
143.	                <td> <input type="button" id="save2" class="e_button" value="Save"></td>  
144.	                <td><input type="button" id="cancel2" class="e_button" value="Cancel"></td>  
145.	            </tr>  
146.	            </table>  
147.	        </div>  
148.	        <input type="hidden" id="edit_id" name="edit_id" value="<?php echo $data['user_id'];?>"/>  
149.	      
150.	    </div>  
151.	</div>  
login-failed.php
1.	<div  style="width: 100%; padding-top: 10px;text-align: center;">  
2.	<table align="center">  
3.	    <?php  
4.	        if ( isset($_GET['err']) ) {  
5.	            if ( $_GET['err'] == 1  ) {  
6.	                echo "<b> <span style='color:red'>* Incorrect Username or Password * </span> </b>";  
7.	            }elseif ( $_GET['err'] == 0 ) {  
8.	                echo "<b> <span style='color:red'>* Your account need to be activated * </span></b>";  
9.	            }else{  
10.	                header("Location:" . BASE_URL );  
11.	            }  
12.	        }else{  
13.	            echo "<b> <span style='color:red'>* Incorrect Username or Password * </span></b>";  
14.	        }  
15.	    ?>  
16.	      
17.	<tr>  
18.	    <td style="font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;"> Username :</td>  
19.	    <td> <input type="text" id="user_name" name="user_name" class="user_input"/></td>  
20.	</tr>  
21.	<tr>  
22.	    <td style="font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;"> Password : </td>  
23.	    <td> <input type="password" id="user_password" name="user_password" class="user_input"></td>  
24.	</tr>  
25.	<tr>  
26.	    <!--  
27.	    <td> <input type="submit" value="submit"></td>  
28.	    <td> <input type="button" value="sign-up"></td>  
29.	    -->  
30.	    <td> <input type="submit" value="Login"></td>  
31.	    <td style="font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;"> <a href="index.php?admin/signupnew">Sign-Up</a></td>  
32.	</tr>  
33.	</table>  
34.	</div>  
exam.php
1.	<html>  
2.	<head>  
3.	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
4.	    <script language="javascript">  
5.	  
6.	    var total_pages, time_limit, current_time, hrs, mins, begin ;  
7.	    var next_page = 0;  
8.	    total_pages = <?php echo $data['count'][0]['count(exams.exam_id)'] - 1 ;?>;  
9.	    time_limit = <?php echo $data['count'][0]['exam_time_limit']; ?>;  
10.	    seconds = 59;  
11.	    var x=0;  
12.	    begin = 0;  
13.	    var time_consumed = 0;  
14.	    //alert(time_limit);  
15.	    $(document).ready(function(){  
16.	        //check result  
17.	          
18.	        var myVar=setInterval(function(){  
19.	            if (time_limit > 0 || seconds > 0) {  
20.	                if (begin == 0){  
21.	                    begin = 1;  
22.	                    hrs = (time_limit - (time_limit % 3600)) / 3600;  
23.	                    mins = (time_limit % 3600) / 60;      
24.	                }  
25.	                time_limit --;  
26.	                seconds--;  
27.	                if (seconds == 0){  
28.	                    hrs = (time_limit - (time_limit % 3600)) / 3600;  
29.	                    mins = (time_limit % 3600) / 60;      
30.	                }  
31.	                if (seconds == 0 && time_limit > 0){  
32.	                    seconds = 59;  
33.	                }  
34.	                time_consumed++;  
35.	                $('#time').html('Time remaining : ' + (parseInt(hrs) > 0 ? parseInt(hrs) : '00') + ' : ' + (parseInt(mins) > 0 ? parseInt(mins) : '00') + ' : ' + (seconds > 0 ? seconds : '00'));  
36.	            }else{  
37.	                //submit data  
38.	                alert("Your time is up, all answers will be submitted!");  
39.	                x = 0;  
40.	                $("input[type='radio']:checked").each(function() {  
41.	                    x = $("input[type=radio]:checked").attr('id');  
42.	                });  
43.	  
44.	                var  type = $('#question_type').val();  
45.	                window.clearInterval(myVar);  
46.	                if (x == 1){  
47.	                    next_page++;  
48.	                    //$.get('index.php?staff/submitresult',{ 'exam_id' : $('#exam_id').val(),'start' : next_page,'question_id':$('#question_id').val(), 'answer_id' : $("input[type=radio]:checked").attr('id') },function(data){  
49.	                    $.get('index.php?staff/submitresult',{ 'exam_id' : $('#exam_id').val(),'start' : next_page,'question_id':$('#question_id').val(), 'answer_id' : $("input[type=radio]:checked").attr('id'),'answer' : '', 'time_consumed' : time_consumed },function(data){  
50.	                        //$('#exam').action="index.php?staff/thankyou";  
51.	                        //$('#exam').submit();  
52.	                        $('#thankyou').load('index.php?staff/thankyou&exam_id='+$('#exam_id').val());  
53.	                    });  
54.	                    x = 0;  
55.	                }else{  
56.	                    if (type == 1){  
57.	                        if ( $('#essay_id').val() != '' ) {  
58.	                            next_page++;  
59.	                            $.get('index.php?staff/submitresult',{ 'exam_id' : $('#exam_id').val(),'start' : next_page,'question_id':$('#question_id').val(), 'answer' : $('#essay_id').val(), 'time_consumed': time_consumed },function(data){  
60.	                                $('#thankyou').load('index.php?staff/thankyou&exam_id='+$('#exam_id').val());  
61.	                                //$('#exam').action="index.php?staff/thankyou";  
62.	                                //$('#exam').submit();  
63.	                            });  
64.	                            x = 0;  
65.	                        }else{  
66.	                            //alert('Essay answer should not be empty');  
67.	                        }  
68.	                    }else{  
69.	                        if (total_pages != 0){  
70.	                            $.get('index.php?staff/submitresult',{ 'exam_id' : $('#exam_id').val(),'start' : next_page,'question_id':$('#question_id').val(), 'answer_id' : x ,'answer' : $('#essay_id').val(), 'time_consumed': time_consumed },function(data){  
71.	                                $('#exam').action="index.php?";  
72.	                                $('#exam').submit();  
73.	                            });   
74.	                        }else{  
75.	                            $.get('index.php?staff/submitresult2',{ 'exam_id' : $('#exam_id').val(),'question_id':$('#question_id2').val(), 'time_consumed' : time_consumed },function(data){  
76.	                                $('#thankyou').load('index.php?staff/thankyou&exam_id='+$('#exam_id').val());  
77.	                                //$('#exam').action="index.php?staff/thankyou";  
78.	                                //$('#exam').submit();  
79.	                            });  
80.	                        }  
81.	                          
82.	                    }  
83.	                }  
84.	            }  
85.	        },1000);  
86.	  
87.	        $('#submit_result').click(function(){  
88.	            $(this).attr('disabled',true);  
89.	            $("input[type='radio']:checked").each(function() {  
90.	                x = 1;  
91.	            });  
92.	            var  type = $('#question_type').val();  
93.	            //type = 1 'essay'  
94.	            if (x == 1){  
95.	                next_page++;  
96.	                $.get('index.php?staff/submitresult',{ 'exam_id' : $('#exam_id').val(),'start' : next_page,'question_id':$('#question_id').val(), 'answer_id' : $("input[type=radio]:checked").attr('id'),'answer' : '', 'time_consumed' : time_consumed },function(data){  
97.	                    $('#thankyou').load('index.php?staff/thankyou&exam_id='+$('#exam_id').val());  
98.	                });  
99.	                x = 0;  
100.	            }else{  
101.	                if (type == 1){  
102.	                    if ( $('#essay_id').val().length >= 1 ) {  
103.	                        next_page++;  
104.	                        $.get('index.php?staff/submitresult',{ 'exam_id' : $('#exam_id').val(),'start' : next_page,'question_id':$('#question_id').val(), 'answer' : $('#essay_id').val(), 'time_consumed' : time_consumed },function(data){  
105.	                            $('#thankyou').load('index.php?staff/thankyou&exam_id='+$('#exam_id').val());  
106.	                        });  
107.	                        x = 0;  
108.	                    }else{  
109.	                        alert('Essay answer should not be empty');  
110.	                    }  
111.	                }else{  
112.	                    if (total_pages != 0){  
113.	                        alert('Please select an answer');  
114.	                        //return false;       
115.	                    }else{  
116.	                        $.get('index.php?staff/submitresult2',{ 'exam_id' : $('#exam_id').val(),'question_id':$('#question_id2').val(), 'answer': '', 'time_consumed' : time_consumed },function(data){  
117.	                            $('#thankyou').load('index.php?staff/thankyou&exam_id='+$('#exam_id').val());  
118.	                            //$('#exam').action="index.php?staff/thankyou";  
119.	                            //$('#exam').submit();  
120.	                        });  
121.	                    }  
122.	                      
123.	                }  
124.	                  
125.	            }  
126.	            $(this).attr('disabled',false);  
127.	        });  
128.	        $('#next').click(function(){  
129.	            $(this).attr('disabled',true);  
130.	            $("input[type='radio']:checked").each(function() {  
131.	                //$("input[type=radio]:checked").attr('id');  
132.	                x = 1;  
133.	            });  
134.	            //alert($('#question_type').val());  
135.	            var  type = $('#question_type').val();  
136.	            if (x == 1){  
137.	                next_page++;  
138.	                $.get('index.php?staff/getexamnext',{ 'exam_id' : $('#exam_id').val(),'start' : next_page,'question_id':$('#question_id').val(), 'answer_id' : $("input[type=radio]:checked").attr('id'), 'answer' : '' },function(data){  
139.	                    $('#xx').html(data);  
140.	                    if (next_page >= total_pages){  
141.	                        $('#next').hide();  
142.	                        $('#submit_result').show();  
143.	                    }  
144.	                });  
145.	                x = 0;  
146.	            }else{  
147.	                if (type == 1){  
148.	                    if ( $('#essay_id').val().length >= 1 ) {  
149.	                        next_page++;  
150.	                        $.get('index.php?staff/getexamnext',{ 'exam_id' : $('#exam_id').val(),'start' : next_page,'question_id':$('#question_id').val(), 'answer' : $('#essay_id').val() },function(data){  
151.	                            $('#xx').html(data);  
152.	                            if (next_page >= total_pages){  
153.	                                $('#next').hide();  
154.	                                $('#submit_result').show();  
155.	                            }  
156.	                        });  
157.	                        x = 0;  
158.	                    }else{  
159.	                        alert('Essay answer should not be empty');  
160.	                        //return false;  
161.	                    }  
162.	                }else{  
163.	                    alert('Please select an answer');  
164.	  
165.	                    //return false;   
166.	                }  
167.	            }     
168.	            $(this).attr('disabled',false);  
169.	        });  
170.	        //myTxtArea.value.replace(/^\s*|\s*$/g,'');  
171.	  
172.	        //$(this).val().replace(/ /g, "<br/>");  
173.	        //$('#essay_id').val().replace(/^\s*|\s*$/g,'');  
174.	        $('#essay_id').val($.trim($('#essay_id').val()));  
175.	    });  
176.	  
177.	    </script>  
178.	    <style>  
179.	  
180.	.mcstyle{  
181.	        font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.9em;  
182.	}  
183.	</style>  
184.	</head>  
185.	<body>  
186.	    <div id="fb-root"></div>  
187.	    <script>  
188.	        (function(d, s, id) {  
189.	          var js, fjs = d.getElementsByTagName(s)[0];  
190.	          if (d.getElementById(id)) return;  
191.	          js = d.createElement(s); js.id = id;  
192.	          js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&appId=735682916475167&version=v2.0";  
193.	          fjs.parentNode.insertBefore(js, fjs);  
194.	        }(document, 'script', 'facebook-jssdk'));  
195.	    </script>  
196.	    <form name="exam" id="exam" action="index.php?staff/thankyou">  
197.	    <div style="margin-top: 20px; width: 990px; margin: 0 auto; " id="thankyou" class="mcstyle">  
198.	        <div id="time" style="font-size: 18px;font-weight: bold;" class="mcstyle">  
199.	  
200.	        </div>  
201.	        <div id="xx" style="width: 100%; margin-top: 5px;" class="mcstyle">  
202.	            <?php  
203.	            if (is_array($data['exam'])){  
204.	            ?>  
205.	                <div>  
206.	                    <?php  
207.	                        echo $data['exam'][0]['question_name'] ;  
208.	                    ?>  
209.	                </div>  
210.	                <div>  
211.	                    <?php   
212.	            //  if(is_array($data['exam'][0]['question_type'])){  
213.	                    if ($data['exam'][0]['question_type'] == 0){  
214.	                    ?>  
215.	  
216.	                           <ol type="A">  
217.	                            <?php  
218.	                                foreach($data[$data['exam'][0]['question_id']] as $row){  
219.	                                ?>  
220.	                                    <li>  
221.	                                        <input name="grpname" id="<?php echo $row['answer_id'];?>" value="<?php echo $row['answer_name'];?>" type='radio'/><?php echo $row['answer_name'];?>  
222.	                                    </li>  
223.	                                <?php  
224.	                                }  
225.	                                ?>  
226.	                            </ol>  
227.	                <?php  
228.	                    }else{  
229.	                ?>  
230.	                        <div>  
231.	                            <textarea id="essay_id"  cols="60" rows="6">  
exam-next.php
1.	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
2.	<script language="javascript">  
3.	$(document).ready(function(){  
4.	    $('#essay_id').val($.trim($('#essay_id').val()));  
5.	});  
6.	      
7.	</script>  
8.	<style>  
9.	  
10.	.mcstyle{  
11.	        font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.9em; color: #535353!important;  
12.	}  
13.	</style>  
14.	<div class="mcstyle">  
15.	    <?php  
16.	    if (is_array($data['exam'])){  
17.	    ?>  
18.	        <div>  
19.	            <?php  
20.	                echo $data['exam'][0]['question_name'];  
21.	                //echo $data['exam'][0]['question_id'];  
22.	            ?>  
23.	        </div>  
24.	        <div>  
25.	            <?php   
26.	            if ($data['exam'][0]['question_type'] == 0){  
27.	            ?>  
28.	  
29.	               <ol type="A">  
30.	                <?php  
31.	  
32.	                foreach($data[$data['exam'][0]['question_id']] as $row){  
33.	                ?>  
34.	                    <li>  
35.	                        <input name="grpname"  id="<?php echo $row['answer_id'];?>" value="<?php echo $row['answer_name'];?>" type='radio'/><?php echo $row['answer_name'];?>  
36.	                    </li>  
37.	                <?php  
38.	                }  
39.	                ?>  
40.	                </ol>  
41.	        <?php  
42.	            }else{  
43.	        ?>  
44.	            <div>  
45.	                <textarea id="essay_id"  cols="60" rows="6">   
exams_list.php
1.	<style>  
2.	    .table-new {border:1px solid #00688B;text-align: center; margin-left:50px; margin-bottom:15px;}  
3.	    .table-new tbody{border: 1px solid #00688B;}  
4.	    .line {border-right: 1px solid #00688B;padding-right: 2px;margin-right: 5px;border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.9em; color: #535353!important;}  
5.	    .line1{border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.9em; color: #535353!important;}  
6.	    .line2{border-right: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important; font-weight:bold;}  
7.	  
8.	  
9.	    .error-msg{  
10.	        overflow:hidden;  
11.	        width:900px;   
12.	    }  
13.	    .error-msg h5{  
14.	        overflow:hidden;  
15.	        color:#F00;  
16.	        text-transform:uppercase;  
17.	        background: white;  
18.	    }  
19.	    .mcstyle{  
20.	        font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
21.	    }  
22.	</style>  
23.	  
24.	<div style="width: 90%; height: auto;">  
25.	  
26.	    <table width="100%" class="table-new" border="0" cellspacing="0" cellpadding="5">  
27.	        <tr class="tr-head">  
28.	            <td width="270" class="line2"><b> Exam Name </b></td>  
29.	            <td width="120" class="line2"> <b>Exam Period </b></td>  
30.	            <td width="30" class="line2"> <b>Department </b></td>  
31.	            <td widt="150" class="">Action</td>  
32.	        </tr>  
33.	        <?php  
34.	        if (is_array($data)) {  
35.	            foreach ($data as $row) {  
36.	                // index.php?admin/examedit&exam_id=23  
37.	                //$link = "javascript:loadPage('index.php?admin/examedit&exam_id=".$row['exam_id']."')";  
38.	                $link = "javascript:loadPage('index.php?admin/questionlist&exam_id=" . $row['exam_id'] . "')";  
39.	                ?>  
40.	                <tr>  
41.	                    <td class="line"> <?php echo $row['exam_name']; ?> </td>  
42.	                    <td class="line"> <?php echo date('m-d-Y', strtotime($row['exam_from'])) . ' - ' . date('m-d-Y', strtotime($row['exam_to'])); ?> </td>  
43.	                    <td class="line"> <?php echo $row['department_name'];?></td>  
44.	                    <td width="100" align="center" class="line1">  
45.	                        <a href="javascript:loadPage('index.php?staff/examsresult&exam_id=<?php echo $row['exam_id'] ?>');"> View Result</a>  
46.	                    </td>  
47.	                </tr>  
48.	                <?php  
49.	            }  
50.	        }  
51.	        ?>  
52.	    </table>  
53.	</div>  
examsresult.php
1.	<script language="javascript">  
2.	    /* 
3.	    $(document).ready(function(){ 
4.	        $("#range_from").datepicker({dateFormat: 'yy-mm-dd'}); 
5.	        $("#range_to").datepicker({dateFormat: 'yy-mm-dd'}); 
6.	        $('#range_from').change(function(){ 
7.	            //alert($(this).val()); 
8.	            if ( $('#range_to').val().length > 1 ) { 
9.	                $.post('index.php?admin/examsresult',{ 'from' : $('#range_from').val(), 'to' : $('#range_to').val() }, 
10.	                function( data ){ 
11.	                    $('#result').html( data ); 
12.	                }) 
13.	            } 
14.	        }); 
15.	        $('#range_to').change(function(){ 
16.	            if ( $('#range_from').val().length > 1 ) { 
17.	                $.post('index.php?admin/examsresult',{ 'from' : $('#range_from').val(), 'to' : $('#range_to').val() }, 
18.	                function( data ){ 
19.	                    $('#result').html( data ); 
20.	                }) 
21.	            } 
22.	        }); 
23.	    }); 
24.	    */  
25.	</script>  
26.	  
27.	<style>  
28.	    .table-new {border:1px solid #00688B;text-align: center; margin-left:50px; margin-bottom:15px;}  
29.	    .table-new tbody{border: 1px solid #00688B;}  
30.	    .line {border-right: 1px solid #00688B;padding-right: 2px;margin-right: 5px;border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
31.	    .line1{border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
32.	    .line2{border-right: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important; font-weight:bold;}  
33.	  
34.	  
35.	    .error-msg{  
36.	        overflow:hidden;  
37.	        width:900px;   
38.	    }  
39.	    .error-msg h5{  
40.	        overflow:hidden;  
41.	        color:#F00;  
42.	        text-transform:uppercase;  
43.	        background: white;  
44.	    }  
45.	    .mcstyle{  
46.	        font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
47.	    }  
48.	</style>  
49.	<div style="width: 90%; height: auto;">  
50.	    <!--  
51.	    <table width="100%">  
52.	        <tr>  
53.	            <td class="mcstyle" align="right">   
54.	                Exam From   
55.	                <input maxlength="10" id="range_from" name="range_from" class="user_input" type="text">  
56.	                     
57.	                Exam To   
58.	                <input maxlength="10" id="range_to" name="range_to" class="user_input" type="text">  
59.	            </td>  
60.	        </tr>  
61.	    </table>  
62.	    -->  
63.	    <div id="result" style="width: 100%; margin: 0 auto;">  
64.	        <table width="100%" class="table-new" border="0" cellspacing="0" cellpadding="5">  
65.	            <tr class="tr-head">  
66.	                <td widt="100" align="center" class="line2">  Examinees Name </td>  
67.	                <td width="300" align="center" class="line2">Exam Name </td>  
68.	                <td width="10" align="center" class="line2">Scores </td>  
69.	                <td width="50" align="center" class="line2">Exam </br>Remarks </td>  
70.	                <td width="60" align="center" class="line2">Check </br> Status  </td>  
71.	                <td align="center" class="">  View </td>  
72.	            </tr>  
73.	  
74.	            <?php  
75.	            //print_r($data);  
76.	            if (is_array($data['exam'])) {  
77.	                foreach ($data['exam'] as $row) {  
78.	                    ?>  
79.	                    <tr>  
80.	                        <td align="center" class="line"> <?php echo $row['user_lname'] . ', ' . $row['user_fname']; ?></td>  
81.	                        <td align="center" class="line"> <?php echo $row['exam_name']; ?></td>  
82.	                        <td align="center" class="line"> <?php echo ( $data[$row['user_id']][$row['exam_id']][0]['score'] == $row['passing_score'] ) ? 'PERFECT' : $data[$row['user_id']][$row['exam_id']][0]['score'] . ' over '. $row['passing_score']; ?> </td>  
83.	                        <td align="center" class="line">  
84.	                            <?php  
85.	                           // echo $data[$row['user_id']][$row['exam_id']][0]['score'];  
86.	                              
87.	                            if ((($data[$row['user_id']][$row['exam_id']][0]['score'] / $row['passing_score']) * 100 ) >= $row['passing_grade']) {  
88.	                                echo "<span style='color: green;'><b>Passed</b></span>";  
89.	                            } else {  
90.	                                echo "<span style='color: red;'><b>Failed</b></span>";  
91.	                               //echo  ($data[$row['user_id']][0]['score'] / $row['passing_score']) * 100;  
92.	                                //echo $data[$row['user_id']][0]['score'];  
93.	                            }  
94.	                              
95.	                            ?>   
96.	                        </td>  
97.	                        <td align="center" class="line"> <?php echo ($row['check_status'] == 1 ) ? '<b>Checked</b>' : "<span style='color: red;'><b><i>Not Yet</i></b></span>";?> </td>  
98.	                        <td align="center" class="line1"> <a href="javascript:loadPage('index.php?admin/checkresult&exam_id=<?php echo $row['exam_id']; ?>' + '&user_id=<?php echo $row['user_id']; ?>');"> Check Results</a></td>  
99.	  
100.	                    </tr>  
101.	                    <?php  
102.	                }  
103.	            }  
104.	            ?>  
105.	  
106.	        </table>  
107.	    </div>  
108.	</div>  
examsresult_data.php
1.	<style>  
2.	    .table-new {border:1px solid #00688B;text-align: center; margin-left:50px; margin-bottom:15px;}  
3.	    .table-new tbody{border: 1px solid #00688B;}  
4.	    .line {border-right: 1px solid #00688B;padding-right: 2px;margin-right: 5px;border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
5.	    .line1{border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
6.	    .line2{border-right: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important; font-weight:bold;}  
7.	  
8.	  
9.	    .error-msg{  
10.	        overflow:hidden;  
11.	        width:900px;   
12.	    }  
13.	    .error-msg h5{  
14.	        overflow:hidden;  
15.	        color:#F00;  
16.	        text-transform:uppercase;  
17.	        background: white;  
18.	    }  
19.	.mcstyle{  
20.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
21.	}  
22.	 </style>  
23.	<table width="100%" class="table-new" border="0" cellspacing="0" cellpadding="5">  
24.	    <tr class="tr-head">  
25.	        <td widt="100" align="center" class="line2">  Examinees Name </td>  
26.	        <td width="300" align="center" class="line2">Exam Name </td>  
27.	        <td width="100" align="center" class="line2">Remarks </td>  
28.	        <td align="center" class="line2">  View </td>  
29.	    </tr>  
30.	  
31.	    <?php  
32.	        if(is_array($data['exam'])){  
33.	            foreach($data['exam'] as $row){  
34.	    ?>  
35.	    <tr>  
36.	        <td align="center" class="line"> <?php echo $row['user_lname'] . ', ' . $row['user_fname'];?></td>  
37.	        <td align="center" class="line"> <?php echo $row['exam_name']; ?></td>  
38.	    <?php  
39.	    ?>  
40.	        <td align="center" class="line">   
41.	            <?php   
42.	                if ( (($data[$row['user_id']][0]['score'] / $row['passing_score']) * 100 ) >= $row['passing_grade'] ) {  
43.	                    echo "<span style='color: green;'><b>Passed</b></span>";  
44.	                }else{  
45.	                    echo "<span style='color: red;'><b>Failed</b></span>";  
46.	                }  
47.	            ?>   
48.	        </td>  
49.	        <td align="center" class="line1"> <a href="javascript:loadPage('index.php?admin/checkresult&exam_id=<?php echo $row['exam_id'];?>' + '&user_id=<?php echo $row['user_id'];?>');"> Check Results</a></td>  
50.	  
51.	    </tr>  
52.	    <?php  
53.	            }  
54.	        }  
55.	    ?>  
56.	  
57.	</table>  
navigation.php
1.	<style>  
2.	a{  
3.	  text-decoration: none;  
4.	  font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em;  
5.	}  
6.	  
7.	  
8.	</style>  
9.	<table class="nav">  
10.	<tr>  
11.	    <?php   
12.	        if ( $data[0]['exam_checker'] == 1 ){  
13.	    ?>  
14.	    <td>  <a  href="javascript:loadPage('index.php?staff/examslist');"> Examinations Results </a> </td>  
15.	    <?php  
16.	        }  
17.	    ?>  
18.	    <td >   <a href="javascript:loadPage('index.php?staff/index');"> Examinations List </a> </td>  
19.	    <td >   <a href="index.php?authenticate/logout"> Logout </a> </td>  
20.	</tr>  
21.	</table>  
thankyou.php
1.	<style>  
2.	  
3.	.mcstyle{  
4.	        font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.9em; color: #535353!important;  
5.	}  
6.	</style>  
7.	<div style="width: 100%;" class="mcstyle">  
8.	    <div style="width: 50%; align: center;">  
9.	        <b> Thank You For Taking The Exam </b>  
10.	    </br>  
11.	        <a href="index.php?staff/viewresults2&exam_id=<?php echo $_GET['exam_id'];?>"> View Results</a>  
12.	    </div>  
13.	</div>  
view-results.php
1.	<script language="javascript">  
2.	$(document).ready(function(){  
3.	    $('#back').click(function(){  
4.	        loadPage('index.php?staff/index');  
5.	  
6.	    });  
7.	});  
8.	</script>  
9.	<style>  
10.	    .table-new {border:1px solid #00688B;text-align: center; margin-left:50px}  
11.	    .table-new tbody{border: 1px solid #00688B;}  
12.	    .line {text-align: left; border-right: 1px solid #00688B;padding-right: 2px;margin-right: 5px;border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
13.	    .line1{border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
14.	    .line2{border-right: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important; font-weight:bold;}  
15.	  
16.	  
17.	    .error-msg{  
18.	        overflow:hidden;  
19.	        width:900px;   
20.	    }  
21.	    .error-msg h5{  
22.	        overflow:hidden;  
23.	        color:#F00;  
24.	        text-transform:uppercase;  
25.	        background: white;  
26.	    }  
27.	.mcstyle{  
28.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
29.	}  
30.	 </style>  
31.	</br>  
32.	<span class="mcstyle" style="margin-left:50px;">Exam name: <?php echo $data['exam_name'][0]['exam_name'];?></span>  
33.	<div style="margin-top: 8px;">  
34.	<table width="90%" class="table-new" border="0" cellspacing="0" cellpadding="5">  
35.	<tr class="tr-head">  
36.	    <td width="150" align="center" class="line2"><b> Questions  </b></td>  
37.	    <td width="100" class="line2"><b> My Answers </b></td>  
38.	</tr>  
39.	<?php   
40.	$cnt = 0;  
41.	$correct = 0;  
42.	if (is_array($data['transaction_dtl'])){  
43.	    foreach($data['transaction_dtl'] as $row){  
44.	    $cnt++;  
45.	        if ($row['israted'] <> 0){  
46.	            $correct += $row['score'];  
47.	        }  
48.	          
49.	      
50.	?>  
51.	<tr>  
52.	    <td class="line"> <?php  echo $cnt . '. ' . $row['question_name']; ?> <?php  echo ($row['israted'] == 0 ?  "<span style='color:gray;'> (Not yet graded) </span>" : '');?> </td>  
53.	    <?php  
54.	    if ($row['israted'] == 0){  
55.	  
56.	    ?>  
57.	        <td class="line"> <span style="color: black"><?php echo $row['essay']; ?> </span></td>  
58.	    <?php  
59.	    }else{  
60.	    ?>  
61.	    <td class="line"> <span style="<?php echo ($row['score']==0 ? 'color: red' : 'color:green');?>"><?php echo ($row['answer_name'] != '' ? $row['answer_name'] : $row['essay']); ?> </span></td>  
62.	    <?php   
63.	    }     
64.	    ?>  
65.	</tr>  
66.	<?php  
67.	    }  
68.	}  
69.	?>  
70.	</table>  
71.	<div style="float:right; padding-right: 10px; margin-right:35px;" class="mcstyle">  
72.	    <table class="mcstyle" style="font-size: 13px;">  
73.	    <tr>  
74.	        <td align="right"> <b> Score: </b></td>  
75.	        <td> <b> <?php echo $correct . ' out of ' . $data['exam_name'][0]['passing_score']; ?></b> </td>  
76.	    </tr>  
77.	    <tr>  
78.	        <td align="right"> <b>Grade: </b> </td>  
79.	         <td>   
80.	            <b>  
81.	            <?php  $grade = ($correct/$data['exam_name'][0]['passing_score']) * 100 ;  
82.	                echo $grade.'%';  
83.	             ?>    
84.	            </b>   
85.	        </td>  
86.	    </tr>  
87.	    <tr>  
88.	        <td align="right"> <b> Remark: </b></td>  
89.	        <td>   
90.	        <?php  
91.	            if ( $grade >= $data['exam_name'][0]['passing_grade'] ) {  
92.	                echo "<span style='color: green;'><b>Passed</b></span>";  
93.	            }else{  
94.	                echo "<span style='color: red;'><b>Failed</b></span>";  
95.	            }  
96.	        ?>  
97.	        </td>  
98.	    </tr>  
99.	    </table>  
100.	    </br>  
101.	    <div style="float:right;">  
102.	        <input type="button" id="back" value="Back">  
103.	    </div>  
104.	</div>  
105.	  
106.	      
107.	</div>  
view-results2.php
1.	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
2.	<script language="javascript">  
3.	$(document).ready(function(){  
4.	    $('#back').click(function(){  
5.	        //loadPage('index.php?staff/index');  
6.	        $('#view').action="index.php?staff/index";  
7.	        $('#view').submit();  
8.	    });  
9.	});  
10.	</script>  
11.	<style>  
12.	    .table-new {border:1px solid #00688B;text-align: center; margin-left:50px;}  
13.	    .table-new tbody{border: 1px solid #00688B;}  
14.	    .line {text-align: left;border-right: 1px solid #00688B;padding-right: 2px;margin-right: 5px;border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
15.	    .line1{border-top: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;}  
16.	    .line2{border-right: 1px solid #00688B;font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important; font-weight:bold;}  
17.	  
18.	  
19.	    .error-msg{  
20.	        overflow:hidden;  
21.	        width:900px;   
22.	    }  
23.	    .error-msg h5{  
24.	        overflow:hidden;  
25.	        color:#F00;  
26.	        text-transform:uppercase;  
27.	        background: white;  
28.	    }  
29.	.mcstyle{  
30.	    font-family: 'Lucida Grande',Helvetica,Arial,Verdana,sans-serif; font-size: 0.8em; color: #535353!important;  
31.	}  
32.	 </style>  
33.	</br>  
34.	<span style="margin-left:50px;" class="mcstyle">Exam name: <?php echo $data['exam_name'][0]['exam_name'];?></span>  
35.	<form name="view" id="view" action="index.php?staff/index">  
36.	<div style="margin-top: 8px;">  
37.	  
38.	    <table width="90%" class="table-new" border="0" cellspacing="0" cellpadding="5">  
39.	    <tr class="tr-head">  
40.	        <td width="150" align="center" class="line2"><b> Questions  </b></td>  
41.	        <td width="100" class="line2"><b> My Answers </b></td>  
42.	    </tr>  
43.	    <?php   
44.	    $cnt = 0;  
45.	    $correct = 0;  
46.	    if (is_array($data['transaction_dtl'])){  
47.	        foreach($data['transaction_dtl'] as $row){  
48.	        $cnt++;  
49.	            if ($row['israted'] <> 0){  
50.	                $correct += $row['score'];  
51.	            }  
52.	              
53.	          
54.	    ?>  
55.	    <tr>  
56.	        <td class="line"> <?php  echo $cnt . '. ' . $row['question_name']; ?> <?php  echo ($row['israted'] == 0 ?  "<span style='color:gray;'> (Not yet graded) </span>" : '');?> </td>  
57.	        <?php  
58.	        if ($row['israted'] == 0){  
59.	  
60.	        ?>  
61.	            <td class="line"> <span style="color: black"><?php echo $row['essay']; ?> </span></td>  
62.	        <?php  
63.	        }else{  
64.	        ?>  
65.	        <td class="line"> <span style="<?php echo ($row['score']==0 ? 'color: red' : 'color:green');?>"><?php echo ($row['answer_name'] != '' ? $row['answer_name'] : $row['essay']); ?> </span></td>  
66.	        <?php   
67.	        }     
68.	        ?>  
69.	    </tr>  
70.	    <?php  
71.	        }  
72.	    }  
73.	    ?>  
74.	    </table>  
75.	    <div style="float:right; padding-right: 10px; margin-right:60px;" class="mcstyle">  
76.	    <table class="mcstyle" style="font-size: 13px;">  
77.	    <tr>  
78.	        <td align="right"> <b> Score: </b></td>  
79.	        <td> <b> <?php echo $correct . ' out of ' . $data['exam_name'][0]['passing_score']; ?></b> </td>  
80.	    </tr>  
81.	    <tr>  
82.	        <td align="right"> <b>Grade: </b> </td>  
83.	         <td>   
84.	            <b>  
85.	            <?php  $grade = ($correct/$data['exam_name'][0]['passing_score']) * 100 ;  
86.	                echo $grade.'%';  
87.	             ?>    
88.	            </b>   
89.	        </td>  
90.	    </tr>  
91.	    <tr>  
92.	        <td align="right"> <b> Remark: </b></td>  
93.	        <td>   
94.	        <?php  
95.	            if ( $grade >= $data['exam_name'][0]['passing_grade'] ) {  
96.	                echo "<span style='color: green;'><b>Passed</b></span>";  
97.	            }else{  
98.	                echo "<span style='color: red;'><b>Failed</b></span>";  
99.	            }  
100.	        ?>  
101.	        </td>  
102.	    </tr>  
103.	    </table>  
104.	    </br>  
105.	    <div style="float:right;">  
106.	        <input type="button" id="back" value="Back">  
107.	    </div>  
108.	    </div>  
109.	</div>  
110.	</form>  
.htaccess
1.	#Index page, which will be opened by user in riedirecting to the site`s domain.  
2.	DirectoryIndex index.php  
3.	  
4.	#If the page is not found  
5.	ErrorDocument 404 /_ERRORS/error404.php  
6.	  
7.	#If in the URL-area, the mistake is made  
8.	ErrorDocument 403 /_ERRORS/index.php  
9.	  
10.	#Doesnot show the catalog of accessable files if the file is not exists.  
11.	Options -Indexes  
12.	  
13.	#Write the errors into the LOG file  
14.	php_flag  log_errors on  
15.	php_value error_log  /_ERRORS/PHP_errors.log  
16.	  
17.	  
18.	#Supress php errors  
19.	php_flag display_startup_errors off  
20.	php_flag display_errors off  
21.	php_flag html_errors off  
22.	php_value docref_root 0  
23.	php_value docref_ext 0  
24.	  
25.	#Anyone who wants to open configuration script of database (as example) of the site can`t get an access to direct request of the file.  
26.	<FilesMatch "config.php">  
27.	  Order Deny,Allow  
28.	  Deny from all  
29.	</FilesMatch>  
error404.php
1.	<style>   
2.	  .window-center {top: 50%; 
3.	  left: 50%; 
4.	  width: 450px; 
5.	  height: 450px; 
6.	  position: absolute; 
7.	  margin-top: -225px;
8.	  margin-left: -225px; 
9.	  
10.	</style>  
11.	  
12.	<div class="window-center">  
13.	                <center>  
14.	                <br>  
15.	                <h2>ERROR<b>!!!</b></h2>  
16.	                <br/>  
17.	                <br>  
18.	                        The website was created and designed by <a href="https://instagram.com/alimkh_n" class="font-size: 14px;">Alimkhan Akimzhan</a>.  
19.	                        <br>Do you have any problems?  Send me a direct message in Instagram.</br>  
20.	                </br>  
21.	                </center>  
22.	</div>  

