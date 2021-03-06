 end of the "name" attribute in <supportedComponentIdentity>: -->
      <!-- This matches both normal manifest (Vista / Win7) and DL manifest (Srv03) -->
      <supportedComponent>
        <supportedComponentIdentity
            language="*"
            name="Microsoft-Windows-Microsoft-Data-Access-Components-(MDAC)-ODBC-DriverManager-Dll*"
            processorArchitecture="*"
            settingsVersionRange="0"
          />
        <migXml xmlns="">
          <!-- User specific setting (Apply Phrase) -->
          <rules context="User">
            <merge script="MigXmlHelper.DestinationPriority()">
              <objectSet>
                <pattern type="Registry">HKCU\Software\ODBC\ODBC.INI\* [*]</pattern>
                <pattern type="File">%ODBCDSNDir_User% [*.DSN]</pattern>
              </objectSet>
            </merge>
            <!-- We need to use <destinationCleanup> to ensure that the absence of "DefaultDSNDir"
                 value name is also replicated. See Win8 #326933 for more detail -->
            <destinationCleanup>
              <objectSet>
                <pattern type="Registry">HKCU\Software\ODBC\ODBC.INI\ODBC File DSN [DefaultDSNDir]</pattern>
              </objectSet>
            </destinationCleanup>
          </rules>
          <!-- System wide setting (Apply Phrase) -->
          <rules context="System">
            <!-- The first argument in "RelativeMove" is computed with "source machine environment", -->
            <!-- while the second one is computed with "target machine environment" -->
            <!-- The first argument in "RelativeMove" must always be "HKLM\Software", since the source machine is x86 -->
            <!-- For [x86 -> x86 migration]: the second argument in "RelativeMove" is "HKLM\Software" -->
            <!-- For [x86 -> AMD64 migration]: the second argument in "RelativeMove" is "HKLM\Software\Wow6432Node" -->
            <!-- Therefore, no location was modified in the first case; but it is modified in the second case -->
            <locationModify script="MigXmlHelper.RelativeMove(&apos;%HklmWowSoftware%\ODBC\ODBC.INI&apos;, &apos;%HklmWowSoftware%\ODBC\ODBC.INI&apos;)">
              <objectSet>
                <!-- %HklmWowSoftware% here is computed with the "source machine context" -->
                <pattern type="Registry">%HklmWowSoftware%\ODBC\ODBC.INI\* [*]</pattern>
              </objectSet>
            </locationModify>
            <merge script="MigXmlHelper.DestinationPriority()">
              <objectSet>
                <!-- %HklmWowSoftware% here is computed with the "target machine environment" -->
                <pattern type="Registry">%HklmWowSoftware%\ODBC\ODBC.INI\* [*]</pattern>
                <pattern type="File">%ODBCDSNDir_System% [*.DSN]</pattern>
              </objectSet>
            </merge>
            <!-- We need to use destinationCleanup to ensure that the absence of "DefaultDSNDir" 
                 value name is also replicated. See Win8 #326933 for more detail -->
            <!-- %HklmWowSoftware% is computed with the "target machine environment" -->
            <destinationCleanup>
              <objectSet>
                <pattern type="Registry">%HklmWowSoftware%\ODBC\ODBC.INI\ODBC File DSN [DefaultDSNDir]</pattern>
              </objectSet>
            </destinationCleanup>
          </rules>
        </migXml>
      </supportedComponent>
    </supportedComponents>
    <!-- Use a special name for better output in log file -->
    <migrationDisplayID>ReplacementManifests</migrationDisplayID>
  </migration>
</assembly>
                                                                                                                                                                                                                                                                                                                                                                                                                                                           <?xml version='1.0' encoding='utf-8' standalone='yes'?>
<assembly
    xmlns="urn:schemas-microsoft-com:asm.v3"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    manifestVersion="1.0"
    >
  <assemblyIdentity
      name="Microsoft-Windows-SpeechCommon-OneCore"
      processorArchitecture="*"
      version="0.0.0.0"
      language="neutral"
      />
  <migration
      replacementSettingsVersionRange="0-3"
      scope="Upgrade,MigWiz,USMT"
      settingsVersion="4"
      >
      <machineSpecific>
        <migXml xmlns="">
          <rules context="System">
            <conditions>
              <condition negation="Yes">MigXmlHelper.DoesObjectExist("Registry", "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization [AllowInputPersonalization]")</condition>
              <condition>MigXmlHelper.DoesObjectExist("Registry", "HKLM\SOFTWARE\Microsoft\PolicyManager\Current\Device\Privacy [AllowInputPersonalization]")</condition>
              <condition>MigXmlHelper.DoesStringContentEqual("Registry", "HKLM\SOFTWARE\Microsoft\PolicyManager\Current\Device\Privacy [AllowInputPersonalization]", "0x00000000")</condition>
            </conditions>
            <include>
              <objectSet>
                <pattern type="Registry">HKLM\SOFTWARE\Microsoft\PolicyManager\Current\Device\Privacy [AllowInputPersonalization]</pattern>
              </objectSet>
            </include>
          </rules>
          <rules context="System">
            <conditions>
              <condition negation="Yes">MigXmlHelper.DoesObjectExist("Registry", "HKLM\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy [HasAccepted]")</condition>
              <condition>MigXmlHelper.DoesObjectExist("Registry", "HKLM\SOFTWARE\Microsoft\Personalization\Settings [AcceptedPrivacyPolicy]")</condition>
              <condition>MigXmlHelper.DoesStringContentEqual("Registry", "HKLM\SOFTWARE\Microsoft\Personalization\Settings [AcceptedPrivacyPolicy]", "0x00000000")</condition>
            </conditions>
            <addObjects>
              <object>
                <location type="Registry">HKLM\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy [HasAccepted]</location>
                <attributes>dword</attributes>
                <bytes>00000000</bytes>
              </object>
 