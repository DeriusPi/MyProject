--CHECK AND ORDER THE TABLE
Select * from MyOwnProject..JobsScores
order by 11;

--FIND CAREERS WITH THE VERBAL REASONING GREATER THAN 7
SELECT *
FROM MyOwnProject..JobsScores
WHERE [Verbal Reasoning] >= 7
ORDER BY 11;

--FIND CAREERS WHICH HAVE ABSTRACT AND VERBAL REASONING GREATER THAN 7
SELECT [Verbal reasoning], [Abstract reasoning], Career
FROM MyOwnProject..JobsScores 
WHERE [Verbal Reasoning]>=7 AND [Abstract Reasoning]>=7
ORDER BY 3;

--FIND TOTAL COUNT OF CAREERS WHICH HAVE ABSTRACT AND VERBAL REASONING GREATER THAN 7 AND THE TOTAL CAREER
SELECT  (SELECT COUNT (Career)
		FROM MyOwnProject..JobsScores 
		WHERE [Verbal Reasoning]>=7 AND [Abstract Reasoning]>=7) AS ReasoningNum , COUNT (Career) AS TotalCareer
FROM MyOwnProject..JobsScores;
 
--FIND THE PERCENTAGE OF CAREER WITH BOTH VERBAL AND ABSTRACT REASONING GREATER THAN 
DROP TABLE IF EXISTS #Temp_Count
CREATE TABLE #Temp_Count(
ReasoningNum FLOAT,
TotalCareer FLOAT
);

INSERT INTO #Temp_Count (ReasoningNum, TotalCareer) SELECT (SELECT COUNT (Career)
		FROM MyOwnProject..JobsScores 
		WHERE [Verbal Reasoning]>=7 AND [Abstract Reasoning]>=7), COUNT (Career)
FROM MyOwnProject..JobsScores;

SELECT ReasoningNum, TotalCareer, ROUND((ReasoningNum / TotalCareer) *100, 2) AS ReasoningPer
FROM #Temp_Count;

--FIND CAREERS WHICH REQUIRE AT LEAST 4 CRITERIAS GREATER THAN 7
SELECT *
FROM MyOwnProject..JobsScores
WHERE  (IIF(O_score >=7, 1,0) + IIF(C_score >=7, 1,0) + IIF(E_score >=7, 1,0) + IIF(A_score >=7, 1,0) + IIF(N_score >=7, 1,0) + 
		IIF([Numerical Aptitude]>=7, 1,0) + IIF([Spatial Aptitude] >=7, 1,0) + IIF([Perceptual Aptitude] >=7, 1,0) + IIF([Abstract Reasoning] >=7, 1,0) + 
		IIF([Verbal Reasoning] >=7, 1,0)) >= 4
ORDER BY Career;

--FIND THE COUNT OF CAREERS WHICH REQUIRE 4 CRITERIAS GREATER THAN 7
SELECT COUNT (Career)  AS CountCareer4
FROM MyOwnProject..JobsScores
WHERE  (IIF(O_score >=7, 1,0) + IIF(C_score >=7, 1,0) + IIF(E_score >=7, 1,0) + IIF(A_score >=7, 1,0) + IIF(N_score >=7, 1,0) + 
		IIF([Numerical Aptitude]>=7, 1,0) + IIF([Spatial Aptitude] >=7, 1,0) + IIF([Perceptual Aptitude] >=7, 1,0) + IIF([Abstract Reasoning] >=7, 1,0) + 
		IIF([Verbal Reasoning] >=7, 1,0)) = 4;

---FIND THE PERCENTAGE OF CAREERS WHICH REQUIRE 4 CRITERIAS GREATER THAN 7
DROP TABLE IF EXISTS #Temp_Career4
CREATE TABLE #Temp_Career4(
CountCareer4 FLOAT,
TotalCareer FLOAT
);

INSERT INTO #Temp_Career4 (CountCareer4, TotalCareer) SELECT (SELECT COUNT (Career)
FROM MyOwnProject..JobsScores
WHERE  (IIF(O_score >=7, 1,0) + IIF(C_score >=7, 1,0) + IIF(E_score >=7, 1,0) + IIF(A_score >=7, 1,0) + IIF(N_score >=7, 1,0) + 
		IIF([Numerical Aptitude]>=7, 1,0) + IIF([Spatial Aptitude] >=7, 1,0) + IIF([Perceptual Aptitude] >=7, 1,0) + IIF([Abstract Reasoning] >=7, 1,0) + 
		IIF([Verbal Reasoning] >=7, 1,0)) = 4), COUNT (Career)
FROM MyOwnProject..JobsScores;

SELECT CountCareer4, TotalCareer, ROUND((CountCareer4/ TotalCareer)*100, 2) AS PerCareer4
FROM #Temp_Career4;
