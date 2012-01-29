--MD 6_2
--Dainis Tillers
--dt08050
with Text_IO; use Text_IO;

procedure Svetki is

   task type bag is
      entry take_cookie (weight : out Integer);
      entry take_candy (weight : out Integer);
   end bag;

   task body bag is
      candy_max, candy_min, candy_step, candy_current, cookies_max, cookies_min
, cookies_step, cookies_current : Integer;

   begin

      --maisa esoso konfeksu un cepumu svari
      candy_min     := 100;
      candy_max     := 700;
      candy_current := 700;
      candy_step    := 100;

      cookies_min     := 200;
      cookies_max     := 1000;
      cookies_step    := 100; --uzdevuma formulejuma ir teikts, ka kopa ir 9
                              --konfeksu kastes katra maisa, lai tas ta butu
                              --ir nepieciesams, lai konfeksu kastu svars butu
                              --no 200g lidz 1000g ar 100g soli
      cookies_current := 1000;

      loop
         select
            accept take_cookie (weight : out Integer) do --panem cepumu no
                                                         --maisa

               if cookies_min > cookies_current then  --parbauda vai var
                                                      --panemt cepumu no maisa
                  weight := 0;
               else  --ja ir iespejams panemt cepumu no maisa, tad samazina
                     --maisa maksimali atrodama cepuma svaru
                  weight          := cookies_current;
                  cookies_current := cookies_current - cookies_step;
               end if;

            end take_cookie;

         or
            accept take_candy (weight : out Integer) do  --panem konfekti no
                                                         --maisa

               if candy_min > candy_current then   --parbauda vai var panemt
                                                   --konfekti no maisa

                  weight := 0;
               else  --ja ir iespejams panemt konfekti no maisa, tad samazina
                     --maisa maksimali atrodamo konfeksu svaru
                  weight        := candy_current;
                  candy_current := candy_current - candy_step;
               end if;

            end take_candy;
         or
            terminate; --pabeidz uzdevuma izpildi

         end select;
      end loop;

   end bag;

   type bag_ptr is access bag; --maisu masivs
   bag_set : array (1 .. 10) of bag_ptr;

   task type santa is
      entry init (first_candy : in Boolean; num : in Integer);

   end santa;

   task body santa is
      candy_cnt, candy_weight, cookie_cnt, cookie_weight : Integer;
      search_candy, more_to_search, found, not_inited, previous_loop,
candy_found, cookies_found : Boolean;
      weight, santa_num : Integer;

   begin

      not_inited := True;

      accept init (first_candy : in Boolean; num : in Integer) do --inicialize salaveci
         candy_cnt      := 0;
         candy_weight   := 0;
         cookie_cnt     := 0;
         cookie_cnt     := 0;
         cookie_weight  := 0;
         search_candy   := first_candy;
         more_to_search := True;
         santa_num      := num;
         not_inited     := False;
      end init;

      while not_inited loop --tuksais cikls kamer salavecis nav inicializets, savadak maisus sak apstaigat vel pirms salavecis ir inicializets
         delay 0.0;
      end loop;

      previous_loop := True; -- vai for cikls iepriekseja reize kaut ko atrada, nepieciesams, lai, ja for cikla vidu tiek piepildits maiss ar cepumiem vai konfektem un izpildot for ciklu lidz galam nav atrastas salaveca maisam nepieciesamie pretejie labumi, tad, lai for cikls tiktu izpildits velreiz, tikai jau no sakuma

      candy_found   := False; --pazimes, vai konfektes un cepumi ir atrasti
      cookies_found := False;

      while more_to_search and (candy_found = False or cookies_found = False) and
            (candy_cnt < 15 or cookie_cnt < 19)
      loop

         found := False;

         weight := 0;

         for i in 1 .. 10 loop --cikls apstaiga visus maisus

            if search_candy and more_to_search and candy_cnt < 15 then --panem konfekti, ja nepieciesams

               bag_set (i).take_candy (weight);

               if weight > 0 then --pievieno konfekti salaveca maisam, ja tada ir atrasta
                  candy_cnt    := candy_cnt + 1;
                  candy_weight := candy_weight + weight;
                  found        := True;
               end if;

            elsif more_to_search and cookie_cnt < 19 then --panem cepumu, ja nepieciesams

               bag_set (i).take_cookie (weight);

               if weight > 0 then --pievieno cepumu maisam, tads tika atrasts
                  cookie_cnt    := cookie_cnt + 1;
                  cookie_weight := cookie_weight + weight;
                  found         := True;
               end if;

            end if;

            if candy_cnt > 14 then --ja visas konfektes atrastas, tad vairs nav vajadzigs meklet tas
               candy_found  := True;
               search_candy := False;
            end if;

            if cookie_cnt > 18 then --ja visi cepumi ir atrasti, tad uzstada, ka vairs nav nepieciesams tos meklet
               cookies_found := True;
               search_candy  := True;
            end if;

         end loop;

         if found = False then --ja apmeklejot visus maisus nekas netika atrasts, tad samaina meklejamo lietu pret otru

            if search_candy and candy_found = False then --atzime, ka konfektes ir atrastas un naksies meklet cepumus nakamaja reize
               candy_found  := True;
               search_candy := False;
            elsif search_candy = False and cookies_found = False then --atzime, ka cepumi ir atrasti un nakamja cikla iteracija naksies meklet konfektes
               search_candy  := True;
               cookies_found := True;
            end if;

         end if;

         more_to_search := found or previous_loop; --ar and palidzibu parliecinas, kas pedejas divas iteracijas nekas nav atrasts
         previous_loop  := found;

      end loop;

      if candy_cnt < 15 or cookie_cnt < 19 then --ja netika atrasts pienacigs skaits konfeksu vai cepumu pacinu, tad izvada iztrukstoso skaitu
         Put_Line
           ("nr : " &
            Integer'Image (santa_num) &
            " trukst cepumu : " &
            Integer'Image (19 - cookie_cnt) &
            " trukst konfektes : " &
            Integer'Image (15 - candy_cnt));
      else --ja pienacigs skaits tika atrasts, tad izvada konfeksu un cepumu svaru
         Put_Line
           ("nr : " &
            Integer'Image (santa_num) &
            " cepumi : " &
            Integer'Image (cookie_weight) &
            " konfektes : " &
            Integer'Image (candy_weight));
      end if;

   end santa;

   santa_set : array (1 .. 5) of santa; --salavecu saraksts

begin

   for i in 1 .. 10 loop --izveido maisus
      bag_set (i) := new bag;
   end loop;

   --inicialize salavecus
   santa_set (1).init (True, 1);
   santa_set (2).init (True, 2);
   santa_set (3).init (True, 3);
   santa_set (4).init (False, 4);
   santa_set (5).init (False, 5);

end Svetki;
