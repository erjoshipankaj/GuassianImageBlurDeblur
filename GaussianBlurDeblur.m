function varargout = GaussianBlurDeblur(varargin)
% GAUSSIANBLURDEBLUR MATLAB code for GaussianBlurDeblur.fig
%      GAUSSIANBLURDEBLUR, by itself, creates a new GAUSSIANBLURDEBLUR or raises the existing
%      singleton*.
%
%      H = GAUSSIANBLURDEBLUR returns the handle to a new GAUSSIANBLURDEBLUR or the handle to
%      the existing singleton*.
%
%      GAUSSIANBLURDEBLUR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAUSSIANBLURDEBLUR.M with the given input arguments.
%
%      GAUSSIANBLURDEBLUR('Property','Value',...) creates a new GAUSSIANBLURDEBLUR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GaussianBlurDeblur_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GaussianBlurDeblur_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GaussianBlurDeblur

% Last Modified by GUIDE v2.5 30-May-2017 12:34:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GaussianBlurDeblur_OpeningFcn, ...
                   'gui_OutputFcn',  @GaussianBlurDeblur_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GaussianBlurDeblur is made visible.
function GaussianBlurDeblur_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GaussianBlurDeblur (see VARARGIN)
handles.radius = 10;
set(handles.edit1,'String',handles.radius)
set(handles.slider1,'Value',handles.radius)

% Choose default command line output for GaussianBlurDeblur
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GaussianBlurDeblur wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GaussianBlurDeblur_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonLoadImage.
function buttonLoadImage_Callback(hObject, eventdata, handles)
% hObject    handle to buttonLoadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.bmp;*.jpg;*.tif', 'Load image for Blurring');
file = [pathname filename];
I = imread(file);
if length(size(I))>2
    I = rgb2gray(I);
end
handles.OriginalImage = I;
I = im2double(I);
set(handles.ButtonBlurImage,'Visible','on');
set(handles.axesOriginalImage,'Visible','on');
set(handles.axesImageDFT,'Visible','on');
set(handles.Message4Radius,'Visible','on');
set(handles.edit1,'Visible','on');
set(handles.slider1,'Visible','on');
handles.originalDFT = fft2(I);
axes(handles.axesOriginalImage);
imshow(handles.OriginalImage)
axes(handles.axesImageDFT);
imshow(fftshift(abs(handles.originalDFT)))
guidata(hObject, handles);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
radius = get(handles.edit1,'String');
radius = str2num(radius);
set(handles.slider1,'Value',radius)

guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
radius = get(handles.slider1,'Value');
set(handles.edit1,'String',fix(radius))

guidata(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in ButtonBlurImage.
function ButtonBlurImage_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonBlurImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
r = get(handles.edit1,'String');
r = str2num(r);
blurImage = GaussianBlur(handles.OriginalImage,r);
set(handles.axesBlluredImage,'Visible','on');
set(handles.axesFilterrespose,'Visible','on');
axes(handles.axesBlluredImage)
imshow(blurImage)
[row,col]=size(handles.OriginalImage);
H = gaussian_lp(row,col,r);
axes(handles.axesFilterrespose)
imshow(fftshift(H))
set(handles.ButtonDeblurImage,'Visible','on');
handles.blurImage = blurImage;
guidata(hObject, handles)

% --- Executes on button press in ButtonDeblurImage.
function ButtonDeblurImage_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonDeblurImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
blurImage = handles.blurImage;
r = EstRadius(blurImage);
[row,col] = size(blurImage);
H = gaussian_lp(row,col,fix(r));
PSF = otf2psf(H,[fix(row/3),fix(col/3)]);
I_rc = deconvwnr(blurImage,PSF,0);
mgsStr = strcat('Estimated Radius = ', num2str(fix(r)));
set(handles.axesRCImage,'Visible','on');
set(handles.textEstimatedRadius,'Visible','on');
set(handles.axesEstimatedFilterReponse,'Visible','on');
set(handles.textEstimatedRadius,'String',mgsStr)
axes(handles.axesRCImage)
imshow(I_rc)
axes(handles.axesEstimatedFilterReponse)
imshow(fftshift(H))
