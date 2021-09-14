# pandoc_get_template() exports templates for a format

    Code
      suppressMessages(pandoc_get_template())
    Output
      $if(titleblock)$
      $titleblock$
      
      $endif$
      $for(header-includes)$
      $header-includes$
      
      $endfor$
      $for(include-before)$
      $include-before$
      
      $endfor$
      $if(toc)$
      $table-of-contents$
      
      $endif$
      $body$
      $for(include-after)$
      
      $include-after$
      $endfor$

