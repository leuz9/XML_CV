////////////////////////////////////////////////////////////////////////////
// Constantes
var FONT_COLOR		= '#C9C5FF';
var FONT_FAMILY		= 'Arial';
var FONT_SIZE		= 14;
var MENUBAR_HEIGHT	= 22;
var BGCOLOR			= '#C9C5FF';
var HIGHLIGH_COLOR	= 'SteelBlue';

// Fin de constantes
////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
// Fonctions générales

function OverlightItem( sNom )
{
	objItem		= document.getElementById( sNom );

	if ( objItem )
		objItem.style.backgroundColor = HIGHLIGH_COLOR;

}

function UndoOverlightItem( sNom )
{
	objItem		= document.getElementById( sNom );

	if ( objItem )
		objItem.style.backgroundColor = BGCOLOR;
}

function ShowMenu( sNom )
{
	// on récupère le menu
	objMenu						= document.getElementById( sNom );
	objMenu.style.visibility 	= 'visible';
}

function HideMenu( sNom )
{
	objMenu						= document.getElementById( sNom );
	objMenu.style.visibility 	= 'hidden';
}

function SwitchMenuVisibility( sNom )
{
	var bVisibility = false;
	
	objMenu		= document.getElementById( sNom );

	if ( bVisibility )
		HideMenu( sNom );
	else
		ShowMenu( sNom );
}

// Fin de fonctions générales
////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
//	Classe menubar
//

function MenuBar( sMenuBarName, sParentElementName )
{
	// propriétés
	this._objMenuBar	= null;
	this._nMenuCount	= 0;
	this._tabMenus		= new Array();
	
	
	// méthodes
	this.AddMenu		= MenuBar_AddMenu;
	this.GetDivElement	= MenuBar_GetDivElement;

	// construction
	// on ajoute une barre de menus nommée sMenuBarName
	this._objMenuBar 						= document.createElement( 'div' );
	this._objMenuBar.style.height			= MENUBAR_HEIGHT;
	this._objMenuBar.id						= sMenuBarName;
	this._objMenuBar.style.backgroundColor	= BGCOLOR;
	
	
	var objParent = document.getElementById( sParentElementName );

	objParent.appendChild( this._objMenuBar );
}

function MenuBar_AddMenu( sMenuName )
{
	this._nMenuCount ++;
	this._tabMenus.push( new Menu( sMenuName, this._objMenuBar, this._nMenuCount ) );
	return this._tabMenus[ this._nMenuCount  - 1 ];
}

function MenuBar_GetDivElement()
{
	return this._objMenuBar;
}

// Fin de classe MenuBar
////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////
//
//	Classe menu
//

function Menu( sMenuName, objMenuBar, nId )
{
	var sId					= objMenuBar.id + '_Menu_' + nId + '_' + sMenuName;
	var sPopUpMenuId		= sId + '_PopUp';
	
	// propriétés
	this._sId				= sId;
	this._objMenu			= null;
	this._objPopUpMenu		= null;
	this._nMenuItemCount	= 0;
	this._tabMenuItems		= new Array();
	
	// méthodes
	this.AddMenuItem		= Menu_AddMenuItem;
	this.GetDivElement		= Menu_GetDivElement;
	
	
	// construction
	// on ajoute une barre de menus nommée sMenuBarName
	this._objMenu			= document.createElement( 'div' );
	this._objMenu.id		= this._sId;

	// libellé du menu
	this._objMenu.appendChild( document.createTextNode( sMenuName ) );
	
	this._objMenu.style.backgroundColor = BGCOLOR;
	this._objMenu.style.fontFamily		= FONT_FAMILY;
	this._objMenu.style.fontColor		= FONT_COLOR;
	this._objMenu.style.fontSize		= FONT_SIZE;
	this._objMenu.style.fontWeight		= 'bold';
	this._objMenu.style.position		= 'absolute';
	this._objMenu.style.left			= 100 * ( nId - 1 ) + 5;
	this._objMenu.style.width			= 100;
	this._objMenu.style.borderTop		= '1px solid';
	this._objMenu.style.borderLeft		= '1px solid';
	this._objMenu.style.borderRight		= '2px solid';
	this._objMenu.style.borderBottom	= '2px solid';
	this._objMenu.style.cursor			= 'pointer';
	this._objMenu.align					= 'center';
	this._objMenu.style.height			= MENUBAR_HEIGHT;

	this._objMenu.onmouseover = function(){
											OverlightItem( sId );
											ShowMenu( sPopUpMenuId );
											};
	this._objMenu.onmouseout = function(){
											UndoOverlightItem( sId );
											HideMenu( sPopUpMenuId );
											};

	objMenuBar.appendChild( this._objMenu );	

	// on crée le popup
	this._objPopUpMenu			= document.createElement( 'div' );
	this._objPopUpMenu.id		= sPopUpMenuId;
	
	this._objPopUpMenu.style.position			= 'absolute';
	this._objPopUpMenu.style.width				= this._objMenu.style.width;
	this._objPopUpMenu.style.top				= MENUBAR_HEIGHT - 1;
	this._objPopUpMenu.style.left				= 0;
	this._objPopUpMenu.style.fontWeight			= 'normal';
	this._objPopUpMenu.style.borderColor		= '#000000';
	this._objPopUpMenu.style.borderTop			= '1px solid';
	this._objPopUpMenu.style.borderLeft			= '1px solid';
	this._objPopUpMenu.style.borderRight		= '2px solid';
	this._objPopUpMenu.style.borderBottom		= '2px solid';
	this._objPopUpMenu.style.backgroundColor	= BGCOLOR;
	this._objPopUpMenu.style.visibility			= 'hidden';
	this._objPopUpMenu.noWrap					= true;
	
	this._objMenu.appendChild( this._objPopUpMenu );
	
}


function Menu_AddMenuItem( sMenuItemLabel, sOnClick )
{
	this._nMenuItemCount ++;
	this._tabMenuItems.push( new MenuItem( sMenuItemLabel, sOnClick, this._objPopUpMenu, this._nMenuItemCount ) );
	
	// on ajuste la taille du popup
	
	
	return this._tabMenuItems[ this._nMenuItemCount - 1 ];
}

function Menu_GetDivElement()
{
	return this._objMenuBar;
}


// Fin de classe Menu
////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////
//
//	Classe menu item
//

function MenuItem( sLabel, sOnClick, objPopUpMenu, nId )
{
	var sId				= objPopUpMenu.id + '_MenuItem_' + nId;

	// propriétés
	this._sId			= sId;
	this._objMenu		= null;
	
	// méthodes
	this.GetDivElement		= MenuItem_GetDivElement;
	
	// construction
	this._objMenuItem			= document.createElement( 'div' );
	this._objMenuItem.id		= this._sId;

	// libellé du menu item
	this._objMenuItem.appendChild( document.createTextNode( sLabel ) );
	
	this._objMenuItem.style.backgroundColor = BGCOLOR;
	this._objMenuItem.style.cursor			= 'pointer';

	this._objMenuItem.onmouseover	= function(){ OverlightItem( sId ); };
	this._objMenuItem.onmouseout	= function(){ UndoOverlightItem( sId ); };
	this._objMenuItem.onclick		= function(){ eval( sOnClick ); };

	objPopUpMenu.appendChild( this._objMenuItem );	

}

function MenuItem_GetDivElement()
{
	return this._objMenuBar;
}


// Fin de classe Menu
////////////////////////////////////////////////////////////////////////////
