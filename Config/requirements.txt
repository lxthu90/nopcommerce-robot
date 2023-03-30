## Installing for Window
1.  Install Python
To install python, go to python official site − https://www.python.org/downloads/ and download the latest version or the prior version of python as per your operating system (Windows)
.
2.  Install Robot Library and VSCode Extension
2.1 Install Relative Libraries:
    Open CMD and enter command:
        pip install robotframework
        pip install robotframework-datadriver
        pip install robotframework-excellib
        pip install robotframework-seleniumlibrary
2.2 Install VSCode Extension
Open VSCode/Extension
Search and install these extensions:
    Robot Framework Language Server  v1.9.0
    Python



## Test execution on Window
1.   Run all tests:
    `robot <path_to_testcases_folder>`
    `e.g: robot testcases`

2.   Run test file:
    `robot <path_to_test_file>`
    `e.g: robot testcases/login.robot`

3.   Run single testcase:
    `robot -t "<testcase_name>"   <path_to_test_file>`
    `e.g: robot -t "Successfully logged in" testcases/login.robot`