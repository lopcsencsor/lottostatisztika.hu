-- III. EGYÉB LEKÉRDEZÉSEK
	
	-- Soha ki nem húzott tripla számkombinációk száma
		-- Működik rendesen, de tenger rekordot ad eredményül (~88000) 1mp-en belül.
		
 		Select ROW_NUMBER() OVER (ORDER BY a.nyeroszam, b.nyeroszam, c.nyeroszam) AS `Sorszam`
				,a.nyeroszam as `nyeroszam1`
                ,b.nyeroszam as `nyeroszam2`
                ,c.nyeroszam as `nyeroszam3`
			from otosalapszamok a
				CROSS JOIN otosalapszamok b
				CROSS JOIN otosalapszamok c
				 
					where 		a.nyeroszam<b.nyeroszam 
							and b.nyeroszam<c.nyeroszam 
							and (select f.HuzasSorszama from otostripla f where f.nyeroszam1=a.nyeroszam and f.nyeroszam2=b.nyeroszam and f.nyeroszam3=c.nyeroszam limit 1) is NULL
					order by ROW_NUMBER() OVER (ORDER BY a.nyeroszam, b.nyeroszam, c.nyeroszam)
			;



	-- Soha ki nem húzott Kvadrupla
		
		Select   ROW_NUMBER() OVER (ORDER BY a.nyeroszam, b.nyeroszam, c.nyeroszam, d.nyeroszam)
			,a.nyeroszam as `nyeroszam1`
			,b.nyeroszam as `nyeroszam2`
			,c.nyeroszam as `nyeroszam3`
			,d.nyeroszam as `nyeroszam4`
			from otosalapszamok a
				CROSS JOIN otosalapszamok b
				CROSS JOIN otosalapszamok c
                CROSS JOIN otosalapszamok d
				-- left join otoskvadrupla f on f.nyeroszam1=a.nyeroszam and f.nyeroszam2=b.nyeroszam and f.nyeroszam3=c.nyeroszam and f.nyeroszam4=d.nyeroszam
					where 		a.nyeroszam<b.nyeroszam 
							and b.nyeroszam<c.nyeroszam 
                            and c.nyeroszam<d.nyeroszam 
							and (select nyeroszam1 from otoskvadrupla f where f.nyeroszam1=a.nyeroszam and f.nyeroszam2=b.nyeroszam and f.nyeroszam3=c.nyeroszam and f.nyeroszam4=d.nyeroszam Limit 1) is NULL
					order by ROW_NUMBER() OVER (ORDER BY a.nyeroszam, b.nyeroszam, c.nyeroszam, d.nyeroszam)
			;

	--Egyszer szerepelt négyes számsor
			Print 'Egyszer szerepelt négyes számsor'
	Select 	 nyeroszam1
			,nyeroszam2
			,nyeroszam3
			,nyeroszam4
			,count(*) as `Alkalom` 
			from otoskvadrupla 
			group by nyeroszam1,nyeroszam2,nyeroszam3,nyeroszam4
			having count(*)=1
			order by Count(*) desc,nyeroszam1,nyeroszam2,nyeroszam3,nyeroszam4

	--Kétszer szerepelt négyes számsor
	
	Print 'Kétszer szerepelt négyes számsor';

	Select 
			 nyeroszam1
			,nyeroszam2
			,nyeroszam3
			,nyeroszam4
			,count(nyeroszam1) as `Alkalom` 
		from otoskvadrupla 
		group by nyeroszam1,nyeroszam2,nyeroszam3,nyeroszam4
		having count=2
		order by Count(*) desc,nyeroszam1,nyeroszam2,nyeroszam3,nyeroszam4
		;

			Print 'Háromszor szerepelt négyes számsor'
			Select nyeroszam1,nyeroszam2,nyeroszam3,nyeroszam4,count(*) as `Alkalom` from otoskvadrupla 
			group by nyeroszam1,nyeroszam2,nyeroszam3,nyeroszam4
			having count(nyeroszam1)=3
			order by Count(nyeroszam1) desc,nyeroszam1,nyeroszam2,nyeroszam3,nyeroszam4
	
	--Kvadrupla előfordulás db szám szerint, azon belül legutolsó húzásának dátuma szerint növekvő
		print 'Kvadrupla előfordulás db szám szerint, azon belül legutolsó húzásának dátuma szerint növekvő'
		Select	 a.nyeroszam1
				,a.nyeroszam2
				,a.nyeroszam3
				,a.nyeroszam4
				,(select max(l.HuzasDatuma) from otoskvadrupla l 
						where l.nyeroszam1=a.nyeroszam1 and l.nyeroszam2=a.nyeroszam2 
								and l.nyeroszam3=a.nyeroszam3 and l.nyeroszam4=a.nyeroszam4)
					as `Utolsó húzásának dátuma`
				,count(nyeroszam1) as `Alkalom` from otoskvadrupla a
			group by a.nyeroszam1,a.nyeroszam2,a.nyeroszam3,a.nyeroszam4
			having count(nyeroszam1)>=1
			order by 
				Count(nyeroszam1) desc
				,(select max(l.HuzasDatuma) from otoskvadrupla l 
						where l.nyeroszam1=a.nyeroszam1 and l.nyeroszam2=a.nyeroszam2 
								and l.nyeroszam3=a.nyeroszam3 and l.nyeroszam4=a.nyeroszam4)
				,a.nyeroszam1,a.nyeroszam2,a.nyeroszam3,a.nyeroszam4

	-- Hétről-hétre ismétlődő Kvadrupla - 0
				print 'Hétről hétre ismétlődő négyes számsor'
				Select	 a.nyeroszam1
					,a.nyeroszam2
					,a.nyeroszam3
					,a.nyeroszam4
					,(select max(l.HuzasDatuma) from otoskvadrupla l 
						where l.nyeroszam1=a.nyeroszam1 and l.nyeroszam2=a.nyeroszam2 
						and l.nyeroszam3=a.nyeroszam3 and l.nyeroszam4=a.nyeroszam4)
					as `Utolsó húzásának dátuma`
					,count(*) as `Alkalom`
				from otoskvadrupla a
				left join otoskvadrupla h on h.HuzasSorszama=a.HuzasSorszama+1 
					and a.nyeroszam1=h.nyeroszam1 and a.nyeroszam2=h.nyeroszam2 
					and a.nyeroszam3=h.nyeroszam3 and a.nyeroszam4=h.nyeroszam4
				where h.nyeroszam1 is not null
				group by a.nyeroszam1,a.nyeroszam2,a.nyeroszam3,a.nyeroszam4
						,h.nyeroszam1,h.nyeroszam2,h.nyeroszam3,h.nyeroszam4
				order by Count(*) desc
					,(select max(l.HuzasDatuma) from otoskvadrupla l 
						where l.nyeroszam1=a.nyeroszam1 and l.nyeroszam2=a.nyeroszam2 
						and l.nyeroszam3=a.nyeroszam3 and l.nyeroszam4=a.nyeroszam4)
					,a.nyeroszam1
					,a.nyeroszam2
					,a.nyeroszam3
					,a.nyeroszam4

-- Szélső szám pár előfordulás csökkenő
	print 'Szélső szám párok előfordulás gyakoriság szerint csökkenő sorrendben'
	Select top 25 nyeroszam1,nyeroszam5,count(*) as `Alkalom` from otosnyeroszamok 
		group by nyeroszam1,nyeroszam5
		having count(*)>=1
		order by Count(*) desc,nyeroszam1,nyeroszam5

-- Leggyakoribb középső szám előfordulás
	print 'Leggyakoribb középső szám'
	Select nyeroszam3,count(*) as `Alkalom` from otosnyeroszamok 
		group by nyeroszam3
		order by Count(*) desc,nyeroszam3
		
-- Legritkább középső szám előfordulás
	print 'Legritkább középső szám'
	Select  nyeroszam3,count(*) as `Alkalom` from otosnyeroszamok 
		group by nyeroszam3
		order by Count(*) asc,nyeroszam3

-- Leggyakoribb 2.4. pár előfordulás
	print 'Leggyakoribb 2.-4. szám pár'
	Select top 1005 nyeroszam2,nyeroszam4,count(*) as `Alkalom` from otosnyeroszamok 
		group by nyeroszam2,nyeroszam4
		having count(*)>=1
		order by Count(*) desc,nyeroszam2,nyeroszam4

-- Csak páros számok Növekvő előfordulás
	print 'Csak páros nyeroszamok'
	select * from otosnyeroszamok
		where 
				round(nyeroszam1/2,0)*2=nyeroszam1
			and round(nyeroszam2/2,0)*2=nyeroszam2
			and round(nyeroszam3/2,0)*2=nyeroszam3
			and round(nyeroszam4/2,0)*2=nyeroszam4
			and round(nyeroszam5/2,0)*2=nyeroszam5
		order by HuzasSorszama 
		
-- Csak páratlan számok Növekvő előfordulás -- 90 előfordulás
	print 'Csak páratlan nyeroszamok'
	select * from otosnyeroszamok
		where 
				round(nyeroszam1/2,0)*2<>nyeroszam1
			and round(nyeroszam2/2,0)*2<>nyeroszam2
			and round(nyeroszam3/2,0)*2<>nyeroszam3
			and round(nyeroszam4/2,0)*2<>nyeroszam4
			and round(nyeroszam5/2,0)*2<>nyeroszam5
		order by HuzasEve asc,HuzasDatuma asc 

-- Csak Hárommal osztható számok Csökkenő előfordulás (13)
	print 'Csak hárommal osztható nyeroszamok'
	select * from otosnyeroszamok
		where 
				round(nyeroszam1/3,2)*3=nyeroszam1
			and round(nyeroszam2/3,2)*3=nyeroszam2
			and round(nyeroszam3/3,2)*3=nyeroszam3
			and round(nyeroszam4/3,2)*3=nyeroszam4
			and round(nyeroszam5/3,2)*3=nyeroszam5
		order by HuzasEve desc,HuzasDatuma desc


-- Csak Hárommal NEM osztható számok Csökkenő előfordulás (378)
	print 'Csak hárommal NEM osztható nyeroszamok'
	select * from otosnyeroszamok
		where 
				round(nyeroszam1/3,2)*3<>nyeroszam1
			and round(nyeroszam2/3,2)*3<>nyeroszam2
			and round(nyeroszam3/3,2)*3<>nyeroszam3
			and round(nyeroszam4/3,2)*3<>nyeroszam4
			and round(nyeroszam5/3,2)*3<>nyeroszam5
		order by HuzasEve desc,HuzasDatuma desc

-- Csak néggyel osztható számok Csökkenő előfordulás (! - 2)
		print 'Csak néggyel osztható nyeroszamok'
		select * from otosnyeroszamok
		where 
				round(nyeroszam1/4,0)*4=nyeroszam1
			and round(nyeroszam2/4,0)*4=nyeroszam2
			and round(nyeroszam3/4,0)*4=nyeroszam3
			and round(nyeroszam4/4,0)*4=nyeroszam4
			and round(nyeroszam5/4,0)*4=nyeroszam5
		order by HuzasEve desc,HuzasDatuma desc

-- Csak néggyel NEM osztható számok Csökkenő előfordulás 718
		print 'Csak néggyel NEM osztható nyeroszamok'
		select * from otosnyeroszamok
		where 
				round(nyeroszam1/4,0)*4<>nyeroszam1
			and round(nyeroszam2/4,0)*4<>nyeroszam2
			and round(nyeroszam3/4,0)*4<>nyeroszam3
			and round(nyeroszam4/4,0)*4<>nyeroszam4
			and round(nyeroszam5/4,0)*4<>nyeroszam5
		order by HuzasEve desc,HuzasDatuma desc

-- Csak öttel osztható számok Csökkenő előfordulás (! 1)
		print 'Csak öttel osztható nyeroszamok'
		select * from otosnyeroszamok
		where 
				round(nyeroszam1/5,0)*5=nyeroszam1
			and round(nyeroszam2/5,0)*5=nyeroszam2
			and round(nyeroszam3/5,0)*5=nyeroszam3
			and round(nyeroszam4/5,0)*5=nyeroszam4
			and round(nyeroszam5/5,0)*5=nyeroszam5
		order by HuzasEve desc,HuzasDatuma desc

-- Csak öttel NEM osztható számok Csökkenő előfordulás 1059
		print 'Csak öttel NEM osztható nyeroszamok'
		select * from otosnyeroszamok
		where 
				round(nyeroszam1/5,0)*5<>nyeroszam1
			and round(nyeroszam2/5,0)*5<>nyeroszam2
			and round(nyeroszam3/5,0)*5<>nyeroszam3
			and round(nyeroszam4/5,0)*5<>nyeroszam4
			and round(nyeroszam5/5,0)*5<>nyeroszam5
		order by HuzasEve desc,HuzasDatuma desc

-- Csak hattal osztható számok Csökkenő előfordulás (0)
		print 'Csak hattal osztható nyeroszamok'
		select * from otosnyeroszamok
		where 
				round(nyeroszam1/6,0)*6=nyeroszam1
			and round(nyeroszam2/6,0)*6=nyeroszam2
			and round(nyeroszam3/6,0)*6=nyeroszam3
			and round(nyeroszam4/6,0)*6=nyeroszam4
			and round(nyeroszam5/6,0)*6=nyeroszam5
		order by HuzasEve desc,HuzasDatuma desc

-- Csak héttel osztható számok Csökkenő előfordulás (0)
		print 'Csak héttel osztható nyeroszamok'
		select * from otosnyeroszamok
		where 
				round(nyeroszam1/7,0)*7=nyeroszam1
			and round(nyeroszam2/7,0)*7=nyeroszam2
			and round(nyeroszam3/7,0)*7=nyeroszam3
			and round(nyeroszam4/7,0)*7=nyeroszam4
			and round(nyeroszam5/7,0)*7=nyeroszam5
		order by HuzasEve desc,HuzasDatuma desc

-- Csak nyolccal osztható számok Csökkenő előfordulás (0)
		print 'Csak nyolccal osztható nyeroszamok'
	select * from otosnyeroszamok
		where 
				round(nyeroszam1/8,0)*8=nyeroszam1
			and round(nyeroszam2/8,0)*8=nyeroszam2
			and round(nyeroszam3/8,0)*8=nyeroszam3
			and round(nyeroszam4/8,0)*8=nyeroszam4
			and round(nyeroszam5/8,0)*8=nyeroszam5
		order by HuzasEve desc,HuzasDatuma desc

-- Csak kilenccel osztható számok Csökkenő előfordulás (0)
		print 'Csak kilenccel osztható nyeroszamok'
		select * from otosnyeroszamok
		where 
				round(nyeroszam1/9,0)*9=nyeroszam1
			and round(nyeroszam2/9,0)*9=nyeroszam2
			and round(nyeroszam3/9,0)*9=nyeroszam3
			and round(nyeroszam4/9,0)*9=nyeroszam4
			and round(nyeroszam5/9,0)*9=nyeroszam5
		order by HuzasEve desc,HuzasDatuma desc

-- Csak prím számok előfordulása ( ! - 2)
	print 'Csak PRÍM számok'
	select * from otosnyeroszamok
	where 
		nyeroszam1 in 
			(select 2 union select 3 union select 5 union select 7 union select 11 union select 13 union select 17 union select 19 
			 union select 23 union select 29 union select 31 union select 37 union select 41 union select 43 union select 47 
			 union select 53 union select 59 union select 61 union select 67 union select 71 union select 73 union select 
			 79 union select 83 union select 89)
		and nyeroszam2 in 
			(select 2 union select 3 union select 5 union select 7 union select 11 union select 13 union select 17 union select 19 
			 union select 23 union select 29 union select 31 union select 37 union select 41 union select 43 union select 47 
			 union select 53 union select 59 union select 61 union select 67 union select 71 union select 73 union select 
			 79 union select 83 union select 89)
		and nyeroszam3 in 
			(select 2 union select 3 union select 5 union select 7 union select 11 union select 13 union select 17 union select 19 
			 union select 23 union select 29 union select 31 union select 37 union select 41 union select 43 union select 47 
			 union select 53 union select 59 union select 61 union select 67 union select 71 union select 73 union select 
			 79 union select 83 union select 89)
		and nyeroszam4 in 
			(select 2 union select 3 union select 5 union select 7 union select 11 union select 13 union select 17 union select 19 
			 union select 23 union select 29 union select 31 union select 37 union select 41 union select 43 union select 47 
			 union select 53 union select 59 union select 61 union select 67 union select 71 union select 73 union select 
			 79 union select 83 union select 89)
		and nyeroszam5 in 
			(select 2 union select 3 union select 5 union select 7 union select 11 union select 13 union select 17 union select 19 
			 union select 23 union select 29 union select 31 union select 37 union select 41 union select 43 union select 47 
			 union select 53 union select 59 union select 61 union select 67 union select 71 union select 73 union select 
			 79 union select 83 union select 89)

-- Szomszéd számok Csökkenő előfordulás
	print 'Szomszédos számok előfordulása csökkenő sorrendben  '
	Select nyeroszam1,nyeroszam2,count(*) 
	from otosdupla
		where nyeroszam1=nyeroszam2-1
		group by nyeroszam1,nyeroszam2
		order by count(*) desc, nyeroszam1 desc ,nyeroszam2 desc

-- Hármas szomszédok Növekvő ( ! 10)
	print 'Három szomszédos szám előfordulása egy sorsolásban - csökkenő sorrendben  '
	Select nyeroszam1,nyeroszam2,nyeroszam3,count(*) 
	from otostripla
		where nyeroszam1=nyeroszam3-2
		group by nyeroszam1,nyeroszam2,nyeroszam3
		order by count(*) asc, nyeroszam1 asc ,nyeroszam2 asc, nyeroszam3 asc

-- 45-ös szám alatti sorsolt 5 nyeroszam - 101
	print '1-45 nyeroszamok egy sorsolásban'
	select * from otosnyeroszamok where nyeroszam5<=45
		order by HuzasSorszama desc,nyeroszam1,nyeroszam2,nyeroszam3,nyeroszam4,nyeroszam5

-- 46 fölött sorsolt 5 nyeroszam - 87
	print '46-90 nyeroszamok egy sorsolásban'
	select * from otosnyeroszamok where nyeroszam1>=46
		order by HuzasSorszama desc,nyeroszam1,nyeroszam2,nyeroszam3,nyeroszam4,nyeroszam5

-- Legmagasabb első szám (62,64 még sosem volt legkisebb szám)
	print 'Legmagasabb első szám'
	select nyeroszam1,Count(*) from otosnyeroszamok 
		group by nyeroszam1
		order by nyeroszam1 desc,count(*) desc
				
-- Legalacsonyabb utolsó szám
	print 'Legmagasabb első szám'
	select nyeroszam5,Count(*) from otosnyeroszamok 
		group by nyeroszam5
		order by  nyeroszam5,count(*)desc

-- Legtávolabbi szélső pár különbözet előfordulások
	print 'Legtávolabbi szélső párok különbözete előfordulások szerint'
	select nyeroszam5-nyeroszam1 as `Különbözet`,Count(*) as `Előfordulás` from otosnyeroszamok 
		group by nyeroszam5-nyeroszam1
		order by count(*) desc ,nyeroszam5-nyeroszam1 desc

-- Leggyakoribb szélső párok - ez máshol is szerepel.

	print 'Leggyakoribb szélső párok'
	select nyeroszam1,nyeroszam5,Count(*) from otosnyeroszamok 
		group by nyeroszam5,nyeroszam1
		order by count(*) desc,nyeroszam1,nyeroszam5

-- Legközelebbi szélső párok
	print 'Legközelebbi szélső párok különbözete és azok előfordulása'
	select nyeroszam1,nyeroszam5,nyeroszam5-nyeroszam1 as `Különbözet`,Count(*) as `Előfordulás` from otosnyeroszamok 
		group by nyeroszam5,nyeroszam1,nyeroszam5-nyeroszam1
		order by nyeroszam5-nyeroszam1 asc,Count(*) desc,nyeroszam5,nyeroszam1
	
	print 'A legközelebbi szélső pár - 11'
			select * from otosnyeroszamok 
		where nyeroszam5-nyeroszam1<=11
		

-- Soha ki nem húzott Dupla 
	print 'Soha ki nem húzott szám párok'
	Select a.nyeroszam,b.nyeroszam from otosalapszamok a
	CROSS JOIN otosalapszamok b
	left join otosdupla f on f.nyeroszam1=a.nyeroszam and f.nyeroszam2=b.nyeroszam
		where a.nyeroszam<b.nyeroszam and f.HuzasEve is NULL
		order by a.nyeroszam,b.nyeroszam

-- Soha ki nem húzott Tripla 
	print 'Soha ki nem húzott Tripla'
	--Select a.nyeroszam,b.nyeroszam,c.nyeroszam from otosalapszamok a
	--	CROSS JOIN otosalapszamok b
	--	CROSS JOIN otosalapszamok c
	--	left join otostripla f on f.nyeroszam1=a.nyeroszam and f.nyeroszam2=b.nyeroszam and f.nyeroszam3=c.nyeroszam
	--		where a.nyeroszam<b.nyeroszam and b.nyeroszam<c.nyeroszam and f.HuzasEve is NULL
	--		order by a.nyeroszam,b.nyeroszam,c.nyeroszam

-- Soha ki nem húzott Kvadrupla 
	print 'Soha ki nem húzott Kvadrupla'
	--Select a.nyeroszam,b.nyeroszam,c.nyeroszam,d.nyeroszam from otosalapszamok a
	--	CROSS JOIN otosalapszamok b
	--	CROSS JOIN otosalapszamok c
	--	CROSS JOIN otosalapszamok d
	--	left join otoskvadrupla f on f.nyeroszam1=a.nyeroszam and f.nyeroszam2=b.nyeroszam 
	--			and f.nyeroszam3=c.nyeroszam and d.nyeroszam=f.nyeroszam4
	--		where a.nyeroszam<b.nyeroszam and b.nyeroszam<c.nyeroszam and c.nyeroszam<d.nyeroszam and f.HuzasEve is NULL
	--		order by a.nyeroszam,b.nyeroszam,c.nyeroszam,d.nyeroszam

-- Soha sem volt első szám
	print 'Soha nem volt első szám' 
	select 
		a.nyeroszam
		,case when a.nyeroszam<1 or a.nyeroszam>86 then 'Előfordulása kizárt' else '' end
	 from otosalapszamok a
		left join otosnyeroszamok h on h.nyeroszam1=a.nyeroszam
		where  h.nyeroszam1 is NULL -- and a.nyeroszam>0 and a.nyeroszam<87
		order by a.nyeroszam

-- Soha sem volt második szám
	print 'Soha nem volt második szám'
	select 
		a.nyeroszam
		,case when a.nyeroszam<=1 or a.nyeroszam>=88 then 'Előfordulása kizárt' else '' end
	 from otosalapszamok a
		left join otosnyeroszamok h on h.nyeroszam2=a.nyeroszam
		where  h.nyeroszam2 is NULL -- and a.nyeroszam>1 and a.nyeroszam<88
		order by a.nyeroszam

-- Soha sem volt harmadik szám
	print 'Soha nem volt harmadik szám'
	select 
		a.nyeroszam
		,case when a.nyeroszam>=89 or a.nyeroszam<=2 then 'Előfordulása kizárt' else '' end
	 from otosalapszamok a
		left join otosnyeroszamok h on h.nyeroszam3=a.nyeroszam
		where  h.nyeroszam3 is NULL -- and a.nyeroszam>2 and a.nyeroszam<89
		order by a.nyeroszam

-- Soha sem volt negyedik szám (kiemelendő a 8 ami már volt)
	print 'Soha nem volt negyedik szám'
	select 
		a.nyeroszam
		,case when a.nyeroszam>=90 or a.nyeroszam<=3 then 'Előfordulása kizárt' else '' end
	 from otosalapszamok a
		left join otosnyeroszamok h on h.nyeroszam4=a.nyeroszam
		where  h.nyeroszam4 is NULL -- and a.nyeroszam>3 and a.nyeroszam<90
		order by a.nyeroszam

		select * from otosnyeroszamok where nyeroszam4=8

-- Soha sem volt utolsó, ötödik szám
	print 'Soha nem volt ötödik szám'
	select a.nyeroszam
		,case when a.nyeroszam>=91 or a.nyeroszam<=4 then 'Előfordulása kizárt' else '' end
	 from otosalapszamok a
		left join otosnyeroszamok h on h.nyeroszam5=a.nyeroszam
		where  h.nyeroszam4 is NULL -- and a.nyeroszam>4 and a.nyeroszam<91
		order by a.nyeroszam

	-- Az öt szám legmagasabb összege (de a legmagasabb első számos -65- csak 17. a sorban)
			print 'Az öt szám legmagasabb összege' 	
			Select *,a.nyeroszam1+a.nyeroszam2+a.nyeroszam3+a.nyeroszam4+nyeroszam5 as `Összeg`
			from otosnyeroszamok a
			order by a.nyeroszam1+a.nyeroszam2+a.nyeroszam3+a.nyeroszam4+nyeroszam5 desc,a.HuzasSorszama asc
			
	-- Az öt szám legalacsonyabb összege
			print 'Az öt szám legalacsonyabb összege' 		
			Select *,a.nyeroszam1+a.nyeroszam2+a.nyeroszam3+a.nyeroszam4+nyeroszam5 as `Összeg`
			from otosnyeroszamok a
			order by a.nyeroszam1+a.nyeroszam2+a.nyeroszam3+a.nyeroszam4+nyeroszam5 asc,a.HuzasSorszama asc

	-- Az öt szám összegeinek előfordulása - 238*34
			print 'Az öt szám összegeinek előfordulása' 	
			Select a.nyeroszam1+a.nyeroszam2+a.nyeroszam3+a.nyeroszam4+nyeroszam5 as `Összeg`,count(*) as `Alkalommal`
			from otosnyeroszamok a
			Group by a.nyeroszam1+a.nyeroszam2+a.nyeroszam3+a.nyeroszam4+nyeroszam5
			order by count(*)desc,a.nyeroszam1+a.nyeroszam2+a.nyeroszam3+a.nyeroszam4+nyeroszam5 desc

	-- Az öt szám összegének ismétlődése két egymást követő húzáson (12)
			print 'Az öt szám összegeinek ismétlődése hétről hétre'
			Select	a.nyeroszam1+a.nyeroszam2+a.nyeroszam3+a.nyeroszam4+a.nyeroszam5 as `Összeg`
					,a.HuzasSorszama,a.HuzasEve,a.HuzasHete,a.HuzasDatuma,a.nyeroszam1,a.nyeroszam2,a.nyeroszam3,a.nyeroszam4,a.nyeroszam5
					,l.HuzasSorszama,l.HuzasEve,l.HuzasHete,l.HuzasDatuma,l.nyeroszam1,l.nyeroszam2,l.nyeroszam3,l.nyeroszam4,l.nyeroszam5
			from otosnyeroszamok a
			left join otosnyeroszamok l on l.HuzasSorszama=a.HuzasSorszama+1
			where a.nyeroszam1+a.nyeroszam2+a.nyeroszam3+a.nyeroszam4+a.nyeroszam5=l.nyeroszam1+l.nyeroszam2+l.nyeroszam3+l.nyeroszam4+l.nyeroszam5
			order by a.HuzasSorszama
			

	-- Első 4 szám összege = 5. számmal  (5) 
		print 'Első 4 szám összege = 5. számmal'
		Select * from otosnyeroszamok
			where nyeroszam1+nyeroszam2+nyeroszam3+nyeroszam4=nyeroszam5
			order by HuzasSorszama			

	-- Első 4 szám összege kisebb mint az 5. szám - 117
		print 'Első 4 szám összege kisebb mint az 5. szám értéke'
		Select * from otosnyeroszamok
			where nyeroszam1+nyeroszam2+nyeroszam3+nyeroszam4<nyeroszam5
			order by HuzasSorszama			

	-- Első 4 szám összege nagyobb mint az 5. szám - 3114
		print 'Első 4 szám összege nagyobb mint az 5. szám értéke'
		Select * from otosnyeroszamok
			where nyeroszam1+nyeroszam2+nyeroszam3+nyeroszam4>nyeroszam5
			order by HuzasSorszama			
			
	-- Első 3 szám összege = utolsó 2 szám összegével - 19
		print 'Első három szám összege egyenlő az utolsó két szám összegével'
		Select * from otosnyeroszamok
			where nyeroszam1+nyeroszam2+nyeroszam3=nyeroszam4+nyeroszam5
			order by HuzasSorszama			

	-- 1+2+4+5 szám átlaga egyenlő a 3. számmal (144 eset)
		print 'A harmadik szám az első kettő, és az utolsó kettő matematikai átlaga' 
		Select * from otosnyeroszamok
			where (nyeroszam1+nyeroszam2+nyeroszam4+nyeroszam5)/4=nyeroszam3


	-- 1*2 + 4*5 szám egyenlő a 3. szám négyzetével ( 0 előfordulás)
		print 'A harmadik szám az első kettő, és az utolsó kettő matematikai átlaga' 	
		Select * from otosnyeroszamok
			where (nyeroszam1*nyeroszam2+nyeroszam4*nyeroszam5)=nyeroszam3*nyeroszam3
-- Szabályos eloszlás - egyező különbségek

	-- Egyező távolságban lévő számok - 0 
	
		Select * from otosnyeroszamok
			where 
				nyeroszam2-nyeroszam1=nyeroszam3-nyeroszam2
				and nyeroszam3-nyeroszam2=nyeroszam4-nyeroszam3
				and nyeroszam4-nyeroszam3=nyeroszam5-nyeroszam4
		
	-- Folymatosan emelkedő különbség - 0
		
		Select * from otosnyeroszamok
			where 
				nyeroszam2-nyeroszam1=2*(nyeroszam3-nyeroszam2)
				and nyeroszam3-nyeroszam2=3*(nyeroszam4-nyeroszam3)
				and nyeroszam4-nyeroszam3=4*(nyeroszam5-nyeroszam4)

	-- Folymatosan emelkedő különbség - 0
		print 'Az első két szám különbözete azonos a harmadik és a negyedik szám különbözetével'		
		Select * from otosnyeroszamok
			where 
				nyeroszam2-nyeroszam1=(nyeroszam3-nyeroszam2)
				and nyeroszam3-nyeroszam2=(nyeroszam4-nyeroszam3)
				and nyeroszam4-nyeroszam3=(nyeroszam5-nyeroszam4) -- ha ezzel is kérem, akkor eddig nem adott előfordulást
 
			-- - - Hibás lekérdezés
			 
			--	-- nyeroszamok szorzatának maximuma
			--		print 'nyeroszamok szorzatának maximális értéke'
			--		select top 1 REPLACE(PARSENAME(CONVERT(VARCHAR(19), CONVERT(MONEY,nyeroszam1*nyeroszam2*nyeroszam3*nyeroszam4*nyeroszam5), 3), 2),',',' ')
			--			,HuzasSorszama,HuzasEve,HuzasHete,HuzasDatuma
			--			,nyeroszam1,nyeroszam2,nyeroszam3,nyeroszam4,nyeroszam5
			--			 from otosnyeroszamok
			--		order by nyeroszam1*nyeroszam2*nyeroszam3*nyeroszam4*nyeroszam5 desc

			--- - Hibás lekérdezés
			 
			--	-- nyeroszamok szorzatának minimuma
			--		print 'nyeroszamok szorzatának minimális értéke'
			--		select top 1 REPLACE(PARSENAME(CONVERT(VARCHAR(19), CONVERT(MONEY,nyeroszam1*nyeroszam2*nyeroszam3*nyeroszam4*nyeroszam5), 3), 2),',',' ')
			--			,HuzasSorszama,HuzasEve,HuzasHete,HuzasDatuma
			--			,nyeroszam1,nyeroszam2,nyeroszam3,nyeroszam4,nyeroszam5
			--			 from otosnyeroszamok
			--		order by nyeroszam1*nyeroszam2*nyeroszam3*nyeroszam4*nyeroszam5 asc
					
			--- - Hibás lekérdezés

			--	-- Azonos nyeroszamok szorzatok előfordulás szerint
			--		print 'Azonos nyeroszamok szorzatok előfordulás szerint'
			--		select 
			--			REPLACE(PARSENAME(CONVERT(VARCHAR(19),CONVERT(MONEY,nyeroszam1*nyeroszam2*nyeroszam3*nyeroszam4*nyeroszam5),3),2),',',' ') as `Szorzat`
			--			,count(*) as `Előfordulás`
			--			 from otosnyeroszamok
			--		group by nyeroszam1*nyeroszam2*nyeroszam3*nyeroszam4*nyeroszam5
			--		order by count(*) desc, nyeroszam1*nyeroszam2*nyeroszam3*nyeroszam4*nyeroszam5

			--- - Hibás lekérdezés

			--	-- Páros szorzat
			--		print 'Páros szorzat'
			--		select count(*) from otosnyeroszamok
			--			where round((nyeroszam1*nyeroszam2*nyeroszam3*nyeroszam4*nyeroszam5)/2,0)*2=nyeroszam1*nyeroszam2*nyeroszam3*nyeroszam4*nyeroszam5
			--- - Hibás lekérdezés

			--	-- Páratlan szorzat
			--		print 'Páratlan szorzat'
			--		select count(*) from otosnyeroszamok
			--			where round((nyeroszam1*nyeroszam2*nyeroszam3*nyeroszam4*nyeroszam5)/2,0)*2 <>nyeroszam1*nyeroszam2*nyeroszam3*nyeroszam4*nyeroszam5

	-- Csak kettesre végződő számok előfordulása
			print 'Csak kettesre végződő számok előfordulása'
			select *,
					case when (nyeroszam1=2 or nyeroszam1=12 or nyeroszam1=22 or nyeroszam1=32 or nyeroszam1=42 or nyeroszam1=52
						 or nyeroszam1=62 or nyeroszam1=72 or nyeroszam1=82) then 1 else 0 end
				+	case when (nyeroszam2=2 or nyeroszam2=12 or nyeroszam2=22 or nyeroszam2=32 or nyeroszam2=42 or nyeroszam2=52
						 or nyeroszam2=62 or nyeroszam2=72 or nyeroszam2=82) then 1 else 0 end
				+	case when (nyeroszam3=2 or nyeroszam3=12 or nyeroszam3=22 or nyeroszam3=32 or nyeroszam3=42 or nyeroszam3=52
						 or nyeroszam3=62 or nyeroszam3=72 or nyeroszam3=82) then 1 else 0 end
				+	case when (nyeroszam4=2 or nyeroszam4=12 or nyeroszam4=22 or nyeroszam4=32 or nyeroszam4=42 or nyeroszam4=52
						 or nyeroszam4=62 or nyeroszam4=72 or nyeroszam4=82) then 1 else 0 end
				+	case when (nyeroszam5=2 or nyeroszam5=12 or nyeroszam5=22 or nyeroszam5=32 or nyeroszam5=42 or nyeroszam5=52
						 or nyeroszam5=62 or nyeroszam5=72 or nyeroszam5=82) then 1 else 0 end
				from otosnyeroszamok
				where 
					case when (nyeroszam1=2 or nyeroszam1=12 or nyeroszam1=22 or nyeroszam1=32 or nyeroszam1=42 or nyeroszam1=52
						 or nyeroszam1=62 or nyeroszam1=72 or nyeroszam1=82) then 1 else 0 end
				+	case when (nyeroszam2=2 or nyeroszam2=12 or nyeroszam2=22 or nyeroszam2=32 or nyeroszam2=42 or nyeroszam2=52
						 or nyeroszam2=62 or nyeroszam2=72 or nyeroszam2=82) then 1 else 0 end
				+	case when (nyeroszam3=2 or nyeroszam3=12 or nyeroszam3=22 or nyeroszam3=32 or nyeroszam3=42 or nyeroszam3=52
						 or nyeroszam3=62 or nyeroszam3=72 or nyeroszam3=82) then 1 else 0 end
				+	case when (nyeroszam4=2 or nyeroszam4=12 or nyeroszam4=22 or nyeroszam4=32 or nyeroszam4=42 or nyeroszam4=52
						 or nyeroszam4=62 or nyeroszam4=72 or nyeroszam4=82) then 1 else 0 end
				+	case when (nyeroszam5=2 or nyeroszam5=12 or nyeroszam5=22 or nyeroszam5=32 or nyeroszam5=42 or nyeroszam5=52
						 or nyeroszam5=62 or nyeroszam5=72 or nyeroszam5=82) then 1 else 0 end 
						 >2
				
				order by 
					case when (nyeroszam1=2 or nyeroszam1=12 or nyeroszam1=22 or nyeroszam1=32 or nyeroszam1=42 or nyeroszam1=52
						 or nyeroszam1=62 or nyeroszam1=72 or nyeroszam1=82) then 1 else 0 end
				+	case when (nyeroszam2=2 or nyeroszam2=12 or nyeroszam2=22 or nyeroszam2=32 or nyeroszam2=42 or nyeroszam2=52
						 or nyeroszam2=62 or nyeroszam2=72 or nyeroszam2=82) then 1 else 0 end
				+	case when (nyeroszam3=2 or nyeroszam3=12 or nyeroszam3=22 or nyeroszam3=32 or nyeroszam3=42 or nyeroszam3=52
						 or nyeroszam3=62 or nyeroszam3=72 or nyeroszam3=82) then 1 else 0 end
				+	case when (nyeroszam4=2 or nyeroszam4=12 or nyeroszam4=22 or nyeroszam4=32 or nyeroszam4=42 or nyeroszam4=52
						 or nyeroszam4=62 or nyeroszam4=72 or nyeroszam4=82) then 1 else 0 end
				+	case when (nyeroszam5=2 or nyeroszam5=12 or nyeroszam5=22 or nyeroszam5=32 or nyeroszam5=42 or nyeroszam5=52
						 or nyeroszam5=62 or nyeroszam5=72 or nyeroszam5=82) then 1 else 0 end
				desc
				,HuzasSorszama asc
				
	-- Csak hármasra végződő számok előfordulása
			print 'Csak hármasra végződő számok előfordulása'
			select *,
					case when (nyeroszam1=3 or nyeroszam1=12 or nyeroszam1=23 or nyeroszam1=33 or nyeroszam1=43 or nyeroszam1=53
						 or nyeroszam1=63 or nyeroszam1=73 or nyeroszam1=83) then 1 else 0 end
				+	case when (nyeroszam2=3 or nyeroszam2=12 or nyeroszam2=23 or nyeroszam2=33 or nyeroszam2=43 or nyeroszam2=53
						 or nyeroszam2=63 or nyeroszam2=73 or nyeroszam2=83) then 1 else 0 end
				+	case when (nyeroszam3=3 or nyeroszam3=12 or nyeroszam3=23 or nyeroszam3=33 or nyeroszam3=43 or nyeroszam3=53
						 or nyeroszam3=63 or nyeroszam3=73 or nyeroszam3=83) then 1 else 0 end
				+	case when (nyeroszam4=3 or nyeroszam4=12 or nyeroszam4=23 or nyeroszam4=33 or nyeroszam4=43 or nyeroszam4=53
						 or nyeroszam4=63 or nyeroszam4=73 or nyeroszam4=83) then 1 else 0 end
				+	case when (nyeroszam5=3 or nyeroszam5=12 or nyeroszam5=23 or nyeroszam5=33 or nyeroszam5=43 or nyeroszam5=53
						 or nyeroszam5=63 or nyeroszam5=73 or nyeroszam5=83) then 1 else 0 end
				from otosnyeroszamok
				where 
				case when (nyeroszam1=3 or nyeroszam1=12 or nyeroszam1=23 or nyeroszam1=33 or nyeroszam1=43 or nyeroszam1=53
						 or nyeroszam1=63 or nyeroszam1=73 or nyeroszam1=83) then 1 else 0 end
				+	case when (nyeroszam2=3 or nyeroszam2=12 or nyeroszam2=23 or nyeroszam2=33 or nyeroszam2=43 or nyeroszam2=53
						 or nyeroszam2=63 or nyeroszam2=73 or nyeroszam2=83) then 1 else 0 end
				+	case when (nyeroszam3=3 or nyeroszam3=12 or nyeroszam3=23 or nyeroszam3=33 or nyeroszam3=43 or nyeroszam3=53
						 or nyeroszam3=63 or nyeroszam3=73 or nyeroszam3=83) then 1 else 0 end
				+	case when (nyeroszam4=3 or nyeroszam4=12 or nyeroszam4=23 or nyeroszam4=33 or nyeroszam4=43 or nyeroszam4=53
						 or nyeroszam4=63 or nyeroszam4=73 or nyeroszam4=83) then 1 else 0 end
				+	case when (nyeroszam5=3 or nyeroszam5=12 or nyeroszam5=23 or nyeroszam5=33 or nyeroszam5=43 or nyeroszam5=53
						 or nyeroszam5=63 or nyeroszam5=73 or nyeroszam5=83) then 1 else 0 end
					>2
				order by 
					case when (nyeroszam1=3 or nyeroszam1=12 or nyeroszam1=23 or nyeroszam1=33 or nyeroszam1=43 or nyeroszam1=53
						 or nyeroszam1=63 or nyeroszam1=73 or nyeroszam1=83) then 1 else 0 end
				+	case when (nyeroszam2=3 or nyeroszam2=12 or nyeroszam2=23 or nyeroszam2=33 or nyeroszam2=43 or nyeroszam2=53
						 or nyeroszam2=63 or nyeroszam2=73 or nyeroszam2=83) then 1 else 0 end
				+	case when (nyeroszam3=3 or nyeroszam3=12 or nyeroszam3=23 or nyeroszam3=33 or nyeroszam3=43 or nyeroszam3=53
						 or nyeroszam3=63 or nyeroszam3=73 or nyeroszam3=83) then 1 else 0 end
				+	case when (nyeroszam4=3 or nyeroszam4=12 or nyeroszam4=23 or nyeroszam4=33 or nyeroszam4=43 or nyeroszam4=53
						 or nyeroszam4=63 or nyeroszam4=73 or nyeroszam4=83) then 1 else 0 end
				+	case when (nyeroszam5=3 or nyeroszam5=12 or nyeroszam5=23 or nyeroszam5=33 or nyeroszam5=43 or nyeroszam5=53
						 or nyeroszam5=63 or nyeroszam5=73 or nyeroszam5=83) then 1 else 0 end
				desc
				,HuzasSorszama asc

	-- Csak négyesre végződő számok előfordulása
			print 'Csak négyesre végződő számok előfordulása'
			select *,
					case when (nyeroszam1=4 or nyeroszam1=14 or nyeroszam1=24 or nyeroszam1=34 or nyeroszam1=44 or nyeroszam1=54
						 or nyeroszam1=64 or nyeroszam1=74 or nyeroszam1=84) then 1 else 0 end
				+	case when (nyeroszam2=4 or nyeroszam2=14 or nyeroszam2=24 or nyeroszam2=34 or nyeroszam2=44 or nyeroszam2=54
						 or nyeroszam2=64 or nyeroszam2=74 or nyeroszam2=84) then 1 else 0 end
				+	case when (nyeroszam3=4 or nyeroszam3=14 or nyeroszam3=24 or nyeroszam3=34 or nyeroszam3=44 or nyeroszam3=54
						 or nyeroszam3=64 or nyeroszam3=74 or nyeroszam3=84) then 1 else 0 end
				+	case when (nyeroszam4=4 or nyeroszam4=14 or nyeroszam4=24 or nyeroszam4=34 or nyeroszam4=44 or nyeroszam4=54
						 or nyeroszam4=64 or nyeroszam4=74 or nyeroszam4=84) then 1 else 0 end
				+	case when (nyeroszam5=4 or nyeroszam5=14 or nyeroszam5=24 or nyeroszam5=34 or nyeroszam5=44 or nyeroszam5=54
						 or nyeroszam5=64 or nyeroszam5=74 or nyeroszam5=84) then 1 else 0 end
				from otosnyeroszamok
				where 
					case when (nyeroszam1=4 or nyeroszam1=14 or nyeroszam1=24 or nyeroszam1=34 or nyeroszam1=44 or nyeroszam1=54
						 or nyeroszam1=64 or nyeroszam1=74 or nyeroszam1=84) then 1 else 0 end
				+	case when (nyeroszam2=4 or nyeroszam2=14 or nyeroszam2=24 or nyeroszam2=34 or nyeroszam2=44 or nyeroszam2=54
						 or nyeroszam2=64 or nyeroszam2=74 or nyeroszam2=84) then 1 else 0 end
				+	case when (nyeroszam3=4 or nyeroszam3=14 or nyeroszam3=24 or nyeroszam3=34 or nyeroszam3=44 or nyeroszam3=54
						 or nyeroszam3=64 or nyeroszam3=74 or nyeroszam3=84) then 1 else 0 end
				+	case when (nyeroszam4=4 or nyeroszam4=14 or nyeroszam4=24 or nyeroszam4=34 or nyeroszam4=44 or nyeroszam4=54
						 or nyeroszam4=64 or nyeroszam4=74 or nyeroszam4=84) then 1 else 0 end
				+	case when (nyeroszam5=4 or nyeroszam5=14 or nyeroszam5=24 or nyeroszam5=34 or nyeroszam5=44 or nyeroszam5=54
						 or nyeroszam5=64 or nyeroszam5=74 or nyeroszam5=84) then 1 else 0 end
					>2
				order by 
					case when (nyeroszam1=4 or nyeroszam1=14 or nyeroszam1=24 or nyeroszam1=34 or nyeroszam1=44 or nyeroszam1=54
						 or nyeroszam1=64 or nyeroszam1=74 or nyeroszam1=84) then 1 else 0 end
				+	case when (nyeroszam2=4 or nyeroszam2=14 or nyeroszam2=24 or nyeroszam2=34 or nyeroszam2=44 or nyeroszam2=54
						 or nyeroszam2=64 or nyeroszam2=74 or nyeroszam2=84) then 1 else 0 end
				+	case when (nyeroszam3=4 or nyeroszam3=14 or nyeroszam3=24 or nyeroszam3=34 or nyeroszam3=44 or nyeroszam3=54
						 or nyeroszam3=64 or nyeroszam3=74 or nyeroszam3=84) then 1 else 0 end
				+	case when (nyeroszam4=4 or nyeroszam4=14 or nyeroszam4=24 or nyeroszam4=34 or nyeroszam4=44 or nyeroszam4=54
						 or nyeroszam4=64 or nyeroszam4=74 or nyeroszam4=84) then 1 else 0 end
				+	case when (nyeroszam5=4 or nyeroszam5=14 or nyeroszam5=24 or nyeroszam5=34 or nyeroszam5=44 or nyeroszam5=54
						 or nyeroszam5=64 or nyeroszam5=74 or nyeroszam5=84) then 1 else 0 end
				desc
				,HuzasSorszama asc


	-- Csak 5-re végződő számok előfordulása
			print 'Csak ötösre végződő számok előfordulása'
			select *,
					case when (nyeroszam1=5 or nyeroszam1=15 or nyeroszam1=25 or nyeroszam1=35 or nyeroszam1=45 or nyeroszam1=55
						 or nyeroszam1=65 or nyeroszam1=75 or nyeroszam1=85) then 1 else 0 end
				+	case when (nyeroszam2=5 or nyeroszam2=15 or nyeroszam2=25 or nyeroszam2=35 or nyeroszam2=45 or nyeroszam2=55
						 or nyeroszam2=65 or nyeroszam2=75 or nyeroszam2=85) then 1 else 0 end
				+	case when (nyeroszam3=5 or nyeroszam3=15 or nyeroszam3=25 or nyeroszam3=35 or nyeroszam3=45 or nyeroszam3=55
						 or nyeroszam3=65 or nyeroszam3=75 or nyeroszam3=85) then 1 else 0 end
				+	case when (nyeroszam4=5 or nyeroszam4=15 or nyeroszam4=25 or nyeroszam4=35 or nyeroszam4=45 or nyeroszam4=55
						 or nyeroszam4=65 or nyeroszam4=75 or nyeroszam4=85) then 1 else 0 end
				+	case when (nyeroszam5=5 or nyeroszam5=15 or nyeroszam5=25 or nyeroszam5=35 or nyeroszam5=45 or nyeroszam5=55
						 or nyeroszam5=65 or nyeroszam5=75 or nyeroszam5=85) then 1 else 0 end
				from otosnyeroszamok
				where 
					case when (nyeroszam1=5 or nyeroszam1=15 or nyeroszam1=25 or nyeroszam1=35 or nyeroszam1=45 or nyeroszam1=55
						 or nyeroszam1=65 or nyeroszam1=75 or nyeroszam1=85) then 1 else 0 end
				+	case when (nyeroszam2=5 or nyeroszam2=15 or nyeroszam2=25 or nyeroszam2=35 or nyeroszam2=45 or nyeroszam2=55
						 or nyeroszam2=65 or nyeroszam2=75 or nyeroszam2=85) then 1 else 0 end
				+	case when (nyeroszam3=5 or nyeroszam3=15 or nyeroszam3=25 or nyeroszam3=35 or nyeroszam3=45 or nyeroszam3=55
						 or nyeroszam3=65 or nyeroszam3=75 or nyeroszam3=85) then 1 else 0 end
				+	case when (nyeroszam4=5 or nyeroszam4=15 or nyeroszam4=25 or nyeroszam4=35 or nyeroszam4=45 or nyeroszam4=55
						 or nyeroszam4=65 or nyeroszam4=75 or nyeroszam4=85) then 1 else 0 end
				+	case when (nyeroszam5=5 or nyeroszam5=15 or nyeroszam5=25 or nyeroszam5=35 or nyeroszam5=45 or nyeroszam5=55
						 or nyeroszam5=65 or nyeroszam5=75 or nyeroszam5=85) then 1 else 0 end
						>2
				order by 
					case when (nyeroszam1=5 or nyeroszam1=15 or nyeroszam1=25 or nyeroszam1=35 or nyeroszam1=45 or nyeroszam1=55
						 or nyeroszam1=65 or nyeroszam1=75 or nyeroszam1=85) then 1 else 0 end
				+	case when (nyeroszam2=5 or nyeroszam2=15 or nyeroszam2=25 or nyeroszam2=35 or nyeroszam2=45 or nyeroszam2=55
						 or nyeroszam2=65 or nyeroszam2=75 or nyeroszam2=85) then 1 else 0 end
				+	case when (nyeroszam3=5 or nyeroszam3=15 or nyeroszam3=25 or nyeroszam3=35 or nyeroszam3=45 or nyeroszam3=55
						 or nyeroszam3=65 or nyeroszam3=75 or nyeroszam3=85) then 1 else 0 end
				+	case when (nyeroszam4=5 or nyeroszam4=15 or nyeroszam4=25 or nyeroszam4=35 or nyeroszam4=45 or nyeroszam4=55
						 or nyeroszam4=65 or nyeroszam4=75 or nyeroszam4=85) then 1 else 0 end
				+	case when (nyeroszam5=5 or nyeroszam5=15 or nyeroszam5=25 or nyeroszam5=35 or nyeroszam5=45 or nyeroszam5=55
						 or nyeroszam5=65 or nyeroszam5=75 or nyeroszam5=85) then 1 else 0 end
				desc
				,HuzasSorszama asc

	-- Csak 6-ra végződő számok előfordulása
			print 'Csak 6-ra végződő számok előfordulása'
			select *,
					case when (nyeroszam1=6 or nyeroszam1=16 or nyeroszam1=26 or nyeroszam1=36 or nyeroszam1=46 or nyeroszam1=56
						 or nyeroszam1=66 or nyeroszam1=76 or nyeroszam1=86) then 1 else 0 end
				+	case when (nyeroszam2=6 or nyeroszam2=16 or nyeroszam2=26 or nyeroszam2=36 or nyeroszam2=46 or nyeroszam2=56
						 or nyeroszam2=66 or nyeroszam2=76 or nyeroszam2=86) then 1 else 0 end
				+	case when (nyeroszam3=6 or nyeroszam3=16 or nyeroszam3=26 or nyeroszam3=36 or nyeroszam3=46 or nyeroszam3=56
						 or nyeroszam3=66 or nyeroszam3=76 or nyeroszam3=86) then 1 else 0 end
				+	case when (nyeroszam4=6 or nyeroszam4=16 or nyeroszam4=26 or nyeroszam4=36 or nyeroszam4=46 or nyeroszam4=56
						 or nyeroszam4=66 or nyeroszam4=76 or nyeroszam4=86) then 1 else 0 end
				+	case when (nyeroszam5=6 or nyeroszam5=16 or nyeroszam5=26 or nyeroszam5=36 or nyeroszam5=46 or nyeroszam5=56
						 or nyeroszam5=66 or nyeroszam5=76 or nyeroszam5=86) then 1 else 0 end
				from otosnyeroszamok
				where 
					case when (nyeroszam1=6 or nyeroszam1=16 or nyeroszam1=26 or nyeroszam1=36 or nyeroszam1=46 or nyeroszam1=56
						 or nyeroszam1=66 or nyeroszam1=76 or nyeroszam1=86) then 1 else 0 end
				+	case when (nyeroszam2=6 or nyeroszam2=16 or nyeroszam2=26 or nyeroszam2=36 or nyeroszam2=46 or nyeroszam2=56
						 or nyeroszam2=66 or nyeroszam2=76 or nyeroszam2=86) then 1 else 0 end
				+	case when (nyeroszam3=6 or nyeroszam3=16 or nyeroszam3=26 or nyeroszam3=36 or nyeroszam3=46 or nyeroszam3=56
						 or nyeroszam3=66 or nyeroszam3=76 or nyeroszam3=86) then 1 else 0 end
				+	case when (nyeroszam4=6 or nyeroszam4=16 or nyeroszam4=26 or nyeroszam4=36 or nyeroszam4=46 or nyeroszam4=56
						 or nyeroszam4=66 or nyeroszam4=76 or nyeroszam4=86) then 1 else 0 end
				+	case when (nyeroszam5=6 or nyeroszam5=16 or nyeroszam5=26 or nyeroszam5=36 or nyeroszam5=46 or nyeroszam5=56
						 or nyeroszam5=66 or nyeroszam5=76 or nyeroszam5=86) then 1 else 0 end
						>2
				order by 
					case when (nyeroszam1=6 or nyeroszam1=16 or nyeroszam1=26 or nyeroszam1=36 or nyeroszam1=46 or nyeroszam1=56
						 or nyeroszam1=66 or nyeroszam1=76 or nyeroszam1=86) then 1 else 0 end
				+	case when (nyeroszam2=6 or nyeroszam2=16 or nyeroszam2=26 or nyeroszam2=36 or nyeroszam2=46 or nyeroszam2=56
						 or nyeroszam2=66 or nyeroszam2=76 or nyeroszam2=86) then 1 else 0 end
				+	case when (nyeroszam3=6 or nyeroszam3=16 or nyeroszam3=26 or nyeroszam3=36 or nyeroszam3=46 or nyeroszam3=56
						 or nyeroszam3=66 or nyeroszam3=76 or nyeroszam3=86) then 1 else 0 end
				+	case when (nyeroszam4=6 or nyeroszam4=16 or nyeroszam4=26 or nyeroszam4=36 or nyeroszam4=46 or nyeroszam4=56
						 or nyeroszam4=66 or nyeroszam4=76 or nyeroszam4=86) then 1 else 0 end
				+	case when (nyeroszam5=6 or nyeroszam5=16 or nyeroszam5=26 or nyeroszam5=36 or nyeroszam5=46 or nyeroszam5=56
						 or nyeroszam5=66 or nyeroszam5=76 or nyeroszam5=86) then 1 else 0 end
				desc
				,HuzasSorszama asc

	-- Csak 7-re végződő számok előfordulása
			print 'Csak 7-re végződő számok előfordulása'
			select *,
					case when (nyeroszam1=7 or nyeroszam1=17 or nyeroszam1=27 or nyeroszam1=37 or nyeroszam1=47 or nyeroszam1=56
						 or nyeroszam1=67 or nyeroszam1=77 or nyeroszam1=87) then 1 else 0 end
				+	case when (nyeroszam2=7 or nyeroszam2=17 or nyeroszam2=27 or nyeroszam2=37 or nyeroszam2=47 or nyeroszam2=56
						 or nyeroszam2=67 or nyeroszam2=77 or nyeroszam2=87) then 1 else 0 end
				+	case when (nyeroszam3=7 or nyeroszam3=17 or nyeroszam3=27 or nyeroszam3=37 or nyeroszam3=47 or nyeroszam3=56
						 or nyeroszam3=67 or nyeroszam3=77 or nyeroszam3=87) then 1 else 0 end
				+	case when (nyeroszam4=7 or nyeroszam4=17 or nyeroszam4=27 or nyeroszam4=37 or nyeroszam4=47 or nyeroszam4=56
						 or nyeroszam4=67 or nyeroszam4=77 or nyeroszam4=87) then 1 else 0 end
				+	case when (nyeroszam5=7 or nyeroszam5=17 or nyeroszam5=27 or nyeroszam5=37 or nyeroszam5=47 or nyeroszam5=56
						 or nyeroszam5=67 or nyeroszam5=77 or nyeroszam5=87) then 1 else 0 end
				from otosnyeroszamok
				where 
					case when (nyeroszam1=7 or nyeroszam1=17 or nyeroszam1=27 or nyeroszam1=37 or nyeroszam1=47 or nyeroszam1=56
						 or nyeroszam1=67 or nyeroszam1=77 or nyeroszam1=87) then 1 else 0 end
				+	case when (nyeroszam2=7 or nyeroszam2=17 or nyeroszam2=27 or nyeroszam2=37 or nyeroszam2=47 or nyeroszam2=56
						 or nyeroszam2=67 or nyeroszam2=77 or nyeroszam2=87) then 1 else 0 end
				+	case when (nyeroszam3=7 or nyeroszam3=17 or nyeroszam3=27 or nyeroszam3=37 or nyeroszam3=47 or nyeroszam3=56
						 or nyeroszam3=67 or nyeroszam3=77 or nyeroszam3=87) then 1 else 0 end
				+	case when (nyeroszam4=7 or nyeroszam4=17 or nyeroszam4=27 or nyeroszam4=37 or nyeroszam4=47 or nyeroszam4=56
						 or nyeroszam4=67 or nyeroszam4=77 or nyeroszam4=87) then 1 else 0 end
				+	case when (nyeroszam5=7 or nyeroszam5=17 or nyeroszam5=27 or nyeroszam5=37 or nyeroszam5=47 or nyeroszam5=56
						 or nyeroszam5=67 or nyeroszam5=77 or nyeroszam5=87) then 1 else 0 end
					>2
				order by 
					case when (nyeroszam1=7 or nyeroszam1=17 or nyeroszam1=27 or nyeroszam1=37 or nyeroszam1=47 or nyeroszam1=56
						 or nyeroszam1=67 or nyeroszam1=77 or nyeroszam1=87) then 1 else 0 end
				+	case when (nyeroszam2=7 or nyeroszam2=17 or nyeroszam2=27 or nyeroszam2=37 or nyeroszam2=47 or nyeroszam2=56
						 or nyeroszam2=67 or nyeroszam2=77 or nyeroszam2=87) then 1 else 0 end
				+	case when (nyeroszam3=7 or nyeroszam3=17 or nyeroszam3=27 or nyeroszam3=37 or nyeroszam3=47 or nyeroszam3=56
						 or nyeroszam3=67 or nyeroszam3=77 or nyeroszam3=87) then 1 else 0 end
				+	case when (nyeroszam4=7 or nyeroszam4=17 or nyeroszam4=27 or nyeroszam4=37 or nyeroszam4=47 or nyeroszam4=56
						 or nyeroszam4=67 or nyeroszam4=77 or nyeroszam4=87) then 1 else 0 end
				+	case when (nyeroszam5=7 or nyeroszam5=17 or nyeroszam5=27 or nyeroszam5=37 or nyeroszam5=47 or nyeroszam5=56
						 or nyeroszam5=67 or nyeroszam5=77 or nyeroszam5=87) then 1 else 0 end
				desc
				,HuzasSorszama asc

	-- Csak 8-ra végződő számok előfordulása
			print 'Csak 8-ra végződő számok előfordulása'
			select *,
					case when (nyeroszam1=8 or nyeroszam1=18 or nyeroszam1=28 or nyeroszam1=38 or nyeroszam1=48 or nyeroszam1=58
						 or nyeroszam1=68 or nyeroszam1=78 or nyeroszam1=88) then 1 else 0 end
				+	case when (nyeroszam2=8 or nyeroszam2=18 or nyeroszam2=28 or nyeroszam2=38 or nyeroszam2=48 or nyeroszam2=58
						 or nyeroszam2=68 or nyeroszam2=78 or nyeroszam2=88) then 1 else 0 end
				+	case when (nyeroszam3=8 or nyeroszam3=18 or nyeroszam3=28 or nyeroszam3=38 or nyeroszam3=48 or nyeroszam3=58
						 or nyeroszam3=68 or nyeroszam3=78 or nyeroszam3=88) then 1 else 0 end
				+	case when (nyeroszam4=8 or nyeroszam4=18 or nyeroszam4=28 or nyeroszam4=38 or nyeroszam4=48 or nyeroszam4=58
						 or nyeroszam4=68 or nyeroszam4=78 or nyeroszam4=88) then 1 else 0 end
				+	case when (nyeroszam5=8 or nyeroszam5=18 or nyeroszam5=28 or nyeroszam5=38 or nyeroszam5=48 or nyeroszam5=58
						 or nyeroszam5=68 or nyeroszam5=78 or nyeroszam5=88) then 1 else 0 end
				from otosnyeroszamok
				where 
					case when (nyeroszam1=8 or nyeroszam1=18 or nyeroszam1=28 or nyeroszam1=38 or nyeroszam1=48 or nyeroszam1=58
						 or nyeroszam1=68 or nyeroszam1=78 or nyeroszam1=88) then 1 else 0 end
				+	case when (nyeroszam2=8 or nyeroszam2=18 or nyeroszam2=28 or nyeroszam2=38 or nyeroszam2=48 or nyeroszam2=58
						 or nyeroszam2=68 or nyeroszam2=78 or nyeroszam2=88) then 1 else 0 end
				+	case when (nyeroszam3=8 or nyeroszam3=18 or nyeroszam3=28 or nyeroszam3=38 or nyeroszam3=48 or nyeroszam3=58
						 or nyeroszam3=68 or nyeroszam3=78 or nyeroszam3=88) then 1 else 0 end
				+	case when (nyeroszam4=8 or nyeroszam4=18 or nyeroszam4=28 or nyeroszam4=38 or nyeroszam4=48 or nyeroszam4=58
						 or nyeroszam4=68 or nyeroszam4=78 or nyeroszam4=88) then 1 else 0 end
				+	case when (nyeroszam5=8 or nyeroszam5=18 or nyeroszam5=28 or nyeroszam5=38 or nyeroszam5=48 or nyeroszam5=58
						 or nyeroszam5=68 or nyeroszam5=78 or nyeroszam5=88) then 1 else 0 end
					>2
				order by 
					case when (nyeroszam1=8 or nyeroszam1=18 or nyeroszam1=28 or nyeroszam1=38 or nyeroszam1=48 or nyeroszam1=58
						 or nyeroszam1=68 or nyeroszam1=78 or nyeroszam1=88) then 1 else 0 end
				+	case when (nyeroszam2=8 or nyeroszam2=18 or nyeroszam2=28 or nyeroszam2=38 or nyeroszam2=48 or nyeroszam2=58
						 or nyeroszam2=68 or nyeroszam2=78 or nyeroszam2=88) then 1 else 0 end
				+	case when (nyeroszam3=8 or nyeroszam3=18 or nyeroszam3=28 or nyeroszam3=38 or nyeroszam3=48 or nyeroszam3=58
						 or nyeroszam3=68 or nyeroszam3=78 or nyeroszam3=88) then 1 else 0 end
				+	case when (nyeroszam4=8 or nyeroszam4=18 or nyeroszam4=28 or nyeroszam4=38 or nyeroszam4=48 or nyeroszam4=58
						 or nyeroszam4=68 or nyeroszam4=78 or nyeroszam4=88) then 1 else 0 end
				+	case when (nyeroszam5=8 or nyeroszam5=18 or nyeroszam5=28 or nyeroszam5=38 or nyeroszam5=48 or nyeroszam5=58
						 or nyeroszam5=68 or nyeroszam5=78 or nyeroszam5=88) then 1 else 0 end
				desc
				,HuzasSorszama asc

	-- Csak 9-re végződő számok előfordulása
			print 'Csak 9-ra végződő számok előfordulása'
			select *,
					case when (nyeroszam1=9 or nyeroszam1=19 or nyeroszam1=29 or nyeroszam1=39 or nyeroszam1=49 or nyeroszam1=69
						 or nyeroszam1=69 or nyeroszam1=79 or nyeroszam1=89) then 1 else 0 end
				+	case when (nyeroszam2=9 or nyeroszam2=19 or nyeroszam2=29 or nyeroszam2=39 or nyeroszam2=49 or nyeroszam2=69
						 or nyeroszam2=69 or nyeroszam2=79 or nyeroszam2=89) then 1 else 0 end
				+	case when (nyeroszam3=9 or nyeroszam3=19 or nyeroszam3=29 or nyeroszam3=39 or nyeroszam3=49 or nyeroszam3=69
						 or nyeroszam3=69 or nyeroszam3=79 or nyeroszam3=89) then 1 else 0 end
				+	case when (nyeroszam4=9 or nyeroszam4=19 or nyeroszam4=29 or nyeroszam4=39 or nyeroszam4=49 or nyeroszam4=69
						 or nyeroszam4=69 or nyeroszam4=79 or nyeroszam4=89) then 1 else 0 end
				+	case when (nyeroszam5=9 or nyeroszam5=19 or nyeroszam5=29 or nyeroszam5=39 or nyeroszam5=49 or nyeroszam5=69
						 or nyeroszam5=69 or nyeroszam5=79 or nyeroszam5=89) then 1 else 0 end
				from otosnyeroszamok
				where 
					case when (nyeroszam1=9 or nyeroszam1=19 or nyeroszam1=29 or nyeroszam1=39 or nyeroszam1=49 or nyeroszam1=69
						 or nyeroszam1=69 or nyeroszam1=79 or nyeroszam1=89) then 1 else 0 end
				+	case when (nyeroszam2=9 or nyeroszam2=19 or nyeroszam2=29 or nyeroszam2=39 or nyeroszam2=49 or nyeroszam2=69
						 or nyeroszam2=69 or nyeroszam2=79 or nyeroszam2=89) then 1 else 0 end
				+	case when (nyeroszam3=9 or nyeroszam3=19 or nyeroszam3=29 or nyeroszam3=39 or nyeroszam3=49 or nyeroszam3=69
						 or nyeroszam3=69 or nyeroszam3=79 or nyeroszam3=89) then 1 else 0 end
				+	case when (nyeroszam4=9 or nyeroszam4=19 or nyeroszam4=29 or nyeroszam4=39 or nyeroszam4=49 or nyeroszam4=69
						 or nyeroszam4=69 or nyeroszam4=79 or nyeroszam4=89) then 1 else 0 end
				+	case when (nyeroszam5=9 or nyeroszam5=19 or nyeroszam5=29 or nyeroszam5=39 or nyeroszam5=49 or nyeroszam5=69
						 or nyeroszam5=69 or nyeroszam5=79 or nyeroszam5=89) then 1 else 0 end
					>2
				order by 
					case when (nyeroszam1=9 or nyeroszam1=19 or nyeroszam1=29 or nyeroszam1=39 or nyeroszam1=49 or nyeroszam1=69
						 or nyeroszam1=69 or nyeroszam1=79 or nyeroszam1=89) then 1 else 0 end
				+	case when (nyeroszam2=9 or nyeroszam2=19 or nyeroszam2=29 or nyeroszam2=39 or nyeroszam2=49 or nyeroszam2=69
						 or nyeroszam2=69 or nyeroszam2=79 or nyeroszam2=89) then 1 else 0 end
				+	case when (nyeroszam3=9 or nyeroszam3=19 or nyeroszam3=29 or nyeroszam3=39 or nyeroszam3=49 or nyeroszam3=69
						 or nyeroszam3=69 or nyeroszam3=79 or nyeroszam3=89) then 1 else 0 end
				+	case when (nyeroszam4=9 or nyeroszam4=19 or nyeroszam4=29 or nyeroszam4=39 or nyeroszam4=49 or nyeroszam4=69
						 or nyeroszam4=69 or nyeroszam4=79 or nyeroszam4=89) then 1 else 0 end
				+	case when (nyeroszam5=9 or nyeroszam5=19 or nyeroszam5=29 or nyeroszam5=39 or nyeroszam5=49 or nyeroszam5=69
						 or nyeroszam5=69 or nyeroszam5=79 or nyeroszam5=89) then 1 else 0 end
				desc
				,HuzasSorszama asc

	-- Csak 0-ra végződő számok előfordulása
			print 'Csak 0-ra végződő számok előfordulása'
			select *,
					case when (nyeroszam1=10 or nyeroszam1=20 or nyeroszam1=30 or nyeroszam1=40 or nyeroszam1=50
						    or nyeroszam1=60 or nyeroszam1=70 or nyeroszam1=80 or nyeroszam1=90) then 1 else 0 end
				+	case when (nyeroszam2=10 or nyeroszam2=20 or nyeroszam2=30 or nyeroszam2=40 or nyeroszam2=50
						    or nyeroszam2=60 or nyeroszam2=70 or nyeroszam2=80 or nyeroszam2=90) then 1 else 0 end
				+	case when (nyeroszam3=10 or nyeroszam3=20 or nyeroszam3=30 or nyeroszam3=40 or nyeroszam3=50
					 	    or nyeroszam3=60 or nyeroszam3=70 or nyeroszam3=80 or nyeroszam3=90) then 1 else 0 end
				+	case when (nyeroszam4=10 or nyeroszam4=20 or nyeroszam4=30 or nyeroszam4=40 or nyeroszam4=50
						    or nyeroszam4=60 or nyeroszam4=70 or nyeroszam4=80 or nyeroszam4=90) then 1 else 0 end
				+	case when (nyeroszam5=10 or nyeroszam5=20 or nyeroszam5=30 or nyeroszam5=40 or nyeroszam5=50
						    or nyeroszam5=60 or nyeroszam5=70 or nyeroszam5=80 or nyeroszam5=90) then 1 else 0 end
				from otosnyeroszamok
				where 
					case when (nyeroszam1=10 or nyeroszam1=20 or nyeroszam1=30 or nyeroszam1=40 or nyeroszam1=50
						    or nyeroszam1=60 or nyeroszam1=70 or nyeroszam1=80 or nyeroszam1=90) then 1 else 0 end
				+	case when (nyeroszam2=10 or nyeroszam2=20 or nyeroszam2=30 or nyeroszam2=40 or nyeroszam2=50
						    or nyeroszam2=60 or nyeroszam2=70 or nyeroszam2=80 or nyeroszam2=90) then 1 else 0 end
				+	case when (nyeroszam3=10 or nyeroszam3=20 or nyeroszam3=30 or nyeroszam3=40 or nyeroszam3=50
					 	    or nyeroszam3=60 or nyeroszam3=70 or nyeroszam3=80 or nyeroszam3=90) then 1 else 0 end
				+	case when (nyeroszam4=10 or nyeroszam4=20 or nyeroszam4=30 or nyeroszam4=40 or nyeroszam4=50
						    or nyeroszam4=60 or nyeroszam4=70 or nyeroszam4=80 or nyeroszam4=90) then 1 else 0 end
				+	case when (nyeroszam5=10 or nyeroszam5=20 or nyeroszam5=30 or nyeroszam5=40 or nyeroszam5=50
						    or nyeroszam5=60 or nyeroszam5=70 or nyeroszam5=80 or nyeroszam5=90) then 1 else 0 end
					>2
				order by 
					case when (nyeroszam1=80 or nyeroszam1=10 or nyeroszam1=20 or nyeroszam1=30 or nyeroszam1=40 or nyeroszam1=50
						    or nyeroszam1=60 or nyeroszam1=70 or nyeroszam1=90) then 1 else 0 end
				+	case when (nyeroszam2=80 or nyeroszam2=10 or nyeroszam2=20 or nyeroszam2=30 or nyeroszam2=40 or nyeroszam2=50
						    or nyeroszam2=60 or nyeroszam2=70 or nyeroszam2=90) then 1 else 0 end
				+	case when (nyeroszam3=80 or nyeroszam3=10 or nyeroszam3=20 or nyeroszam3=30 or nyeroszam3=40 or nyeroszam3=50
						    or nyeroszam3=60 or nyeroszam3=70 or nyeroszam3=90) then 1 else 0 end
				+	case when (nyeroszam4=80 or nyeroszam4=10 or nyeroszam4=20 or nyeroszam4=30 or nyeroszam4=40 or nyeroszam4=50
						    or nyeroszam4=60 or nyeroszam4=70 or nyeroszam4=90) then 1 else 0 end
				+	case when (nyeroszam5=80 or nyeroszam5=10 or nyeroszam5=20 or nyeroszam5=30 or nyeroszam5=40 or nyeroszam5=50
						    or nyeroszam5=60 or nyeroszam5=70 or nyeroszam5=90) then 1 else 0 end
				desc
				,HuzasSorszama asc

-- Egy kis mérteni elemzésm, rajzolás

-- Átlós számok Jobbra fölfelé
			print 'Számok átlóban - jobbra fölfelé' 		
			Select a.nyeroszam1,a.nyeroszam2,a.nyeroszam3,a.nyeroszam4,nyeroszam5
			from otosnyeroszamok a
				where 
					(nyeroszam5>=41 and nyeroszam5<=46
					 or
					 nyeroszam5>=51 and nyeroszam5<=56
					 or 
					 nyeroszam5>=61 and nyeroszam5<=66
					 or 
					 nyeroszam5>=71 and nyeroszam5<=76
					 or 
					 nyeroszam5>=81 and nyeroszam5<=86)
					 and nyeroszam5-nyeroszam4=9 and nyeroszam4-nyeroszam3=9 and nyeroszam3-nyeroszam2=9 and nyeroszam2-nyeroszam1=9
				order by a.nyeroszam1,a.nyeroszam2,a.nyeroszam3,a.nyeroszam4,nyeroszam5,a.HuzasSorszama
				

-- Átlós számok Jobbra lefelé
			print 'Számok átlóban - jobbra lefelé' 		
			Select a.nyeroszam1,a.nyeroszam2,a.nyeroszam3,a.nyeroszam4,nyeroszam5
			from otosnyeroszamok a
				where 
					(nyeroszam5>=45 and nyeroszam5<=50
					 or
					 nyeroszam5>=55 and nyeroszam5<=60
					 or 
					 nyeroszam5>=65 and nyeroszam5<=70
					 or 
					 nyeroszam5>=75 and nyeroszam5<=80
					 or 
					 nyeroszam5>=85 and nyeroszam5<=90)
					 and nyeroszam5-nyeroszam4=11 and nyeroszam4-nyeroszam3=11 and nyeroszam3-nyeroszam2=11 and nyeroszam2-nyeroszam1=11
				order by a.nyeroszam1,a.nyeroszam2,a.nyeroszam3,a.nyeroszam4,nyeroszam5,a.HuzasSorszama


-- Számmisztika


-- Számmisztikai szám előfordulása gyakoriság szerinti sorrendben
	print 'Számmisztikai szám előfordulása gyakoriság szerinti sorrendben' 
	select 
		 SzammisztikaiSzam
		,COUNT(SzammisztikaiSzam) as `Előfordulás Db` 
		,(select max(HuzasDatuma) from otosnyeroszamok ny2 where ny1.SzammisztikaiSzam=ny2.SzammisztikaiSzam) as `Számmisztikai Szám Utolsó Előfordulása`
		from otosnyeroszamok ny1
	group by SzammisztikaiSzam
	order by COUNT(SzammisztikaiSzam) desc
	--order by (select max(HuzasDatuma) from otosnyeroszamok ny2 where ny1.SzammisztikaiSzam=ny2.SzammisztikaiSzam) asc

-- Számmisztikai szám előfordulása időrendi sorrendben 

	print 'Számmisztikai szám előfordulása időrendi sorrendben'
	select 
		 SzammisztikaiSzam
		,COUNT(SzammisztikaiSzam) as `Előfordulás Db` 
		,(select max(HuzasDatuma) from otosnyeroszamok ny2 where ny1.SzammisztikaiSzam=ny2.SzammisztikaiSzam) as `Számmisztikai Szám Utolsó Előfordulása`
		from otosnyeroszamok ny1
	group by SzammisztikaiSzam
	--order by COUNT(SzammisztikaiSzam) desc
	order by (select max(HuzasDatuma) from otosnyeroszamok ny2 where ny1.SzammisztikaiSzam=ny2.SzammisztikaiSzam) asc

-- Számmisztikai számok ismétlődése hétről-hétre 

	Print 'Számmisztikai számok ismétlődése hétről-hétre - két egymás követő héten'
	
	Select	 ny1.SzammisztikaiSzam
			,count(ny1.SzammisztikaiSzam) as `2 Heti ismétlődés Db`
			from otosnyeroszamok ny1
			left join otosnyeroszamok ny2 on ny1.HuzasSorszama+1=ny2.HuzasSorszama
			where ny1.SzammisztikaiSzam=ny2.SzammisztikaiSzam
			group by ny1.SzammisztikaiSzam
			order by count(ny1.SzammisztikaiSzam) desc ,ny1.SzammisztikaiSzam

-- 	Print 'Számmisztikai számok ismétlődése hétről-hétre három egymás követő héten'	
	
	Print 'Számmisztikai számok ismétlődése hétről-hétre - három egymás követő héten'
	Select	 ny1.SzammisztikaiSzam
			,count(ny1.SzammisztikaiSzam) as `3 Heti ismétlődés Db`
			from otosnyeroszamok ny1
			left join otosnyeroszamok ny2 on ny1.HuzasSorszama+1=ny2.HuzasSorszama
			left join otosnyeroszamok ny3 on ny1.HuzasSorszama+2=ny3.HuzasSorszama
			where 
					ny1.SzammisztikaiSzam=ny2.SzammisztikaiSzam 
				and ny1.SzammisztikaiSzam=ny3.SzammisztikaiSzam 
			group by ny1.SzammisztikaiSzam
			order by count(ny1.SzammisztikaiSzam) desc ,ny1.SzammisztikaiSzam


-- Számmisztikai számok ismétlődése hétről-hétre négy egymás követő héten 

	print 'Számmisztikai számok ismétlődése hétről-hétre - négy egymás követő héten'	
	Select	 ny1.SzammisztikaiSzam
			,count(ny1.SzammisztikaiSzam) as `4 Heti ismétlődés Db`
			from otosnyeroszamok ny1
			left join otosnyeroszamok ny2 on ny1.HuzasSorszama+1=ny2.HuzasSorszama
			left join otosnyeroszamok ny3 on ny1.HuzasSorszama+2=ny3.HuzasSorszama
			left join otosnyeroszamok ny4 on ny1.HuzasSorszama+3=ny4.HuzasSorszama
			where 
					ny1.SzammisztikaiSzam=ny2.SzammisztikaiSzam 
				and ny1.SzammisztikaiSzam=ny3.SzammisztikaiSzam
				and ny1.SzammisztikaiSzam=ny4.SzammisztikaiSzam
			group by ny1.SzammisztikaiSzam
			order by count(ny1.SzammisztikaiSzam) desc ,ny1.SzammisztikaiSzam

-- Számmisztikai számok ismétlődése hétről-hétre öt egymás követő héten 

	print 'Számmisztikai számok ismétlődése hétről-hétre - öt egymás követő héten'	
	Select	 ny1.SzammisztikaiSzam
			,count(ny1.SzammisztikaiSzam) as `5 Heti ismétlődés Db`
			from otosnyeroszamok ny1
			left join otosnyeroszamok ny2 on ny1.HuzasSorszama+1=ny2.HuzasSorszama
			left join otosnyeroszamok ny3 on ny1.HuzasSorszama+2=ny3.HuzasSorszama
			left join otosnyeroszamok ny4 on ny1.HuzasSorszama+3=ny4.HuzasSorszama
			left join otosnyeroszamok ny5 on ny1.HuzasSorszama+4=ny5.HuzasSorszama
			where 
					ny1.SzammisztikaiSzam=ny2.SzammisztikaiSzam 
				and ny1.SzammisztikaiSzam=ny3.SzammisztikaiSzam
				and ny1.SzammisztikaiSzam=ny4.SzammisztikaiSzam
				and ny1.SzammisztikaiSzam=ny5.SzammisztikaiSzam
			group by ny1.SzammisztikaiSzam
			order by count(ny1.SzammisztikaiSzam) desc ,ny1.SzammisztikaiSzam
			
			
-- Számmisztika vége


-- nyeroszamok a tipposzlopok hátterében látható számmal érintett számok között.

	-- '1-es ábra ,25,26,36,46,56,66,'
	-- '2-es ábra ,34,24,35,25,26,27,36,37,46,47,55,56,64,65,66,67,'
	-- '3-as ábra ,25,26,36,37,45,46,47,54,56,57,64,65,66,67,'
	-- '4-es ábra ,26,35,36,44,45,46,54,55,56,57,66,'
	-- '5-ös ábra ,25,26,34,35,36,44,45,46,47,54,57,64,65,66,67,'
	-- '6-os ábra ,25,26,36,37,45,46,47,56,57,64,65,66,67,'

-- 1-es ábra
	Print 'Ábra az 1-es tipposzlop hátterében - 25,26,36,46,56,66'
	declare @AbraString1 as varchar (max) = '1-es ábra ,25,26,36,46,56,66,'
	SELECT HuzasEve,HuzasHete
			 ,left(case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam1)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam2)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam3)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam4)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam5)as varchar)+'`' else '' end
			  ,20)
			  as `nyeroszamok az "1" ábrában`
			 , case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  as `Darab`
			from otosnyeroszamok
			where 
			(case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then 1 else 0 end)>2
			order by Darab desc,HuzasEve desc,HuzasHete desc
		Go

-- 2-es ábra		
	Print 'Ábra a 2-es tipposzlop hátterében - 34,24,35,25,26,27,36,37,46,47,55,56,64,65,66,67'
	declare @AbraString1 as varchar (max) = '2-es ábra ,34,24,35,25,26,27,36,37,46,47,55,56,64,65,66,67,'
	SELECT HuzasEve,HuzasHete
			 ,left(case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam1)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam2)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam3)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam4)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam5)as varchar)+'`' else '' end
			  ,20)
			  as `nyeroszamok a "2" ábrában`
			 , case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  as `Darab`
			from otosnyeroszamok
			where 
			(case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then 1 else 0 end)>2
			order by Darab desc,HuzasEve desc,HuzasHete desc
		Go		

-- 3-as ábra		
	Print 'Ábra a 3-as tipposzlop hátterében - 25,26,36,37,45,46,47,54,56,57,64,65,66,67'
	declare @AbraString1 as varchar (max) = '3-as ábra ,25,26,36,37,45,46,47,54,56,57,64,65,66,67,'
	SELECT HuzasEve,HuzasHete
			 ,left(case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam1)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam2)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam3)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam4)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam5)as varchar)+'`' else '' end
			  ,20)
			  as `nyeroszamok a "3" ábrában`
			 , case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  as `Darab`
			from otosnyeroszamok
			where 
			(case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then 1 else 0 end)>2
			order by Darab desc,HuzasEve desc,HuzasHete desc
		Go				

-- 4-es ábra 		
	Print 'Ábra a 4-es tipposzlop hátterében - 26,35,36,44,45,46,54,55,56,57,66'
	declare @AbraString1 as varchar (max) = '4-es ábra ,26,35,36,44,45,46,54,55,56,57,66,'
	SELECT HuzasEve,HuzasHete
			 ,left(case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam1)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam2)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam3)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam4)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam5)as varchar)+'`' else '' end
			  ,20)
			  as `nyeroszamok a "4" ábrában`
			 , case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  as `Darab`
			from otosnyeroszamok
			where 
			(case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then 1 else 0 end)>2
			order by Darab desc,HuzasEve desc,HuzasHete desc
		Go				

-- 5-ös ábra
	Print 'Ábra az 5-ös tipposzlop hátterében - 25,26,34,35,36,44,45,46,47,54,57,64,65,66,67'
	declare @AbraString1 as varchar (max) = '5-ös ábra ,25,26,34,35,36,44,45,46,47,54,57,64,65,66,67,'
	SELECT HuzasEve,HuzasHete
			 ,left(case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam1)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam2)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam3)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam4)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam5)as varchar)+'`' else '' end
			  ,20)
			  as `nyeroszamok az "5" ábrában`
			 , case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  as `Darab`
			from otosnyeroszamok
			where 
			(case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then 1 else 0 end)>2
			order by Darab desc,HuzasEve desc,HuzasHete desc
		Go				

	
	-- 
-- 6-os ábra
	Print 'Ábra a 6-os tipposzlop hátterében - 25,26,36,37,45,46,47,56,57,64,65,66,67'
	declare @AbraString1 as varchar (max) = '6-os ábra ,25,26,36,37,45,46,47,56,57,64,65,66,67,'
	SELECT HuzasEve,HuzasHete
			 ,left(case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam1)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam2)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam3)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam4)as varchar)+'`' else '' end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then '`'+cast(CONVERT(smallint,nyeroszam5)as varchar)+'`' else '' end
			  ,20)
			  as `nyeroszamok a "6" ábrában`
			 , case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  as `Darab`
			from otosnyeroszamok
			where 
			(case when charindex(','+cast(CONVERT(smallint,nyeroszam1)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam2)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam3)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam4)as varchar)+',',@AbraString1)<>0 then 1 else 0 end
			  +case when charindex(','+cast(CONVERT(smallint,nyeroszam5)as varchar)+',',@AbraString1)<>0 then 1 else 0 end)>2
			order by Darab desc,HuzasEve desc,HuzasHete desc
		Go				
