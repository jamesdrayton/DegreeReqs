info :- write('Check to see if CS Major degree requirements are met. Based on requirements from 2019.'), nl,
write('For simplicity, degree requirements regarding GPA are not considered.'), nl,
write('Also please note that compounded courses/programs such as Science One or Arts One will not be evaluated.'), nl,
write('Sorry for the inconvenience =(').

% function descriptions:
% breadth_req will provide the names of the departments of the courses you've taken considered to meet breadth requirements
% comm_req will provide the courses you've taken that meet the communication requirement

% List Meeting all Criteria ["MATH 184", "ENGL 111", "MATH 105", "CPSC 110", "ENGL 112", "CPSC 121"].

% CPSC First year reqs
cs_year_one(Courses) :- commReqMet(Courses), differentialReqMet(Courses), integralReqMet(Courses), cpsc121ReqMet(Courses), cpsc110ReqMet(Courses).

% COMMUNICATIONS REQUIREMENT
commReqMet(C) :- comm_req(C, R), length(R, 2).

% DIFFERENTIAL CALCULUS REQUIREMENT
differentialReqMet([]) :- false.
differentialReqMet([H|_]) :- differentialCalc(H).
differentialReqMet([_|T]) :- differentialReqMet(T).

differentialCalc("MATH 100").
differentialCalc("MATH 102").
differentialCalc("MATH 104").
differentialCalc("MATH 180").
differentialCalc("MATH 184").
differentialCalc("MATH 120").
differentialCalc("MATH 110").

% INTEGRAL CALCULUS REQUIREMENT
integralReqMet([]) :- false.
integralReqMet([H|_]) :- integralCalc(H).
integralReqMet([_|T]) :- integralReqMet(T).

integralCalc("MATH 101").
integralCalc("MATH 103").
integralCalc("MATH 105").
integralCalc("MATH 121").

% CPSC 121 REQUIREMENT
cpsc121ReqMet([]) :- false.
cpsc121ReqMet([H|_]) :- cpsc121(H).
cpsc121ReqMet([_|T]) :- cpsc121ReqMet(T).

cpsc121("CPSC 121").

% CPSC 110 (or 103 and 107) REQUIREMENT --> FUNCTION DEPENDS ON FACT YOU CAN'T HAVE THE SAME COURSE LISTED TWICE
cpsc110ReqMet([]) :- false.
cpsc110ReqMet([H|_]) :- cpsc110(H).
cpsc110ReqMet(C) :- cpsc107ReqMet(C), cpsc103ReqMet(C).
cpsc110ReqMet([_|T]) :- cpsc110ReqMet(T).

cpsc103ReqMet([]) :- false.
cpsc103ReqMet([H|_]) :- cpsc103(H).
cpsc103ReqMet([_|T]) :- cpsc103ReqMet(T).

cpsc107ReqMet([]) :- false.
cpsc107ReqMet([H|_]) :- cpsc107(H).
cpsc107ReqMet([_|T]) :- cpsc107ReqMet(T).

cpsc110("CPSC 110").
cpsc103("CPSC 103").
cpsc107("CPSC 107").

% Actually mycommCourses is not needed since I figured out how comm_req works
% mycommCourses(C, R) C is all courses taken, R is the list of comm courses taken
% mycommCourses([], []).
% mycommCourses([_|T], R) :- mycommCourses(T,R).
% mycommCourses([H|T], [H|R]) :- communication(H), mycommCourses(T, R).

% lab_req(:Courses, R) R is the course (if any) that meets the lab_req
lab_req([], _) :- false.
lab_req([H|_], H) :- labCourse(H).
lab_req([_|T], _) :- lab_req(T, _).

labCourse("ASTR 101").
labCourse("ASTR 102").
labCourse("BIOL 140").
labCourse("CHEM 111").
labCourse("CHEM 121").
labCourse("CHEM 123").
labCourse("EOSC 111").
labCourse("PHYS 101").

% breadth_req(:Courses, X) will return X as the list of all courses used to meet breadth requirements
breadth_req([], []).
breadth_req([_|T], R) :- breadth_req(T, R).
breadth_req([H|T], [A|R]) :- takedept(H, A), breadth_req(T, R), breadthDepartment(A), \+ member(A, R), \+ epsCoordinator(R, A).

% takedept(L, A) where A is the department name.
takedept(L, DeptName) :- split_string(L, " ", "", [DeptName | _]).

% epsCoordinator(R, A) will check the result list to ensure only one course from all the departments considered Earth and Planetary Sciences are added

epsCoordinator([], _) :- false.
epsCoordinator([_|T], C) :- epsCoordinator(T, C).
epsCoordinator([H|_], C) :- epsDepartment(H), epsDepartment(C).

epsDepartment("ASTR").
epsDepartment("ATSC").
epsDepartment("ENVR").
epsDepartment("EOSC").
epsDepartment("GEOB").

breadthDepartment("MATH").
breadthDepartment("CHEM").
breadthDepartment("PHYS").
breadthDepartment("BIOL").
breadthDepartment("STAT").
breadthDepartment("CPSC").
breadthDepartment("MATH").
breadthDepartment("ASTR").
breadthDepartment("ATSC").
breadthDepartment("ENVR").
breadthDepartment("EOSC").
breadthDepartment("GEOB").


% comm_req(:Courses, X) will return X as the list of all courses meeting the communication requirement
comm_req([], []).
comm_req([_|T], R) :- comm_req(T, R).
comm_req([H|T], [H|R]) :- comm_req(T, R), exclusion(R, H), communication(H). 

communication("APSC 176").
communication("ASTU 100").
communication("ASTU 101").
communication("CHEM 300").
communication("ENGL 100").
communication("ENGL 110").
communication("ENGL 111").
communication("ENGL 112").
communication("ENGL 120").
communication("ENGL 121").
communication("LFS 150").
communication("SCIE 113").
communication("SCIE 300").
communication("WRDS 150").

% Exclusion is true if a course is not an exclusion of any other course.

exclusion([], _).
exclusion([First | Rest], Comp) :- \+ excluded(First, Comp), \+ excluded(Comp, First), exclusion(Rest, Comp).

excluded("WRDS 150", "ENGL 112").

% VG = ["APSC 176", "LFS 150", "WRDS 150", "SCIE 300", "CPSC 110", "CPSC 121", "CPSC 210", "CPSC 221", "CHEM 300", "ENGL 112"].


