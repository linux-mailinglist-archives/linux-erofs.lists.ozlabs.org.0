Return-Path: <linux-erofs+bounces-655-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A4AB0844B
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 07:36:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjM9L3Bwmz2yDk;
	Thu, 17 Jul 2025 15:36:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.61.248
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752730582;
	cv=none; b=Hnas3iWyfCpNnSf/5SNNQuBa8Z5yIVnTcKnhfyNKUoM52HvlQdkzdNrT7Yd11Lyx/Uzz/gtWSFBVJadFqw7nfSrxPi1xAszPx0pL8KdxbymLkvQ+jmp3rnJr2736lwf58b/Jna2JDk7eoKOzOKoxD7fPTBtInr/3vMX7kM30IZcqRoAet6T+sWAeDI9lQdIR9TTNyWCOiFT122X4t5kexObTiTB8vcmQoN2cX4irS5j4+JpTEgvkstymCuYuS0rOu06GRrw13pKDhvo6nP1XA2aek1+BQxWgTJg3VGJsIVfpWik2o5ge2x1KwF/fPFIqb5qPRS2lexgUPEhT15ecZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752730582; c=relaxed/relaxed;
	bh=JvT2P3zHoC70VJxx2FAZtqMsTYuN9gDNYZlrl1fQDzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OESONdPUEi2Ien6DtegMStqZq3iehZeNndvh+t2KG3RYiajIA3cQIzVA3BhuSVV1zr/mG0SwG0X/5U4YByow0P40ybhfps+x0B7EI/qJRqxKA3ng6aBQ9vYb4qxsSEn1qwFESSDZDr0NBNF2N03To+KgufG65/vKxt31Y3dVyXWGYcUs0p1dQdcsr98iNsuitVznqOfNffXu9bDPX7OduHmuDj76bEnnmwF3V1dFyN66h2BslhRaDp6shw/7wmVwHQzHNuNom/TZrqPsv+H5GFyWrt2w731HZeVvSk/ruZCAs5JOidvGJbWlFb9MQCvg6PCGf2Z6627fo2QqVLezMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjM9H4HYbz2xlM
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 15:36:15 +1000 (AEST)
Received: from jtjnmail201621.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202507171336085477;
        Thu, 17 Jul 2025 13:36:08 +0800
Received: from jtjnmail201622.home.langchao.com (10.100.2.22) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 17 Jul 2025 13:36:07 +0800
Received: from jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6])
 by jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6%7]) with mapi
 id 15.01.2507.057; Thu, 17 Jul 2025 13:36:07 +0800
From: =?utf-8?B?Qm8gTGl1ICjliJjms6IpLea1qua9ruS/oeaBrw==?=
	<liubo03@inspur.com>
To: "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org" <chao@kernel.org>
CC: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] erofs: fix build error with
 CONFIG_EROFS_FS_ZIP_ACCEL=y
Thread-Topic: [PATCH v2] erofs: fix build error with
 CONFIG_EROFS_FS_ZIP_ACCEL=y
Thread-Index: AQHb9r5bhEEMaSKriE2nZnjqJiZT7bQ1FgiAgAC1fpA=
Date: Thu, 17 Jul 2025 05:36:07 +0000
Message-ID: <d850ca30f0fd4c54a2ff66c984571565@inspur.com>
References: <b741fd09704a087a6fa48359812c4a7717-7-25linux.alibaba.com@g.corp-email.com>
 <c46f71ae-f04c-4aa6-99fb-cf8f8e751589@linux.alibaba.com>
In-Reply-To: <c46f71ae-f04c-4aa6-99fb-cf8f8e751589@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-originating-ip: [182.45.253.56]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0022_01DBF71F.B2288B50"
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
tUid: 2025717133608f519e00ca0dd2aafeeb36228f4d41a22
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

------=_NextPart_000_0022_01DBF71F.B2288B50
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

>On 2025/7/17 09:58, Bo Liu wrote:
>> fix build err:
>>   ld.lld: error: undefined symbol: crypto_req_done
>>     referenced by decompressor_crypto.c
>>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in
>archive vmlinux.a
>>     referenced by decompressor_crypto.c
>>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in
>> archive vmlinux.a
>>
>>   ld.lld: error: undefined symbol: crypto_acomp_decompress
>>     referenced by decompressor_crypto.c
>>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in
>> archive vmlinux.a
>>
>>   ld.lld: error: undefined symbol: crypto_alloc_acomp
>>     referenced by decompressor_crypto.c
>>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_enable_engine)
>> in archive vmlinux.a
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes:
>> https://lore.kernel.org/oe-kbuild-all/202507161032.QholMPtn-lkp@intel.
>> com/
>> Fixes: b4a29efc5146 ("erofs: support DEFLATE decompression by using
>> Intel QAT")
>> Signed-off-by: Bo Liu <liubo03@inspur.com>
>>
>> v1:
>> https://lore.kernel.org/linux-erofs/7a1dbee70a604583bae5a29f690f4231@i
>> nspur.com/T/#t
>>
>> change since v1:
>> - add Fixes commits
>> ---
>>   fs/erofs/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig index
>> 6beeb7063871..60510a041bf1 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -147,6 +147,7 @@ config EROFS_FS_ZIP_ZSTD
>>   config EROFS_FS_ZIP_ACCEL
>>   	bool "EROFS hardware decompression support"
>>   	depends on EROFS_FS_ZIP
>> +	select CRYPTO
>
>After testing, I think we should rely on CRYPTO_ACOMP or CRYPTO_ACOMP2
>instead.
>
>Otherwise it will still fails.

I will change it.

Thanks.
Bo Liu.

------=_NextPart_000_0022_01DBF71F.B2288B50
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
hkiG9w0DBzAdBgNVHQ4EFgQUsmXTjDrO/nhxGDpnz5cAr1neWI8wHwYDVR0jBBgwFoAUXlkDprRM
WGCRTvYetaU5pjLBNWowggEPBgNVHR8EggEGMIIBAjCB/6CB/KCB+YaBumxkYXA6Ly8vQ049SU5T
UFVSLUNBLENOPUpUQ0EyMDEyLENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1T
ZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPWhvbWUsREM9bGFuZ2NoYW8sREM9Y29tP2NlcnRp
ZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2lu
dIY6aHR0cDovL0pUQ0EyMDEyLmhvbWUubGFuZ2NoYW8uY29tL0NlcnRFbnJvbGwvSU5TUFVSLUNB
LmNybDCCASwGCCsGAQUFBwEBBIIBHjCCARowgbEGCCsGAQUFBzAChoGkbGRhcDovLy9DTj1JTlNQ
VVItQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNv
bmZpZ3VyYXRpb24sREM9aG9tZSxEQz1sYW5nY2hhbyxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNl
P29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwZAYIKwYBBQUHMAKGWGh0dHA6Ly9K
VENBMjAxMi5ob21lLmxhbmdjaGFvLmNvbS9DZXJ0RW5yb2xsL0pUQ0EyMDEyLmhvbWUubGFuZ2No
YW8uY29tX0lOU1BVUi1DQSgxKS5jcnQwKQYDVR0lBCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgor
BgEEAYI3CgMEMDUGCSsGAQQBgjcVCgQoMCYwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQwDAYKKwYB
BAGCNwoDBDBBBgNVHREEOjA4oCIGCisGAQQBgjcUAgOgFAwSbGl1Ym8wM0BpbnNwdXIuY29tgRJs
aXVibzAzQGluc3B1ci5jb20wUwYJKwYBBAGCNxkCBEYwRKBCBgorBgEEAYI3GQIBoDQEMlMtMS01
LTIxLTE2MDY5ODA4NDgtNzA2Njk5ODI2LTE4MDE2NzQ1MzEtMjU4ODUyMzQ4MA0GCSqGSIb3DQEB
CwUAA4IBAQAucjq5s0Qq1UtBIL8Und9mnrfn3azil+rXBoZf/N+DNuZYml+Ct4SDC0tng7F5kSt/
2zU4vShrkviUh8kjCstCrPyqkxQodvm7reuGuBKZLy9PLZR0oB3S7vD9gUdMCw7UianFwY+mgbG/
33dY43zujZIY8DMm6od3GMZlIueeqB6VyEESU4+ll2VFPyLXPzUMBK7DLAEnOiPbJSUvR7738lSk
DPXxdujcFhL9wxTvh/3ghYuY0OCwf+HM7TFBSSFxa1wdkfO8aA9Bl6tY5awZ6bbsr+3+FRf/h1jW
ZQOCCnEGixEPN0irb1ZjdI2O4u1TlTwZAYXdLVRqmr2vi1KHMYIDkzCCA48CAQEwcDBZMRMwEQYK
CZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbGFuZ2NoYW8xFDASBgoJkiaJk/IsZAEZ
FgRob21lMRIwEAYDVQQDEwlJTlNQVVItQ0ECE34AA47lMgPE5azBUewAAQADjuUwCQYFKw4DAhoF
AKCCAfgwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUwNzE3MDUz
NTQ0WjAjBgkqhkiG9w0BCQQxFgQU7SDPVqnWGPYGWZx14xm9pnhCYaYwfwYJKwYBBAGCNxAEMXIw
cDBZMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbGFuZ2NoYW8xFDASBgoJ
kiaJk/IsZAEZFgRob21lMRIwEAYDVQQDEwlJTlNQVVItQ0ECE34AA47lMgPE5azBUewAAQADjuUw
gYEGCyqGSIb3DQEJEAILMXKgcDBZMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQB
GRYIbGFuZ2NoYW8xFDASBgoJkiaJk/IsZAEZFgRob21lMRIwEAYDVQQDEwlJTlNQVVItQ0ECE34A
A47lMgPE5azBUewAAQADjuUwgZMGCSqGSIb3DQEJDzGBhTCBgjAKBggqhkiG9w0DBzALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAhowCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwDQYJ
KoZIhvcNAQEBBQAEggEALe/aGvTg8r9U7Iljpta2fp9tfRI98eeTNISgece+1OiYv+x5/yXqbA6i
KP4BW06ST9/qoCLGGeCRuKI++OLQZlbdw/7TdkX+nsI9cuR/hD2MtDprMtP5ch2C8EEF18MEyXoG
/2CmFVTQJW1lsklPRodUDMzgix9/TFcfK8IB1g5iCbHzqeKKT5rlBJ5Tyn48/2K0SZYx8UpVn2I6
XTJk884vlr/UrQYWWDkTePAYEBJdUfqO8hqQjU7derYHR+WMYs73+Dd8B4U6DaCLJ7FEQe8842ov
IGkI8uroWrhnepXYivLpecwiOEB8gfOjfVv0OXqcNA6oT9XKpu2Vuh4CvQAAAAAAAA==

------=_NextPart_000_0022_01DBF71F.B2288B50--

