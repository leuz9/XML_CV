java -jar XMLValidator.jar xmlcv.xsd xmlcv.xml
java -jar xslapplyer.jar xmlcv.xml xmlcv.xsl cv-default.html MODE=default
java -jar xslapplyer.jar xmlcv.xml xmlcv.xsl cv-ifp.html MODE=ifp
java -jar xslapplyer.jar xmlcv.xml xmlcv.xsl cv-sii.html MODE=sii
rem "C:\Program Files\Internet Explorer\iexplore.exe" "D:\Fichiers\xmlcv\cv-sii.html"