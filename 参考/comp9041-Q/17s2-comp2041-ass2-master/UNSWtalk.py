#!/usr/bin/python3
#!/web/cs2041/bin/python3.6.3
#test
# written by andrewt@cse.unsw.edu.au October 2017
# as a starting point for COMP[29]041 assignment 2
# https://cgi.cse.unsw.edu.au/~cs2041/assignments/UNSWtalk/

import os,copy
from flask import Flask, render_template, session,request,url_for
from collections import defaultdict
import re,shutil,time,random
import subprocess


# send_email funtion from piazza
def send_email(to, subject, message):
    mutt = [
            'mutt',
            '-s',
            subject,
            '-e', 'set copy=no',
            '-e', 'set realname=UNSWtalk',
            '--', to
    ]
    subprocess.run(
            mutt,
            input = message.encode('utf8'),
            stderr = subprocess.PIPE,
            stdout = subprocess.PIPE,
    )



students_dir = "static/dataset-medium";

app = Flask(__name__)
user = ""
database = defaultdict(dict)
posts = defaultdict(dict)
sorted_key = defaultdict(list)


# read every file needed and store into dict database and posts
# sort keys of posts in terms of time
def init():
    global database,user,posts,sorted_key
    database = defaultdict(dict)
    posts = defaultdict(dict)
    sorted_key = defaultdict(list)
    students = os.listdir(students_dir)
    raw_databse={
        "zid":"",
        "password":"",
        "full_name":"",
        "program":"",
        "birthday":"",
        "email":"",
        "home_suburb":"",
        "home_latitude":"",
        "home_longitude":"",
        "request":[""],
        "friends":[""],
        "courses":[""],
        "text":""
    }
    raw_posts={
        "raw":"",
        "message":"",
        "from":"",
        "time":"",
        "latitude":"",
        "longitude":""
    }
    for student in students:
        database[student] = copy.deepcopy(raw_databse)
        details_filename = os.path.join(students_dir, student, "student.txt")
        with open(details_filename) as f:
            details = f.readlines()
            for line in details:
                if re.match("^zid: (.*)\n",line):
                    obj = re.match("^zid: (.*)\n",line)
                    database[student]["zid"] = obj.group(1)
                elif re.match("^password: (.*)\n",line):
                    obj = re.match("^password: (.*)\n",line)
                    database[student]["password"] = obj.group(1)
                elif re.match("^full_name: (.*)\n",line):
                    obj = re.match("^full_name: (.*)\n",line)
                    database[student]["full_name"] = obj.group(1)
                elif re.match("^program: (.*)\n",line):
                    obj = re.match("^program: (.*)\n",line)
                    database[student]["program"] = obj.group(1)
                elif re.match("^birthday: (.*)\n",line):
                    obj = re.match("^birthday: (.*)\n",line)
                    database[student]["birthday"] = obj.group(1)
                elif re.match("^text: (.*)\n",line):
                    obj = re.match("^text: (.*)\n",line)
                    database[student]["text"] = obj.group(1)
                elif re.match("^email: (.*)\n",line):
                    obj = re.match("^email: (.*)\n",line)
                    database[student]["email"] = obj.group(1)
                elif re.match("^home_suburb: (.*)\n",line):
                    obj = re.match("^home_suburb: (.*)\n",line)
                    database[student]["home_suburb"] = obj.group(1)
                elif re.match("^home_latitude: (.*)\n",line):
                    obj = re.match("^home_latitude: (.*)\n",line)
                    database[student]["home_latitude"] = obj.group(1)
                elif re.match("^home_longitude: (.*)\n",line):
                    obj = re.match("^home_longitude: (.*)\n",line)
                    database[student]["home_longitude"] = obj.group(1)
                elif re.match("^friends: (.*)\n",line):
                    obj = re.match("^friends: \((.*)\)\n",line)
                    database[student]["friends"] = re.split(", ",obj.group(1))
                elif re.match("^courses: (.*)\n",line):
                    obj = re.match("^courses: \((.*)\)\n",line)
                    database[student]["courses"] = re.split(", ",obj.group(1))
                elif re.match("^request: (.*)\n",line):
                    obj = re.match("^request: \((.*)\)\n",line)
                    database[student]["request"] = re.split(", ",obj.group(1))
        for file in os.listdir(os.path.join(students_dir, student)):
            if re.match(r"\d+(-\d+)*\.txt$",file):
                key = tuple(file.split(".")[0].split("-"))
                if key not in posts[student]:
                    posts[student][key] = copy.deepcopy(raw_posts)
                    posts[student][key]['raw'] = file.split(".")[0]
                posts_filename = os.path.join(students_dir, student, file)
                with open(posts_filename) as f:
                    content = f.readlines()
                    for line in content:
                        if re.match("^message: (.*)\n",line):
                            obj = re.match("^message: (.*)\n",line)
                            message = re.sub("\\\\n","\n",obj.group(1))
                            posts[student][key]['message'] = message
                        elif re.match("^from: (.*)\n",line):
                            obj = re.match("^from: (.*)\n",line)
                            posts[student][key]['from'] = obj.group(1)
                        elif re.match("^time: (.*)\n",line):
                            obj = re.match("^time: (.*)\n",line)
                            time = re.sub(r"T"," ",obj.group(1))
                            time = re.sub(r"\+.*","",time)
                            posts[student][key]['time'] = time
                        elif re.match("^latitude: (.*)\n",line):
                            obj = re.match("^latitude: (.*)\n",line)
                            posts[student][key]['latitude'] = obj.group(1)
                        elif re.match("^longitude: (.*)\n",line):
                            obj = re.match("^longitude: (.*)\n",line)
                            posts[student][key]['longitude'] = obj.group(1)
    for student in posts:
        for key in posts[student]:
            if "message" in posts[student][key]:
                message = posts[student][key]['message']
                patterns = re.findall("z\d{7}",message)
                for pattern in set(patterns):
                    if pattern in database.keys():
                        message = re.sub(pattern,'<a href = "/{0}">{1}</a>'.format(pattern,database[pattern]["full_name"]),message)
                        posts[student][key]['message'] = message
    tmplist = [(student, key) for student in posts for key in posts[student]]
    sorted_key = sorted(tmplist, key=lambda x: posts[x[0]][x[1]]['time'], reverse=True)


# reWrite data of a student from database to directory
def reWrite(student):
    global database
    details_filename = os.path.join(students_dir, student, "student.txt")
    with open(details_filename,"w") as f:
        f.write("zid: {}\n".format(database[student]['zid']))
        f.write("password: {}\n".format(database[student]['password']))
        f.write("full_name: {}\n".format(database[student]['full_name']))
        f.write("birthday: {}\n".format(database[student]['birthday']))
        f.write("email: {}\n".format(database[student]['email']))
        f.write("home_suburb: {}\n".format(database[student]['home_suburb']))
        f.write("home_latitude: {}\n".format(database[student]['home_latitude']))
        f.write("home_longitude: {}\n".format(database[student]['home_longitude']))
        f.write("text: {}\n".format(database[student]['text']))
        f.write("program: {}\n".format(database[student]['program']))
        f.write("friends: ({}".format(database[student]['friends'][0]))
        for word in database[student]['friends'][1:]:
            f.write(", {}".format(word))
        f.write(")\n")
        f.write("request: ({}".format(database[student]['request'][0]))
        for word in database[student]['request'][1:]:
            f.write(", {}".format(word))
        f.write(")\n")
        f.write("courses: ({}".format(database[student]['courses'][0]))
        for word in database[student]['courses'][1:]:
            f.write(", {}".format(word))
        f.write(")\n")


# start page
# clear session when linked to stat page
@app.route('/', methods=['GET','POST'])
def home():
    global database,user,posts,sorted_key,students_dir
    init()
    user = ''
    session['user'] = user
    session['students_dir'] = students_dir
    # session['sorted_key'] = sorted_key
    return render_template('start.html')

# clear session when linked to start page
@app.route('/start', methods=['GET','POST'])
def start():
    global database,user,posts,sorted_key
    init()
    user = ''
    session['user'] = user
    return render_template('start.html')


# login page
@app.route('/login', methods=['GET','POST'])
def login():
    global database,user,posts,sorted_key
    init()
    user = session.get('user','')
    if user:  # direct to user's home page if already logged in
        return render_template('mainpage.html', zid=user, database=database, students_dir=students_dir, \
    user=user, posts=posts,sorted_key=sorted_key)
    if not database:
        init()
    if request.method == "GET":   # show sign in form when method is method
        return render_template('login.html')
    zid = request.form.get('zid', '')
    password = request.form.get('password', '')
    if zid not in database:
        return render_template('login.html', error = "Not valid user!")
    if database[zid]["password"] != password:
        return render_template('login.html', error = "Incorrect password!")
    user = zid
    session['user'] = user
    return render_template('mainpage.html', zid=zid, database=database, students_dir=students_dir, \
user=user, posts=posts,sorted_key=sorted_key)


# student's personal page diplaying user's own posts, details, friends's posts, friend list
# users can add or remove or accept friend on mainpage
@app.route('/<string:zid>', methods=['GET','POST'])
def mainpage(zid):
    global database,user,posts,sorted_key
    init()
    user = session.get('user','')
    if not user:    # direct to start page if try to access someone's page while have't logged in
        return render_template('start.html')
    if request.method == "POST":    # make post
        post_text = request.form.get('post_text','')
        post_text='%r'%post_text
        post_text = post_text[1:-1].replace(r"\r\n",r"\n")
        i = -1
        while True:
            i += 1
            newkey = (str(i),)
            if newkey not in posts[user]:
                break
        file_name = os.path.join(students_dir, user, str(i) +".txt")
        time_text = time.strftime("%Y-%m-%dT%H:%M:%S+0000", time.localtime())
        with open(file_name,'a') as f:
            f.write("message: "+ post_text + "\n")
            f.write("time: "+ time_text + "\n")
            f.write("from: "+ user + "\n")
        init()
    return render_template('mainpage.html', zid = zid,database = database,students_dir = students_dir,\
user=user, posts=posts,sorted_key=sorted_key)


#  search page
#  will show both student and posts which match the input pattern
@app.route('/search', methods=['POST'])
def search():
    global database,user,posts,sorted_key
    init()
    user = session.get('user','')
    result = []
    post_result=[]
    if not user:
        return render_template('start.html')
    pattern = request.form.get('pattern')
    if pattern:
        # search student (ignore case)
        for key in database:
            if re.search(pattern, key,flags=re.I) or re.search(pattern,database[key]['full_name'],flags = re.I):
                result.append(key)
        # search posts (ignore case)
        for student,key in sorted_key:
            if 'message' in posts[student][key] and re.search(pattern,posts[student][key]['message'],flags=re.I):
                from_zid = posts[student][key]['from']
                post_result.append((student,key,from_zid))
    return render_template('search.html', pattern = pattern,database=database,students_dir = students_dir,\
result=result,user=user,posts=posts, post_result=post_result)

# search user's own posts
# access is in home page
@app.route('/MPosts/<zid>', methods=['POST'])
def MPosts(zid):
    global database,user,posts,sorted_key
    init()
    user = session.get('user','')
    result = []
    if not database:
        init()
    if not user:
        return render_template('start.html')
    pattern =request.form.get('pattern', '')
    if pattern:
        for key in posts[zid]:
            if "message" in posts[zid][key] and re.search(pattern, posts[zid][key]['message'],flags=re.I):
                result.append(key)
    return render_template('MPosts.html', pattern = pattern,database=database,students_dir = students_dir,\
result=result,user=zid,sorted_key=sorted_key,posts=posts)

# search user's friends' posts
# access is in home page
@app.route('/FPosts/<zid>', methods=['POST'])
def FPosts(zid):
    global database,user,posts,sorted_key
    init()
    user = session.get('user','')
    result = []
    if not user:
        return render_template('start.html')
    pattern =request.form.get('pattern', '')
    if pattern:
        for student,key in sorted_key:
            if student in database[zid]["friends"] and "message" in posts[student][key] and re.search(pattern, posts[student][key]['message'],flags=re.I):
                result.append((student,key))
    return render_template('FPosts.html', pattern = pattern,database=database,students_dir = students_dir,\
result=result,user=zid,sorted_key=sorted_key,posts=posts)

# notification page
# show posts which @user in the content
@app.route('/notifications', methods=['GET','POST'])
def notifications():
    global database,user,posts,sorted_key
    init()
    user = session.get('user','')
    result = []
    if not user:
        return render_template('start.html')
    pattern = user
    if pattern:
        for student,key in sorted_key:
            if "message" in posts[student][key] and re.search(pattern, posts[student][key]['message'],flags=re.I):
                result.append((student,key))
    return render_template('notifications.html', pattern = pattern,database=database,students_dir = students_dir,\
result=result,user=user,sorted_key=sorted_key,posts=posts)


# page showing replys of a particular post or replay
# in which user can reply the reply or linked to the up level of the reply
@app.route('/replys/<comment_key>', methods=['GET','POST'])
def replys(comment_key):    #ie. comment_key=z5555555_1-1-1
    global database,user,posts,sorted_key,students_dir
    init()
    user = session.get('user','')
    if not user:
        return render_template('start.html')
    reply_zid,key = comment_key.split("_")  #ie. reply_zid=z555555 key=1-1-1
    reply_key = tuple(key.split("-"))   #ie. reply_key=(1,1,1)
    backward = reply_zid + "_" + str(reply_key[0])
    for n in reply_key[1:-1]:
        backward += ("-" + str(n))
    if request.method == "POST":    #   user replys to reply
        reply_text = request.form.get('reply_text','')
        reply_text='%r'%reply_text
        reply_text = reply_text[1:-1].replace(r"\r\n",r"\n")
        i = -1
        while True:
            i += 1
            newkey = tuple(key.split("-") + [str(i)])
            if newkey not in posts[reply_zid]:
                break
        file_name = os.path.join(students_dir, reply_zid, key + "-" + str(i) +".txt")
        time_text = time.strftime("%Y-%m-%dT%H:%M:%S+0000", time.localtime())
        with open(file_name,'a') as f:
            f.write("message: "+ reply_text + "\n")
            f.write("time: "+ time_text + "\n")
            f.write("from: "+ user + "\n")
        init()
    return render_template('replys.html',database = database,students_dir = students_dir,\
user=user, posts=posts,sorted_key=sorted_key,reply_zid = reply_zid, reply_key=reply_key,backward=backward)

# sign up page
# in which check zid email full_name and password to sign up for a new user
@app.route('/signup', methods=['GET','POST'])
def signup():
    global database,user,posts,sorted_key
    init()
    user = session.get('user','')
    error = {'zid':0, 'email':0, 'password':0}
    if request.method == "GET":
        return render_template('signup.html',error = error)
    # elif method is POST
    zid = request.form.get('zid','')
    email = request.form.get('email','')
    full_name = request.form.get('full_name','')
    password_a = request.form.get('password_a','')
    password_b = request.form.get('password_b','')
    if not re.match("z\d{7}",zid):
        error['zid'] = 1
    if zid in database:
        error['zid'] = 2
    error['email'] = 0 if re.match("[a-zA-Z_0-9]+@[a-zA-Z_0-9]+(\.[a-zA-Z_0-9]+)+",email) else 1 # check email in format xxx@xxx(.xxx)+
    error['password'] = 0 if password_a == password_b else 1
    if error == {'zid':0, 'email':0, 'password':0}:
        directory = os.path.join(students_dir, zid)
        if not os.path.exists(directory):
            os.makedirs(directory)
        with open(os.path.join(directory, "student.txt"),"w") as f:
            f.write("zid: {}\n".format(zid))
            f.write("full_name: {}\n".format(full_name))
            f.write("email: {}\n".format(email))
            f.write("password: {}\n".format(password_a))
        url = url_for('home', _external=True)+"success"
        send_email(email,"UNSWtalk registration confirm email","Link to start your UNSWtalk!\n" + url) #send comfirm email
        return(render_template('success.html',flag = True))
    return(render_template('signup.html',error = error))


# show signup success or not
@app.route('/success', methods=['GET','POST'])
def success():
    global database,user,posts,sorted_key
    init()
    user = ''
    session['user'] = user
    return(render_template('success.html'))

# page to edit profile
@app.route('/profile', methods=['GET','POST'])
def profile():
    global database,user,posts,sorted_key,students_dir
    init()
    user = session.get('user','')
    if not user:
        return render_template('start.html')
    if request.method == "POST":
        text = request.form.get('text','')
        full_name = request.form.get('full_name','')
        birthday = request.form.get('birthday','')
        home_suburb = request.form.get('home_suburb','')
        program = request.form.get('program','')
        database[user]['full_name'] = full_name
        database[user]['birthday'] = birthday
        database[user]['home_suburb'] = home_suburb
        database[user]['program'] = program
        database[user]['text'] = text
        reWrite(user)
        init()
    return(render_template('profile.html', database=database, user=user,students_dir=students_dir))


# page to view friend request, friend suggestion and friend list.
@app.route('/friends', methods=['GET','POST'])
def friends():
    global database,user,posts,sorted_key,students_dir
    init()
    result=[]
    user = session.get('user','')
    for student in database:
        if student != user and student not in database[user]['friends']:
            if database[user]['home_suburb'] == database[student]['home_suburb'] or \
            len(database[user]['courses'] + database[student]['courses']) != len(set(database[user]['courses'] \
            + database[student]['courses'])) or database[user]['program'] == database[student]['program']:
                result.append(student)
    if not user:
        return render_template('start.html')
    return(render_template('friends.html', database=database, user=user,students_dir=students_dir,result=result))


# show friend removed
@app.route('/remove/<zid>', methods=['GET','POST'])
def remove(zid):
    global database,user,posts,sorted_key,students_dir
    init()
    user = session.get('user','')
    if not user:
        return render_template('start.html')
    try:
        database[user]['friends'].remove(zid)
    except:
        pass
    try:
        database[zid]['friends'].remove(user)
    except:
        pass
    reWrite(zid)
    reWrite(user)
    init()
    return(render_template('remove.html', database=database, user=user,students_dir=students_dir))


# show friend added
@app.route('/add/<zid>', methods=['GET','POST'])
def add(zid):
    global database,user,posts,sorted_key,students_dir
    init()
    user = session.get('user','')
    if not user:
        return render_template('start.html')
    try:
        send_email(database[zid]['email'],'Someon add you on UNSWtalk!',\
    '{} sended you a friend request.\n{}'.format(database[user]['full_name'], url_for('home', _external=True)))
    except:
        pass
    try:
        if user not in database[zid]['request']:
            database[zid]['request'].append(user)
    except:
        pass
    reWrite(zid)
    init()
    return(render_template('remove.html', database=database, user=user,students_dir=students_dir))


# show friend accepted
@app.route('/accept/<zid>', methods=['GET','POST'])
def accept(zid):
    global database,user,posts,sorted_key,students_dir
    init()
    user = session.get('user','')
    if not user:
        return render_template('start.html')
    try:
        database[user]['request'].remove(zid)
        database[user]['friends'].append(zid)
        database[zid]['friends'].append(user)
    except:
        pass
    reWrite(zid)
    reWrite(user)
    init()
    return(render_template('remove.html', database=database, user=user,students_dir=students_dir))


# page to enter zid to recovery password
@app.route('/recovery', methods=['GET','POST'])
def recovery():
    global database,user,posts,sorted_key,students_dir
    init()
    return(render_template('recovery.html', database=database, user=user,students_dir=students_dir))


# page to recovery password of a particular
@app.route('/recovery_done', methods=['GET','POST'])
def recovery_done():
    global database,user,posts,sorted_key,students_dir
    init()
    zid = request.form.get('zid','')
    try:    # use try here to avoid evil or mistyped input
        new = ''
        for i in range(8):
            new += str(random.randint(0,9)) # new password is a random eight-digit number
        send_email(database[zid]['email'],"Password Recoveried","Your new password is " + new)
        database[zid]['password'] = new
        reWrite(zid)
    except:
        return (render_template('recovery.html', database=database, user=user,students_dir=students_dir))
    return(render_template('recovery_done.html'))


if __name__ == '__main__':
    app.secret_key = os.urandom(12)
    app.run(debug=True, use_reloader = True)
