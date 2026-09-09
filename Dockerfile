# Stage 1 - Build the jar (java application runtime) suing maven
FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

COPY . .

# create jar file
RUN mvn clean install -DskipTests=true

# Stage 2 - execute jar file from the above stage
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/expenseapp.jar

CMD ["java","-jar","expenseapp.jar"]
