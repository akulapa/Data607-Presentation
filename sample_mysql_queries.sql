use model1;

SELECT ageDesc, AnswerDesc, response_count,response_percentage 
FROM model1.age A 
JOIN model1.age_fact B ON A.idAge = B.idAge
JOIN model2.answer C ON C.idAnswer = B.idAnswer
WHERE B.idQuestion = 1
ORDER BY ageDesc, AnswerDesc DESC;

use model2;

SELECT sectionDesc, AnswerDesc, response_count,response_percentage 
FROM model2.section A 
JOIN model2.survey_fact B ON A.idSection = B.idSection 
JOIN model2.category C ON A.idCategory = C.idCategory
JOIN model2.answer D ON D.idAnswer = B.idAnswer
WHERE B.idQuestion = 1 AND CategoryDesc = "AGE"
ORDER BY sectionDesc, AnswerDesc DESC;

use model3;

SELECT DISTINCT ageDesc, AnswerDesc, age_response_count, age_response_percentage 
FROM model3.survey_fact A
JOIN model3.age B ON A.idAge = B.idAge
JOIN model3.answer D ON D.idAnswer = A.idAnswer
WHERE idQuestion = 1
ORDER BY ageDesc, AnswerDesc DESC;

SELECT AnswerDesc, ageDesc, age_response_count, age_response_percentage, genderDesc, gender_response_count, gender_response_percentage
FROM model3.survey_fact A
JOIN model3.age B ON A.idAge = B.idAge
JOIN model3.answer D ON D.idAnswer = A.idAnswer
JOIN model3.gender C ON C.idGender = A.idGender
WHERE idQuestion = 1 AND genderDesc != 'TotalObs';

select * from survey_fact where idQuestion = 1;


