
-- MySQL带参数的存储过程小例子
-- 存储过程P_GET_CLASS_NAME是根据输入的班级号判断班级名称
-- 存储过程P_INSERT_STUDENT是接收输入的学生信息，最终将信息插入学生表。
-- 在第二个存储过程中
-- ①利用SET声明了参数，调用了第一个存储过程
-- ②在第一个存储过程中的NAME参数是输出参数，所以@CLASSNAME这个参数在调用完第一个过程后就被附值
-- ③最终利用CONCAT拼接SQL语句并传入参数执行SQL语句
-- CALL P_INSERT_STUDENT(1,'xy',1,'2012-10-01 10:20:01');调用存储过程

-- PREPARE statement_name FROM sql_text /*定义*/   
-- EXECUTE statement_name [USING variable [,variable...]] /*执行预处理语句*/   
-- DEALLOCATE PREPARE statement_name /*删除定义*/   

DROP TABLE IF EXISTS `tbl_student`;
CREATE TABLE `tbl_student` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL,
  `classname` varchar(10) DEFAULT NULL,
  `birthday` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP PROCEDURE IF EXISTS `P_GET_CLASS_NAME`;  
CREATE PROCEDURE P_GET_CLASS_NAME(IN ID int,OUT NAME VARCHAR(50))  
BEGIN  
    IF(ID = 1) THEN   
          SET NAME = '一班';   
    ELSEIF(ID = 2) THEN   
          SET NAME = '二班';    
		ELSE
					SET NAME = '三班';
		END IF;
END;  

DROP PROCEDURE IF EXISTS `P_INSERT_STUDENT`;  
CREATE PROCEDURE P_INSERT_STUDENT(IN ID INT,IN NAME VARCHAR(10),IN CLASSNO INT,IN BIRTH DATETIME)  
BEGIN  
     SET @ID = ID;  
     SET @NAME = NAME;  
     SET @CLASSNO = CLASSNO;  
     SET @BIRTH = BIRTH;  
     SET @CLASSNAME = NULL;  
     CALL P_GET_CLASS_NAME(@CLASSNO,@CLASSNAME);  
		 PREPARE stmtinsert1 FROM 'INSERT INTO TBL_STUDENT VALUES(?,?,?,?)';
     EXECUTE stmtinsert1 USING @ID,@NAME,@CLASSNAME,@BIRTH;  
     DEALLOCATE PREPARE stmtinsert1;  
END;  
  
CALL P_INSERT_STUDENT(1,'xy',1,'2012-10-01 10:20:01'); 
CALL P_INSERT_STUDENT(2,'zhou',2,'1990-12-20 10:20:01'); 
CALL P_INSERT_STUDENT(3,'pretty',3,'2012-10-01 10:20:01'); 

SELECT * FROM  tbl_student;