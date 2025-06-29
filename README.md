
# SKINPAIRS_1 👩‍🔬✨

**SKINPAIRS_1** is a skincare-focused system built with Java (Ant), JSP, and Servlets. This project analyzes skincare products and matches them to users based on ingredients and skin types.

---

## 📄 Important Files

- [Dockerfile](Dockerfile) → Containerize the project  
- [build.xml](build.xml) → Ant build script  
- [src/](src/) → Java source files  
- [web/](web/) → JSP pages and static resources  

---

## 📦 Project Structure

```
SKINPAIRS_1/
├── build/          # Compiled Java classes
├── dist/           # JAR/WAR output after build
├── image/          # Custom assets (e.g. icons)
├── nbproject/      # NetBeans project configuration
├── src/            # Java source code (Servlets, models)
├── test/           # JUnit test files (if any)
├── web/            # Web content (JSP, CSS, JS)
├── Dockerfile      # Docker configuration file
└── build.xml       # Apache Ant build file
```

---

## 🐳 Docker Instructions

Make sure the project is built first via NetBeans or by running:

```bash
ant clean
ant dist
```

Then build and run the Docker container:

```bash
docker build -t skinpairs-app .
docker run --rm -p 8080:8080 skinpairs-app
```

> Note: Update the Dockerfile depending on whether you're deploying a `.jar` or `.war`.

---

## 🧠 Features

- ✨ Ingredient-based product recommendation
- 📊 Match analysis logic based on skin types and ingredients
- 💬 User skin type quiz and profiling
- 🚀 Docker-ready for deployment
- 📈 Match percentage logic based on ingredient intersection

---

## 🔧 Technologies Used

- Java (Servlets)
- JSP
- HTML/CSS (Bootstrap 4.5)
- Apache Ant
- MySQL
- Docker

---

## 📌 TODO

- [ ] Add database setup & connection instructions
- [ ] Include sample SQL files
- [ ] Set up CI/CD with GitHub Actions
- [ ] Write unit tests for analysis logic

---

## 🤝 Contributions

Feel free to fork this repository and contribute via pull requests. All improvements, bug fixes, and suggestions are welcome!

---

## 📃 License

This project is created for academic and demo purposes. You can reuse and modify it freely for personal or educational use.
