Return-Path: <linux-erofs+bounces-583-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3E3B000A0
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Jul 2025 13:36:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bdCV461Y0z30MY;
	Thu, 10 Jul 2025 21:36:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.61.248
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752147388;
	cv=none; b=S3qU3rYDk2J5FRwVXdc0jDtBNj6fEe5kedHWkxz14NWWtn4FKSwKPcc5uf92EJWdwV5ZgYF3gHa/jjoq4PF3T7wOpTw1EMuhm257YIa188hNYvXTm8sFy345fuZxUP2Rprrk9jWm1Dqv2/DyJQAdJfWKU4cPriaxH4ipQLHzqooDYFyj7BZr+iL2SOCO+vHsSFvuaLKcGNtFBCcE3wYvs8gfMQTwcuqrLOfa1OCEDFk+XhHcyVUDeGO3zZZFII4t1tqGkNAtSSfsI+Fv9ZQkzw6sxPB5aH3IsJXWTEjqwHViI8FF292Pd2ElsvJrM7wQzaQn8CWMw9V7LeJSwysfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752147388; c=relaxed/relaxed;
	bh=3Nf8bXnc6DKj7aB5sETR0IWPsNmAB1Ub/y1Mxt5t4rU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Disposition:MIME-Version; b=oeMmjfxYCxmNCEnHDVRGCSDmeDK0OCWejB6N6KaLurMRA9j6FIwzVhQNFPPuimUBJmihO1Br1uAvwkPDrymyTPRJFPiI+57YrV2gtYMl/YRH9ubVOUV1b9Om+N2yRMKws2dA34B/X35dj8kSxQiAjJbhfxw0Lh5crDCbM+aaVmU/uJq2sOiCjndbJboCFfMijD8fqvQ+p+vqP6NX3sRjdlhD7Pb/hfNIzz+B7L5EaWYQEs7eEqIQjepJrIo0LJZ4f8eyUJI/Q/7N7c1bqNQl7M1eBMUNhXoJPuI5Rw4qiIfqcXerg/1pwTntqGESRkSlEjjV3i2eG1055eck50sMoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Thu, 10 Jul 2025 21:36:27 AEST
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bdCV30rr1z2xsW
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Jul 2025 21:36:26 +1000 (AEST)
Received: from Jtjnmail201618.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202507101935080355;
        Thu, 10 Jul 2025 19:35:08 +0800
Received: from jtjnmail201626.home.langchao.com (10.100.2.36) by
 Jtjnmail201618.home.langchao.com (10.100.2.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 10 Jul 2025 19:35:10 +0800
Received: from jtjnmail201622.home.langchao.com (10.100.2.22) by
 jtjnmail201626.home.langchao.com (10.100.2.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 10 Jul 2025 19:35:10 +0800
Received: from jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6])
 by jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6%7]) with mapi
 id 15.01.2507.057; Thu, 10 Jul 2025 19:35:10 +0800
From: =?gb2312?B?Qm8gTGl1ICjB9bKoKS3Ay7Ox0MXPog==?= <liubo03@inspur.com>
To: "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org" <chao@kernel.org>
CC: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: support metadata compression
Thread-Topic: [PATCH] erofs: support metadata compression
Thread-Index: AQHb8ACFaSvIuPujuUSWHlZrHEmfU7QqTfIAgADtq2A=
Date: Thu, 10 Jul 2025 11:35:09 +0000
Message-ID: <00fc488bbdd1489ca94f4d0bcd416403@inspur.com>
References: <43e95e68b2a66605e9dad2f04a26410710-7-25linux.alibaba.com@g.corp-email.com>
 <c3ebea91-9a78-4ac8-8312-3d98008f7950@linux.alibaba.com>
In-Reply-To: <c3ebea91-9a78-4ac8-8312-3d98008f7950@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-originating-ip: [182.45.253.56]
Content-Type: application/pkcs7-mime; smime-type=signed-data;
	name="smime.p7m"
Content-Disposition: attachment; filename="smime.p7m"
Content-Transfer-Encoding: base64
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
tUid: 20257101935084bc478eff5f14da9811aba78548f6f5d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.0 required=3.0 tests=ENCRYPTED_MESSAGE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAaCAJIAEggPXQ29u
dGVudC1UeXBlOiB0ZXh0L3BsYWluOw0KCWNoYXJzZXQ9ImdiMjMxMiINCkNvbnRlbnQtVHJhbnNm
ZXItRW5jb2Rpbmc6IDdiaXQNCg0KDQpPbiAyMDI1LzcvMTAgMTM6MTgsIEdhbyBYaWFuZyB3cm90
ZToNCj5IaSBCbywNCj4NCj5PbiAyMDI1LzcvOCAyMDowMSwgQm8gTGl1IHdyb3RlOg0KPj4gRmls
ZXN5c3RlbSBtZXRhZGF0YSBoYXMgYSBoaWdoIGRlZ3JlZSBvZiByZWR1bmRhbmN5LCBzbyBzaG91
bGQNCj4+IGNvbXByZXNzIHdlbGwgaW4gdGhlIGdlbmVyYWwgY2FzZS4NCj4+IFRvIGltcGxlbWVu
dCB0aGlzIGZlYXR1cmUsIHdlIG1ha2UgYSBzcGVjaWFsIG9uLWRpc2sgaW5vZGUgd2hpY2gga2Vl
cHMNCj4+IGFsbCBtZXRhZGF0YSBhcyBpdHMgZGF0YSwgYW5kIHRoZW4gY29tcHJlc3MgdGhlIHNw
ZWNpYWwgb24tZGlzayBpbm9kZQ0KPj4gd2l0aCB0aGUgZ2l2ZW4gYWxnb3JpdGhtLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEJvIExpdSA8bGl1Ym8wM0BpbnNwdXIuY29tPg0KPg0KPkknbSB3b3Jr
aW5nIG9uIGVyb2ZzLXV0aWxzIHN1cHBvcnQgZm9yIHRoaXMgZmVhdHVyZSwgYnV0IGJlZm9yZSB0
aGF0IEkgdGVuZA0KdG8NCj5zdXBwb3J0IG9wdGlvbmFsIG1ldGFkYXRhIGNvbXByZXNzaW9uLCB3
aGljaCBtZWFucw0KPg0KPmlmIHRoZSBiaXQgNjMgb2YgbmlkIGlzIHNldCwgdGhlIGlub2RlIGl0
c2VsZiBtZXRhZGF0YSBjb21wcmVzc2VkLg0KPmlmIG5vdCwganVzdCB1c2VzIHRoZSBjdXJyZW50
IHdheS4NCj4NCj5CZWNhdXNlIHRoYXQgd2UgY291bGQgZW5hYmxlIGltYWdlIGluY3JlbWVudGFs
IGJ1aWxkcyBzbyB0aGF0IHdlIGRvbid0IGhhdmUNCj50byByZXdyaXRlIHRoZSBiYXNlIGlub2Rl
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
BgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcKAwQwCwYDVR0PBAQDAgWgMDUGCSsGAQQBgjcVCgQo
MCYwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDBDBEBgkqhkiG9w0BCQ8ENzA1
MA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAIAwBwYFKw4DAgcwCgYIKoZIhvcNAwcwHQYD
VR0OBBYEFOQd2n/Lf4O4MnXdDVjOBT2JXs13MB8GA1UdIwQYMBaAFF5ZA6a0TFhgkU72HrWlOaYy
wTVqMIIBDwYDVR0fBIIBBjCCAQIwgf+ggfyggfmGgbpsZGFwOi8vL0NOPUlOU1BVUi1DQSxDTj1K
VENBMjAxMixDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049
Q29uZmlndXJhdGlvbixEQz1ob21lLERDPWxhbmdjaGFvLERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9j
YXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGOmh0dHA6Ly9K
VENBMjAxMi5ob21lLmxhbmdjaGFvLmNvbS9DZXJ0RW5yb2xsL0lOU1BVUi1DQS5jcmwwggEpBggr
BgEFBQcBAQSCARswggEXMIGxBggrBgEFBQcwAoaBpGxkYXA6Ly8vQ049SU5TUFVSLUNBLENOPUFJ
QSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9u
LERDPWhvbWUsREM9bGFuZ2NoYW8sREM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFz
cz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MGEGCCsGAQUFBzAChlVodHRwOi8vSlRDQTIwMTIuaG9t
ZS5sYW5nY2hhby5jb20vQ2VydEVucm9sbC9KVENBMjAxMi5ob21lLmxhbmdjaGFvLmNvbV9JTlNQ
VVItQ0EuY3J0MEEGA1UdEQQ6MDigIgYKKwYBBAGCNxQCA6AUDBJsaXVibzAzQGluc3B1ci5jb22B
EmxpdWJvMDNAaW5zcHVyLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAD4FpjcHepea9mruDu1kvOrZV
CNT/9cdObKXnwYsNZ1Uey5feWsAbAR8tWdSh2m+2GO1vtPvERTMmHgXrbMsVKbwc4E8fUH7pIVAo
KEdl4zSlq69evWStG1W/zZGAuxTbpetcVQ8341w/C3u87DXMc6IOJzhqcvcD2Cy4OWMCLaX4IDlF
jTnIv7yitqwQCE5gvr6Sz1oHxCILFtnNKGQNMySuHQ3UOOgEtqJu2eUj9/E5Rgzq+B2Ij4ULTYbj
UHfrhkBzWZptIW8Yg/pwh2v+iWms9A6P1yrrMyLTmpQFSPbaEO+FxjROVPh8QlKu9uWn8sbqpO1U
jeKVQDGF7yL1wjGCA5MwggOPAgEBMHAwWTETMBEGCgmSJomT8ixkARkWA2NvbTEYMBYGCgmSJomT
8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTESMBAGA1UEAxMJSU5TUFVSLUNB
AhN+AADR0dVMbAhPX/CLAAAAANHRMAkGBSsOAwIaBQCgggH4MBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDcxMDExMzQ1MFowIwYJKoZIhvcNAQkEMRYEFB/ZHKYl
EhgvkkRfPKuVQkUW8rsqMH8GCSsGAQQBgjcQBDFyMHAwWTETMBEGCgmSJomT8ixkARkWA2NvbTEY
MBYGCgmSJomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTESMBAGA1UEAxMJ
SU5TUFVSLUNBAhN+AADR0dVMbAhPX/CLAAAAANHRMIGBBgsqhkiG9w0BCRACCzFyoHAwWTETMBEG
CgmSJomT8ixkARkWA2NvbTEYMBYGCgmSJomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQB
GRYEaG9tZTESMBAGA1UEAxMJSU5TUFVSLUNBAhN+AADR0dVMbAhPX/CLAAAAANHRMIGTBgkqhkiG
9w0BCQ8xgYUwgYIwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIaMAsGCWCGSAFlAwQC
AzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAO3Qz9x8KC6hXoRh
HISMwqWwJOuZ/V3wLtFSBHhn6V/Lo1si8nb3nzeyz/zO1mg7heVXtTBdA55b71qFDsz/r0sP1jBH
REWwNCGzjR/FXs6PhDvKXJAvlzSq4D5N3a6fGg/1Jm+EJjFWpG1QveNgq+Vz07ggtGgY1j2IEsoU
T/uz821/Uy7XLuf7hJXBNUhNMMRBiWCYC3S1J/buMN7+A1ljZsrP3CV5nvwXpPlE52fSY/ujn42k
4y7nOHsJTuNcUG/ezWP1IhVY1d65tS7vtGYsT5q0xfZzjHxhJn2FqyBRBF8j+FGYoMpS+pCsFrTy
tGacxuaON/FYzLSfq17kQ6AAAAAAAAA=

