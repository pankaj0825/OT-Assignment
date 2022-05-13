#!/bin/bash

sudo apt-get install toilet lolcat boxes 2> /dev/null 1> /dev/null

_randomValueVar=$(((RND=RANDOM<<15|RANDOM)) ; echo ${RND: -6})

source ./printtable.sh

_hostFileLocation="/etc/hosts"

while getopts "a:r:n:o:" o; do
    case "${o}" in
        a)
            _ipAddressVar=${OPTARG}
            ;;
        r)
            _ruleFileVar=${OPTARG}
            ;;
        n)
            _AbhyarthiNameVar=${OPTARG}
            ;;
        o)
            _organizationNameVar=${OPTARG}
            ;;
        *)
            echo "no help"
        esac
done

nullCheckerFunction() {
    nullValue=$1
    if [[ "${nullValue}" == "null" ]] || [[ "${nullValue}" == "" ]] ;
    then
        echo "break"
    fi
}

_hostEntryRemoveFunc() {
    _removalIpAddressVar=$1
    sudo sed -i '/##awsninjabatch/d' ${_hostFileLocation}
}

_hostEntryAddFunc() {
    _addIpAddressVar=$1
    _addDnsVar=$2
    sudo /bin/bash -c "echo \"${_addIpAddressVar} ${_addDnsVar} ##awsninjabatch\" >> ${_hostFileLocation}"
}

_addressGatherFromRuleFileFunc() {
    _positionVar=$1
    cat ${_ruleFileVar} | yq ".addresses[${_positionVar}].address"
}

_contentGatherFromRuleFileFunc() {
    _positionVar=$1
    cat ${_ruleFileVar} | yq ".addresses[${_positionVar}].content"
}

_validatorFunc() {
    _addressValidationVar="$1"
    _contentValidationVar="$2"
    _curlContentValidationVar=$(curl --silent ${_addressValidationVar})
    if [[ "${_contentValidationVar}" == "${_curlContentValidationVar}" ]];
    then
        echo -e "\e[32mValid\e[0m"
    else
        echo -e "\e[31mInvalid\e[0m"
    fi
}

_i=0

echo "Address,Status" >> /tmp/normalfile_${_randomValueVar}

while true
do
    NULLCHECKER=$(cat ${_ruleFileVar} | yq ".addresses[${_i}]")
    BREAKCHECKER=$(nullCheckerFunction ${NULLCHECKER})
    ${BREAKCHECKER}
    CONTENTGATHERVAR=$(_contentGatherFromRuleFileFunc ${_i})
    ADDRESSGATHERVAR=$(_addressGatherFromRuleFileFunc ${_i})
    _hostEntryAddFunc ${_ipAddressVar} ${ADDRESSGATHERVAR}
    VALIDATIONVAR=$(_validatorFunc "${ADDRESSGATHERVAR}" "${CONTENTGATHERVAR}")
    _hostEntryRemoveFunc ${_ipAddressVar} ${ADDRESSGATHERVAR}
    echo "${ADDRESSGATHERVAR},${VALIDATIONVAR}" >> /tmp/normalfile_${_randomValueVar}
    ((_i++))
done

toilet  ${_organizationNameVar}  | boxes -d cat -a hc -p h8| lolcat -p 4.0 -F 0.0
echo ""
echo "                              Abhyarthi:     ${_AbhyarthiNameVar}"  | boxes -d  stone |  lolcat
echo ""

_printTableOuputGatherVar=$(printTable ',' "$(cat /tmp/normalfile_${_randomValueVar})")

echo "$_printTableOuputGatherVar" | boxes -d tex-cmt -a hc -p h8 | boxes -d tex-cmt -a hc -p h8 | boxes -d tex-cmt -a hc -p h8 | sed 's/%//g'

echo "" > /tmp/normalfile_${_randomValueVar}

rm -rf /tmp/normalfile_${_randomValueVar}
