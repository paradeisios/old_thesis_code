% Boulakis Paradeisios ALexandros 
% 13/12/2020 

function blocks = feedback_blocks(mat_file)

%     Function that loops over a single subject matfile from 
%     the HEART recordings, containing the task tyoe and the feedback condition 
%     per fMRI scan and returns the onset and the duration of the feedback block 
%     (SYNC /ASYNC)
% 
%     INPUT: log (mat_file) ---- Mat file containg experiment data
% 
%     OUTPUT: onsets(dict) ---- Struct with the number of the subject,
%     2 onset lists and 2 duration lists, one for each feedback condition.
   
    
    
    mat = load(mat_file);    
    mat = cat(1,mat.condition,"PAD");
    
    sync_onset     = [];
    sync_duration  = [];
    async_onset    = [];
    async_duration = [];
    
    for ii = 1: length(mat)
            
        if (mat(ii) == "SYNC ") && (mat(ii-1)~= "SYNC ")
            sync_onset = [sync_onset ii];
    
            count = 0;
            position = ii;  
            while mat(position+1)== "SYNC "
                count = count +1;
                position = position +1;
            end      
            sync_duration = [sync_duration count];
        
        elseif (mat(ii) == "OSYNC") && (mat(ii-1)~= "OSYNC")
            async_onset = [async_onset ii];
            
            count = 0;
            position = ii;  
            while mat(position+1)== "OSYNC"
                count = count +1;
                position = position +1;
            end
            async_duration = [async_duration count];
        end
        blocks = struct();
        blocks.name = mat_file(13:17);
        blocks.sync_onset = sync_onset; blocks.sync_duration = sync_duration;
        blocks.async_onset = async_onset; blocks.async_duration = async_duration;
        
        
    end
    end
    
    
    
    
    
    
        
    
