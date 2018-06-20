import argparse
# args 1=K8s job name
#      2=python program


parser = argparse.ArgumentParser(description='Build a K8s YAML file to make it easier to real time submit Python jobs')
parser.add_argument('--job', help='Specify the Job name for the python task')
parser.add_argument('--src', help='Python source file name')

args = parser.parse_args()


k8s_job_template = """
apiVersion: batch/v1
kind: Job
metadata:
  name: {0}
spec:
  template:
    spec:
      containers:
      - name: {0}
        image: markfjohnson/python-k8s
        command: ["python"]
        args: ["/python-k8s-samples/{1}"]
      restartPolicy: Never
  backoffLimit: 4
"""

yaml_adj = k8s_job_template.format(args.job, args.src)
yaml = open("{}.yaml".format(args.job),"w")
yaml.write(yaml_adj)
yaml.close()
