
Query con GROUP BY

1. Contare quanti iscritti ci sono stati ogni anno
    SELECT YEAR(enrolment_date), COUNT(id) FROM students
    GROUP BY YEAR(enrolment_date)

2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
    SELECT office_address, COUNT(id) FROM teachers
    GROUP BY office_address

3. Calcolare la media dei voti di ogni appello d'esame
    SELECT exam_id, AVG(vote) FROM exam_student
    GROUP BY exam_id

4. Contare quanti corsi di laurea ci sono per ogni dipartimento
    SELECT department_id, COUNT(id) FROM degrees
    GROUP by department_id

------------------------------------------------------------------------------

Query con JOIN

1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
    SELECT 
        degrees.name as degree,
        students.id as student_id,
        CONCAT(students.name, ' ', students.surname) as student
    FROM degrees
    JOIN students
    ON degrees.id = students.degree_id
    WHERE degrees.name = 'Corso di Laurea in Economia'

2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
    SELECT
        departments.name AS departments_name,
        degrees.id AS degrees_id,
        degrees.name AS degreees_name
    FROM departments
    JOIN degrees
    ON degrees.department_id = departments.id
    WHERE departments.name LIKE '%neuroscienze%' AND level = 'magistrale'

3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
    SELECT 
        CONCAT(teachers.name, ' ', teachers.surname) AS teacher,
        courses.name AS course
    FROM teachers
    JOIN course_teacher
    ON course_teacher.teacher_id = teachers.id
    JOIN courses
    ON courses.id = course_teacher.course_id
    WHERE teachers.id = 44

4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
    SELECT
        d.name as deparment,
        deg.name as degree,
        CONCAT(s.surname, ' ', s.name) as student
    FROM departments AS d
    JOIN degrees AS deg
    ON  deg.department_id = d.id
    JOIN students AS s
    ON s.degree_id = deg.id
    ORDER BY student

5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
    SELECT
        c.name course,
        CONCAT(t.name, ' ', t.surname) teacher,
        deg.name degree
    FROM degrees deg
    JOIN courses c
    ON c.degree_id = deg.id
    JOIN course_teacher
    ON course_teacher.course_id = c.id
    JOIN teachers t
    ON t.id = course_teacher.teacher_id

6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
    SELECT DISTINCT
        CONCAT(t.name, ' ', t.surname) teacher,
        d.name department
    FROM departments d
    JOIN degrees
    ON degrees.department_id = d.id
    JOIN courses c
    ON c.degree_id = degrees.id
    JOIN course_teacher
    ON course_teacher.course_id = c.id
    JOIN teachers t
    ON t.id = course_teacher.teacher_id
    WHERE d.name like 'Dipartimento di Matematica'
    ORDER BY teacher

7. BONUS:
    Selezionare per ogni studente il numero di tentativi sostenuti per ogni esame, stampando anche il voto massimo. Successivamente, filtrare i tentativi con voto minimo 18.
        SELECT
            CONCAT(s.name, ' ', s.surname) student,
            c.name course,
            ex.id exam,
            ex.date exam_date,
            ex_s.vote vote
        FROM courses c
        JOIN exams ex
        ON ex.course_id = c.id
        JOIN exam_student ex_s
        ON ex_s.exam_id = ex.id
        JOIN students s
        ON ex_s.student_id = s.id
        WHERE vote >= 18
        ORDER BY student