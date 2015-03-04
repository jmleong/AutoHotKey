import sys, os, glob

def checkPath(fileName):
    if os.path.exists(fileName):
        print "Path file exist"
        inFile = open(fileName, 'r')
        for line in inFile:
            path = line;
            
            

        inFile.close()
        os.remove(fileName)
        os.chdir(path)
        
    else:
        print "Path file doesn't exist"
        


def checkFileExists(fileName):
    if os.path.exists(fileName):
        os.remove(fileName)

def formatLine(line, speed, fileName):
    cache = ''
    output = ''
    cache = line.split()
    cache[0] = cache[0][:-1]
    for c in cache:
        output += c
        output += ', '
    output += speed
    output += fileName
    output += '\n'
    return output

def memSpeed(line):
    cache = ''
    cache = line.split()
    if 'processor' in line:
          cache[6] += ', '
          return cache[6]
    else:
        cache[9] +=', '
        return cache[9]
        

def calResult(core, inFile, result, start, end):
    result.write(core + ',RxDqLeft,RxDqRight,RxVLow,RxVHigh,TxDqLeft,TxDqRight,TxVLow,TxVHigh, Speed, File\n')
    for line in inFile:
        result.write(line)
        end +=1
    result.write('Result,')
    result.write('=abs(max(B' + str(start) + ':B' + str(end) + ')),')
    result.write('=min(C' + str(start) + ':C' + str(end) + '),')
    result.write('=abs(max(D' + str(start) + ':D' + str(end) + ')),')
    result.write('=min(E' + str(start) + ':E' + str(end) + '),')
    result.write('=abs(max(F' + str(start) + ':F' + str(end) + ')),')
    result.write('=min(G' + str(start) + ':G' + str(end) + '),')
    result.write('=abs(max(H' + str(start) + ':H' + str(end) + ')),')
    result.write('=min(I' + str(start) + ':I' + str(end) + '),\n\n')
    start = end + 4
    end += 3
    return start, end

def combineFile(file0, file1, file2, file3, file4, file5, file6, file7, result):
    inFile0 = open(file0, 'r')
    inFile1 = open(file1, 'r')
    inFile2 = open(file2, 'r')
    inFile3 = open(file3, 'r')
    inFile4 = open(file4, 'r')
    inFile5 = open(file5, 'r')
    inFile6 = open(file6, 'r')
    inFile7 = open(file7, 'r')    
    position = 1
    start = 2
    if os.stat(file0)[6] != 0:
        (start, position) = calResult('N0', inFile0, result, start, position)
    if os.stat(file1)[6] != 0:
        (start, position) = calResult('N1', inFile1, result, start, position)
    if os.stat(file2)[6] != 0:
        (start, position) = calResult('N2', inFile2, result, start, position)
    if os.stat(file3)[6] != 0:
        (start, position) = calResult('N3', inFile3, result, start, position)
    if os.stat(file4)[6] != 0:
        (start, position) = calResult('N4', inFile4, result, start, position)
    if os.stat(file5)[6] != 0:
        (start, position) = calResult('N5', inFile5, result, start, position)
    if os.stat(file6)[6] != 0:
        (start, position) = calResult('N6', inFile6, result, start, position)
    if os.stat(file7)[6] != 0:
        (start, position) = calResult('N7', inFile7, result, start, position)        
    inFile0.close()
    inFile1.close()
    inFile2.close()
    inFile3.close()
    inFile4.close()
    inFile5.close()
    inFile6.close()
    inFile7.close()   
    os.remove(file0)
    os.remove(file1)
    os.remove(file2)
    os.remove(file3)
    os.remove(file4)
    os.remove(file5)
    os.remove(file6)
    os.remove(file7)

def main(f):

    print 'Extracting Data...\n'
    
    

    checkFileExists('N0.csv')
    checkFileExists('N1.csv')
    checkFileExists('N2.csv')
    checkFileExists('N3.csv')
    checkFileExists('N4.csv')
    checkFileExists('N5.csv')
    checkFileExists('N6.csv')
    checkFileExists('N7.csv')



    #inFile = open(sys.argv[1], 'r')
    N0File = open('N0.csv', 'a')
    N1File = open('N1.csv', 'a')
    N2File = open('N2.csv', 'a')
    N3File = open('N3.csv', 'a')
    N4File = open('N4.csv', 'a')
    N5File = open('N5.csv', 'a')
    N6File = open('N6.csv', 'a')
    N7File = open('N7.csv', 'a')
    outFile_name = f + ".csv"
    if '.log' in outFile_name:
        outFile_name =  outFile_name.replace('.log', '')
    print outFile_name
    outFile = open(outFile_name, 'w')

    write = False

 
#   for f in glob.glob(inputFile):
    inFile = open(f, 'r')
    for line in inFile:
        if 'Memory behind' in line:
            Speed = memSpeed(line)
            '''
        if 'Memory behind * 1' in line:
            N1Speed = memSpeed(line)
        if 'Memory behind * 2' in line:
            N2Speed = memSpeed(line)
        if 'Memory behind * 3' in line:
            N3Speed = memSpeed(line)
            '''
        if 'STOP_RMT_N' in line:
            write = False
        if write:
             if 'N0.C' in line:
                N0File.write(formatLine(line, Speed, f))
             if 'N1.C' in line:
                N1File.write(formatLine(line, Speed, f))
             if 'N2.C' in line:
                N2File.write(formatLine(line, Speed, f))
             if 'N3.C' in line:
                N3File.write(formatLine(line, Speed, f))
             if 'N4.C' in line:
                N4File.write(formatLine(line, Speed, f))
             if 'N5.C' in line:
                N5File.write(formatLine(line, Speed, f))
             if 'N6.C' in line:
                N6File.write(formatLine(line, Speed, f))
             if 'N7.C' in line:
                N7File.write(formatLine(line, Speed, f))

        if 'RxDqLeft' in line:
                write = True

    inFile.close()

    N0File.close()
    N1File.close()
    N2File.close()
    N3File.close()
    N4File.close()
    N5File.close()
    N6File.close()
    N7File.close()
    
    print 'Data Extraction Completed.\n'

    print 'Calculating Result...\n'

    combineFile('N0.csv', 'N1.csv', 'N2.csv', 'N3.csv', 'N4.csv', 'N5.csv', 'N6.csv', 'N7.csv', outFile)

    print 'Result is exported to "outFile_name.csv"'

    outFile.close()

    # print 'Number of arguments:', len(sys.argv), 'arguments.'
    # print 'Argument List:', str(sys.argv)

checkPath('path.txt')

files = glob.glob('*.log')

for file in files:
        print file
        main(file)