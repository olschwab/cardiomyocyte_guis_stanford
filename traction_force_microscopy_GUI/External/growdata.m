function A=growdata(newdata)
% incremental growth of an array by appending rows
%
% usage always involves 3 steps
%  (initial call):   growdata
%  (growth call):    growdata(newdata)
%  (final call):     A = growdata;
% 
%
% Example usage:
%  
%  growdata
%  for i = 1:100000
%    growdata(rand(1,3))
%  end
%  A = growdata;

% recall the stored data
persistent celldata n columncount rowcount totalrows

% which mode are we in?
if (nargout==0) && (nargin>0)
  % its a growth step
  
  % size of the appending data
  [r,c]=size(newdata);
  
  % was this the first call after initialization?
  if isnan(columncount)
    % this is actually an initialization step.
    % set the column count
    columncount = c;
    
    defaultrows = 20000;
    rowcount = max(defaultrows,r);
    
    celldata = {[newdata;zeros(rowcount - r,columncount)]};
    n = r;
    totalrows = n;
    
    if n==rowcount;
      celldata{end+1} = zeros(rowcount,columncount);
      n = 0;
    end
    
  else
    % its an appending call
    if c ~= columncount
      error 'Columns not compatible for appending'
    end
    
    % stuff into the last cell
    celldata{end}(n+(1:r),:) = newdata;
    n = n+r;
    totalrows = totalrows + r;
    
    % do we need to append another cell?
    if n>=rowcount
      rowcount = max(n,10*r);
      celldata{end+1} = zeros(rowcount,columncount);
      n = 0;
    end
    
  end
  
elseif (nargout==0) && (nargin==0)
  % its an initialization call, with no data
  columncount = NaN;

  defaultrows = 20000;
  rowcount = defaultrows;
    
  celldata = {zeros(rowcount,0)};
  n = 0;
  totalrows = 0;
  
elseif (nargout>0) && (nargin==0)
  % its an unpacking step
  
  % first drop any extraneous rows in the last cell
  celldata{end} = celldata{end}(1:n,:);
  
  % concatenate
  A = cat(1,celldata{:});
  
  % and clear the data
  clear celldata n columncount rowcount totalrows
  
else
  % cannot both append and unpack in the same step.
  error 'Cannot append more data and unpack in the same call'
end




