-- 1. List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world
WHERE continent = 'Europe'AND gdp/population > (
SELECT gdp/population
FROM world
WHERE name = 'United Kingdom'
)

-- 3. List the name and continent of countries in the continents containing 
-- either Argentina or Australia. Order by name of the country.
SELECT name, continent FROM world
WHERE continent =
(SELECT continent FROM world
WHERE name = 'Argentina') OR continent = (SELECT continent FROM world
WHERE name = 'Australia')
ORDER BY name;

-- 4. Which country has a population that is more than Canada but less than Poland? 
-- Show the name and the population.
SELECT name, population FROM world
WHERE population >
(SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland');

-- 5. Show the name and the population of each country in Europe. 
-- Show the population as a percentage of the population of Germany.
SELECT name, concat(ROUND(population/(SELECT population FROM world WHERE name = 'Germany') * 100, 0), '%') AS 'population as % of Germany' FROM world
WHERE continent = 'Europe';

-- 6. Which countries have a GDP greater than every country in Europe? 
-- [Give the name only.] (Some countries may have NULL gdp values)
SELECT name FROM world
WHERE gdp > ALL(SELECT gdp FROM world WHERE gdp > 0 AND continent = 'Europe');

-- 7. Find the largest country (by area) in each continent, show the continent, 
-- the name and the area:
SELECT continent, name, area FROM world AS x
  WHERE area >= ALL
    (SELECT area FROM world AS y
        WHERE y.continent=x.continent
          AND population>0);

-- 8. List each continent and the name of the country that comes first alphabetically.
SELECT continent, name FROM world AS x
WHERE name <= ALL
(SELECT name FROM world AS y
WHERE y.continent = x.continent);