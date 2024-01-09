# Devops 과제 관련 설명
## 환경
- EKS 환경에서 사용하는 것을 전제로 만들었습니다.
- k8s 관련 파일들은 manifest에 추가해두었으며 app,db,sc(storageclass),alb(aws load balancer ingress)폴더를 만들어서 구분해두었습니다.

## 관련 작업에 대하여
- 컨테이너라이즈를 위하여 Dockerfile을 작성했습니다. 여기서 `--mount=type=cache`를 사용하여 gradle 패키지 캐싱처리 작업을 진행했으며 userid를 999로 설정하여 user를 세팅해두었습니다.
- host의 logs 폴더를 사용하기 위해 deployments.yaml에 hostpath를 volume mounts으로 설정했습니다.
- 정상동작 여부를 체크하기 위해서 spring boot acuator를 활용해서 readinessprobe와 livenessprobe를 설정해주었습니다.
- 종료 시 30초 이내에 프로세스가 종료되지 않으면 SIGKILL 설정을 하기 위해서 terminationGracePeriodSeconds을 30초로 설정해두었습니다.
- scalie-in,out 상황에서 유실되는 트래픽이 없도록 하기 위해서 hpa와pdb 설정을 통해 pod가 하나씩 업데이트 되도록해두었으며 app 설정으로 gracefulshutdown을 추가해두었습니다. 이를 통해 pod에 sigterm을 주면 더 이상 트래픽이 들어가지 않도록 하였습니다.
- db는 helm chart를 활용하여 만들었으면 statefulset으로 만들어서 db가 종료되어도 다시 붙어도 유실되지 않도록 설정되어 있습니다.
- 어플리케이션과 db 통신에 경우 클러스터 domain을 활용했으며 spring profile을 활용해서 local에서는 local 테스트를 할 수 있고 k8s에서는 k8s에서만 사용할 수 있도록 해두었습니다.
- 스토리지가 필요하기에 gp3를 활용하여 작업을 진행했습니다. gp2대비 gp3가 비용이 덜 들기에 사용했습니다.
- ingress-controller에 경우 aws load balancer ingress를 활용하여 작업을 진행할 수 있도록 해두었습니다.
