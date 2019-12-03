/*1.How many stops are in the database.*/
SELECT COUNT(*) FROM stops;

/*2.Find the id value for the stop 'Craiglockhart'*/
SELECT id FROM stops WHERE name = 'Craiglockhart';

/*3.Give the id and the name for the stops on the '4' 'LRT' service.*/
SELECT id, name
FROM stops JOIN route ON id = stop
WHERE num = 4 AND company = 'LRT';

/*4 Run the query and notice the two services that link these stops have a count of 2. 
Add a HAVING clause to restrict the output to these two routes.*/
SELECT company, num, COUNT(*) FROM route
WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2;

/*5.Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. 
Change the query so that it shows the services from Craiglockhart to London Road.*/
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
WHERE a.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart') AND
      b.stop = (SELECT id FROM stops WHERE name = 'London Road');
      
/*6.The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops 
by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. 
If you are tired of these places try 'Fairmilehead' against 'Tollcross'*/
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b     ON (a.company=b.company AND a.num=b.num)
             JOIN stops stopa ON (a.stop=stopa.id)
             JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road';

/*7.Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')*/
SELECT x.company, x.num
FROM route x
JOIN route y ON (x.company = y.company AND x.num = y.num)
WHERE x.stop = 115 AND y.stop = 137;
GROUP BY x.company, x.num;

/*8.Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'*/
SELECT x.company, x.num
FROM route x
JOIN route y ON (x.company = y.company AND x.num = y.num)
JOIN stops stopa ON (x.stop = stopa.id)
JOIN stops stopb ON (y.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'
GROUP BY x.company, x.num;

/*9.Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' 
itself, offered by the LRT company. Include the company and bus no. of the relevant services.*/
SELECT DISTINCT stopb.name, x.company, x.num
FROM route x
JOIN route y ON (x.company = y.company AND x.num = y.num)
JOIN stops stopa ON (x.stop = stopa.id)
JOIN stops stopb ON (y.stop = stopb.id)
WHERE x.company = 'LRT' AND stopa.name = 'Craiglockhart';
