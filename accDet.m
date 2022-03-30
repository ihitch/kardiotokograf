function [decStarts,decEnds] = accDet(signal,baseline, fs)
    decStarts = [];
    decEnds = [];
    timeCounter = 0;
    decStart = 0;decEnd=0;
    
    for i = 1:length(signal)
        if(signal(i) >= baseline(i)+10)
            if(timeCounter == 0)
                decStart = i;
            end
            timeCounter = timeCounter + 1/fs;
        end
        if(decStart > 0 && signal(i) <= baseline(i))
            decEnd = i;
        end
        
        if(decStart > 0 && decEnd > 0)
            
            if(timeCounter >=15)
                decStarts = [decStarts decStart];
                decEnds = [decEnds decEnd];
            end
            decStart = 0;
            decEnd = 0;
            timeCounter = 0;
        end
    end

end