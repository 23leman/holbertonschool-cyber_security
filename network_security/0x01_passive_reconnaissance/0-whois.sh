#!/bin/bash
whois "$1" | awk -F': +' '
BEGIN {
    # Strukturlaşdırılmış sahələrin siyahısı
    split("Name,Organization,Street,City,State/Province,Postal Code,Country,Phone,Phone Ext:,Fax,Fax Ext:,Email", fields, ",")
    split("Registrant,Admin,Tech", sections, ",")
}
{
    # Hər sətirdəki lazımsız boşluqları təmizləyirik
    gsub(/^[ \t]+|[ \t]+$/, "", $1)
    gsub(/^[ \t]+|[ \t]+$/, "", $2)
    
    # Uyğun gələn sahələri massivdə saxlayırıq
    for (s in sections) {
        sec = sections[s]
        for (f in fields) {
            f_name = fields[f]
            # "Phone Ext:" və "Fax Ext:" üçün xüsusi yoxlanış
            if (f_name ~ /Ext:/) {
                match_name = f_name
                sub(/:/, "", match_name)
            } else {
                match_name = f_name
            }
            
            if ($1 == sec " " match_name) {
                # Əgər Street sahəsidirsə, sonuna mütləq bir boşluq əlavə edirik
                if (f_name == "Street" && $2 != "") {
                    $2 = $2 " "
                }
                data[sec, f_name] = $2
            }
        }
    }
}
END {
    out = ""
    for (s in sections) {
        sec = sections[s]
        for (f in fields) {
            f_name = fields[f]
            val = data[sec, f_name]
            out = out sec " " f_name "," val "\n"
        }
    }
    # Son sətirdəki əlavə newline (\n) simvolunu silirik
    printf "%s", substr(out, 1, length(out) - 1)
}
' > "$1.csv"
