create table chemistry_experiments
(experiment_id      INT,
compound           TEXT,
temperature_c      NUMERIC,
pressure_atm       NUMERIC,
ph                 NUMERIC,
reaction_rate      NUMERIC,
lab                TEXT
);


create table physics_experiments
(
experiment_id      INT,
experiment_type    TEXT,
mass_kg            NUMERIC,
velocity_m_s       NUMERIC,
energy_j           NUMERIC,
temperature_k      NUMERIC,
facility           TEXT

);

--🧠 30 PostgreSQL Problems + Answers
--BASIC QUERIES (1–10)

select * from chemistry_experiments;

select * from physics_experiments;

--1. Get all chemistry experiments with pH < 3

select * from chemistry_experiments
where ph < 3;



--2. List distinct compounds

select distinct compound
from chemistry_experiments;



--3. Count experiments per lab

select lab,
count(*) from chemistry_experiments
group by lab;



--4. Physics experiments with velocity > 100 m/s

select * from physics_experiments
where velocity_m_s > 100;


--5. Average temperature in chemistry experiments

select avg(temperature_c) as avg_temp_in_chtry_lab
from chemistry_experiments;



--6. Max energy recorded in physics

select max(energy_j) as max_energy
from physics_experiments;



--7. Experiments done at CERN

select * from physics_experiments
where facility = 'CERN';




--8. Chemistry experiments using H2SO4

select * from chemistry_experiments
where compound = 'H2SO4';



--9. Lowest reaction rate
select min(reaction_rate) as lowest_reaction_rate
from chemistry_experiments;


--10. Total physics experiments

SELECT COUNT(*) FROM physics_experiments;



--INTERMEDIATE QUERIES (11–20)

--11. Avg reaction rate per compound

select compound, avg(reaction_rate)
from chemistry_experiments
group by compound;



--12. Experiments above boiling point of water

select * from chemistry_experiments
where temperature_c = 100;



--13. Physics experiments with kinetic energy > 500k J


select * from physics_experiments
where energy_j > 500000;




--14. Count physics experiments per facility.

select facility, count(*) as total_experiments
from physics_experiments
group by facility;



--15. Labs with avg pH < 7

select lab, ph
from chemistry_experiments
group by lab, ph
having avg(ph) < 7;


--16. Top 5 highest velocities

select * from physics_experiments
order by velocity_m_s desc
limit 5;


--17. Chemistry experiments between pH 6 and 8

select * from chemistry_experiments
where ph between 6 and 8;

--18. Avg temperature per physics experiment type

select experiment_type, avg(temperature_k)
from physics_experiments
group by experiment_type;



--19. Experiments with pressure > 3 atm

SELECT * FROM chemistry_experiments WHERE pressure_atm > 3;

--20. Facilities with more than 100 experiments
SELECT facility
FROM physics_experiments
GROUP BY facility
HAVING COUNT(*) > 100;




--ADVANCED / ANALYTICAL (21–30)

--21. Rank physics experiments by energy

select *,
		RANK () OVER (ORDER BY energy_j DESC) AS rank_energy
		from physics_experiments;


--22. Running average of reaction rate

select experiment_id,
			avg(reaction_rate) over(order by experiment_id)
			from chemistry_experiments;



--23. Highest avg reaction rate lab
select lab
from chemistry_experiments
group by lab
order by avg(reaction_rate) desc
limit 1;



--24. Physics experiments above avg energy

select *
from physics_experiments

where energy_j > (select avg(energy_j) from physics_experiments);



--25. Percentage of acidic experiments (pH < 7)
select
	100.0 * count(*)  /  (select count(*) as percent
	from chemistry_experiments)
	from chemistry_experiments
	where ph < 7;



--26. Stddev of physics velocities

select stddev(velocity_m_s)
from physics_experiments;



--27. Correlation between mass and energy

select corr(mass_kg, energy_j)
from physics_experiments;



--28. Experiments per compound ordered by frequency

SELECT compound, COUNT(*)
FROM chemistry_experiments
GROUP BY compound
ORDER BY COUNT(*) DESC;



--29. Median reaction rate

select percentile_cont(0.5)
within group(order by reaction_rate)
from chemistry_experiments;



--30. Physics experiments with extreme temperatures (top 1%)

select * from physics_experiments
where temperature_k > 
(select percentile_cont(0.99)
within group (order by temperature_k)
from physics_experiments);







