function [decStarts,decEnds] = decDet(signal,baseline, fs)
    decStarts = [];
    decEnds = [];
    timeCounter = 0;
    decEndCounter1 = 0;
    decEndCounter2 = 0;
    decStart = 0;decEnd=0;
    
    for i = 1:length(signal)
        if(signal(i) <= baseline(i)-10)
            if(timeCounter == 0)
                decStart = i;
            end
            timeCounter = timeCounter + 1/fs;
        end
        if(decStart > 0 && signal(i) >= baseline(i))
            decEnd = i;
        end
        if(decStart > 0 && signal(i) <= baseline(i) && signal(i) >= baseline(i)-5)
            decEndCounter1 = decEndCounter1 + 1/fs;
            timeCounter = timeCounter + 1/fs;
            if(decEndCounter1 >= 10)
                decEnd = i;
            end
        end
        if(decStart > 0 && signal(i) <= baseline(i)-5 && signal(i) >= baseline(i)-10)
            decEndCounter2 = decEndCounter2 + 1/fs;
            timeCounter = timeCounter + 1/fs;
            if(decEndCounter2 >= 18)
                decEnd = i;
            end
        end
        
        if(decStart > 0 && decEnd > 0)
            
            if(timeCounter >=15)
                decStarts = [decStarts decStart];
                decEnds = [decEnds decEnd];
            end
            decStart = 0;
            decEnd = 0;
            timeCounter = 0;
            decEndCounter1 = 0;
            decEndCounter2 = 0;
        end
    end

end