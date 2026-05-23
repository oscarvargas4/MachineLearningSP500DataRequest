
# Starting the container

## Build the image: 
```bash
docker build -t ml-data-request-anaconda-jupyter .
```
## Run the container:
```bash    
MSYS_NO_PATHCONV=1 docker run -d -p 8888:8888 -v "$(pwd):/app" --name machine_learning_data_request ml-data-request-anaconda-jupyter 
```
Notice that we needed to add "MSYS_NO_PATHCONV=1" in order to properly map the files from the container to the host due to Git rewriting paths.

## Open the link:
http://localhost:8888



# Mapping issues

🔎 Why Git rewrites paths (this only happens on Windows most of the cases)
Git Bash automatically converts Unix-style paths to Windows paths.

When Docker sees:
```bash
/app
```

Git Bash converts it into something like:
```bash
C:\Program Files\Git\app
```

That’s why your container destination became:
```bash
\Program Files\Git\app
```
Which is completely wrong.



In order to validate if the files from the container would be mapped locally, run command "docker inspect <container_id>". Then you should check the Sorce and destination are properly populated:
"Mounts": [
            {
                "Type": "bind",
                "Source": "/c/Users/<UserName>/Desktop/<FolderNameDesired>",
                "Destination": "/app",
                "Mode": "",
                "RW": true,
                "Propagation": "rprivate"
            }
        ],


# Executing commands inside the container
To start a terminal with bash:
```bash
docker exec -it <container_name_or_id> bash
```


# Command to start Anaconda Prompt
```bash
conda activate base
```

## Anaconda command to list installed packages in the current environment 
```bash
conda list
```

## Anaconda command to install packages 
```bash
conda install <name_of_package>
```


## You can also use pip command to install packages 
```bash
pip install <name_of_package>
```

## There 2 Kernels
Python (TF2) Kernel is installed in order to use TensorFlow in case is needed
