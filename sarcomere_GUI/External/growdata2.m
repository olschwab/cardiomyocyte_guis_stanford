function funH=growdata2(appendmode,blocksize)
% incremental growth of an array by appending rows (or columns)
%
% usage always involves 3 steps
%  (initial call):   funH=growdata2;
%  (growth call):    funH(newdata)
%  (unpacking call): A = funH();
%
%  Alternative initial call:
%                    funH = growdata2(appendmode,blocksize);
%
%  Note that the basic unpacking call, A = funH; will drain
%  the data stored in the function handle funH. Future calls
%  to funH will begin accumulation from an empty state.
%
% 
% arguments: (input)
%  appendmode - (OPTIONAL) specifies appending to rows or columns.
%
%               appendmode == 'rows' --> append new data as rows
%                  of the final array.
%
%               appendmode == 'columns' --> append new data as
%                  columns of the final array.
%
%               DEFAULT: 'rows'
%
%  blocksize - (OPTIONAL) specifies the initial block size to
%               accumulate into. Larger blocksizes will result
%               faster accumulation, but will grab larger chunks
%               of memory at a time.
%
%               DEFAULT: 20000
%
%
% arguments: (output)
%  funH       - function handle which will be used for the growth
%               and terminal calls to unpack the grown array of
%               data.
%
%
% Example usage 1:
%  
%  fun1 = growdata2;
%  for i = 1:100000
%    fun1(i)
%  end
%  A = fun1();
%
% A will have size [100000,1]
%
%
% Example usage 2:
%
%  Note: growdata uses a function handle to a nested function,
%  so multiple arrays may be grown at the same time, simply by
%  assigning a different function name on the first call to
%  growdata. We can also change the appending style for each
%  instance.
%
%  fun1 = growdata2;            % append as new rows by default
%  fun2 = growdata2('columns'); % append as new columns
%  fun3 = growdata2('rows');    % append as new rows
%  for i = 1:10000
%    fun1(rand(2,3))
%    fun2(sin(rand(2,1)))
%    fun3(rand(round(rand(1)*2),2))
%  end
%  A = fun1();
%  B = fun2();
%  C = fun3();
%
% In this case, A will have final size [20000,3], B will
% have size [2, 10000], and C will have a ramdom number of
% rows, with 2 columns.
%
%
% see also: cat, horzcat, vertcat
%
%
%  Author: John D'Errico
%  e-mail: woodchips@rochester.rr.com
%  Release: 1.1
%  Release date: 2/28/07

% when growdata is called, a function handle to a nested
% function is returned.
% first, set up the variables we will need to remember

% check for appendmode
if (nargin<1) || isempty(appendmode)
  appendmode = 'rows';
end
valid = {'rows','columns'};
ind = strmatch(appendmode,valid);
if isempty(ind)
  error 'Appendmode must be ''rows'' or ''columns'' or any contraction'
end
% appendmode == 0 --> append as rows
% appendmode == 1 --> append as columns
appendmode = ind - 1;

% default for blocksize
if (nargin<2) || isempty(blocksize)
  blocksize = 20000;
end
% default number of rows in each cell
rowcount = blocksize;

% we don't know how many columns
columncount = NaN;
celldata = {zeros(rowcount,0)};
n = 0;
totalrows = 0;

% Return a handle to the function which will actually
% do all the work
funH = @growthfun;

% ====================================================
% nested function definition
function A = growthfun(newdata)

% is this a growth call, or a final unpacking call?
if (nargout==0) && (nargin>0)
  % its a growth step
  
  % if appendmode says to use columns, then transpose the
  % data, append as rows. we will re-transpose at the very
  % end to undo this.
  if appendmode
    newdata = newdata';
  end
  
  % size of the appending data
  [r,c]=size(newdata);
  
  % was this the first call after initialization?
  if isnan(columncount)
    % first time called, we need to know the number
    % of columns to expect
    columncount = c;
    
    if r < rowcount
      % rowcount is large enough for now
      celldata = {[newdata;zeros(rowcount - r,columncount)]};
      n = r;
      totalrows = r;
    else
      % the first call overwhelmed rowcount, so make it larger
      n = 0;
      totalrows = r;
      rowcount = 2*r;
      celldata = {newdata, zeros(rowcount,columncount)}; 
    end
  
  else
    % its an appending call after we have seen some data
    if c ~= columncount
      error '# of columns are incompatible for appending to this data'
    end
    
    % stuff into the last cell
    if (n+r)<rowcount
      celldata{end}(n+(1:r),:) = newdata;
      n = n+r;
      totalrows = totalrows + r;
    elseif (n+r)==rowcount
      % exactly filled that last cell, so add a new
      % (empty) cell on to the end
      celldata{end}(n+(1:r),:) = newdata;
      celldata{end+1} = zeros(rowcount,columncount);
      totalrows = totalrows + r;
      n = 0;
    else
      % we will overfill the last cell
      s = rowcount - n;
      celldata{end}(n+(1:s),:) = newdata(1:s,:);
      celldata{end+1} = newdata((s+1):end,:);
      totalrows = totalrows + r;
      n = size(celldata{end},1);
      
      if n>=rowcount
        % enlarge the cell size
        rowcount = n;
        celldata{end+1} = zeros(rowcount,columncount);
        n = 0;
      end
      
    end
  end
  
elseif (nargin==0)
  % its an unpacking step
  
  % first drop any extraneous rows in the last cell
  celldata{end} = celldata{end}(1:n,:);
  
  % concatenate
  if ~appendmode
    % as rows
    A = cat(1,celldata{:});
  else
    % as columns, but we did it as rows, so transpose
    A = cat(1,celldata{:})';
  end
  
  % and clear the data to return some memory
  celldata = {zeros(rowcount,columncount)};
  
elseif (nargout>0) && (nargin>0)
  % cannot both append and unpack in the same step.
  error 'Cannot append more data and unpack in the same call'
end


end % end nested function

end % end main fun



