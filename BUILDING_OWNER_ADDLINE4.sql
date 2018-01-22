
CREATE OR REPLACE FUNCTION        AMANDA.BUILDING_OWNER_ADDLINE4 (parmFolderRSN number)
   return varchar2  is
/* Add on Task1234 *
 New change on V1.2 *
 
 Someone change on master branch */
vl_addressline4 varchar2(600);
v_ADDRHOUSE            amanda.people.addrhouse%type := null;
v_ADDRSTREET            amanda.people.addrstreet%type := null;
v_ADDRUNITTYPE          amanda.people.addrunittype%type := null;
v_ADDRUNIT              amanda.people.addrunit%type := null;
v_ADDRCITY              amanda.people.addrcity%type := null;
v_ADDRPROVINCE          amanda.people.addrprovince%type := null;
v_ADDRPOSTAL            amanda.people.addrpostal%type := null;

v_ADDRESSLINE1   VARCHAR2(800);
v_ADDRESSLINE2   VARCHAR2(800);


begin

     begin
        select p.addrhouse, p.addrstreet,
           p.addrunittype, p.addrunit, p.addrcity, p.addrprovince, p.addrpostal,
           p.addressline1, p.addressline2
     into v_addrhouse, v_addrstreet,
          v_addrunittype, v_addrunit, v_addrcity, v_addrprovince, v_addrpostal,
          v_addressline1, v_addressline2
        from folder f,  property pb,  propertypeople pp, people p
        where f.folderrsn = parmFolderRSN
        and pb.propertyrsn(+) = f.propertyrsn
        and pp.propertyrsn(+) = pb.parentpropertyrsn
        and p.peoplersn(+) = pp.peoplersn
        and rownum = 1;

     exception
           WHEN NO_DATA_FOUND THEN
            v_addrstreet := null;
            v_addressline2 := null;
     end;

if v_addrstreet is not null then
      vl_addressline4 := rtrim(v_addrcity)||' '||rtrim(v_addrprovince);
   else
      vl_addressline4 := v_addressline2;
end if;

return vl_addressline4;

end building_owner_addline4;

