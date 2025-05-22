Return-Path: <linux-erofs+bounces-353-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72799AC0696
	for <lists+linux-erofs@lfdr.de>; Thu, 22 May 2025 10:08:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b31BX03w4z3c3D;
	Thu, 22 May 2025 18:08:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.61.247
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747901299;
	cv=none; b=NDsA+OYuODSbCK1OcdcVEwrke2DrfCw6JjGqxPd+2WqugxRiRX4ShNBN/0RTaUlVN+oeWVtYhEtwGJhXAS+sX85SGkEEr+NovdaQZVyVOItwGfrbNu9As8ADKHesB1myvMNlQg4m1eVc1VHINjPd29pK29BS3uBKI8CGbRzAVG4NB0Qo/RDiKKRyYY1iNEUQ7v5ceDHBKx9YafjgRsvmGiVK3MKeSpPXWsIS63w+b3jOKT1BGE1th2XLFHLZ/I/EsbHDuIiZkyQdo715E3LDU7yV6VfymNvTfJ7mB7DCgLRgdyz+hMPkFJzBwQPTDNWNwRBd70khC+pyuePUg8GtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747901299; c=relaxed/relaxed;
	bh=Ze4gsgrRBDEzTmJB/vFn8fh/7BqTfQ08+s7HUZV9a3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iiQ/VaCMciweUNK6IUioD7fwJU/MrWOK23s7p67WydsLztjeWjREyPVoCQ18+/D/ywqrJ8iWKEa++ICyq7xZ6YmByiBGg7AsLzV15Lu3ylMaCo0r+K/MZrloGCdFB56dtwoZx7DKxON485s2kT+kYOp2ZdyqMqLZDpGmMQ9AD8tIoy/zhGVLX9qCevvm1ky96j098kRtbrFQJ/kBpDiZ6udvZRnpHwCb4SC/wTpYrjaHLm344bRIhcoC2QeWA8HK8m35bwb0QhiRPPbDgiGBhK8w2s80DXiKE7WO/DJtNkXaBMrkAu2d8s9W1Ih2CaVbH5bBfKHfg8FSTdJGj3ZrVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.61.247; helo=ssh247.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.61.247; helo=ssh247.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b31BT6z4Wz2yfK
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 May 2025 18:08:14 +1000 (AEST)
Received: from jtjnmail201624.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202505221608037672;
        Thu, 22 May 2025 16:08:03 +0800
Received: from jtjnmail201622.home.langchao.com (10.100.2.22) by
 jtjnmail201624.home.langchao.com (10.100.2.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 May 2025 16:08:02 +0800
Received: from jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6])
 by jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6%7]) with mapi
 id 15.01.2507.039; Thu, 22 May 2025 16:08:02 +0800
From: =?utf-8?B?Qm8gTGl1ICjliJjms6IpLea1qua9ruS/oeaBrw==?=
	<liubo03@inspur.com>
To: "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org" <chao@kernel.org>
CC: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] erofs: support deflate decompress by using Intel QAT
Thread-Topic: [PATCH v5] erofs: support deflate decompress by using Intel QAT
Thread-Index: AQHbyuEGmfH0eixYq0GAC0x1fGTM9bPdwY0AgACHwQA=
Date: Thu, 22 May 2025 08:08:02 +0000
Message-ID: <f245b9edfc1b4205804c415cc0608558@inspur.com>
References: <f27f94b56ca2765fd8ee98b075beedc322-5-25linux.alibaba.com@g.corp-email.com>
 <49ca7ddc-4ea7-4081-84ee-609a23b815e4@linux.alibaba.com>
In-Reply-To: <49ca7ddc-4ea7-4081-84ee-609a23b815e4@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-originating-ip: [120.224.42.184]
Content-Type: multipart/signed; micalg=SHA1;
	protocol="application/x-pkcs7-signature";
	boundary="----=_NextPart_000_0030_01DBCB33.44482130"
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
tUid: 2025522160803d54babb357ce7e819c474450970c1f1d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

------=_NextPart_000_0030_01DBCB33.44482130
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: Gao Xiang <hsiangkao@linux.alibaba.com>
>Sent: Thursday, May 22, 2025 3:54 PM
>To: Bo Liu (=E5=88=98=E6=B3=A2)-=E6=B5=AA=E6=BD=AE=E4=BF=A1=E6=81=AF =
<liubo03@inspur.com>; xiang@kernel.org;
>chao@kernel.org
>Cc: linux-erofs@lists.ozlabs.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH v5] erofs: support deflate decompress by using =
Intel QAT
>
>Hi Bo,
>
>On 2025/5/22 14:16, Bo Liu wrote:
>> This patch introdueces the use of the Intel QAT to decompress
>> compressed data in the EROFS filesystem, aiming to improve the
>> decompression speed of compressed datea.
>>
>> We created a 285MiB compressed file and then used the following
>> command to create EROFS images with different cluster size.
>>       # mkfs.erofs -zdeflate,level=3D9 -C16384
>>
>> fio command was used to test random read and small random read(~5%)
>> and sequential read performance.
>>       # fio -filename=3Dtestfile  -bs=3D4k -rw=3Dread -name=3Djob1
>>       # fio -filename=3Dtestfile  -bs=3D4k -rw=3Drandread =
-name=3Djob1
>>       # fio -filename=3Dtestfile  -bs=3D4k -rw=3Drandread =
--io_size=3D14m
>> -name=3Djob1
>>
>> Here are some performance numbers for reference:
>>
>> Processors: Intel(R) Xeon(R) 6766E(144 core)
>> Memory:     521 GiB
>>
>> =
|------------------------------------------------------------------------=
-----|
>> |           | Cluster size | sequential read | randread  | small
>> | randread(5%) |
>> =
|-----------|--------------|-----------------|-----------|---------------=
-----|
>> | Intel QAT |    4096      |    538  MiB/s   | 112 MiB/s |     20.76
>MiB/s    |
>> | Intel QAT |    16384     |    699  MiB/s   | 158 MiB/s |     21.02
>MiB/s    |
>> | Intel QAT |    65536     |    917  MiB/s   | 278 MiB/s |     20.90
>MiB/s    |
>> | Intel QAT |    131072    |    1056 MiB/s   | 351 MiB/s |     23.36
>MiB/s    |
>> | Intel QAT |    262144    |    1145 MiB/s   | 431 MiB/s |     26.66
>MiB/s    |
>> | deflate   |    4096      |    499  MiB/s   | 108 MiB/s |     21.50
>MiB/s    |
>> | deflate   |    16384     |    422  MiB/s   | 125 MiB/s |     18.94
>MiB/s    |
>> | deflate   |    65536     |    452  MiB/s   | 159 MiB/s |     13.02
>MiB/s    |
>> | deflate   |    131072    |    452  MiB/s   | 177 MiB/s |     11.44
>MiB/s    |
>> | deflate   |    262144    |    466  MiB/s   | 194 MiB/s |     10.60
>MiB/s    |
>>
>> Signed-off-by: Bo Liu <liubo03@inspur.com>
>> ---
>> v1:
>> =
https://lore.kernel.org/linux-erofs/20250410042048.3044-1-liubo03@insp
>> ur.com/
>> v2:
>> =
https://lore.kernel.org/linux-erofs/20250410042048.3044-1-liubo03@insp
>> ur.com/T/#t
>> v3:
>> =
https://lore.kernel.org/linux-erofs/20250516082634.3801-1-liubo03@insp
>> ur.com/
>> v4:
>> =
https://lore.kernel.org/linux-erofs/20250521100326.2867828-1-hsiangkao
>> @linux.alibaba.com/
>> change since v4:
>>   - add sysfs documentation.
>>
>>   Documentation/ABI/testing/sysfs-fs-erofs |  12 ++
>>   fs/erofs/Kconfig                         |  14 ++
>>   fs/erofs/Makefile                        |   1 +
>>   fs/erofs/compress.h                      |  10 ++
>>   fs/erofs/decompressor_crypto.c           | 186
>+++++++++++++++++++++++
>>   fs/erofs/decompressor_deflate.c          |  17 ++-
>>   fs/erofs/sysfs.c                         |  34 ++++-
>>   fs/erofs/zdata.c                         |   1 +
>>   8 files changed, 272 insertions(+), 3 deletions(-)
>>   create mode 100644 fs/erofs/decompressor_crypto.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs
>> b/Documentation/ABI/testing/sysfs-fs-erofs
>> index b134146d735b..95201a62f704 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-erofs
>> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
>> @@ -27,3 +27,15 @@ Description:	Writing to this will drop
>compression-related caches,
>>   		- 1 : invalidate cached compressed folios
>>   		- 2 : drop in-memory pclusters
>>   		- 3 : drop in-memory pclusters and cached compressed folios
>> +
>> +What:		/sys/fs/erofs/accel
>> +Date:		May 2025
>> +Contact:	"Bo Liu" <liubo03@inspur.com>
>> +Description:	The accel file is read-write and allows to set or show
>> +		hardware decompression accelerators, and it supports writing
>> +		multiple accelerators separated by =E2=80=98\n=E2=80=99.
>
>		Used to set or show hardware accelerators in effect and multiple
>		accelerators are separated by '\n'.
>
>		Supported accelerator(s): qat_deflate
>
>		Disable all accelerators with an empty string (echo > accel).
>
>> +		Currently supported accelerators:
>
>...
OK, I will make some changes

Thanks
Bo Liu

------=_NextPart_000_0030_01DBCB33.44482130
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
MAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZIhvcN
AwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMB0GA1UdDgQWBBTkHdp/y3+DuDJ13Q1YzgU9iV7N
dzAfBgNVHSMEGDAWgBReWQOmtExYYJFO9h61pTmmMsE1ajCCAQ8GA1UdHwSCAQYwggECMIH/oIH8
oIH5hoG6bGRhcDovLy9DTj1JTlNQVVItQ0EsQ049SlRDQTIwMTIsQ049Q0RQLENOPVB1YmxpYyUy
MEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9aG9tZSxEQz1s
YW5nY2hhbyxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
PWNSTERpc3RyaWJ1dGlvblBvaW50hjpodHRwOi8vSlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb20v
Q2VydEVucm9sbC9JTlNQVVItQ0EuY3JsMIIBKQYIKwYBBQUHAQEEggEbMIIBFzCBsQYIKwYBBQUH
MAKGgaRsZGFwOi8vL0NOPUlOU1BVUi1DQSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2Vydmlj
ZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ob21lLERDPWxhbmdjaGFvLERDPWNv
bT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBh
BggrBgEFBQcwAoZVaHR0cDovL0pUQ0EyMDEyLmhvbWUubGFuZ2NoYW8uY29tL0NlcnRFbnJvbGwv
SlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb21fSU5TUFVSLUNBLmNydDBBBgNVHREEOjA4oCIGCisG
AQQBgjcUAgOgFAwSbGl1Ym8wM0BpbnNwdXIuY29tgRJsaXVibzAzQGluc3B1ci5jb20wDQYJKoZI
hvcNAQELBQADggEBAA+BaY3B3qXmvZq7g7tZLzq2VQjU//XHTmyl58GLDWdVHsuX3lrAGwEfLVnU
odpvthjtb7T7xEUzJh4F62zLFSm8HOBPH1B+6SFQKChHZeM0pauvXr1krRtVv82RgLsU26XrXFUP
N+NcPwt7vOw1zHOiDic4anL3A9gsuDljAi2l+CA5RY05yL+8orasEAhOYL6+ks9aB8QiCxbZzShk
DTMkrh0N1DjoBLaibtnlI/fxOUYM6vgdiI+FC02G41B364ZAc1mabSFvGIP6cIdr/olprPQOj9cq
6zMi05qUBUj22hDvhcY0TlT4fEJSrvblp/LG6qTtVI3ilUAxhe8i9cIxggOTMIIDjwIBATBwMFkx
EzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT
8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA0dHVTGwIT1/wiwAAAADR0TAJBgUr
DgMCGgUAoIIB+DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA1
MjIwODA0NThaMCMGCSqGSIb3DQEJBDEWBBQWw9Jux2Pt6xZgvxK7xNdwVHVnVTB/BgkrBgEEAYI3
EAQxcjBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEU
MBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA0dHVTGwIT1/wiwAA
AADR0TCBgQYLKoZIhvcNAQkQAgsxcqBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJ
k/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1D
QQITfgAA0dHVTGwIT1/wiwAAAADR0TCBkwYJKoZIhvcNAQkPMYGFMIGCMAoGCCqGSIb3DQMHMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMA4GCCqGSIb3DQMCAgIAgDANBggq
hkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJYIZIAWUDBAICMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAPRUsga5q70/FSMu2ybjnQ7Bdcytek6b/yWLfFX8z1Mg0o0A0Y
4ZMA7VrUjiNpM3C9s6mwK5Q86qEl4QYiCjMr1GRgqtEv1lSa8N6uNJa278nXOs56smbC40KRts5U
3f73lI5ZmTQ9t1cOXbD7F52E5NB+Mr/UhgE3V44QKVfTOL5I5oWifmOxR79AgGTMNFoWlyWp4WFH
37+YIXinoaHFqgToDZRal2PZLZKsRFxvQNsiO+UnPGNL3Rc8PGFzpL7ovfNl6K4ryrMrn1D82n+A
8X6r3TbTx7IhN8TyRu+13D+iolNs/OIRXK4YAArlNehLT+HElOlhMWaUvJDuw29SAAAAAAAA

------=_NextPart_000_0030_01DBCB33.44482130--

