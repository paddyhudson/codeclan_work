SELECT *
FROM animals

SELECT *
FROM diets

SELECT
	animals.*,
	diets.*
FROM animals INNER JOIN diets
ON animals.diet_id = diets.id;

SELECT
	animals.name,
	animals.species,
	diets.diet_type
FROM animals INNER JOIN diets
ON animals.diet_id = diets.id;

SELECT
	a.name,
	a.species,
	d.diet_type
FROM animals a INNER JOIN diets d
ON a.diet_id = d.id;

SELECT
	a.id,
	a.name,
	a.species,
	a.age,
	d.diet_type
FROM animals a INNER JOIN diets d
ON a.diet_id = d.id
WHERE a.age > 4;

SELECT
	d.diet_type,
	count(d.diet_type) AS count
FROM animals a INNER JOIN diets d
ON a.diet_id = d.id
GROUP BY d.diet_type;

SELECT
	a.*,
	d.*
FROM animals a LEFT JOIN diets d
ON a.diet_id = d.id;

SELECT
	a.*,
	d.*
FROM animals a RIGHT JOIN diets d
ON a.diet_id = d.id;

SELECT
	a.*,
	d.*
FROM animals a FULL OUTER JOIN diets d
ON a.diet_id = d.id;

SELECT
	a.name AS animal_name,
	a.species,
	cs.DAY,
	k.name AS keeper_name
FROM
	(animals a INNER JOIN care_schedule cs
	ON a.id = cs.animal_id
	)
	INNER JOIN keepers AS k
	ON cs.keeper_id = k.id
ORDER BY a.name, cs.day;
	
/* How would we change the query above to show only the schedule for the keepers looking after Ernest the Snake? */

SELECT
	a.name AS animal_name,
	a.species,
	cs.DAY,
	k.name AS keeper_name
FROM
	(animals a INNER JOIN care_schedule cs
	ON a.id = cs.animal_id
	)
	INNER JOIN keepers AS k
	ON cs.keeper_id = k.id
WHERE a.name = 'Ernest'
ORDER BY cs.day;


SELECT
	a.name AS animal_name,
	a.species,
	t.name AS tour_name,
	at.start_date,
	at.end_date
FROM
	(animals a INNER JOIN animals_tours at
	ON a.id = at.animal_id
	)
	INNER JOIN tours AS t
	ON at.tour_id = t.id
WHERE start_date < now() AND (end_date IS NULL OR end_date > now())
ORDER BY t.name, a.name;

SELECT
	k.name AS keeper_name,
	m.name AS manager_name
FROM
	keepers k LEFT JOIN keepers m
	ON k.manager_id = m.id;