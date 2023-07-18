#include "dbf.h"

// Copyright (C) 2012 Ron Ostafichuk
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files
// (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify,
// merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
// IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

DBF::DBF()
{
    m_pFileHandle = NULL;
    m_nNumFields = 0;
    m_bAllowWrite = false;
    m_bStructSizesOK = true;
    if( sizeof( fileHeader ) != 32 )
    {
        std::cerr << __FUNCTION__ << " fileHeader Structure is padded and will not work! Must be 32, but is " << sizeof( fileHeader ) << std::endl;
        m_bStructSizesOK = false;
    }
    if( sizeof( fieldDefinition ) != 32 )
    {
        std::cerr << __FUNCTION__ << " fieldDefinition Structure is padded and will not work! Must be 32, but is " << sizeof( fieldDefinition ) << std::endl;
        m_bStructSizesOK = false;
    }

    m_pRecord = new char[MAX_RECORD_SIZE];
}

DBF::~DBF()
{
    if( m_pFileHandle != NULL )
        fclose(m_pFileHandle);

    m_pFileHandle = NULL;
    delete [] m_pRecord;
}

int DBF::open(string sFileName,bool bAllowWrite)
{
    // open a dbf file for reading only
    m_sFileName = sFileName;
    if( bAllowWrite && !m_bStructSizesOK )
        bAllowWrite = false; // DO NOT WRITE IF ENGINE IS NOT COMPILED PROPERLY!
    m_bAllowWrite = bAllowWrite;

    char cMode[10] = "rb"; // for windows we MUST open in binary mode ALWAYS!!!  Linux does not care
    if( m_bAllowWrite )
        strncpy(cMode,"rb+",3); // change to read write mode

    m_pFileHandle = fopen(sFileName.c_str(),cMode);
    if( m_pFileHandle == NULL )
    {
        std::cerr << __FUNCTION__ << " Unable to open file " << sFileName << std::endl;
       return errno;
    }

    // open is ok, so read in the File Header

    int nBytesRead = fread (&m_FileHeader,1,32,m_pFileHandle);
    if( nBytesRead != 32 )
    {
        std::cerr << __FUNCTION__ << " Bad read for Header, wanted 32, got " << nBytesRead << std::endl;
        return 1; // fail
    }

    std::cout << "Header: Type=" << m_FileHeader.u8FileType << std::endl
      << "  Last Update=" << (int) m_FileHeader.u8LastUpdateDay << "/" << (int) m_FileHeader.u8LastUpdateMonth << "/" << (int) m_FileHeader.u8LastUpdateYear << std::endl
      << "  Num Recs=" << m_FileHeader.uRecordsInFile << std::endl
      << "  Rec0 position=" << m_FileHeader.uPositionOfFirstRecord << std::endl
      << "  Rec length=" << m_FileHeader.uRecordLength << std::endl
      << "  CodePage=" << (int) m_FileHeader.uCodePage << std::endl
      << "  TableFlags=" << (int) m_FileHeader.uTableFlags << std::endl;

    m_nNumFields = 0;
    // now read in all the field definitions
    std::cout << "Fields: " << std::endl;
    do
    {
        int nBytesRead = fread(&(m_FieldDefinitions[m_nNumFields]),1,32,m_pFileHandle);
        if( nBytesRead != 32 )
        {
            std::cerr << __FUNCTION__ << " Bad read for Field, wanted 32, got " << nBytesRead << std::endl;
            return 1;
        }

        if( m_FieldDefinitions[m_nNumFields].cFieldName[0] == 0x0D || strlen(m_FieldDefinitions[m_nNumFields].cFieldName) <= 1 )
        {
            // end of fields
            break;
        }
        // show field in std out
        std::cout << "  " << m_FieldDefinitions[m_nNumFields].cFieldName << ", Type=" << m_FieldDefinitions[m_nNumFields].cFieldType
              << ", Offset=" << (int) m_FieldDefinitions[m_nNumFields].uFieldOffset << ", len=" << (int) m_FieldDefinitions[m_nNumFields].uLength
              << ", Dec=" << (int) m_FieldDefinitions[m_nNumFields].uNumberOfDecimalPlaces << ", Flag=" << (int) m_FieldDefinitions[m_nNumFields].FieldFlags << std::endl;

        m_nNumFields++;
    }while(!feof(m_pFileHandle));

    // move to start of first record
    int nFilePosForRec0 = 32+32*m_nNumFields+264;
    if( m_FileHeader.uPositionOfFirstRecord != nFilePosForRec0 )
    {
        // bad Rec0 position calc!!!  debug it!
        std::cerr << __FUNCTION__ << " Bad Rec 0 file position calculated " << nFilePosForRec0 << ", header says " << m_FileHeader.uPositionOfFirstRecord << std::endl;
        return 1;
    }

    return 0; // ok
}

int DBF::close()
{
    int nRet = fclose(m_pFileHandle);
    m_pFileHandle = NULL;
    m_sFileName = "";
    m_nNumFields = 0;
    m_bAllowWrite = false;
    m_FileHeader.u8FileType = 0;
    return nRet;
}

int DBF::getFieldIndex(string sFieldName)
{
    for( int i = 0 ; i < m_nNumFields ; i++ )
    {
        if( strncmp(m_FieldDefinitions[i].cFieldName,sFieldName.c_str(),10) == 0 )
            return i;
    }
    return -1; // not found
}

int DBF::loadRec(int nRecord)
{
    // read as a string always!  All modern languages can convert it later
    int nPos = m_FileHeader.uPositionOfFirstRecord + m_FileHeader.uRecordLength*nRecord;
    int nRes = fseek(m_pFileHandle,nPos,SEEK_SET);
    if ( nRes != 0 )
    {
        std::cerr << __FUNCTION__ << " Error seeking to record " << nRecord << " at " << nPos << " err=" << ferror (m_pFileHandle) << std::endl;
        return 1;
    }

    if( nRes != 0)
    {
        for( unsigned int i=0;itm_year % 100; // convert yr to 2 digits
    m_FileHeader.u8LastUpdateDay = timePtr->tm_mday;
    m_FileHeader.u8LastUpdateMonth = timePtr->tm_mon+1;
    m_FileHeader.u8LastUpdateYear = nYear;
    m_FileHeader.uCodePage = 0; // copied from another db, no idea what this corresponds to
    m_FileHeader.uPositionOfFirstRecord = 32+32*nNumFields+264; // calculated based on the file header size plus the n*FieldDef size + 1 term char + 263 zeros
    m_FileHeader.uRecordLength = 0;
    m_FileHeader.uRecordsInFile = 0;
    m_FileHeader.uTableFlags = 0; // bit fields, copied from another db , 0x01=has a .cdx?, 0x02=Has Memo Fields, 0x04=is a .dbc?

    // write the File Header for the first time!
    fwrite(&m_FileHeader,1,sizeof(m_FileHeader),m_pFileHandle);

    // now write dummy field definition records until the real ones can be specified
    for( int i = 0; i < nNumFields ; i++ )
    {
        for( int j = 0; j < 11 ; j++ )
            m_FieldDefinitions[i].cFieldName[j]=0; // clear entire name
        m_FieldDefinitions[i].cFieldType='C';
        m_FieldDefinitions[i].FieldFlags=0;
        m_FieldDefinitions[i].uAutoIncrementStep=0;
        m_FieldDefinitions[i].uNextAutoIncrementValue[0]=0;
        m_FieldDefinitions[i].uNextAutoIncrementValue[1]=0;
        m_FieldDefinitions[i].uNextAutoIncrementValue[2]=0;
        m_FieldDefinitions[i].uNextAutoIncrementValue[3]=0;
        m_FieldDefinitions[i].uLength=0;
        m_FieldDefinitions[i].uNumberOfDecimalPlaces=0;
        m_FieldDefinitions[i].Reserved8[i]=0;

        // write the definitions
        fwrite(&m_FieldDefinitions[i],1,sizeof(fieldDefinition),m_pFileHandle);
    }
    // write the field definition termination character
    char FieldDefTermination[2];
    FieldDefTermination[0] = 0x0D;
    FieldDefTermination[1] = 0;

    fwrite(FieldDefTermination,1,1,m_pFileHandle);
    // write the 263 bytes of 0
    char cZero[263];
    for( int j=0; j<263;j++)
        cZero[j]=0;

    fwrite(&cZero[0],1,263,m_pFileHandle);
    // this is now the starting point for the first record
    // ready to assign the field definitions!

    // make sure change is made permanent, we are not looking for speed, just reliability and compatibility
    fflush(m_pFileHandle);

    return 0;
}

int DBF::updateFileHeader()
{
    // move to file start
    int nRes = fseek(m_pFileHandle,0,SEEK_SET);
    if( nRes != 0)
        return 1; //fail

    // update the last modified date
    time_t t = time(NULL);
    tm* timePtr = localtime(&t);
    int nYear = timePtr->tm_year % 100; // convert yr to 2 digits
    m_FileHeader.u8LastUpdateDay = timePtr->tm_mday;
    m_FileHeader.u8LastUpdateMonth = timePtr->tm_mon+1;
    m_FileHeader.u8LastUpdateYear = nYear;

    // write the current header info
    int nBytesWritten = fwrite(&m_FileHeader,1,sizeof(m_FileHeader),m_pFileHandle);
    if( nBytesWritten != sizeof(m_FileHeader) )
    {
        // error!
        std::cerr << __FUNCTION__ << " Failed to update header!" << std::endl;
        return 1;
    }
    return 0;
}

int DBF::assignField(fieldDefinition fd,int nField)
{
    // used to assign the field info ONLY if num records in file = 0 !!!
    if( m_FileHeader.uRecordsInFile != 0)
    {
        std::cerr << __FUNCTION__ << " Failed to AssignField Can not change Fields once the File has records in it!" << std::endl;
        return 1; // fail
    }

    // set the unused characters for the field name to zero
    int nPos = strlen(fd.cFieldName);
    for( int i=nPos; i < 11 ; i++ )
        fd.cFieldName[i]=0;

    // this engine does not support auto increment, set it to zero
    fd.uAutoIncrementStep=0;
    fd.uNextAutoIncrementValue[0]=0;
    fd.uNextAutoIncrementValue[1]=0;
    fd.uNextAutoIncrementValue[2]=0;
    fd.uNextAutoIncrementValue[3]=0;

    for( int i=0; i<8;i++)
        fd.Reserved8[i] = 0; // must always be set to zeros!

    // add some rules to prevent creation of invalid db.
    if( fd.cFieldType=='I' )
    {
        fd.uLength = 4;
    }else if( fd.cFieldType=='B' )
    {
        fd.uLength = 8; // actual double, not text!
    }else if( fd.cFieldType=='L' )
    {
        fd.uLength = 1;
    } else
    {
        //default case
        if( fd.uLength < 1 )
            fd.uLength=1;
    }

    // calculate the proper field offset based on corrected data
    if( nField == 0 )
        fd.uFieldOffset = 1;
    else
    {
        fd.uFieldOffset = 1;
        for( int i=0;i 0 )
                std::cerr << "Unable to convert '" << sFieldValue << "' to int "
                          << m_FieldDefinitions[f].uLength << " bytes" << std::endl;
        }
        else if( cType== 'B' )
        {
            // float or double
            int res = ConvertStringToFloat(sFieldValue,m_FieldDefinitions[f].uLength,&m_pRecord[m_FieldDefinitions[f].uFieldOffset]);
            if( res > 0 )
            {
                std::cerr << "Unable to convert '" << sFieldValue << "' to float "
                          << m_FieldDefinitions[f].uLength << " bytes" << std::endl;
            }
        }
        else if( cType== 'L' )
        {
            // logical
            if( sFieldValue=="T" || sFieldValue=="TRUE" )
                m_pRecord[m_FieldDefinitions[f].uFieldOffset] = 'T';
            else if( sFieldValue=="?")
                m_pRecord[m_FieldDefinitions[f].uFieldOffset] = '?';
            else
                m_pRecord[m_FieldDefinitions[f].uFieldOffset] = 'F';
        } else
        {
            // default for character type fields (and all unhandled field types)
            for( unsigned int j=0;j 0 ; i-- )
            {
                if( s[i] == ' ' )
                    s.erase(i,1);
                else
                    break; // done
            }
            // trim left spaces
            for( int i = 0 ; i < s.length() ; i++ )
            {
                if( s[i] == ' ' )
                {
                    s.erase(i,1);
                    i--;
                }
                else
                    break; // done
            }

            int nFind = s.find(",");
            if( nFind > -1 )
            {
                // put string in double quotes!
                // need quotes (make sure string also does not have double quotes, NOT DONE!)
                nFind = s.find("\"");
                while( nFind > -1 )
                {
                    s[nFind] = '\''; // convert double quote(34) to single quote to prevent errors reading this csv
                    nFind = s.find("\"");
                }
                std::cout << ",\"" << s << "\"";
            }
            else
                std::cout << "," << s;
        }
        std::cout << std::endl;
    }
}