# returns the full table of LCS lengths, or [] if either s1 or s2 is empty
def table(s1, s2):
    tbl = [[0 for j in range(len(s2))] for i in range(len(s1))]
    for i in range(len(s1)):
        for j in range(len(s2)):
            if (s1[i] == s2[j]):
                if (i>0 and j>0):
                    tbl[i][j] = tbl[i-1][j-1] + 1
                else:
                    tbl[i][j] = 1
            else:
                if (i>0 and j>0):
                    tbl[i][j] = max(tbl[i-1][j], tbl[i][j-1])
                elif (i>0):
                    tbl[i][j] = tbl[i-1][j]
                elif (j>0):
                    tbl[i][j] = tbl[i][j-1]
                else:
                     tbl[i][j] = 0
    return tbl

# return the final LCS string, given  tbl = table(s1, s2)
def match_string(s1, s2, tbl):
    i = len(s1) - 1
    j = len(s2) - 1
    LCS = []
    while (i>=0):
        if i == 0 and tbl[0][j] == 1:
                LCS.append(s1[i])
        elif i>0 and tbl[i][j] > tbl[i-1][j]:
            LCS.append(s1[i])
            j = j - 1 # ATTENTION: don't forget j--, otherwise the code will fail for input like s1 = 'XMJYAUZ' s2 = 'MZJAWXU'
        i = i-1
    LCS.reverse() # ATTENTION: what we get after the while loop is the reverse of the correct answer
    return LCS

# return the final LCS length, given  tbl = table(s1, s2)
def match_length(tbl):
    i = len(tbl) - 1
    if i<0: # ATTENTION: s1 might be ''
        return 0
    else:
        j = len(tbl[0]) - 1
        if j<0: # ATTENTION: s2 might be ''
            return 0
        else:
            return tbl[i][j]
