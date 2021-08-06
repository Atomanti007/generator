#!/bin/bash

echo "Start spring boot project generate"
JAVA_SPRING_TEMPLATE="$TEMPLATE_PATH/java/spring-boot"

if [[ -z $NAME ]]; then
  echo "Missing project name"
  exit 1
fi
if [[ -z $PACKAGE ]]; then
  echo "Missing package"
  exit 1
fi
if [[ -z $VERSION ]]; then
  echo "Missing package"
  exit 1
fi
if [[ -z $OUTPUT ]]; then
  echo "Missing OUTPUT dir"
  exit 1
fi
if [[ -z $TEMPLATE_PATH ]]; then
  echo "Missing template dir"
  exit 1
fi


export CAMEL_NAME=$(sed -r 's/(^|-)(\w)/\U\2/g' <<<"$NAME")

packages=$(echo $PACKAGE | tr "." "\n")
packages+=" "
packages+=$(echo $NAME | tr "-" "\n")

package_path=$(echo $packages | tr " " "/")
export CLASS_PACKAGE=$(echo $packages | tr " " ".")


# ------------------------------
# business
mkdir -p "$OUTPUT/modules/business"

cp "$JAVA_SPRING_TEMPLATE/modules/business/build.gradle" "$OUTPUT/modules/business/build.gradle"
cp "$JAVA_SPRING_TEMPLATE/modules/business/jacoco.gradle" "$OUTPUT/modules/business/jacoco.gradle"
cp "$JAVA_SPRING_TEMPLATE/modules/business/lombok.config" "$OUTPUT/modules/business/lombok.config"

mkdir -p "$OUTPUT/modules/business/src/main"
mkdir -p "$OUTPUT/modules/business/src/main/java"
mkdir -p "$OUTPUT/modules/business/src/main/java/$package_path"
mkdir -p "$OUTPUT/modules/business/src/main/java/$package_path/config"
cat "$JAVA_SPRING_TEMPLATE/modules/business/java/BeanFactory.java" | mo > "$OUTPUT/modules/business/src/main/java/$package_path/config/BeanFactory.java"
mkdir -p "$OUTPUT/modules/business/src/main/java/$package_path/controller"
cat "$JAVA_SPRING_TEMPLATE/modules/business/java/ExampleController.java" | mo > "$OUTPUT/modules/business/src/main/java/$package_path/controller/ExampleController.java"

if [[ $IS_DB = "TRUE" ]]; then
  mkdir -p "$OUTPUT/modules/business/src/main/java/$package_path/entity"
  cat "$JAVA_SPRING_TEMPLATE/modules/business/java/ExampleEntity.java" | mo > "$OUTPUT/modules/business/src/main/java/$package_path/entity/ExampleEntity.java"
  mkdir -p "$OUTPUT/modules/business/src/main/java/$package_path/mapper"
  cat "$JAVA_SPRING_TEMPLATE/modules/business/java/ExampleMapper.java" | mo > "$OUTPUT/modules/business/src/main/java/$package_path/mapper/ExampleMapper.java"
  mkdir -p "$OUTPUT/modules/business/src/main/java/$package_path/repository"
  cat "$JAVA_SPRING_TEMPLATE/modules/business/java/ExampleRepository.java" | mo > "$OUTPUT/modules/business/src/main/java/$package_path/repository/ExampleRepository.java"
fi

mkdir -p "$OUTPUT/modules/business/src/test"
mkdir -p "$OUTPUT/modules/business/src/test/java"
mkdir -p "$OUTPUT/modules/business/src/test/resources"

# ------------------------------
# create interface
mkdir -p "$OUTPUT/modules/interface"

cp "$JAVA_SPRING_TEMPLATE/modules/interface/build.gradle" "$OUTPUT/modules/interface/build.gradle"

mkdir -p "$OUTPUT/modules/interface/src/main"
mkdir -p "$OUTPUT/modules/interface/src/main/java"
mkdir -p "$OUTPUT/modules/interface/src/main/java/$package_path"
mkdir -p "$OUTPUT/modules/interface/src/main/java/$package_path/dto"
cat "$JAVA_SPRING_TEMPLATE/modules/interface/java/ExampleDto.java" | mo > "$OUTPUT/modules/interface/src/main/java/$package_path/dto/ExampleDto.java"
mkdir -p "$OUTPUT/modules/interface/src/main/java/$package_path/service"
cat "$JAVA_SPRING_TEMPLATE/modules/interface/java/ExampleRest.java" | mo > "$OUTPUT/modules/interface/src/main/java/$package_path/service/ExampleRest.java"


# ------------------------------
# create rest-docker
mkdir -p "$OUTPUT/modules/rest-docker"

cp "$JAVA_SPRING_TEMPLATE/modules/rest-docker/build.gradle" "$OUTPUT/modules/rest-docker/build.gradle"
cp "$JAVA_SPRING_TEMPLATE/modules/rest-docker/Dockerfile" "$OUTPUT/modules/rest-docker/Dockerfile"

mkdir -p "$OUTPUT/modules/rest-docker/src/main"
mkdir -p "$OUTPUT/modules/rest-docker/src/main/java"
mkdir -p "$OUTPUT/modules/rest-docker/src/main/java/$package_path"
mkdir -p "$OUTPUT/modules/rest-docker/src/main/java/$package_path/rest"
cat "$JAVA_SPRING_TEMPLATE/modules/rest-docker/java/Application.java" | mo > "$OUTPUT/modules/rest-docker/src/main/java/$package_path/rest/Application.java"

mkdir -p "$OUTPUT/modules/rest-docker/src/main/resources"
cat "$JAVA_SPRING_TEMPLATE/modules/rest-docker/resources/application.properties" | mo > "$OUTPUT/modules/rest-docker/src/main/resources/application.properties"
cat "$JAVA_SPRING_TEMPLATE/modules/rest-docker/resources/application-dev.properties" | mo > "$OUTPUT/modules/rest-docker/src/main/resources/application-dev.properties"
cat "$JAVA_SPRING_TEMPLATE/modules/rest-docker/resources/application-test.properties" | mo > "$OUTPUT/modules/rest-docker/src/main/resources/application-test.properties"
cat "$JAVA_SPRING_TEMPLATE/modules/rest-docker/resources/application-prod.properties" | mo > "$OUTPUT/modules/rest-docker/src/main/resources/application-prod.properties"
cp "$JAVA_SPRING_TEMPLATE/modules/rest-docker/resources/logback.xml" "$OUTPUT/modules/rest-docker/src/main/resources/logback.xml"


cat "$JAVA_SPRING_TEMPLATE/Makefile" | mo > "$OUTPUT/Makefile"
cp "$JAVA_SPRING_TEMPLATE/.gitignore" "$OUTPUT/.gitignore"
cp "$JAVA_SPRING_TEMPLATE/.gitattributes" "$OUTPUT/.gitattributes"

cat "$JAVA_SPRING_TEMPLATE/build.gradle" | mo > "$OUTPUT/build.gradle"
cat "$JAVA_SPRING_TEMPLATE/settings.gradle" | mo > "$OUTPUT/settings.gradle"
cat "$JAVA_SPRING_TEMPLATE/release.gradle" | mo > "$OUTPUT/release.gradle"

cd $OUTPUT || exit 1
gradle wrapper --gradle-version 6.8 --distribution-type bin

./gradlew build

echo 'Add kubernetes descriptors'
KUBERNETES_TEMPLATE="$JAVA_SPRING_TEMPLATE/kubernetes"

mkdir -p "$OUTPUT/kubernetes"
cp "$KUBERNETES_TEMPLATE/deployment.yaml" "$OUTPUT/kubernetes/deployment.yaml"
cp "$KUBERNETES_TEMPLATE/prometheus.yaml" "$OUTPUT/kubernetes/prometheus.yaml"
cp "$KUBERNETES_TEMPLATE/service.yaml" "$OUTPUT/kubernetes/service.yaml"


echo 'Add liquibase'
LIQUIBASE_TEMPLATE="$JAVA_SPRING_TEMPLATE/liquibase"

mkdir -p "$OUTPUT/liquibase"
cp -r "$LIQUIBASE_TEMPLATE" "$OUTPUT"


echo 'Add git workflows'
mkdir -p "$OUTPUT/.github/workflows"
cp "$JAVA_SPRING_TEMPLATE/.github/workflows/build.yml" "$OUTPUT/.github/workflows/build.yml"
cp "$JAVA_SPRING_TEMPLATE/.github/workflows/deploy-dev.yml" "$OUTPUT/.github/workflows/deploy-dev.yml"


