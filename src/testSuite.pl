:- begin_tests(comm_req).
:- use_module(library(plunit)).

test("comm_req basic - 2 valid courses array", true) :-
        comm_req(["CHEM 300", "ENGL 111"], ["CHEM 300", "ENGL 111"]).

test("comm_req basic - 1 valid courses array", fail) :-
        comm_req(["LFS 150", "CPSC 121"], ["LFS 150", "CPSC 121"]).

:- end_tests(comm_req).

:- begin_tests(year_one).
:- use_module(library(plunit)).

test("year 1 - list contains ALL and ONLY required courses", true) :-
        cs_year_one(["MATH 184", "ENGL 111", "MATH 105", "CPSC 110", "ENGL 112", "CPSC 121"]).

test("year 1 - list contains ALL required courses AND additional courses", true) :-
        cs_year_one(["MATH 184", "ECON 101", "BIOL 140", "BIOL 121", "CPSC 100", "SOCI 312", "ENGL 111", "MATH 105", "CPSC 110", "ENGL 112", "CPSC 121"]).

test("year 1 - list contains MISSING required courses AND additional courses", fail) :-
        cs_year_one(["MATH 184", "ECON 101", "BIOL 140", "BIOL 121", "CPSC 100", "SOCI 312", "ENGL 111", "MATH 105", "CPSC 103", "ENGL 112", "CPSC 121"]).

:- end_tests(year_one).
