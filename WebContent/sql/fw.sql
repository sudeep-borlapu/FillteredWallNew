create table person(id int primary key auto_increment, uname varchar(40), fname varchar(40), lname varchar(40), gender varchar(1), email varchar(40), dob varchar(15),phone varchar(15), password varchar(40));
create table posts(pid int primary key auto_increment, body varchar(1000), id int, postdate varchar(15), posttime varchar(15), constraint `fk_post_person` foreign key(id) references person(id));
create table likes(lid int primary key auto_increment, pid int, id int, constraint `fk_likes_posts` foreign key(pid) references posts(pid), constraint `fk_likes_posts1` foreign key(id) references person(id), unique(pid,id));
create table comments(cid int primary key auto_increment, pid int, constraint `fk_comments_posts` foreign key(pid) references posts(pid));
create table friends(friendid int primary key auto_increment,sentfrom int, sentto int, fromdate timestamp, status varchar(20), unique(sentto,sentfrom), constraint `fk_freinds_person1` foreign key(sentfrom) references person(id),constraint `fk_friends_person2` foreign key(sentto) references person(id));
create table messages(mid int primary key auto_increment, msgfrom int, msgto int, tym timestamp conv_id int, constraint `fk_messages_con` foreign key(conv_id) references conversation(conv_id), constraint `fk_msgfrom_id` foreign key(msgfrom) references person(id), constraint `fk_msgto_id` foreign key(msgto) references person(id));
create table conversations(conv_id int primary key auto_increment, p1 int, p2 int, constraint `fk_conv_person1` foreign key(p1) references person(id), constraint `fk_conv_person2` foreign key(p2) references person(id), unique(p1,p2));

--to access a db from a remote station first u need to give the privilleges to the user with the ip address as below query

GRANT ALL PRIVILEGES ON db_base.* TO db_user @'ip_address' IDENTIFIED BY 'db_passwd';


-- retrieving last messages from all the conversations from their friends for side display in messages.jsp--
select * from messages where tym in (select max(tym) from messages where (msgfrom=6 and msgto in (<friends_list>)) or (msgto=6 and msgfrom in (<friends_list>)) group by conv_id) order by tym;