cd tika-trunk
sed -i "s/extractInlineImages false/extractInlineImages true/g" tika-parsers/src/main/resources/org/apache/tika/parser/pdf/PDFParser.properties
sed -i "s/extractUniqueInlineImagesOnly true/extractUniqueInlineImagesOnly false/g" tika-parsers/src/main/resources/org/apache/tika/parser/pdf/PDFParser.properties

mvn -DskipTests=true clean install
cp tika-server/target/tika-server-1.*-SNAPSHOT.jar /srv/tika-server-1.*-SNAPSHOT.jar
