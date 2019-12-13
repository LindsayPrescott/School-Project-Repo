//filesystem by Lindsay Prescott and Stephen Watson

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include "softwaredisk.h"
#include "filesystem.h"

#define  TRUE  1
#define  FALSE 0

#define MAX_NAME_SIZE 80
#define NUM_DIRECT_INODE_BLOCKS 9 
#define NUM_INDIRECT_BLOCK (SOFTWARE_DISK_BLOCK_SIZE/2) //Since block numbers are defined in unsigned short int, we divide by 2

#define MAX_FILE_SIZE ((NUM_INDIRECT_BLOCK+NUM_DIRECT_INODE_BLOCKS)*SOFTWARE_DISK_BLOCK_SIZE)
#define MAX_NUMBER_OF_FILES 4095
#define TOTAL_NUMBER_INODES 4095
#define TOTAL_NUMBER_DIRECTORIES 4095

#define INODE_BITMAP_INDEX 0
#define DATA_BITMAP_INDEX 1
#define DIRECTORY_BITMAP_INDEX 2

#define FIRST_INODE_BLOCK 3
#define LAST_INODE_BLOCK 197
                                     
#define FIRST_DIRECTORY_BLOCK 198 
                                                
#define LAST_DIRECTORY_BLOCK 880

#define FIRST_DATA_BLOCK 905
#define LAST_DATA_BLOCK 4999

#define DIRECTORIES_PER_BLOCK 6
#define INODES_PER_BLOCK 21

//Inode Struct
typedef struct Inode {
    unsigned long int fileSize; //Size of the file this Inode maps to in bytes
    unsigned short int blocks[NUM_DIRECT_INODE_BLOCKS]; //Array of direct block numbers
    unsigned short int indirect; //Block number of single indirect block 
} Inode;
//Directory Struct
typedef struct Directory {
    unsigned short inodeNum;
    unsigned short directoryNum;
    char fileName[MAX_NAME_SIZE];
    char isOpen;
} Directory;
//Bitmap Struct with bitmap buffer array inside
typedef struct Bitmap {
    char bitmapbuf[SOFTWARE_DISK_BLOCK_SIZE];
} Bitmap;
//Directory Block structure to make it easy to cycle through the Directories from a block.
typedef struct DirectoryBlock {
    Directory directoriesBuf[DIRECTORIES_PER_BLOCK];
} DirectoryBlock;
//Inode Block structure to make it easy to cycle through the inodes from a block.
typedef struct InodeBlock {
    Inode inodesBuf[INODES_PER_BLOCK];
} InodeBlock;
//Indirect Block mapping block to make it easy to cycle through the block mappings in an Indirect block.
typedef struct IndirectBlock {
    unsigned short int indirectbuf[NUM_INDIRECT_BLOCK];
} IndirectBlock;

// main private file type: you implement this in filesystem.c
typedef struct FileInternals {
    unsigned short int boolWrite;
    Inode inode;
    Directory directory;
    unsigned long filePosition;
} FileInternals;

// file type used by user code
typedef struct FileInternals* File;

//Global
Directory workingDirectory;
// filesystem error code set (set by each filesystem function)
FSError fserror;
// zero buf
char zerobuf[SOFTWARE_DISK_BLOCK_SIZE];

//Helper functions for filesystem.c
char toggle_bit(char byteName, int bitNum) {
    return (byteName ^= 1UL << bitNum);
}

char check_bit(char byteName, int bitNum) {
    return ((byteName >> bitNum) & 1U);
}

void toggleInodeBit(unsigned short int inodeNum) {
    Bitmap inodeBits;
    read_sd_block(&inodeBits.bitmapbuf, INODE_BITMAP_INDEX);
    inodeBits.bitmapbuf[inodeNum/8] = toggle_bit(inodeBits.bitmapbuf[inodeNum/8], inodeNum%8);
    write_sd_block(&inodeBits.bitmapbuf, INODE_BITMAP_INDEX);
}

void toggleDataBit(unsigned short int blockNum) {
    Bitmap dataBits;
    read_sd_block(&dataBits.bitmapbuf, DATA_BITMAP_INDEX);
    int bufIndex = (blockNum-FIRST_DATA_BLOCK)/8;
    int byteNum = (blockNum-FIRST_DATA_BLOCK)%8;
    dataBits.bitmapbuf[bufIndex] = toggle_bit(dataBits.bitmapbuf[bufIndex], byteNum);
    write_sd_block(&dataBits.bitmapbuf, DATA_BITMAP_INDEX);
}

void toggleDirectoryBit(unsigned short int directoryNum) {
    Bitmap directoryBits;
    read_sd_block(&directoryBits.bitmapbuf, DIRECTORY_BITMAP_INDEX);
    directoryBits.bitmapbuf[directoryNum/8] = toggle_bit(directoryBits.bitmapbuf[directoryNum/8], directoryNum%8);
    write_sd_block(&directoryBits.bitmapbuf, DIRECTORY_BITMAP_INDEX);
}

unsigned short int firstAvailableInodeNum() {
    Bitmap inodeBits;
    read_sd_block(&inodeBits.bitmapbuf, INODE_BITMAP_INDEX);
    unsigned short int inodeNum = 0;
    while(check_bit(inodeBits.bitmapbuf[inodeNum/8], inodeNum%8)) {
        inodeNum++;
    }
    if(inodeNum>=TOTAL_NUMBER_INODES){
        return -1;
    }
    return inodeNum;
}

unsigned short int firstAvailableDataBlockNum() {
    Bitmap dataBits;
    read_sd_block(&dataBits.bitmapbuf, DATA_BITMAP_INDEX);
    unsigned short int blockNum = 0;
    while(check_bit(dataBits.bitmapbuf[(blockNum-FIRST_DATA_BLOCK)/8], (blockNum-FIRST_DATA_BLOCK)%8) == TRUE) {
        blockNum++;
    }
    if(blockNum>LAST_DATA_BLOCK) {
        return -1;
    }
    write_sd_block(&zerobuf, blockNum);
    return blockNum;
}

unsigned short int firstAvailableDirectoryNum() {
    Bitmap directoryBits;
    read_sd_block(&(directoryBits.bitmapbuf), DIRECTORY_BITMAP_INDEX);
    unsigned short int directoryNum = 0;
    while(check_bit(directoryBits.bitmapbuf[directoryNum/8], directoryNum%8) == TRUE) {
        directoryNum++;
    }
    if(directoryNum>=TOTAL_NUMBER_DIRECTORIES){
        return -1;
    }
    return directoryNum;
}

unsigned short int getInodeBlockNum(unsigned short int inodeNum) {
    return (inodeNum/INODES_PER_BLOCK + FIRST_INODE_BLOCK);
}

unsigned short int getDirectoryBlockNum(unsigned short int directoryNum) {
    return (directoryNum/DIRECTORIES_PER_BLOCK + FIRST_DIRECTORY_BLOCK);
}

Inode getInodeFromDirectory(Directory directory) {
    unsigned short int inodeBlockNum = getInodeBlockNum(directory.inodeNum);
    InodeBlock inodeBlockData;
    char buf[SOFTWARE_DISK_BLOCK_SIZE];
    read_sd_block(&buf,inodeBlockNum);
    memcpy(&(inodeBlockData.inodesBuf), &buf, sizeof(inodeBlockData.inodesBuf));
    return inodeBlockData.inodesBuf[directory.inodeNum%INODES_PER_BLOCK];
}

Directory getDirectoryFromDirectoryNum(unsigned short int directoryNum) {
    DirectoryBlock directoryBlockData;
    unsigned short int directoryBlockNum = getDirectoryBlockNum(directoryNum);
    char buf[SOFTWARE_DISK_BLOCK_SIZE];
    read_sd_block(&buf, directoryBlockNum);
    memcpy(&(directoryBlockData.directoriesBuf), &buf, sizeof(directoryBlockData.directoriesBuf));
    return directoryBlockData.directoriesBuf[directoryNum%DIRECTORIES_PER_BLOCK];
}

//Helper function to find the file position of the EOF character.  Returns 0 if no EOF character found.
unsigned long int findEofFilePos(File file) {
    if(file==NULL) {
        fserror = FS_FILE_NOT_FOUND;
        return 0;
    }
    unsigned long int eofFilePos;
    unsigned short int eofBlockNum = 0;
    int index;
    if(file->inode.indirect!=0) {
        IndirectBlock indirectBlock;
        unsigned short int indirectBlockNum = file->inode.indirect;
        read_sd_block(&(indirectBlock.indirectbuf), indirectBlockNum);
        for(int i = SOFTWARE_DISK_BLOCK_SIZE; i<=0; i--) {
            if(indirectBlock.indirectbuf[i]!=0) {
                eofBlockNum = indirectBlock.indirectbuf[i];
                index = i+NUM_DIRECT_INODE_BLOCKS;
                break;
            }
        }
        if(eofBlockNum == 0) {
            for(int i = NUM_DIRECT_INODE_BLOCKS-1; i<=0; i--) {
                if(file->inode.blocks[i] != 0) {
                eofBlockNum = file->inode.blocks[i];
                index = i;
                break;
                }
            }
        }
    }
    else {
        for(int i = NUM_DIRECT_INODE_BLOCKS-1; i<=0; i--) {
            if(file->inode.blocks[i] != 0) {
                eofBlockNum = file->inode.blocks[i];
                index = i;
                break;
            }
        }
    }
    if(eofBlockNum == 0) {
        return 0;
    }
    char workingbuf[SOFTWARE_DISK_BLOCK_SIZE];
    read_sd_block(&workingbuf, eofBlockNum);
    for(int i = 0; i<SOFTWARE_DISK_BLOCK_SIZE; i++) {
        if(workingbuf[i]==EOF) {
            index = index * 8 +i;
            return index;
        }
    }
    return 0;
}
// functions for filesystem API

// open existing file with pathname 'name' and access mode 'mode'.  Current file
// position is set at byte 0.  Returns NULL on error. Always sets 'fserror' global.
File open_file(char *name, FileMode mode){
    fserror = FS_NONE;
    if(file_exists(name)) {
        if(workingDirectory.isOpen==0x1) {
            fserror = FS_FILE_OPEN;
            return NULL;
        }
        workingDirectory.isOpen = 0x1;
        File file = (File)malloc(sizeof(FileInternals));
        if(mode == READ_WRITE) {
            file->boolWrite = 1;
        }
        else{
            file->boolWrite = 0;
        }
        file->filePosition = 0;
        file->directory = workingDirectory;
        file->inode = getInodeFromDirectory(workingDirectory);
        return file;
    }
    else {
        fserror = FS_FILE_NOT_FOUND;
        return NULL;
    }
}


// create and open new file with pathname 'name' and (implied) access
// mode READ_WRITE. The current file position is set at byte 0.
// Returns NULL on error. Always sets 'fserror' global.
File create_file(char *name) {
    fserror = FS_NONE;
    if(file_exists(name)) {
        fserror = FS_FILE_ALREADY_EXISTS;
        return NULL;
    }
    unsigned short inodeNum = firstAvailableInodeNum();
    unsigned short directoryNum = firstAvailableDirectoryNum();
    if(inodeNum==-1 || directoryNum==-1) {
        fserror = FS_OUT_OF_SPACE;
        return NULL;
    }
    unsigned short inodeBlock = getInodeBlockNum(inodeNum);
    unsigned short directoryBlockNum = getDirectoryBlockNum(directoryNum);

    File file = (File)malloc(sizeof(FileInternals));
    file->boolWrite = 1;
    file->filePosition = 0;
    file->directory.isOpen = 0x1;
    memcpy(file->directory.fileName, (name), sizeof((name)));//use str copy ? instead, see file exists logic
    file->directory.inodeNum = inodeNum;
    file->directory.directoryNum = directoryNum;
    file->inode = getInodeFromDirectory(file->directory);

    DirectoryBlock directoryBlockData;
    char buf[SOFTWARE_DISK_BLOCK_SIZE];
    read_sd_block(&buf,directoryBlockNum);//every time we call this function, we should check for IO error
    memcpy(&(directoryBlockData.directoriesBuf), &buf, sizeof(directoryBlockData.directoriesBuf));
    memcpy(&(directoryBlockData.directoriesBuf[directoryNum%DIRECTORIES_PER_BLOCK]),&(file->directory),sizeof(Directory));
    memcpy(&buf, &(directoryBlockData.directoriesBuf), sizeof(buf));
    write_sd_block(&buf,directoryBlockNum);

    toggleDirectoryBit(directoryNum);
    toggleInodeBit(inodeNum);
    return file;
}

// close 'file'.  Always sets 'fserror' global.
void close_file(File file) {
    fserror = FS_NONE;
    
    if(file==NULL) {
        fserror = FS_FILE_NOT_FOUND;
    }
    else if(file->directory.isOpen == 0x0) {
        fserror = FS_FILE_NOT_OPEN;
    }
    else {
        file->directory.isOpen = 0x0;
        unsigned short int directoryBlockNum = getDirectoryBlockNum(file->directory.directoryNum);
        unsigned short int inodeBlockNum = getInodeBlockNum(file->directory.inodeNum);
        unsigned short int dirPosOnBlock = file->directory.directoryNum%DIRECTORIES_PER_BLOCK;
        unsigned short int inodePosOnBlock = file->directory.inodeNum%INODES_PER_BLOCK;

        char workingbuf[SOFTWARE_DISK_BLOCK_SIZE];
        DirectoryBlock directoryBlock;
        InodeBlock inodeBlock;

        read_sd_block(&workingbuf, directoryBlockNum);
        memcpy(&(directoryBlock.directoriesBuf),&workingbuf,sizeof(directoryBlock.directoriesBuf));
        directoryBlock.directoriesBuf[dirPosOnBlock] = file->directory;
        memcpy(&workingbuf, &(directoryBlock.directoriesBuf), sizeof(directoryBlock.directoriesBuf));
        write_sd_block(&workingbuf, directoryBlockNum);

        read_sd_block(&workingbuf, inodeBlockNum);
        memcpy(&(inodeBlock.inodesBuf),&workingbuf,sizeof(inodeBlock.inodesBuf));
        inodeBlock.inodesBuf[inodePosOnBlock] = file->inode;
        memcpy(&workingbuf, &(inodeBlock.inodesBuf), sizeof(inodeBlock.inodesBuf));
        write_sd_block(&workingbuf, inodeBlockNum);

        free(file);
    }
}

// read at most 'numbytes' of data from 'file' into 'buf', starting at the 
// current file position.  Returns the number of bytes read. If end of file is reached,
// then a return value less than 'numbytes' signals this condition. Always sets
// 'fserror' global.
unsigned long read_file(File file, void *buf, unsigned long numbytes) {
    fserror = FS_NONE;
    if(file==NULL) {
        fserror = FS_FILE_NOT_FOUND;
        return 0;
    }
    if(file->directory.isOpen==0x0) {
        fserror = FS_FILE_NOT_OPEN;
        return 0;
    }
    unsigned long bytesCopied = 0;
    unsigned long int i = file->filePosition/SOFTWARE_DISK_BLOCK_SIZE;
    unsigned short dataBlockNum;
    IndirectBlock indirectBlock;
    int isDirect = FALSE;
    if(i<NUM_DIRECT_INODE_BLOCKS) {
        dataBlockNum = file->inode.blocks[i];
        isDirect = TRUE;
    }
    else {
        i = i-NUM_DIRECT_INODE_BLOCKS;
        dataBlockNum = file->inode.indirect;
        if(dataBlockNum==0) {
            fserror = FS_EXCEEDS_MAX_FILE_SIZE;
            return 0;
        }
        read_sd_block(&(indirectBlock.indirectbuf), dataBlockNum);
        dataBlockNum = indirectBlock.indirectbuf[i];
    }

    char workingbuf[SOFTWARE_DISK_BLOCK_SIZE];
    char workingbuf2[sizeof((buf))];
    unsigned long int dataPosition = file->filePosition%SOFTWARE_DISK_BLOCK_SIZE;

    read_sd_block(&workingbuf, dataBlockNum);
    int j;
    for(j = dataPosition; j<SOFTWARE_DISK_BLOCK_SIZE-dataPosition; j++){
        workingbuf2[j-dataPosition]= workingbuf[j];
        if (workingbuf[j] == EOF) {
            memcpy(buf, &workingbuf2, j-dataPosition);
            return j-dataPosition;
        }
    }
    
    if(SOFTWARE_DISK_BLOCK_SIZE-dataPosition<numbytes){
        bytesCopied += SOFTWARE_DISK_BLOCK_SIZE-dataPosition;
    }
    else{
        memcpy(buf, &workingbuf2, numbytes);
        return numbytes;
    }

    while(bytesCopied<numbytes) {
        i++;
        if(isDirect==TRUE){
            if(i<NUM_DIRECT_INODE_BLOCKS) {
                dataBlockNum = file->inode.blocks[i];
            }
            else {
                isDirect = FALSE;
                i = i-NUM_DIRECT_INODE_BLOCKS;
                dataBlockNum = indirectBlock.indirectbuf[i];
            }
        }
        else {
            dataBlockNum = indirectBlock.indirectbuf[i];
        }

        read_sd_block(&workingbuf, dataBlockNum);

        for(j=0;j<SOFTWARE_DISK_BLOCK_SIZE;j++) {
            bytesCopied++;
            if(workingbuf[j]==EOF||bytesCopied==numbytes) {
                memcpy(&workingbuf2[bytesCopied-j], &workingbuf, j);
                memcpy(buf, &workingbuf2, bytesCopied);
                return bytesCopied;
            }
        }
        memcpy(&workingbuf2[bytesCopied], &workingbuf, j);
    }
}

// write 'numbytes' of data from 'buf' into 'file' at the current file position. 
// Returns the number of bytes written. On an out of space error, the return value may be
// less than 'numbytes'.  Always sets 'fserror' global.
unsigned long write_file(File file, void *buf, unsigned long numbytes) {
    fserror = FS_NONE;
    if(file==NULL) {
        fserror = FS_FILE_NOT_FOUND;
        return 0;
    }
    if(file->directory.isOpen==0x0) {
        fserror = FS_FILE_NOT_OPEN;
        return 0;
    }
    if(file->boolWrite==FALSE) {
        fserror = FS_FILE_READ_ONLY;
        return 0;
    }
    unsigned short int eofPos = findEofFilePos(file);
    unsigned long bytesCopied = 0;
    unsigned long int i = file->filePosition/SOFTWARE_DISK_BLOCK_SIZE;
    unsigned short dataBlockNum;
    IndirectBlock indirectBlock;
    int isDirect = FALSE;
    if(i<NUM_DIRECT_INODE_BLOCKS) {
        dataBlockNum = file->inode.blocks[i];
        isDirect = TRUE;
    }
    else {
        i = i-NUM_DIRECT_INODE_BLOCKS;
        dataBlockNum = file->inode.indirect;
        if(dataBlockNum==0) {
            file->inode.indirect = firstAvailableDataBlockNum();
            if(file->inode.indirect = -1) {
                file->inode.indirect = 0;
                fserror = FS_OUT_OF_SPACE;
                return 0;
            }
            toggleDataBit(file->inode.indirect);
            dataBlockNum = file->inode.indirect;
        }
        read_sd_block(&(indirectBlock.indirectbuf), dataBlockNum);
        dataBlockNum = indirectBlock.indirectbuf[i];
    }

    if(dataBlockNum == 0) {
        dataBlockNum = firstAvailableDataBlockNum();
        if(dataBlockNum==-1) {
            fserror = FS_OUT_OF_SPACE;
            return 0;
        }
        toggleDataBit(dataBlockNum);
        if(isDirect) {
            file->inode.blocks[i] = dataBlockNum;
        }
        else {
            indirectBlock.indirectbuf[i] = dataBlockNum;
        }
    }

    char workingbuf[SOFTWARE_DISK_BLOCK_SIZE];
    char *workingbuf2 = buf;
    unsigned long int dataPosition = file->filePosition%SOFTWARE_DISK_BLOCK_SIZE;
    int eofFlag = FALSE;
    if(file->filePosition + numbytes>eofPos) {
        eofFlag = TRUE;
    }
    read_sd_block(&workingbuf, dataBlockNum);

    if(numbytes<SOFTWARE_DISK_BLOCK_SIZE-dataPosition) {
        memcpy((workingbuf+dataPosition), workingbuf2, numbytes);
        if(eofFlag){
            workingbuf[dataPosition+numbytes] = EOF;
            file->inode.fileSize += (unsigned long) (file->filePosition + numbytes - eofPos);
        }
        write_sd_block(&workingbuf, dataBlockNum);
        file->filePosition+=numbytes;
        return numbytes;
    }
    
    bytesCopied += SOFTWARE_DISK_BLOCK_SIZE-dataPosition;
    memcpy(&(workingbuf[dataPosition]), workingbuf2, bytesCopied);
    write_sd_block(&workingbuf, dataBlockNum);

    while(bytesCopied<numbytes) {
        i++;
        if(isDirect==TRUE){
            if(i<NUM_DIRECT_INODE_BLOCKS) {
                dataBlockNum = file->inode.blocks[i];
            }
            else {
                isDirect = FALSE;
                i = i-NUM_DIRECT_INODE_BLOCKS;
                dataBlockNum = file->inode.indirect;
                if(dataBlockNum==0) {
                    file->inode.indirect = firstAvailableDataBlockNum();
                    if(file->inode.indirect==-1) {
                        file->inode.indirect = 0;
                        fserror = FS_OUT_OF_SPACE;
                        return bytesCopied;
                    }
                    toggleDataBit(file->inode.indirect);
                    dataBlockNum = file->inode.indirect;
                }
                read_sd_block(&(indirectBlock.indirectbuf), dataBlockNum);
                dataBlockNum = indirectBlock.indirectbuf[i];
            }
        }
        else {
            dataBlockNum = indirectBlock.indirectbuf[i];
        }
        if(dataBlockNum == 0) {
            dataBlockNum = firstAvailableDataBlockNum();
            if(dataBlockNum==-1) {
                fserror = FS_OUT_OF_SPACE;
                return bytesCopied;
            }
            toggleDataBit(dataBlockNum);
            if(isDirect) {
                file->inode.blocks[i] = dataBlockNum;
            }
            else {
                indirectBlock.indirectbuf[i] = dataBlockNum;
            }
        }
        read_sd_block(&workingbuf, dataBlockNum);
        int j;
        for(j=0;j<SOFTWARE_DISK_BLOCK_SIZE;j++) {
            bytesCopied++;
            if(bytesCopied==numbytes) {
                memcpy((workingbuf2+(bytesCopied-j)), &workingbuf, j);
                if(eofFlag) {
                    workingbuf[j] = EOF;
                    file->inode.fileSize += (unsigned long) (file->filePosition + numbytes - eofPos);
                }
                write_sd_block(&workingbuf, dataBlockNum);
                file->filePosition += bytesCopied;
                return bytesCopied;
            }
        }
        memcpy((workingbuf2 + (bytesCopied-j)), &workingbuf, SOFTWARE_DISK_BLOCK_SIZE);
        write_sd_block(&workingbuf, dataBlockNum);
    }

}

// sets current position in file to 'bytepos', always relative to the
// beginning of file.  Seeks past the current end of file should
// extend the file. Returns 1 on success and 0 on failure.  Always
// sets 'fserror' global.
int seek_file(File file, unsigned long bytepos){
    fserror = FS_NONE;
    if(file==NULL) {
        fserror = FS_FILE_NOT_FOUND;
        return 0;
    }
    if(file->directory.isOpen == 0x0){
        fserror = FS_FILE_NOT_OPEN;
        return 0;
    }
    file->filePosition=bytepos;
    
    int index = bytepos/SOFTWARE_DISK_BLOCK_SIZE + 1;
    while(index<NUM_DIRECT_INODE_BLOCKS) {
        if(file->inode.blocks[index]!=0) {
            return 1;
        }
        index++;
    }

    index -= NUM_DIRECT_INODE_BLOCKS;

    IndirectBlock indirectBlock;
    unsigned short dataBlockNum;

    dataBlockNum = file->inode.indirect;

    if(dataBlockNum==0) {
        return 1;
    }

    read_sd_block(&(indirectBlock.indirectbuf), dataBlockNum);

    while(index<NUM_INDIRECT_BLOCK){
        if(indirectBlock.indirectbuf[index]!=0) {
            return 1;
        }
        index++;
    }

    index = bytepos/SOFTWARE_DISK_BLOCK_SIZE;
    int isIndirect = FALSE;
    if(index<NUM_DIRECT_INODE_BLOCKS) {
        dataBlockNum = file->inode.blocks[index];
    }
    else {
        index -= NUM_DIRECT_INODE_BLOCKS;
        dataBlockNum = file->inode.indirect;
        read_sd_block(&(indirectBlock.indirectbuf), dataBlockNum);
        dataBlockNum = indirectBlock.indirectbuf[index];
        isIndirect = TRUE;
    }
    unsigned short int eofBlock = 0;
    int endSeek = SOFTWARE_DISK_BLOCK_SIZE;
    if(dataBlockNum==0) {
        dataBlockNum = firstAvailableDataBlockNum();
        toggleDataBit(dataBlockNum);
        if(isIndirect) {
            indirectBlock.indirectbuf[index] = dataBlockNum;
            write_sd_block(&(indirectBlock.indirectbuf),file->inode.indirect);
            while(index>=0 && eofBlock != 0) {
                index--;
                if(indirectBlock.indirectbuf[index]!=0) {
                    eofBlock = indirectBlock.indirectbuf[index];
                }
            }
            index+=NUM_DIRECT_INODE_BLOCKS;
        }
        else {
            file->inode.blocks[index] = dataBlockNum;
        }
        while(index>=0 && eofBlock!=0 ) {
            if(file->inode.blocks[index]!=0) {
                eofBlock = file->inode.blocks[index];
            }
            index--;
        }
    }
    else {
        endSeek = bytepos%SOFTWARE_DISK_BLOCK_SIZE;
    }
    char workingbuf[SOFTWARE_DISK_BLOCK_SIZE];
    read_sd_block(&workingbuf, eofBlock);

    for(int i = 0; i<endSeek; i++) {
        if(workingbuf[i]==EOF) {
            workingbuf[i] = 0;
            endSeek = bytepos%SOFTWARE_DISK_BLOCK_SIZE;
            break;
        }
    }
    if(eofBlock!=dataBlockNum) {
        write_sd_block(&workingbuf, eofBlock);
        read_sd_block(&workingbuf, dataBlockNum);
    }
    workingbuf[endSeek] = EOF;
    write_sd_block(&workingbuf,dataBlockNum);

}//use char=EOF to denote end of file

// returns the current length of the file in bytes. Always sets 'fserror' global.
unsigned long file_length(File file) {
    fserror = FS_NONE;
    if(file==NULL) {
        fserror = FS_FILE_NOT_FOUND;
        return 0;
    }
    if(file->directory.isOpen == 0x0) {
        fserror = FS_FILE_NOT_OPEN;
    }
    else {
        return file->inode.fileSize;
    }
}

// deletes the file named 'name', if it exists. Returns 1 on success, 0 on failure. 
// Always sets 'fserror' global.   
int delete_file(char *name) {
    fserror = FS_NONE;
    if(file_exists(name)) {
        if(workingDirectory.isOpen==0x1) {
            fserror = FS_FILE_OPEN;
            return FALSE;
        }
        unsigned short int directoryBlockNum = getDirectoryBlockNum(workingDirectory.directoryNum);
        unsigned short int inodeBlockNum = getInodeBlockNum(workingDirectory.inodeNum);
        unsigned short int dirPosOnBlock = workingDirectory.directoryNum%DIRECTORIES_PER_BLOCK;
        unsigned short int inodePosOnBlock = workingDirectory.inodeNum%INODES_PER_BLOCK;

        char workingbuf[SOFTWARE_DISK_BLOCK_SIZE];
        DirectoryBlock directoryBlock;
        InodeBlock inodeBlock;

        read_sd_block(&workingbuf, directoryBlockNum);
        memcpy(&(directoryBlock.directoriesBuf),&workingbuf,sizeof(directoryBlock.directoriesBuf));
        Directory directory = directoryBlock.directoriesBuf[dirPosOnBlock];
        for (int i = 0; i<MAX_NAME_SIZE; i++) {
            directory.fileName[i] = 0;
        }
        directory.inodeNum = 0;
        directoryBlock.directoriesBuf[dirPosOnBlock] = directory;
        memcpy(&workingbuf, &(directoryBlock.directoriesBuf), sizeof(directoryBlock.directoriesBuf));
        write_sd_block(&workingbuf, directoryBlockNum);

        read_sd_block(&workingbuf, inodeBlockNum);
        memcpy(&(inodeBlock.inodesBuf),&workingbuf,sizeof(inodeBlock.inodesBuf));
        Inode inode = inodeBlock.inodesBuf[inodePosOnBlock];

        for(int i=0; i<NUM_DIRECT_INODE_BLOCKS;i++) {
            if(inode.blocks[i] != 0) {
                toggleDataBit(inode.blocks[i]);
                inode.blocks[i] = 0;
            }
        }
        if(inode.indirect != 0) {
            IndirectBlock indirectBlock;
            read_sd_block(&(indirectBlock.indirectbuf), inode.indirect);
            for(int i = 0; i<NUM_INDIRECT_BLOCK; i++) {
                if(indirectBlock.indirectbuf[i] != 0) {
                    toggleDataBit(indirectBlock.indirectbuf[i]);
                    indirectBlock.indirectbuf[i] = 0;
                }
            }
            write_sd_block(&(indirectBlock.indirectbuf), inode.indirect);
            toggleDataBit(inode.indirect);
            inode.indirect = 0;
        }
        inode.fileSize = 0;
        inodeBlock.inodesBuf[inodePosOnBlock] = inode;
        memcpy(&workingbuf, &(inodeBlock.inodesBuf), sizeof(inodeBlock.inodesBuf));
        write_sd_block(&workingbuf, inodeBlockNum);

        toggleDirectoryBit(directoryBlockNum);
        toggleInodeBit(inodeBlockNum);
        return TRUE;
    }
    else {
        fserror = FS_FILE_NOT_FOUND;
        return FALSE;
    }
} 

// determines if a file with 'name' exists and returns 1 if it exists, otherwise 0.
// Always sets 'fserror' global.
int file_exists(char *name) {
    fserror = FS_NONE;
    Bitmap directoryBits;
    read_sd_block(&(directoryBits.bitmapbuf), DIRECTORY_BITMAP_INDEX);
    for(int i = 0; i<SOFTWARE_DISK_BLOCK_SIZE; i++) {
        for(int j = 0; j<8; j++) {
            if(check_bit(directoryBits.bitmapbuf[i], j) == TRUE) {
                unsigned short int directoryNum = i*8+j;
                Directory directory = getDirectoryFromDirectoryNum(directoryNum);
                char * const pointer = directory.fileName;
                if(strcmp(name, pointer)==0) {
                    workingDirectory = directory;
                    return TRUE;
                }
            }
        }
    }
    return FALSE;
};

// describe current filesystem error code by printing a descriptive message to standard
// error.
void fs_print_error(void){
    if(fserror == FS_NONE) {
        printf("No Error\n");
    } 
    else if(fserror == FS_OUT_OF_SPACE){
        printf("the operation caused the software disk to fill up\n");
    }
    else if(fserror == FS_FILE_NOT_OPEN){
        printf("attempted read/write/close/etc. on file that isn’t open\n");
    }
    else if(fserror == FS_FILE_OPEN){
        printf("file is already open. Concurrent opens are not supported and neither is deleting a file that is open.\n");
    }
    else if(fserror == FS_FILE_NOT_FOUND){
        printf("attempted open or delete of file that doesn’t exist\n");
    }
    else if(fserror == FS_FILE_READ_ONLY){
        printf("attempted write to file opened for READ_ONLY\n");
    }
    else if(fserror == FS_FILE_ALREADY_EXISTS){
        printf("attempted creation of file with existing name\n");
    }
    else if(fserror == FS_EXCEEDS_MAX_FILE_SIZE){
        printf("seek or write would exceed max file size\n");
    }
    else if(fserror == FS_ILLEGAL_FILENAME){
        printf("filename begins with a null character\n");
    }
    else if(fserror == FS_IO_ERROR){
        printf("something really bad happened\n");
    }
}


