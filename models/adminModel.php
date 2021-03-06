<?php

Class adminModel extends _Db {
    /* for users */

    public function addnewuser($user_fname, $user_lname, $user_name, $user_password, $role_id, $department_id, $enabled=0, $user_id, $ischecker) {
        $this->insert('users', array('user_fname' => "'$user_fname'", 'user_lname' => "'$user_lname'", 'user_name' => "'$user_name'",
            'user_password' => "'$user_password'", 'role_id' => $role_id, 'department_id' => $department_id,
            'user_enabled' => $enabled, 'user_createdby' => $user_id, 'exam_checker' => $ischecker));
    }
	
	

    public function userupdate($user_fname, $user_lname, $user_name, $role_id, $department_id, $enabled=0, $current_user_id, $edit_id, $ischecker=0) {
        if (!isset($enabled)) {
            $enabled = 0;
        }
        if (!isset($ischecker)) {
            $ischecker = 0;
        }
        $modify_date = date("Y-m-d", time());
		
        echo $sql;
        $this->query($sql);
        $sql = "UPDATE users SET user_fname = '$user_fname', user_lname='$user_lname',
								 user_name='$user_name',role_id=$role_id,department_id=$department_id,
								 user_enabled=$enabled,user_modifiedby=$current_user_id,user_modifiedon='$modify_date',
								 exam_checker = $ischecker
								 WHERE user_id = $edit_id";
        //							 echo $sql;
        $this->query($sql);
    }

    public function userupdate2($edit_id , $change_pass){
        $modify_date = date("Y-m-d", time());
        $change_pass = md5($change_pass);
        $sql = "UPDATE users SET user_password = '$change_pass', user_modifiedon='$modify_date' WHERE user_id = $edit_id";
        $this->query($sql);
    }

    public function loadDepartmentandRole() {
        $result['department'] = $this->fetch_all_rows('select * from department');
        $result['role'] = $this->fetch_all_rows('select * from user_roles');
        return $result;
    }

    public function loadUsers() {
        return $this->fetch_all_rows('select * from users LEFT join department on users.department_id = department.department_id Left Join user_roles a ON users.role_id = a.role_id Order by user_enabled asc');
    }

    public function selectuser($user_id) {
        return $this->fetch_all_rows('select * from users where user_id =' . $user_id);
    }

    public function userdelete($user_id) {
        $sql = "delete from users where user_id = $user_id";
        $this->query($sql);
    }

    public function signupadd($user_fname, $user_lname, $user_name, $user_password, $department_id) {
        $sql = "SELECT * FROM users WHERE user_name ='$user_name'";
        $result = $this->query($sql);
        if (is_array($result)) {
            //echo json_encode(array('value'=>'error'));
            echo "1";
        } else {
            $this->insert('users', array('user_fname' => "'$user_fname'", 'user_lname' => "'$user_lname'", 'user_name' => "'$user_name'",
                'user_password' => "'$user_password'", 'department_id'=>$department_id));
            echo "0";
            //echo json_encode(array('value'=>'ok'));
        }
    }

    /* for department */

    public function savedepartmentnew($department_code, $department_name) {
        $this->insert('department', array('department_code' => "'$department_code'", 'department_name' => "'$department_name'"));
    }

    public function loadDepartment() {
        return $this->fetch_all_rows('select * from department');
    }

    public function departmentedit($department_id) {
        return $this->fetch_all_rows("select * from department where department_id = $department_id");
    }

    public function departmentupdate($department_id, $department_name) {
        $sql = "UPDATE department SET department_name ='$department_name' WHERE department_id = $department_id";
        $this->query($sql);
    }

    public function departmentdelete($department_id) {
        $this->query("DELETE FROM department WHERE department_id = $department_id");
    }

    /* for exams */

    public function saveexamsnew($exam_name, $exam_from, $exam_to, $user_id, $total_points, $time, $passing_grade, $department_id) {
        $this->insert('exams', array('exam_name' => "'$exam_name'", 'exam_from' => "'$exam_from'", 'exam_to' => "'$exam_to'",
            'exam_created_by' => $user_id, 'passing_score' => $total_points, 'exam_time_limit' => $time, 'passing_grade' => $passing_grade, 'department_id' => $department_id));
    }

    public function saveexamsupdate($exam_name, $exam_from, $exam_to, $user_id, $total_points, $time, $exam_id, $passing_grade,$department_id) {
        $sql = "UPDATE exams SET exam_name='$exam_name',exam_from ='$exam_from', 
			 	exam_to='$exam_to',exam_modified_by=$user_id,passing_score=$total_points,
                exam_time_limit=$time,passing_grade=$passing_grade, department_id = $department_id
			 	WHERE exam_id = $exam_id";
        echo $sql;
        $this->query($sql);
    }

    public function loadExams($from, $to) {
        if ($from != '' && $to != '') {
            $WHERE = " LEFT JOIN department ON exams.department_id = department.department_id WHERE exam_from >= '$from' AND exam_to <= '$to'  ORDER BY exam_id ASC";
        } else {
            $WHERE = " LEFT JOIN department ON exams.department_id = department.department_id WHERE CURDATE() BETWEEN exam_from AND exam_to ORDER BY exam_id ASC";
        }
        $sql = "select * from exams $WHERE ";
        return $this->fetch_all_rows($sql);
    }

    public function generate_uuid() {
        $sql = "SELECT UUID()";
        return $this->fetch_all_rows($sql);
    }

    public function examedit($exam_id) {
        $sql = "select * from exams  LEFT JOIN department ON exams.department_id = department.department_id WHERE exam_id = $exam_id";
        return $this->fetch_all_rows($sql);
    }

    public function examsresult($from = '', $to = '') {
        //return $this->fetch_all_rows('select * from exams WHERE NOW() BETWEEN exam_from AND exam_to ORDER BY exam_id ASC');
        if ($from != '' && $to != '') {
            $WHERE = " WHERE exam_from >= '$from' AND exam_to <= '$to' ORDER BY exams.exam_id, transaction.user_id ASC";
        } else {
            $WHERE = " WHERE CURDATE() BETWEEN exam_from AND exam_to ORDER BY exams.exam_id, transaction.user_id ASC";
        }
        $sql = "SELECT * FROM transaction 
				INNER JOIN users ON transaction.user_id = users.user_id
				INNER JOIN exams ON transaction.exam_id = exams.exam_id 
				$WHERE";
       // echo $sql;
        $result['exam'] = $this->fetch_all_rows($sql);
        if (is_array($result['exam'])) {
            foreach ($result['exam'] as $row) {
                $sql = "SELECT SUM(score) AS 'score' FROM transaction_dtl WHERE user_id = $row[user_id]  AND exam_id = $row[exam_id] ORDER BY exam_id, user_id ASC";
                $result[$row['user_id']][$row['exam_id']] = $this->fetch_all_rows($sql);
                // echo $row['user_id'] . ' - ' . $row['exam_id'] . '</br>';
                //echo $result[$row['user_id']][$row['exam_id']][0]['score'].'</br>';
            }
          
        }
        return $result;
        /*
          $sql = 'SELECT distinct exams.exam_id, users.user_id,exam_name, user_fname, user_lname from exams
          INNER JOIN transaction ON exams.exam_id = transaction.exam_id
          INNER JOIN users ON users.user_id = transaction.user_id
          WHERE NOW() BETWEEN exam_from AND exam_to ORDER BY exams.exam_id ASC';
          $result['exam'] = $this->fetch_all_rows($sql);
          if (is_array($result['exam'])){
          foreach($result['exam'] as $row){
          $sql = "SELECT * FROM exams_question
          INNER JOIN exams_answers ON exams_question.question_id = exams_answers.question_id
          INNER JOIN transaction ON exams_answers.question_id = transaction.question_id
          WHERE exams_question.exam_id = $row[exam_id] AND user_id = $row[user_id] ORDER BY exams_answers.question_id ASC";
          $result[$row['exam_id']] = $this->fetch_all_rows($sql);
          }
          return $result;
          }
         */
    }

    public function checkresult($exam_id, $user_id) {
        $sql = "SELECT * FROM exams WHERE exam_id = $exam_id";
        $result['exam_name'] = $this->fetch_all_rows($sql);

        $sql = "SELECT * 
		FROM transaction_dtl
        INNER JOIN transaction ON transaction_dtl.user_id = transaction.user_id AND transaction_dtl.exam_id = transaction.exam_id
		INNER JOIN exams_question ON transaction_dtl.question_id = exams_question.question_id
		INNER JOIN users ON  transaction_dtl.user_id = users.user_id
		LEFT JOIN exams_answers ON transaction_dtl.transaction_answer_id = exams_answers.answer_id

		WHERE transaction_dtl.user_id = $user_id AND transaction_dtl.exam_id = $exam_id ORDER BY exams_question.question_id ASC";
        //echo $sql;
        $result['transaction_dtl'] = $this->query($sql);
        //print_r($result);

        return $result;
        /* ()
          $sql = "SELECT * FROM transaction_dtl WHERE exam_id = $exam_id and user_id = $user_id";
          return $this->fetch_all_rows($sql);
         */
    }

    public function rate($transaction_dtl_id) {
        //$sql = "UPDATE transaction_dtl SET score = $score WHERE transaction_dtl_id = $transaction_dtl_id";
        $sql = "SELECT * FROM transaction_dtl WHERE transaction_dtl_id = $transaction_dtl_id";
        return $this->query($sql);
    }

    public function rateupdate($transaction_dtl_id, $score, $checked_by) {
        if (!isset($score)) {
            $score = 0;
        }
        $sql = "UPDATE transaction_dtl SET score = $score, israted=1, checked_by =$checked_by WHERE transaction_dtl_id = $transaction_dtl_id";
        //$sql = "SELECT * FROM transaction_dtl WHERE transaction_dtl_id = $transaction_dtl_id";
        $this->query($sql);
    }
    public function checkstatus($status, $user_id, $exam_id ){
        if ( !isset($status) ){
            $status = 0;
        }
        $sql = "UPDATE transaction SET check_status = $status WHERE user_id = $user_id AND exam_id = $exam_id";
        $this->query($sql);
    }
    /* question */

    public function questionexamsnew($exam_id, $question_name, $question_type = 0, $data, $user_id) {
        if (!isset($question_type)) {
            $question_type = 0;
        }
        $question_code = $this->generate_uuid();
        $question_code = substr($question_code[0]['UUID()'], 0, 8);
        $this->insert('exams_question', array('exam_id' => $exam_id, 'question_name' => "'$question_name'", 'question_code' => "'$question_code'", 'question_type' => $question_type, 'question_created_by' => $user_id));
        $result = $this->fetch_all_rows("select * from exams_question WHERE question_code = '$question_code'");
        //$result[0]['question_id'];
        foreach (explode(',', $data) as $val) {
            if ($val != '') {
                $var = explode(':', $val);
                $right = explode('@', $var[1]);

                if (isset($right[1])) {

                    $this->insert('exams_answers', array('question_id' => $result[0]['question_id'], 'answer_name' => "'$right[0]'", 'answer_flag' => 1));
                } else {
                    $this->insert('exams_answers', array('question_id' => $result[0]['question_id'], 'answer_name' => "'$var[1]'"));
                }
            }
        }
    }

    public function questionaddinsert($exam_id, $question_name, $question_type, $user_id, $essay_points) {
        if (!isset($question_type)) {
            $question_type = 0;
        }
        if (!isset($essay_points)) {
            $essay_points = 0;
        }
        $this->insert('exams_question', array('exam_id' => $exam_id, 'question_name' => "'$question_name'", 'question_type' => $question_type, 'question_created_by' => $user_id, 'essay_points' => $essay_points));
    }

    public function loadQuestion($exam_id) {
        $sql = "SELECT  * FROM users 
				LEFT JOIN exams ON users.user_id = exams.exam_created_by 
				LEFT JOIN exams_question ON exams.exam_id = exams_question.exam_id 
				WHERE exams.exam_id =" . $exam_id . " ORDER BY exams_question.question_id ASC";
        $result['exam'] = $this->fetch_all_rows($sql);
        if (is_array($result['exam'])) {
            foreach ($result['exam'] as $row) {
                $sql = "SELECT * FROM exams_answers WHERE question_id = $row[question_id] order by answer_id asc";
                $result[$row['question_id']] = $this->fetch_all_rows($sql);
            }
        }


        return $result;
        //print_r($result['here']);
    }

    public function questionedit($question_id) {
        /*
          return $this->fetch_all_rows('select * from exams_question
          LEFT join exams_answers on exams_question.question_id =  exams_answers.question_id
          where exams_answers.question_id ='.$question_id . ' order by answer_id');
         */
        $sql = 'select * from exams_question WHERE question_id=' . $question_id;

        return $this->fetch_all_rows($sql);
    }

    public function questionupdate($question_name, $question_type, $question_id, $essay_points) {
        if (!isset($question_type)) {
            $question_type = 0;
        }
        $sql = "UPDATE exams_question SET question_name ='$question_name', question_type = $question_type, essay_points = $essay_points WHERE question_id =" . $question_id;

        $this->query($sql);
        //$admin->questionupdate($question_name,$question_type,$question_id);
    }

    public function questiondelete($exam_id) {
        //$sql = "UPDATE exams SET isdeleted = 1 WHERE exam_id  = $exam_id";
        $sql = "DELETE FROM exams WHERE exam_id = $exam_id";
        $this->query($sql);
    }

    //for answers
    public function answeredit($answer_id) {
        return $this->fetch_all_rows('select * from exams_answers where answer_id =' . $answer_id);
    }

    public function answerupdate($answer_id, $answer_name, $flag, $question_id) {
        if ($flag == 1) {
            $this->query("UPDATE exams_answers SET answer_flag = 0 WHERE question_id = " . $question_id);

            $sql = "UPDATE exams_answers 
					SET answer_name ='$answer_name', answer_flag = 1 
					WHERE answer_id = " . $answer_id;
        } else {
            $sql = "UPDATE exams_answers SET answer_name ='$answer_name' WHERE answer_id = " . $answer_id;
        }

        $this->query($sql);
    }

    public function answeraddinsert($answer_name, $flag, $question_id) {
        if (isset($flag)) {
            $this->query("UPDATE exams_answers SET answer_flag = 0 WHERE question_id = " . $question_id);
        } else {
            $flag = 0;
        }
        $this->insert('exams_answers', array('answer_name' => "'$answer_name'", 'question_id' => $question_id, 'answer_flag' => $flag));
    }

    public function answerdelete($answer_id) {
        $this->query("DELETE FROM exams_answers WHERE answer_id = $answer_id");
    }

    /* check if the user is allowed to check exam */

    public function allowedtocheck($user_id) {
        return $this->query("SELECT * FROM users WHERE user_id = $user_id");
    }

}