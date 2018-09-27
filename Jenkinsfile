def label = "mypod-${UUID.randomUUID().toString()}"
podTemplate(label: label, yaml: """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: some-label-value
spec:
  containers:
  - name: busybox
    image: busybox
    command:
    - cat
    tty: true
"""
) {
  node(label) {
    stage('Run specific shell') {
      container(name:'busybox', shell:'/bin/sh') {
        sh 'echo hello world'
      }
    }
  }
}
