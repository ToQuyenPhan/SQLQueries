use FUH_COMPANY
select * from tblDepartment
select * from tblProject
select * from tblLocation
select * from tblDepLocation
select * from tblEmployee
select * from tblDependent
--Câu 2
select proNum, proName, depName
from tblDepartment d, tblProject p
where d.depNum = p.depNum and d.depName like N'Phòng Nghiên cứu và phát triển'
--Câu 1
select empSSN, empName, d.depNum, depName
from tblEmployee e, tblDepartment d
where e.depNum=d.depNum and e.empSSN = (select mgrSSN 
from tblDepartment where depName = N'Phòng Nghiên cứu và phát triển')
--Câu 3
select proNum, proName, depName
from tblDepartment d, tblProject p
where d.depNum=p.depNum and proName like N'ProjectB'
--Câu 4
select empSSN, empName
from tblEmployee
where supervisorSSN = (select empSSN
from tblEmployee 
where empName like N'Mai Duy An')
--Câu 5
select empSSN, empName
from tblEmployee
where empSSN = (select supervisorSSN
from tblEmployee 
where empName like N'Mai Duy An')
--Câu 6
select locName
from tblLocation l, tblProject p
where l.locNum=p.locNum and proName like N'ProjectA'
--Câu 7
select proNum, proName
from tblProject p, tblLocation l
where p.locNum=l.locNum and locName like N'Tp Hồ Chí Minh'
--Câu 8
select depName, depBirthdate, empName
from tblEmployee e, tblDependent d
where e.empSSN=d.empSSN and year(getDate()) - year(depBirthdate) > 18
--Câu 9
select depName, depBirthdate, empName
from tblEmployee e, tblDependent d
where e.empSSN=d.empSSN and depSex like N'M'
--Câu 10
select d.depNum, depName, locName
from tblDepartment d join tblDepLocation de on d.depNum = de.depNum
join tblLocation l on de.locNum=l.locNum
and d.depName like N'Phòng Nghiên cứu và phát triển'
select d.depNum, depName, locName
from tblDepartment d, tblDepLocation de, tblLocation l
where d.depNum=de.depNum and de.locNum = l.locNum and d.depName like N'Phòng Nghiên cứu và phát triển'
--Câu 11
select proNum, proName, depName
from tblDepartment d, tblProject p, tblLocation l
where d.depNum=p.depNum and p.locNum=l.locNum and locName like N'Tp Hồ Chí Minh'
--Câu 12
select empName, d.depName, depRelationship
from tblEmployee e, tblDependent d, tblDepartment de
where e.empSSN=d.empSSN and e.depNum=de.depNum 
and de.depName like N'Phòng Nghiên cứu và phát triển' and d.depSex like N'F'
--Câu 13
select empName, d.depName, depRelationship
from tblEmployee e, tblDependent d, tblDepartment de
where e.empSSN=d.empSSN and e.depNum=de.depNum 
and de.depName like N'Phòng Nghiên cứu và phát triển' and year(getDate())-year(depBirthdate) > 18
--Câu 14
select depSex, count(*) as 'Số lượng'
from tblDependent
group by depSex
--Câu 15
select depRelationship, count(*) as 'Số lượng'
from tblDependent
group by depRelationship
--Câu 16
select a.depNum, [Số lượng], depName
from (select depNum, count(*) as 'Số lượng'
from tblEmployee
group by depNum) a join tblDepartment d on a.depNum=d.depNum
--Câu 17
select depNum, depName, numbers
from (select de.depNum, de.depName, count(*) as 'numbers'
from tblDependent d join tblEmployee e on d.empSSN=e.empSSN
join tblDepartment de on e.depNum=de.depNum
group by de.depNum, de.depName) a 
join (select min(b.numbers) as 'Min'
from (select de.depNum, de.depName, count(*) as 'numbers'
from tblDependent d join tblEmployee e on d.empSSN=e.empSSN
join tblDepartment de on e.depNum=de.depNum
group by de.depNum, de.depName) b) c on a.numbers=c.Min
--With ties
select top 1 with ties  de.depNum, de.depName, count(*) as 'numbers'
from tblDependent d join tblEmployee e on d.empSSN=e.empSSN
join tblDepartment de on e.depNum=de.depNum
group by de.depNum, de.depName
order by numbers asc
--Câu 18
select depNum, depName, numbers
from (select de.depNum, de.depName, count(*) as 'numbers'
from tblDependent d join tblEmployee e on d.empSSN=e.empSSN
join tblDepartment de on e.depNum=de.depNum
group by de.depNum, de.depName) a 
join (select max(b.numbers) as 'Max'
from (select de.depNum, de.depName, count(*) as 'numbers'
from tblDependent d join tblEmployee e on d.empSSN=e.empSSN
join tblDepartment de on e.depNum=de.depNum
group by de.depNum, de.depName) b) c on a.numbers=c.Max
--with ties
select top 1 with ties de.depNum, de.depName, count(*) as 'numbers'
from tblDependent d join tblEmployee e on d.empSSN=e.empSSN
join tblDepartment de on e.depNum=de.depNum
group by de.depNum, de.depName
order by numbers desc
--Câu 19
select e.empSSN, empName, depName
from (select empSSN, sum(workHours) as 'Tổng'
from tblWorksOn
group by empSSN) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum
--Câu 20
select d.depNum, depName, Tổng
from (select depNum, sum(Tổng) as 'Tổng'
from (select proNum, sum(workHours) as 'Tổng'
from tblWorksOn
group by proNum) a join tblProject p on a.proNum=p.proNum
group by depNum) b join tblDepartment d on b.depNum=d.depNum
--Câu 21
select empSSN, empName, Tổng
from (select e.empSSN, empName, Tổng
from (select empSSN, sum(workHours) as 'Tổng'
from tblWorksOn
group by empSSN) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum) c join
(select min(Tổng) as 'Mini'
from (select e.empSSN, empName, Tổng
from (select empSSN, sum(workHours) as 'Tổng'
from tblWorksOn
group by empSSN) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum) b) h on c.Tổng=h.Mini
--with ties
select top 1 with ties e.empSSN, empName, Tổng
from (select empSSN, sum(workHours) as 'Tổng'
from tblWorksOn
group by empSSN) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum
order by Tổng asc
--Câu 22
select *
from (select e.empSSN, empName, Tổng
from (select empSSN, sum(workHours) as 'Tổng'
from tblWorksOn
group by empSSN) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum) c join
(select max(Tổng) as 'Maxi'
from (select e.empSSN, empName, Tổng
from (select empSSN, sum(workHours) as 'Tổng'
from tblWorksOn
group by empSSN) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum) b) h on c.Tổng=h.Maxi
--with ties
select top 1 with ties e.empSSN, empName, Tổng
from (select empSSN, sum(workHours) as 'Tổng'
from tblWorksOn
group by empSSN) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum
order by Tổng desc
--Câu 23
select e.empSSN, empName, depName
from (select empSSN, count(*) as 'Times'
from tblWorksOn
group by empSSN
having count(*) = 1) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum
--Câu 24
select e.empSSN, empName, depName
from (select empSSN, count(*) as 'Times'
from tblWorksOn
group by empSSN
having count(*) = 2) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum
--Câu 25
select e.empSSN, empName, depName
from (select empSSN, count(*) as 'Times'
from tblWorksOn
group by empSSN
having count(*) >= 2) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum
--Câu 26
select proNum, proName, SL
from (select depNum, count(empSSN) as 'SL'
from tblEmployee
group by depNum) a join tblProject p on a.depNum=p.depNum
--Câu 27
select p.proNum, proName, Tổng
from (select proNum, sum(workHours) as 'Tổng'
from tblWorksOn
group by proNum) a join tblProject p on a.proNum=p.proNum
--Câu 28
select proNum, proName, SL
from (select p.proNum, proName, SL
from(select depNum, count(empSSN) as 'SL'
from tblEmployee
group by depNum) b join tblProject p on b.depNum=p.depNum) d
join (select min(SL) as 'Mini'
from (select depNum, count(empSSN) as 'SL'
from tblEmployee
group by depNum) a join tblProject p on a.depNum=p.depNum) h on d.SL=h.Mini
--with ties
select top 1 with ties p.proNum, proName, SL
from(select depNum, count(empSSN) as 'SL'
from tblEmployee
group by depNum) b join tblProject p on b.depNum=p.depNum
order by SL asc
--Câu 29
select proNum, proName, SL
from (select p.proNum, proName, SL
from(select depNum, count(empSSN) as 'SL'
from tblEmployee
group by depNum) b join tblProject p on b.depNum=p.depNum) d
join (select max(SL) as 'Maxi'
from (select depNum, count(empSSN) as 'SL'
from tblEmployee
group by depNum) a join tblProject p on a.depNum=p.depNum) h on d.SL=h.Maxi
--with ties
select top 1 with ties p.proNum, proName, SL
from(select depNum, count(empSSN) as 'SL'
from tblEmployee
group by depNum) b join tblProject p on b.depNum=p.depNum
order by SL desc
--Câu 30
select proNum, proName, Tổng
from (select p.proNum, proName, Tổng
from (select proNum, sum(workHours) as 'Tổng'
from tblWorksOn
group by proNum) c join tblProject p on c.proNum=p.proNum) d
join (select min(Tổng) as 'Mini'
from (select p.proNum, proName, Tổng
from (select proNum, sum(workHours) as 'Tổng'
from tblWorksOn
group by proNum) a join tblProject p on a.proNum=p.proNum) b) h on d.Tổng=h.Mini
--with ties
select top 1 with ties p.proNum, proName, Tổng
from (select proNum, sum(workHours) as 'Tổng'
from tblWorksOn
group by proNum) c join tblProject p on c.proNum=p.proNum
order by Tổng asc
--Câu 31
select proNum, proName, Tổng
from (select p.proNum, proName, Tổng
from (select proNum, sum(workHours) as 'Tổng'
from tblWorksOn
group by proNum) c join tblProject p on c.proNum=p.proNum) d
join (select max(Tổng) as 'Maxi'
from (select p.proNum, proName, Tổng
from (select proNum, sum(workHours) as 'Tổng'
from tblWorksOn
group by proNum) a join tblProject p on a.proNum=p.proNum) b) h on d.Tổng=h.Maxi
--with ties
select top 1 with ties p.proNum, proName, Tổng
from (select proNum, sum(workHours) as 'Tổng'
from tblWorksOn
group by proNum) c join tblProject p on c.proNum=p.proNum
order by Tổng desc
--Câu 32
select locName, SL
from (select locNum, count(depNum) as 'SL'
from tblDepLocation
group by locNum) a, tblLocation l
where a.locNum=l.locNum
--Câu 33
select a.depNum, depName, SL
from (select depNum, count(locNum) as 'SL'
from tblDepLocation
group by depNum) a, tblDepartment d
where a.depNum=d.depNum
--Câu 34
select depNum, depName, SL
from (select a.depNum, depName, SL
from (select depNum, count(locNum) as 'SL'
from tblDepLocation
group by depNum) a, tblDepartment d
where a.depNum=d.depNum) c
join (select min(SL) as 'Mini'
from (select a.depNum, depName, SL
from (select depNum, count(locNum) as 'SL'
from tblDepLocation
group by depNum) a, tblDepartment d
where a.depNum=d.depNum) b) e on c.SL=e.Mini
--Câu 35
select depNum, depName, SL
from (select a.depNum, depName, SL
from (select depNum, count(locNum) as 'SL'
from tblDepLocation
group by depNum) a, tblDepartment d
where a.depNum=d.depNum) c
join (select max(SL) as 'Maxi'
from (select a.depNum, depName, SL
from (select depNum, count(locNum) as 'SL'
from tblDepLocation
group by depNum) a, tblDepartment d
where a.depNum=d.depNum) b) e on c.SL=e.Maxi
--Câu 36
select locName, SL
from (select locName, SL
from (select locNum, count(depNum) as 'SL'
from tblDepLocation
group by locNum) a, tblLocation l
where a.locNum=l.locNum) d
join (select max(SL) as 'Maxi'
from (select locName, SL
from (select locNum, count(depNum) as 'SL'
from tblDepLocation
group by locNum) a, tblLocation l
where a.locNum=l.locNum) b) c on d.SL=c.Maxi
--Câu 37
select locName, SL
from (select locName, SL
from (select locNum, count(depNum) as 'SL'
from tblDepLocation
group by locNum) a, tblLocation l
where a.locNum=l.locNum) d
join (select min(SL) as 'Mini'
from (select locName, SL
from (select locNum, count(depNum) as 'SL'
from tblDepLocation
group by locNum) a, tblLocation l
where a.locNum=l.locNum) b) c on d.SL=c.Mini
--Câu 38
select b.empSSN, empName, SL
from (select empSSN, count(depName) as 'SL'
from tblDependent 
group by empSSN) b
join (select max(SL) as 'Maxi'
from (select empSSN, count(depName) as 'SL'
from tblDependent 
group by empSSN) a) c on b.SL = c.Maxi
join tblEmployee e on b.empSSN=e.empSSN
--Câu 39
select b.empSSN, empName, SL
from (select empSSN, count(depName) as 'SL'
from tblDependent 
group by empSSN) b
join (select min(SL) as 'Mini'
from (select empSSN, count(depName) as 'SL'
from tblDependent 
group by empSSN) a) c on b.SL = c.Mini
join tblEmployee e on b.empSSN=e.empSSN
--Câu 40
select e.empSSN, empName, depName
from (select empSSN
from tblEmployee e 
except
select empSSN
from tblDependent d) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum
--Câu 41
select distinct d.depNum, depName
from (select empSSN
from tblEmployee e 
except
select empSSN
from tblDependent d) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum
--Câu 42
select e.empSSN, empName, depName
from (select empSSN 
from tblEmployee
except
select empSSN
from tblWorksOn) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum
--Câu 43
select distinct d.depNum, depName
from (select empSSN 
from tblEmployee
except
select empSSN
from tblWorksOn) a, tblEmployee e, tblDepartment d
where a.empSSN=e.empSSN and e.depNum=d.depNum
--Câu 44
select d.depNum, depName
from (select depNum
from tblDepartment
except
select depNum
from tblProject
where proName like 'ProjectA') a, tblDepartment d
where a.depNum=d.depNum
--Câu 45
select d.depNum, depName, SL
from (select depNum, count(depNum) as 'SL'
from tblProject
group by depNum) a, tblDepartment d
where a.depNum = d.depNum
--Câu 46
select depNum, depName, SL
from (select d.depNum, depName, SL
from (select depNum, count(depNum) as 'SL'
from tblProject
group by depNum) a, tblDepartment d
where a.depNum = d.depNum) b
join (select min(SL) as 'Mini'
from (select d.depNum, depName, SL
from (select depNum, count(depNum) as 'SL'
from tblProject
group by depNum) a, tblDepartment d
where a.depNum = d.depNum) a) c on b.SL=c.Mini
--Câu 47
select depNum, depName, SL
from (select d.depNum, depName, SL
from (select depNum, count(depNum) as 'SL'
from tblProject
group by depNum) a, tblDepartment d
where a.depNum = d.depNum) b
join (select max(SL) as 'Maxi'
from (select d.depNum, depName, SL
from (select depNum, count(depNum) as 'SL'
from tblProject
group by depNum) a, tblDepartment d
where a.depNum = d.depNum) a) c on b.SL=c.Maxi
--Câu 48
select d.depNum, depName, SL, proName
from (select depNum, count(*) as 'SL'
from tblEmployee
group by depNum
having count(*) > 5) a,tblProject p, tblDepartment d
where a.depNum=p.depNum and a.depNum=d.depNum
--Câu 49
select e.empSSN, empName
from (select empSSN
from tblEmployee
where depNum = (select depNum
from tblDepartment
where depName like N'Phòng Nghiên cứu và %')
intersect
(select empSSN
from tblEmployee e 
except
select empSSN
from tblDependent d)) a, tblEmployee e
where a.empSSN=e.empSSN
--Câu 50
select b.empSSN, empName, Tổng
from (select empSSN, sum(workHours) as 'Tổng'
from tblWorksOn
group by empSSN) a join (select empSSN
from tblEmployee e 
except
select empSSN
from tblDependent d) b on a.empSSN=b.empSSN 
join tblEmployee e on a.empSSN = e.empSSN
--Câu 51
select b.empSSN, empName, SL, Tổng
from (select empSSN, sum(workHours) as 'Tổng'
from tblWorksOn
group by empSSN) a join (select empSSN, count(depName) as 'SL'
from tblDependent 
group by empSSN
having count(depName) > 3) b on a.empSSN=b.empSSN 
join tblEmployee e on a.empSSN = e.empSSN
--Câu 52
select b.empSSN, empName, Tổng
from (select empSSN, sum(workHours) as 'Tổng'
from tblWorksOn
group by empSSN) a join (select empSSN
from tblEmployee
where supervisorSSN = (select empSSN 
from tblEmployee
where empName like N'Mai Duy An')) b on a.empSSN=b.empSSN 
join tblEmployee e on a.empSSN = e.empSSN