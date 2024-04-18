function varargout = Soleil(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Soleil_OpeningFcn, ...
                   'gui_OutputFcn',  @Soleil_OutputFcn, ...
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

% --- Executes just before Soleil is made visible.
function Soleil_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);

    clc
    global R F phiX phiZ phiT phiF x y z n phiL
    a = clock;
    str = num2str( a( 3 ) );
    txtJOUR = findobj( gcf, 'tag', 'JOUR' );
    set(txtJOUR,'string',str);
    str = num2str( a( 2 ) );
    txtMOIS = findobj( gcf, 'tag', 'MOIS' );
    set(txtMOIS,'string',str);

% --- Outputs from this function are returned to the command line.
function varargout = Soleil_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on slider movement.
function LATITUDE_Callback(hObject, eventdata, handles)
    global R F phiX phiZ phiT phiF x y z n phiL nF
    phiX = get(hObject,'Value') + 90;
    sPlot(R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n, nF );

    % SET TEXT BOX
    str = num2str(floor(abs(phiX-90)));
    txtLATITUDE = findobj(gcf,'tag','TXT_LATITUDE');
    set(txtLATITUDE,'string',str);
    
    text = findobj(gcf,'tag','text9');
    if phiX > 90
        set(text,'string','Nord');
    else    set(text,'string','Sud');
    end
    
% --- Executes during object creation, after setting all properties.
function LATITUDE_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function SPHERE_RZ_Callback(hObject, eventdata, handles)
    global R F phiX phiZ phiT phiF x y z n phiL nF
    phiZ = get(hObject,'Value');
    sPlot(R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n, nF );

    % SET TEXT BOX
    str = num2str(floor(phiZ));
    txtRZ = findobj(gcf,'tag','TXT_RZ');
    set(txtRZ,'string',str);

% --- Executes during object creation, after setting all properties.
function SPHERE_RZ_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function TXT_LATITUDE_Callback(hObject, eventdata, handles)
    global R F phiX phiZ phiT phiF x y z n phiL nF
    
    LATITUDE = findobj(gcf,'tag','LATITUDE');
    str = get(handles.text9,'String');
    if strcmp(str,'Nord') == 1
        phiX = str2double(get(hObject,'String')) + 90;
        set(LATITUDE,'Value',phiX-90);
    else
        phiX = -str2double(get(hObject,'String')) + 90;
        set(LATITUDE,'Value',phiX-90);
    end

    sPlot(R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n, nF );

% --- Executes during object creation, after setting all properties.
function TXT_LATITUDE_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function TXT_RZ_Callback(hObject, eventdata, handles)
    global R F phiX phiZ phiT phiF x y z n phiL nF
    phiZ = str2double(get(hObject,'String'));
    sphereRZ = findobj(gcf,'tag','SPHERE_RZ');
    set(sphereRZ,'Value',phiZ);

    sPlot(R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n, nF );
% --- Executes during object creation, after setting all properties.
function TXT_RZ_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function SPHERE_TX_Callback(hObject, eventdata, handles)
    global R F phiX phiZ phiT phiF x y z n phiL nF
    x = get(hObject,'Value');
    
    str = num2str(floor(x));
    txtTX = findobj(gcf,'tag','TXT_TX');
    set( txtTX, 'string', str );
    
    sPlot(R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n, nF );
% --- Executes during object creation, after setting all properties.
function SPHERE_TX_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function SPHERE_TY_Callback(hObject, eventdata, handles)
    global R F phiX phiZ phiT phiF x y z n phiL nF
    y = get(hObject,'Value');
    
    str = num2str(floor(y));
    txtTY = findobj(gcf,'tag','TXT_TY');
    set( txtTY, 'string', str );
    
    sPlot(R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n, nF );
% --- Executes during object creation, after setting all properties.
function SPHERE_TY_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function TXT_TX_Callback(hObject, eventdata, handles)
    global R F phiX phiZ phiT phiF x y z n phiL nF
    x = str2double(get(hObject,'String'));
    txtRX = findobj( gcf, 'tag', 'SPHERE_TX' );
    set( txtRX, 'Value', x );

    sPlot(R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n, nF );
% --- Executes during object creation, after setting all properties.
function TXT_TX_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function TXT_TY_Callback(hObject, eventdata, handles)
    global R F phiX phiZ phiT phiF x y z n phiL nF
    y = str2double(get(hObject,'String'));
    txtRY = findobj(gcf,'tag','SPHERE_TY');
    set( txtRY, 'Value', y );

    sPlot(R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n, nF );
% --- Executes during object creation, after setting all properties.
function TXT_TY_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function SPHERE_TZ_Callback(hObject, eventdata, handles)
    global R F phiX phiZ phiT phiF x y z n phiL nF
    z = get(hObject,'Value');
    
    str = num2str(floor(z));
    txtTZ = findobj(gcf,'tag','TXT_TZ');
    set( txtTZ, 'string', str );
    
    barF( F, phiF, z, nF );
    sPlot(R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n, nF );
% --- Executes during object creation, after setting all properties.
function SPHERE_TZ_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function TXT_TZ_Callback(hObject, eventdata, handles)
    global R F phiX phiZ phiT phiF x y z n phiL nF
    z = str2double(get(hObject,'String'));
    txtRZ = findobj(gcf,'tag','SPHERE_TZ');
    set( txtRZ, 'Value', z );
    
    barF( F, phiF, z, nF );
    sPlot(R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n, nF );
% --- Executes during object creation, after setting all properties.
function TXT_TZ_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)

% --- Executes on slider movement.
function LONGITUDE_Callback(hObject, eventdata, handles)
    global R F phiX phiZ phiT phiF x y z n phiL nF
    phiL = get(hObject,'Value');

    % SET TEXT BOX
    str = num2str(floor(abs(phiL)));
    txtLONGITUDE = findobj(gcf,'tag','TXT_LONGITUDE');
    set(txtLONGITUDE,'string',str);
    
    text1 = findobj(gcf,'tag','text12');
    text2 = findobj(gcf,'tag','text15');
    
    if phiL > 0
        set(text1,'string','Est');
        set(text2,'string','+ GMT');
    else
        set(text1,'string','Ouest');
        set(text2,'string','- GMT');
    end
    
    txtFUSEAU = findobj(gcf,'tag','FUSEAU');
    str = num2str( floor( ( abs( phiL ) + 7.5 ) / 15 ) );
    set(txtFUSEAU,'string',str);
    
    phiL = mod( phiL, 15 ) * phiL / abs( phiL );
    sPlot(R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n, nF );

% --- Executes during object creation, after setting all properties.
function LONGITUDE_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function TXT_LONGITUDE_Callback(hObject, eventdata, handles)
    global R F phiX phiZ phiT phiF x y z n phiL nF
    
    LONGITUDE = findobj(gcf,'tag','LONGITUDE');
    str = get(handles.text12,'String');
    if strcmp(str,'Est') == 1
        phiL = str2double(get(hObject,'String'));
        set( LONGITUDE, 'Value', phiL );
    else
        phiL = - str2double(get(hObject,'String'));
        set( LONGITUDE, 'Value', phiL );
    end
    
    txtFUSEAU = findobj(gcf,'tag','FUSEAU');
    str = num2str( floor( ( abs( phiL ) + 7.5 ) / 15 ) );
    set(txtFUSEAU,'string',str);
    
    phiL = mod( phiL, 15 ) * phiL / abs( phiL );
    sPlot(R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n, nF );
% --- Executes during object creation, after setting all properties.
function TXT_LONGITUDE_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FUSEAU_Callback(hObject, eventdata, handles)
    
% --- Executes during object creation, after setting all properties.
function FUSEAU_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function JOUR_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function JOUR_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in HEURE_HIVER.
function HEURE_HIVER_Callback(hObject, eventdata, handles)

function MOIS_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function MOIS_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OUVRIR.
function OUVRIR_Callback(hObject, eventdata, handles)

    global R F phiX phiZ phiT phiF x y z n phiL nF
    n = 4*24;           % DIVISER LES CIRCLES EN N PARTIE
    phiX = 90;          % ROTATION AUTOUR L'AXE X
    phiZ = 0;           % ROTATION AUTOUR L'AXE Z
    phiL = 0;           % LONGITUDE DE LA LOCATION
    phiT = radians( 23.4394 ); % LATITUDE DU TROPIQUE
    % TRANSLATION DE LA SPHERE
    x = 0;
    y = 0;
    z = 0;
    
    % LES FENETRES
    [ nF, F, phiF, L ] = ReadDXF();
    
    str = '';
    for i = 1 : ( nF - 1 )
        str = strcat( str, 'Fenetre-');
        str = strcat( str, num2str( i ) );
        str = strcat( str, '|');
    end
    str = strcat( str, 'Fenetre-');
    str = strcat( str, num2str( nF ) );
    
    LIST = findobj( gcf, 'tag', 'F_LIST' );
    set( LIST ,'string', str );
    % PREMIER PLOT
    h = gca;
    delete( h );
    R = iniPlot( phiX, phiZ, phiT, F, phiF, n, nF, L );

% --- Executes on selection change in F_LIST.
function F_LIST_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function F_LIST_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in F_PLOT.
function F_PLOT_Callback(hObject, eventdata, handles)
    global R F phiX phiZ phiT phiF x y z phiL
    clc
    Date = clock;
    Y = Date(1);
    M = str2double(get(handles.MOIS,'String'));
    D = str2double(get(handles.JOUR,'String'));
    
    i = get( handles.F_LIST, 'Value' );
    F2D = matrix3D2D ( F, i );

    phiL = abs( get(handles.LONGITUDE,'Value') );
    iFUSEAU = str2double(get(handles.FUSEAU,'String')) - floor( ( phiL + 7.5 ) / 15 ) - get(handles.HEURE_HIVER,'Value');
%     if phiL >= 7.5, phiL = mod( phiL - 7.5, 15 ); , end
    phiL = mod( phiL, 15 );
    sPlot2D ( Y, M, D, R, F2D, phiX, phiZ, phiL - iFUSEAU * 15, phiT, phiF( i ), x, y, z, 20*24 );
%     phiL
%     sPlot2D ( Y, M, D, R, F2D, phiX, phiZ, phiL, phiT, phiF( i ), x, y,
%     z, 20*24 );