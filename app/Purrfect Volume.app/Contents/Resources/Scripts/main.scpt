JsOsaDAS1.001.00bplist00�Vscripto	� c l a s s   V o l i m i t e r   { 
     c o n s t r u c t o r ( a p p N a m e ,   o n l y O n H e a d p h o n e s )   { 
         t h i s . a p p   =   A p p l i c a t i o n . c u r r e n t A p p l i c a t i o n ( ) ; 
         t h i s . a p p . i n c l u d e S t a n d a r d A d d i t i o n s   =   t r u e ; 
         t h i s . a p p N a m e   =   a p p N a m e ; 
         t h i s . m a x V o l u m e   =   5 0 ; 
         t h i s . o n l y O n H e a d p h o n e s   =   o n l y O n H e a d p h o n e s ; 
         t h i s . h e a d P h o n e s C o n n e c t e d   =   ! t h i s . o n S p e a k e r ( ) ; 
         t h i s . p r e v i o u s V o l u m e   =   n u l l ; 
     } 
 
     g e t   c u r r e n t V o l u m e ( )   { 
         c o n s t   {   o u t p u t V o l u m e   }   =   t h i s . a p p . g e t V o l u m e S e t t i n g s ( ) ; 
         r e t u r n   o u t p u t V o l u m e ; 
     } 
 
     g e t   o u t p u t T y p e T e x t ( )   { 
         r e t u r n   t h i s . o n l y O n H e a d p h o n e s   ?   "�<ߧ   h e a d p h o n e s "   :   "�=�
   g l o b a l " ; 
     } 
 
     g e t   v o l u m e L i m i t T e x t ( )   { 
         r e t u r n   ` L i m i t i n g   y o u r   $ { t h i s . o u t p u t T y p e T e x t }   t o   $ { t h i s . m a x V o l u m e } %   t o   p r o t e c t   y o u r   e a r s ` ; 
     } 
 
     g e t   s h o u l d L i m i t V o l u m e ( )   { 
         r e t u r n   ( 
             t h i s . o n l y O n H e a d p h o n e s   & & 
             t h i s . h e a d P h o n e s C o n n e c t e d   & & 
             t h i s . c u r r e n t V o l u m e   >   t h i s . m a x V o l u m e 
         ) ; 
     } 
 
     o n S p e a k e r ( )   { 
         c o n s t   a u d i o   =   t h i s . a p p . d o S h e l l S c r i p t ( " s y s t e m _ p r o f i l e r   S P A u d i o D a t a T y p e " ) ; 
         r e t u r n   / D e f a u l t   O u t p u t   D e v i c e :   Y e s ( ? : ( ? ! O u t p u t   S o u r c e :   ) [ \ s \ S ] ) * O u t p u t   S o u r c e :   I n t e r n a l   S p e a k e r s ( ? : . * ) $ / g m . t e s t ( 
             a u d i o 
         ) ; 
     } 
 
     c h e c k H e a d P h o n e s ( )   { 
     	 i f   ( ! t h i s . o n l y O n H e a d p h o n e s )   { 
 	 	 	 r e t u r n ; 
 	 	 } 
 
     	 c o n s t   a r e H e a d p h o n e s C o n n e c t e d   =   ! t h i s . o n S p e a k e r ( ) ; 
         c o n s t   w e r e H e a d p h o n e s C o n n e c t e d   =   t h i s . h e a d P h o n e s C o n n e c t e d ; 
 
         i f   ( a r e H e a d p h o n e s C o n n e c t e d   = = =   w e r e H e a d p h o n e s C o n n e c t e d )   { 
 	 	 	 r e t u r n ; 
 	 	 } 
 
 	 	 i f   ( a r e H e a d p h o n e s C o n n e c t e d )   { 
             t h i s . h e a d P h o n e s C o n n e c t e d   =   t r u e ; 
             t h i s . l i m i t V o l u m e ( ) ; 
             t h i s . a p p . d i s p l a y N o t i f i c a t i o n ( " " ,   { 
                 w i t h T i t l e :   "�<ߧ   H e a d p h o n e s   c o n n e c t e d " , 
                 s u b t i t l e :   t h i s . v o l u m e L i m i t T e x t , 
             } ) ; 
 	 	 }   e l s e   { 
             t h i s . h e a d P h o n e s C o n n e c t e d   =   f a l s e ; 
             t h i s . a p p . d i s p l a y N o t i f i c a t i o n ( " " ,   { 
                 w i t h T i t l e :   "�=�   H e a d p h o n e s   d i s c o n n e c t e d " , 
                 s u b t i t l e :   " S t o p p i n g   v o l u m e   l i m i t ,   b e   c a r e f u l " , 
 	 	 	 } ) ; 
         } 
     } 
 
     l i m i t V o l u m e ( )   { 
         i f   ( t h i s . s h o u l d L i m i t V o l u m e )   { 
             t h i s . a p p . b e e p ( ) ; 
             t h i s . a p p . s e t V o l u m e ( n u l l ,   {   o u t p u t V o l u m e :   t h i s . m a x V o l u m e   } ) ; 
         } 
     } 
 
     s t a r t N o t i f i c a t i o n ( )   { 
         t h i s . a p p . d i s p l a y N o t i f i c a t i o n ( " " ,   { 
             w i t h T i t l e :   t h i s . a p p N a m e , 
             s u b t i t l e :   t h i s . v o l u m e L i m i t T e x t , 
 	 	 	 s o u n d N a m e :   " S o n a r " 
         } ) ; 
     } 
 
 	 s t a r t ( )   { 
 	 	 v a r   r e s p o n s e   =   t h i s . a p p . d i s p l a y D i a l o g ( " W h a t ' s   t h e   m a x i m u m   v o l u m e   l e v e l   ( 0 - 1 0 0 ) ? " ,   { 
     	     d e f a u l t A n s w e r :   " 5 0 " , 
         	 b u t t o n s :   [ " O K " ] , 
 	         d e f a u l t B u t t o n :   " O K " 
 	 	 } ) 
 	 	 t h i s . m a x V o l u m e   =   r e s p o n s e . t e x t R e t u r n e d 
 	 	 t h i s . s t a r t N o t i f i c a t i o n ( ) 
 	 } 
 } 
 
 c o n s t   P u r r f e c t V o l u m e   =   n e w   V o l i m i t e r ( " P u r r f e c t   v o l u m e  �=�8 " ,   t r u e ) ; 
 P u r r f e c t V o l u m e . s t a r t ( ) ; 
 
 f u n c t i o n   i d l e ( )   { 
     P u r r f e c t V o l u m e . c h e c k H e a d P h o n e s ( ) ; 
     P u r r f e c t V o l u m e . l i m i t V o l u m e ( ) ; 
     r e t u r n   0 . 0 5 ; 
 } 
                              �jscr  ��ޭ