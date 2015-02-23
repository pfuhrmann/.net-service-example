USE comp1688;

-- http://stackoverflow.com/questions/155246/how-do-you-truncate-all-tables-in-a-database-using-tsql
-- disable all constraints
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"
-- delete data in all tables
EXEC sp_MSForEachTable "DELETE FROM ?"
-- enable all constraints
EXEC sp_msforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"

INSERT INTO [dbo].[Sitters]
 ([FirstName]
 ,[LastName]
 ,[Email]
 ,[Phone])
VALUES
	('Homer' ,'Kimberlyn', 'test1@gmail.com', '+4474545485'),
	('Lynette' ,'Jervis', 'test2@gmail.com', '+4474545485'),
	('Elton' ,'Brock', 'test3@gmail.com', '+4474545485'),
	('Des' ,'Lecia', 'test4@gmail.com', '+4474545485'),
	('Gil' ,'Jonie', 'test5@gmail.com', '+4474545484'),
	('Ida' ,'Barb', 'test6@gmail.com', '+4474545484'),
	('Breanne' ,'Jarrod', 'test7@gmail.com', '+4474545484'),
	('Garfield' ,'Debbie', 'test8@gmail.com', '+4474545484'),
	('Sybil' ,'Dahlia', 'test9@gmail.com', '+4474545484'),
	('Danica' ,'Polly', 'test10@gmail.com', '+4474545484')
GO

INSERT INTO [dbo].[Services]
 ([Sitter_id]
 ,[Type]
 ,[Location]
 ,[Availability]
 ,[Description]
 ,[Charges])
VALUES
	(1 ,'babysitter', 'Lewisham A', 'monday, tuesday', 'Phasellus eu diam viverra sem pretium mattis non eu diam. Ut tempus odio eget est bibendum, eget viverra turpis ullamcorper. Integer a justo nisi. Nulla in consectetur justo. Nulla in egestas tortor, ac condimentum massa. Morbi eleifend enim facilisis purus efficitur consequat. Fusce ante enim, laoreet vitae ullamcorper sit amet, gravida vitae enim. Phasellus malesuada sed orci placerat convallis.', '8'),
	(1 ,'petsitter', 'Lewisham Z', 'tuesday, wednesday', 'Nam sodales pellentesque magna. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nunc urna lectus, imperdiet quis lectus pulvinar, fringilla lacinia nunc. Nunc viverra velit at imperdiet feugiat. Sed urna augue, ornare ac eleifend vitae, placerat quis tellus. Donec lacinia sagittis dui. Fusce suscipit quam non nisi ultrices, id faucibus nibh egestas. Ut at quam mi. Nunc tincidunt molestie rhoncus. Ut convallis lacinia interdum. Duis ac leo dictum, maximus lacus eget, suscipit urna.', '8.3'),
	(2 ,'grannysitter', 'Lewisham D', 'tuesday, wednesday', 'Morbi id pharetra libero, nec pellentesque ligula. Aenean ut odio et nulla lobortis euismod. Sed dapibus, elit ac ultrices auctor, ligula massa hendrerit justo, quis pretium ante mauris tincidunt magna. Donec quis eros aliquam, tincidunt risus vel, blandit purus. Ut condimentum sollicitudin lorem ut rutrum. Sed varius elementum elementum. Quisque quis arcu ut neque ultricies pretium. Morbi in magna scelerisque, pharetra ligula ac, finibus velit. Aenean fermentum finibus arcu, eget faucibus elit congue ut. Aliquam vel aliquet nulla. Quisque a sagittis elit, convallis varius diam. Pellentesque sit amet mollis urna. Nullam posuere erat quis elit hendrerit faucibus. Aenean vitae erat aliquet velit interdum maximus. Pellentesque vehicula luctus facilisis.', '7'),
	(3 ,'petsitter', 'Lewisham B', 'wednesday', 'Praesent luctus orci eget augue tincidunt, in placerat ligula hendrerit. Vestibulum at justo non urna fringilla ornare. Sed eu leo porta, dignissim quam in, finibus nisl. Aenean ante dolor, ornare nec molestie ut, semper in neque. Sed a mollis arcu, quis vehicula mauris. Etiam et ullamcorper massa, nec imperdiet quam. Pellentesque rutrum ac est nec egestas.', '8.5'),
	(4 ,'housesitter', 'Lewisham D', 'monday', 'Praesent laoreet erat eget nisl maximus, ac dapibus ipsum mollis. Nullam semper egestas eros, at tristique quam rutrum sit amet. Aliquam suscipit justo in ultricies sollicitudin. Morbi dictum condimentum leo fringilla luctus. Maecenas dictum faucibus mauris vitae pulvinar. Phasellus luctus magna magna. Ut vel nulla est. Curabitur consectetur, velit a dictum laoreet, libero lacus dapibus ante, vel posuere sem mauris ut sem. Fusce eros tellus, aliquam sed sollicitudin non, consequat non lorem. Donec rhoncus, magna in malesuada egestas, tellus sem interdum arcu, non condimentum turpis risus vel ipsum. Aliquam erat volutpat. Interdum et malesuada fames ac ante ipsum primis in faucibus.', '10'),
	(4 ,'petsitter', 'Lewisham D', 'friday', 'Nulla lobortis bibendum consequat. Donec pretium ex in mi tempor laoreet. Curabitur semper lectus sed est imperdiet, nec rutrum odio vulputate. Donec molestie mi nibh, vitae maximus mi lobortis vitae. Cras eleifend, nisl vel faucibus elementum, magna sem viverra leo, sit amet cursus mauris nulla id tellus. Sed vitae elit maximus, scelerisque ipsum in, ullamcorper dolor. Fusce ornare nisi ut diam interdum, vitae gravida urna vehicula. Aenean venenatis justo id posuere ultricies. Quisque dui sapien, dignissim ac lorem sed, sagittis finibus ligula. Suspendisse tincidunt, nunc quis convallis ultricies, tortor odio eleifend est, in rhoncus erat augue id dui. Sed feugiat nisl vel urna fringilla facilisis. Mauris et facilisis metus. Vestibulum dictum tortor ligula, at efficitur ligula hendrerit ut. Donec sodales egestas interdum. Integer luctus sem vel sapien posuere, id pulvinar arcu ultricies. Phasellus id tempor enim.', '12'),
	(5 ,'babysitter', 'Lewisham Z', 'weekend', 'Suspendisse ac dolor vel urna semper hendrerit a eu elit. Pellentesque commodo sapien nec enim vestibulum finibus. Maecenas mollis pretium orci quis ornare. Proin pulvinar consectetur consequat. Curabitur massa erat, volutpat eget scelerisque id, pharetra a sapien. Nunc justo sem, efficitur quis pretium a, fringilla in sapien. Donec vehicula augue id placerat mattis. Ut sollicitudin turpis iaculis leo blandit ornare. Etiam vel sapien vitae risus malesuada imperdiet sagittis non eros. Cras sagittis dolor et sapien tempus, a eleifend lorem mollis. Aenean nec tellus mattis, tempor elit a, dignissim justo. Praesent venenatis orci nec posuere aliquet. Duis vitae ipsum sed nulla fermentum euismod. Vivamus mauris massa, sagittis eget mi sit amet, pulvinar aliquet urna. Sed semper massa at turpis viverra fermentum.', '8.6'),
	(6 ,'grannysitter', 'Lewisham A', 'monday, friday', 'TNunc vestibulum nulla quis risus iaculis rutrum. Aliquam vel efficitur diam, eget tempus nisl. Suspendisse placerat libero ac eros pulvinar, quis suscipit quam accumsan. Pellentesque convallis lacus vel velit viverra, eu viverra purus pretium. Quisque non porta lectus. Mauris eu neque rhoncus risus vestibulum blandit et vitae velit. In vehicula, neque nec pellentesque faucibus, massa ipsum consequat lectus, a rhoncus lorem nunc in libero. Donec vitae scelerisque lorem, et fermentum dui. Nam vel tellus congue, consequat purus ut, accumsan nibh. Quisque at porta felis. Morbi quis porttitor nisl, non bibendum nulla. Vestibulum in tristique leo. Mauris porttitor aliquet consequat. Nulla quis sem mauris. Suspendisse id enim ac urna mattis porta.', '11'),
	(7 ,'babysitter', 'Lewisham Z', 'weekend', 'Sed euismod diam sit amet nibh pharetra porta. Sed auctor orci erat, vel porttitor lectus sollicitudin sed. Ut sodales sapien ac dui laoreet pharetra. Sed eu commodo diam, id accumsan elit. Suspendisse a leo nec eros aliquet placerat quis vel metus. Aliquam fermentum pharetra sodales. Etiam in lectus turpis.', '9.3'),
	(5 ,'babysitter', 'Lewisham Z', 'wednesday', 'Sed a mauris quis enim ultrices auctor. Integer pellentesque mauris dolor, ac ullamcorper orci gravida vitae. Aenean dignissim faucibus massa. Maecenas semper, ante id tristique suscipit, nulla ipsum ultrices leo, sed bibendum lacus magna pretium ex. Cras tellus orci, vehicula in aliquet id, lacinia imperdiet nulla. Aliquam pulvinar sed felis sit amet varius. Proin condimentum scelerisque nunc vel volutpat. Nam imperdiet accumsan bibendum. Nunc eu elit sed risus aliquam dignissim eget quis est. Ut porta bibendum nulla sit amet laoreet. Nullam ut cursus nibh, vitae aliquet lorem. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nullam in lorem venenatis tellus viverra mattis eu non ex.', '15')
GO

INSERT INTO [dbo].[Images]
 ([Service_Id]
 ,[Code])
VALUES
	(1 ,'http://media4.popsugar-assets.com/files/2013/06/19/700/n/1922664/772994b82620c65e_Babysitter.xxxlarge/i/How-Hire-Babysitter-Vacation.jpg'),
	(1 ,'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTPjKI5Ww087Yt0HM16cnajPeMBnmBmjOc1N23r4HObc91WQWOO'),
	(2 ,'http://2.bp.blogspot.com/_Sog5JsjlJ6s/TP0uEissQXI/AAAAAAAAAAc/8XnETZo0hVg/S1600-R/pet-sitter.jpg'),
	(2 ,'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQM4e_pmLeqcs63cxUYDDi2VDoDG9_5nou2TFYq1yVBDaBHVylR'),
	(2 ,'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQSBfafDrifKCxDGZXq3Vrp5KJ2KWY6ilhFEBbUXy21ADYvivM9'),
	(3 ,'http://static.guim.co.uk/sys-images/Society/Comment/Columnist/2012/3/2/1330713290501/Ivy-Gunn-with-sitter-Step-007.jpg'),
	(3 ,'http://www.homeinstead.co.uk/edinburgh/1896.do/uploads/_NEWS/5138dce027fba3.29928645.jpg'),
	(7 ,'http://media4.popsugar-assets.com/files/2013/06/19/700/n/1922664/772994b82620c65e_Babysitter.xxxlarge/i/How-Hire-Babysitter-Vacation.jpg'),
	(7 ,'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTPjKI5Ww087Yt0HM16cnajPeMBnmBmjOc1N23r4HObc91WQWOO'),
	(4 ,'http://2.bp.blogspot.com/_Sog5JsjlJ6s/TP0uEissQXI/AAAAAAAAAAc/8XnETZo0hVg/S1600-R/pet-sitter.jpg'),
	(4 ,'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQM4e_pmLeqcs63cxUYDDi2VDoDG9_5nou2TFYq1yVBDaBHVylR'),
	(4 ,'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQSBfafDrifKCxDGZXq3Vrp5KJ2KWY6ilhFEBbUXy21ADYvivM9'),
	(6 ,'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQM4e_pmLeqcs63cxUYDDi2VDoDG9_5nou2TFYq1yVBDaBHVylR'),
	(6 ,'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQSBfafDrifKCxDGZXq3Vrp5KJ2KWY6ilhFEBbUXy21ADYvivM9'),
	(8 ,'http://static.guim.co.uk/sys-images/Society/Comment/Columnist/2012/3/2/1330713290501/Ivy-Gunn-with-sitter-Step-007.jpg'),
	(8 ,'http://www.homeinstead.co.uk/edinburgh/1896.do/uploads/_NEWS/5138dce027fba3.29928645.jpg')
GO
