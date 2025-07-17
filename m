Return-Path: <linux-erofs+bounces-648-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD45B08291
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 03:43:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjG0t6xTyz2yF1;
	Thu, 17 Jul 2025 11:43:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.26.146
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752716622;
	cv=none; b=CKRXt4MTZdyeqNSr4qiFsLz8dYNQ+jlAZTv+GdXDuU14F8D5dt6EpVh2xSMKxfL7ckdVyPKclhGgy/w2oQIKLBFqtDw1qsJl8o8SPckox5V9S8gg1OYKqiPx7eNKHGZ8dn1MLfftiHG0Tg+xtmu14afR79c9ptUqtjzFn+0Pnk4rJeg29sSmU+cHC2H5MLqhsx0/rK3sRZIS3EZBwWjpLRAQQorQQ22sU2/rbTpRhLr7AjGmyXdRvI6Jv/pnKuDumbd3KQi4/V+Yx4fhpOnL1L5VkmA/yW3IRDWt5cRHVW+dR5PWaJZThbg2oGciC5g9dHEvvhm9UefRzrmJDbjuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752716622; c=relaxed/relaxed;
	bh=Tt7KWLYn0h3gYz1s9gkyMKHpT2lVwqQlpQSkOOz6/Y4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LqehPanDXlZCP1JYWhpTbJDp0JMPs1Zq0h4hPYm4D5oY3mUW3Nr0A2IYQIdw3gDgcbxI9qd+Enqt+7OouQEhvDpOZQQRtGHA4GhlUrS3NTnD+sZQaF5bRVRH/NrNxW7E6Ba3fzEHRPQqQbVPFDdiTORmSmGbCOcKiq5C40y5yo1mwTFfvyaR4jEHGKOLyJXZAwZOsG4L5W9XlcrvhOWtsdoRwVj+A0iUbtw7giUkImxxTp8W15Skx5rSnjLyQUZRFN6CenSFX55FLhUTqgyOyI0dBkudnFrNadZ9k93pswmk2xlZr/itGLBRSkr0HtwRR5aTytnNyb5cTqOTdJKCcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.26.146; helo=unicom146.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.26.146; helo=unicom146.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjG0s5bsCz2yDk
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 11:43:39 +1000 (AEST)
Received: from jtjnmail201619.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202507170943338503;
        Thu, 17 Jul 2025 09:43:33 +0800
Received: from jtjnmail201622.home.langchao.com (10.100.2.22) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 17 Jul 2025 09:43:33 +0800
Received: from jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6])
 by jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6%7]) with mapi
 id 15.01.2507.057; Thu, 17 Jul 2025 09:43:33 +0800
From: =?utf-8?B?Qm8gTGl1ICjliJjms6IpLea1qua9ruS/oeaBrw==?=
	<liubo03@inspur.com>
To: "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org" <chao@kernel.org>
CC: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
Thread-Topic: [PATCH] erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
Thread-Index: AQHb9rs+z1tDqdTop0ya67w6HSZeFbQ1A9AAgACGdvA=
Date: Thu, 17 Jul 2025 01:43:33 +0000
Message-ID: <7a1dbee70a604583bae5a29f690f4231@inspur.com>
References: <b628d0517cde6f8914e65e1d7365d22217-7-25linux.alibaba.com@g.corp-email.com>
 <7d4b5f45-a8c1-47d6-8404-9cad88a297c1@linux.alibaba.com>
In-Reply-To: <7d4b5f45-a8c1-47d6-8404-9cad88a297c1@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-originating-ip: [182.45.253.56]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0009_01DBF6FF.3AF80DF0"
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
tUid: 20257170943332caa2229f388bf2fd194f9f14c2e5d33
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-0.7 required=3.0 tests=RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

------=_NextPart_000_0009_01DBF6FF.3AF80DF0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

>On 2025/7/17 09:34, Bo Liu wrote:
>> fix build err:
>>   ld.lld: error: undefined symbol: crypto_req_done
>>     referenced by decompressor_crypto.c
>>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in
>archive vmlinux.a
>>     referenced by decompressor_crypto.c
>>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in
>archive vmlinux.a
>>
>>   ld.lld: error: undefined symbol: crypto_acomp_decompress
>>     referenced by decompressor_crypto.c
>>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in
>archive vmlinux.a
>>
>>   ld.lld: error: undefined symbol: crypto_alloc_acomp
>>     referenced by decompressor_crypto.c
>>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_enable_engine) in
>archive vmlinux.a
>
>Could you add a `Fixes` tag for this?
>
I will add this.

Thanks
Bo Liu

------=_NextPart_000_0009_01DBF6FF.3AF80DF0
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
6zMi05qUBUj22hDvhcY0TlT4fEJSrvblp/LG6qTtVI3ilUAxhe8i9cIwggezMIIGm6ADAgECAhN+
AAOO5TIDxOWswVHsAAEAA47lMA0GCSqGSIb3DQEBCwUAMFkxEzARBgoJkiaJk/IsZAEZFgNjb20x
GDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMT
CUlOU1BVUi1DQTAeFw0yNTA3MTcwMTIxMDVaFw0zMDA3MTYwMTIxMDVaMIG3MRMwEQYKCZImiZPy
LGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbGFuZ2NoYW8xFDASBgoJkiaJk/IsZAEZFgRob21l
MTMwMQYDVQQLDCrmtarmva7nlLXlrZDkv6Hmga/kuqfkuJrogqHku73mnInpmZDlhazlj7gxGDAW
BgNVBAMMD+WImOazoihsaXVibzAzKTEhMB8GCSqGSIb3DQEJARYSbGl1Ym8wM0BpbnNwdXIuY29t
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmt17k1i6xhukLYDgv4PB5YV9rNmuVKH5
WO2ehZYIJn186Qt0EkhhoA7T2xt4AVZWaon2N27/bGKOp4xz8BYIPWpODowfg2FtrABqvJxsGQxf
VakiH5YBpPG4fUO+Y0D8vqKw4bAJ5I5quixu2t8OZenYCvvlLMXyP2KSshCJWVDw9rMEQhemcDot
PJfH9vFM085tUCvhPpjyMGq6/moGO8JQZ262X3XsFKnE0Zs9KMjtP6G4lJcmWfgwu3rAH3hMKRK6
bTsLPO+bY3TRz8avw8S1UmjJLTb2HDFLkzXzpOhDdKjO2Fk9V7JNmpjk7YQ7P8LLA1hVInOUjFv6
GR61vQIDAQABo4IEEzCCBA8wCwYDVR0PBAQDAgWgMD0GCSsGAQQBgjcVBwQwMC4GJisGAQQBgjcV
CILyqR+Egdd6hqmRPYaA9xWD2I9cgUr9iyaBlKdNAgFkAgFhMEQGCSqGSIb3DQEJDwQ3MDUwDgYI
KoZIhvcNAwICAgCAMA4GCCqGSIb3DQMEAgIAgDAHBgUrDgMCBzAKBggqhkiG9w0DBzAdBgNVHQ4E
FgQUsmXTjDrO/nhxGDpnz5cAr1neWI8wHwYDVR0jBBgwFoAUXlkDprRMWGCRTvYetaU5pjLBNWow
ggEPBgNVHR8EggEGMIIBAjCB/6CB/KCB+YaBumxkYXA6Ly8vQ049SU5TUFVSLUNBLENOPUpUQ0Ey
MDEyLENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25m
aWd1cmF0aW9uLERDPWhvbWUsREM9bGFuZ2NoYW8sREM9Y29tP2NlcnRpZmljYXRlUmV2b2NhdGlv
bkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludIY6aHR0cDovL0pUQ0Ey
MDEyLmhvbWUubGFuZ2NoYW8uY29tL0NlcnRFbnJvbGwvSU5TUFVSLUNBLmNybDCCASwGCCsGAQUF
BwEBBIIBHjCCARowgbEGCCsGAQUFBzAChoGkbGRhcDovLy9DTj1JTlNQVVItQ0EsQ049QUlBLENO
PVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9
aG9tZSxEQz1sYW5nY2hhbyxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNl
cnRpZmljYXRpb25BdXRob3JpdHkwZAYIKwYBBQUHMAKGWGh0dHA6Ly9KVENBMjAxMi5ob21lLmxh
bmdjaGFvLmNvbS9DZXJ0RW5yb2xsL0pUQ0EyMDEyLmhvbWUubGFuZ2NoYW8uY29tX0lOU1BVUi1D
QSgxKS5jcnQwKQYDVR0lBCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3CgMEMDUGCSsG
AQQBgjcVCgQoMCYwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDBDBBBgNVHREE
OjA4oCIGCisGAQQBgjcUAgOgFAwSbGl1Ym8wM0BpbnNwdXIuY29tgRJsaXVibzAzQGluc3B1ci5j
b20wUwYJKwYBBAGCNxkCBEYwRKBCBgorBgEEAYI3GQIBoDQEMlMtMS01LTIxLTE2MDY5ODA4NDgt
NzA2Njk5ODI2LTE4MDE2NzQ1MzEtMjU4ODUyMzQ4MA0GCSqGSIb3DQEBCwUAA4IBAQAucjq5s0Qq
1UtBIL8Und9mnrfn3azil+rXBoZf/N+DNuZYml+Ct4SDC0tng7F5kSt/2zU4vShrkviUh8kjCstC
rPyqkxQodvm7reuGuBKZLy9PLZR0oB3S7vD9gUdMCw7UianFwY+mgbG/33dY43zujZIY8DMm6od3
GMZlIueeqB6VyEESU4+ll2VFPyLXPzUMBK7DLAEnOiPbJSUvR7738lSkDPXxdujcFhL9wxTvh/3g
hYuY0OCwf+HM7TFBSSFxa1wdkfO8aA9Bl6tY5awZ6bbsr+3+FRf/h1jWZQOCCnEGixEPN0irb1Zj
dI2O4u1TlTwZAYXdLVRqmr2vi1KHMYIDkzCCA48CAQEwcDBZMRMwEQYKCZImiZPyLGQBGRYDY29t
MRgwFgYKCZImiZPyLGQBGRYIbGFuZ2NoYW8xFDASBgoJkiaJk/IsZAEZFgRob21lMRIwEAYDVQQD
EwlJTlNQVVItQ0ECE34AANHR1UxsCE9f8IsAAAAA0dEwCQYFKw4DAhoFAKCCAfgwGAYJKoZIhvcN
AQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUwNzE3MDE0MzIwWjAjBgkqhkiG9w0B
CQQxFgQUa9SKy+5VREpQVRwh+K9KHFefhHgwfwYJKwYBBAGCNxAEMXIwcDBZMRMwEQYKCZImiZPy
LGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbGFuZ2NoYW8xFDASBgoJkiaJk/IsZAEZFgRob21l
MRIwEAYDVQQDEwlJTlNQVVItQ0ECE34AA47lMgPE5azBUewAAQADjuUwgYEGCyqGSIb3DQEJEAIL
MXKgcDBZMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbGFuZ2NoYW8xFDAS
BgoJkiaJk/IsZAEZFgRob21lMRIwEAYDVQQDEwlJTlNQVVItQ0ECE34AA47lMgPE5azBUewAAQAD
juUwgZMGCSqGSIb3DQEJDzGBhTCBgjAKBggqhkiG9w0DBzALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEA
TRKO7WvzJ9SjqvoT+IhLVH3WDsoB1qw3VlX/4Vyfafl82YrRvbmeeRx4EtWr0uIwsjOC3pnQjsZp
lyZ/Pq5gSlbD7xPJsoHXtPzwMdswpKOSvRugfcQmr+nefSeOI20UsfpxjhpjtzN3P22FXLHodTGd
h8n9g/7BuKW7rNChCO1Jdd0QqFsrpEGbQ/ptT958fO0vk4Wc94BPT9Omusrm9HdMe28nsgw9/tep
Ef9AMAgcvss79w3BYxDYy3oOSh6o5kGc1ZhrOk+b6ZgBq84RRlluMFqWxpEIX8pa4jhaH/scQjBI
PIZq7Vhgh0x0r0r/8i+nrcPAy7P4qqE9L8ZqqgAAAAAAAA==

------=_NextPart_000_0009_01DBF6FF.3AF80DF0--

