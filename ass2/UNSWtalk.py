#!/web/cs2041/bin/python3.6.3

# written by Xiang Zhang October 2017
# COMP[29]041 assignment 2
# https://cgi.cse.unsw.edu.au/~cs2041/assignments/UNSWtalk/

import os, re, glob, collections
from PIL import Image
from flask import Flask, render_template, session, request, redirect, url_for, flash
from datetime import datetime

students_dir = "dataset-medium";

app = Flask(__name__)

# Show unformatted details for student "n"
# Increment n and store it in the session cookie

@app.route('/', methods=['GET','POST'])
def begin():
       return render_template('login.html')
@app.route('/login', methods=['POST'])
def login():
    zid = request.form.get('zid', '')
    password = request.form.get('password', '')
    #zid = re.sub(r'\D', '', zid)
    password_filename = os.path.join(students_dir, zid, "student.txt")
    if os.path.exists(password_filename):
        for line in open(password_filename):
            if re.match(r"password", line):
                correct_password = re.sub(r'password: ', '', line)
                correct_password = re.sub(r'\n', '', correct_password)
        if correct_password == password:
            authenticated = 1
            return redirect(url_for('start'))
            return redirect(url_for('profile', zid=zid))
        #return render_template('start.html', authenticated=authenticated)

	# the password is wrong

        else:
            return render_template('login.html', message="Wrong password!")
	
	#the zid is wrong

    else:
        return render_template('login.html', message="Wrong zid!")

#logout module

@app.route('/logout')
def logout():
    return render_template('login.html')

@app.route('/start', methods=['GET','POST'])
def start():
    n = session.get('n', 0)
    students = sorted(os.listdir(students_dir))
    student_to_show = students[n % len(students)]
    details_filename = os.path.join(students_dir, student_to_show, "student.txt")
    #with open(details_filename) as f:
        #lines = f.readline()

	#hide the private information

    for line in open(details_filename):
        if re.match(r"e-mail", line):
            e_mail = ''
        if re.match(r"password", line):
            password = ''
        if re.match(r"home_lattitude", line):
            lattitude = ''
        if re.match(r"home_longitude", line):
            longitude = ''
        if re.match(r"courses", line):
            courses = ''
        if re.match(r"program", line):
            program = line
        if re.match(r"full_name", line):
            full_name = line;
        if re.match(r"zid", line):
            zid = line
        if re.match(r"home_suburb", line):
            home = line
        else:
            home = ''
        if re.match(r"birthday", line):
            birthday = line
        if re.match(r"friends", line):
            friends = line

	#get the zid of friends

            friends_zid = line
            friends_zid = re.sub(r'friends: \(', '', friends_zid)
            friends_zid = re.sub(r'\)', '', friends_zid)
            friends_zid = re.sub(r' ', '', friends_zid)
            friends_zid = re.sub(r'\n', '', friends_zid)
            friends_zids = friends_zid.split(',')

	#display the image of the student

    images_filename = os.path.join(students_dir, student_to_show, "img.jpg") 
    try:
         #images = Image.open(images_filename)
        with open(images_filename) as file:
            images = images_filename
    except IOError:
        images = ''

	#display the name and the thumbnail image of the friend

    friends_list = collections.OrderedDict()
    for zid in friends_zids:
        name_filename = os.path.join(students_dir, zid, "student.txt")
    for id in friends_zids:
        name_filename = os.path.join(students_dir, id, "student.txt")
        for line in open(name_filename):
            if re.match(r"full_name", line):
                friend_name = re.sub(r'full_name: ', '', line)
                friends_list[zid] = {'name': friend_name}
                friends_list[id] = {'name': friend_name}

	#show the post in reverse chronological order

    post = []
    post = collections.OrderedDict()
    path_filename = os.path.join(students_dir, student_to_show)
    for path in sorted(glob.glob(path_filename+"/[0-9].txt")):
        with open(path) as f:
            content = f.read()
            post.append(content)
    for n in range(0,100):
        try:
            for path in glob.glob(path_filename+"/"+str(n)+".txt"):
                for line in open(path):
                    if re.match(r"from", line):
                        zid = re.sub(r'from: ', '', line)
                    if re.match(r"message", line):
                        message = line
                    if re.match(r"time", line):
                        time = line
                post[n] = {'from': zid, 'message': message, 'time': time}
        except IOError:
            post[n] = ''
            zid = ''
            message = ''
            time = ''
    name = re.sub(r'full_name: ', '', full_name)
    session['n'] = n + 1
    authenticated = 1

    return render_template('start.html', student_fullname=full_name, student_program=program, 
					 student_zid=zid, student_home=home, 
					 student_birthday=birthday, student_images=images, 
					 post=post, friends_list=friends_list, 
					 authenticated=authenticated)
					 authenticated=authenticated, name=name)

#Clicking on the image and/or name should take you to that UNSWtalk page.

@app.route('/profile/<path:zid>', methods=['GET', 'POST'])
def profile(zid=''):
    details_filename = os.path.join(students_dir, zid, "student.txt")

    details_filename = os.path.join(students_dir, zid, "student.txt")
    #print(zid)
        #hide the private information

    for line in open(details_filename):
        if re.match(r"e-mail", line):
            e_mail = ''
        if re.match(r"password", line):
            password = ''
        if re.match(r"home_lattitude", line):
            lattitude = ''
        if re.match(r"home_longitude", line):
            longitude = ''
        if re.match(r"courses", line):
            courses = ''
        if re.match(r"program", line):
            program = line
        if re.match(r"full_name", line):
            full_name = line;
        if re.match(r"home_suburb", line):
            home = line
        else:
            home = ''
        if re.match(r"birthday", line):
            birthday = line
        if re.match(r"friends", line):
            friends = line

        #get the zid of friends

            friends_zid = line
            friends_zid = re.sub(r'friends: \(', '', friends_zid)
            friends_zid = re.sub(r'\)', '', friends_zid)
            friends_zid = re.sub(r' ', '', friends_zid)
            friends_zid = re.sub(r'\n', '', friends_zid)
            friends_zids = friends_zid.split(',')

        #display the image of the student

    images_filename = os.path.join(students_dir, zid, "img.jpg")
    try:
        with open(images_filename) as file:
            images = images_filename
    except IOError:
        images = ''

        #display the name and the thumbnail image of the friend

    friends_list = collections.OrderedDict()
    for id in friends_zids:
        name_filename = os.path.join(students_dir, id, "student.txt")
        for line in open(name_filename):
            if re.match(r"full_name", line):
                friend_name = re.sub(r'full_name: ', '', line)
                friends_list[id] = {'name': friend_name}

        #show the post in reverse chronological order

    post = []
    post = collections.OrderedDict()
    path_filename = os.path.join(students_dir, zid)
    for path in sorted(glob.glob(path_filename+"/[0-9].txt")):
        with open(path) as f:
            content = f.read()
            post.append(content)
    for n in range(0,100):
        try:
            for path in glob.glob(path_filename+"/"+str(n)+".txt"):
                for line in open(path):
                    if re.match(r"from", line):
                        zid = re.sub(r'from: ', '', line)
                    if re.match(r"message", line):
                        message = line
                    if re.match(r"time", line):
                        time = line
                post[n] = {'from': zid, 'message': message, 'time': time}
        except IOError:
            post[n] = ''
            message = ''
            time = ''
    authenticated = 1
    name = re.sub(r'full_name: ', '', full_name)
    return render_template('profile.html', student_fullname=full_name, student_program=program,
                                         student_zid=zid, student_home=home,
                                         student_birthday=birthday, student_images=images,
                                         post=post, friends_list=friends_list,
                                         authenticated=authenticated)
                                         authenticated=authenticated, name=name)


#search the students whose names match the string and display the thumbnail images.

@app.route('/search', methods=['POST', 'GET'])
def search():
    query = request.form.get('search', '')

    search_list = collections.OrderedDict()
    students = sorted(os.listdir(students_dir))
    for zid in students:
        details_filename = os.path.join(students_dir, zid, "student.txt")
        for line in open(details_filename):
            if re.match(r"full_name", line):
                full_name = line
                full_name = re.sub(r'full_name: ', '', full_name)
                if re.search(r''+query+'', full_name):
                    full_name = full_name
                    search_list[zid] = {'name': full_name}

    
    return render_template('search.html', search_list=search_list)

@app.route('/searchpost', methods=['POST', 'GET'])
def searchpost():
    query = request.form.get('search', '')
    post = collections.OrderedDict()
    search_list = collections.OrderedDict()
    students = sorted(os.listdir(students_dir))
    for zid in students:
        path_filename = os.path.join(students_dir, zid)
        for n in range(0,100):
            try:
                for path in glob.glob(path_filename+"/"+str(n)+".txt"):
                    for line in open(path):
                        if re.match(r"from", line):
                            num = re.sub(r'from: ', '', line)
                        if re.match(r"message", line):
                            message = line
                        if re.match(r"time", line):
                            time = line
                    post[zid] = {'from': num, 'message': message, 'time': time, 'n': n}
            except IOError:
                post[n] = ''
                message = ''
                time = ''

    search_list = collections.OrderedDict()
    for n in post:
        if re.search(r''+query+'', post[n]['message']):
           message = post[n]['message']
           name = post[n]['from']
           search_list[n] = {'from': name, 'message': message}
        else:
           message = ''
           name = ''

    return render_template('searchpost.html', search_list=search_list)


@app.route('/add', methods=['POST'])
def add_post():

    add_post = []

    add_post.append({
        'date': datetime.utcnow().isoformat(),
        'title': request.form['title'],
        'text': request.form['text'],
    })
    
    return redirect(url_for('start'))

if __name__ == '__main__':
    app.secret_key = os.urandom(12)
    app.run(debug=True, port=9000)