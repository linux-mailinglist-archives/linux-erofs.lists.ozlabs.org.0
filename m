Return-Path: <linux-erofs+bounces-88-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 786E4A68525
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Mar 2025 07:40:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHfGb2pPhz2xd5;
	Wed, 19 Mar 2025 17:40:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.26.146
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742366423;
	cv=none; b=AjeIJOD+roe4avk4cvvRBVXEDTeMLl3Yh2gB/rA0VIi1JSIWEtaNcbBhgUUvt5t1s8t6Rmm+cp6EGF54G3crAndvU8rL9cqHQeFotlpsuM9V9A/4Sa1/2WQhOjWQtyJlG0RTGYrXiWJqyN9HOfrcCTeXkv744tz9SLFXNPhagZayHcr1hne4+vpF+TsCOJVlE6qgodyVpGOQeMadkigOFazcCWnxIJf6AYVNmmh6jLwZsw05482/p1jZySfEcpfomjQ4wRdoPDBXFMNSXUhw6uFjdlDZZL7SKz6l+tSTiR4lqn0WxJApW0m6SxHP7CxrE5+6M7E4kAvYVlfgQ/PsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742366423; c=relaxed/relaxed;
	bh=3Qlw4FZyR9lLGq0+/AlGkASsaTVkszfOJx5RMU3lAgg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nrJaK94NchJwYgxQtnQFXR6kSWGP9YN3TR/y5Hio362t2VylrNTU+avVEefuJssOLTI0wEnVEuv0nEZQ6Q+9ox7iXZCG7+aAi8cOIt6P+oQ/vAOFxvNWuoD4w9/1bbVi++907Vt1t3hHoOSmNpomsxFlxu+naBuuMC0Y3TmxOMUbQ7h1SybsLRG5RpZ5Ekm2w3AzISKWNXd8tOW+snSbrzqrm93Y3NJpCYhnjvRq0Y6UNENCG2gGBtGZugLTyGSZ8GsCLwJHAVCFYKMTMerc7fCw8047fA/EzZYeWTpbc3Bi5eF4qHZps+2VbQT+Q8Ta00waMiPCcsEd7BTkgE0s4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.26.146; helo=unicom146.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.26.146; helo=unicom146.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHfGY5Vzmz2xPL
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Mar 2025 17:40:14 +1100 (AEDT)
Received: from jtjnmail201623.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202503191440057170;
        Wed, 19 Mar 2025 14:40:05 +0800
Received: from jtjnmail201622.home.langchao.com (10.100.2.22) by
 jtjnmail201623.home.langchao.com (10.100.2.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Mar 2025 14:40:06 +0800
Received: from jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6])
 by jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6%7]) with mapi
 id 15.01.2507.039; Wed, 19 Mar 2025 14:40:06 +0800
From: =?gb2312?B?Qm8gTGl1ICjB9bKoKS3Ay7Ox0MXPog==?= <liubo03@inspur.com>
To: "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>, "bfoster@redhat.com"
	<bfoster@redhat.com>
CC: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "hch@lst.de"
	<hch@lst.de>, "djwong@kernel.org" <djwong@kernel.org>
Subject: Re: [PATCH -next] iomap: fix inline data on buffered read
Thread-Topic: [PATCH -next] iomap: fix inline data on buffered read
Thread-Index: AduYmXY6aY6bfqZqTPedAurYKq7QZQ==
Date: Wed, 19 Mar 2025 06:40:06 +0000
Message-ID: <3e2e3c7edcec403fb824e973953a10ad@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-originating-ip: [120.224.42.184]
Content-Type: multipart/signed; micalg=SHA1;
	protocol="application/x-pkcs7-signature";
	boundary="----=_NextPart_000_0028_01DB98DC.85E07B30"
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
tUid: 2025319144005a6c2e4d7e8a45e2da203be86f34f7c9e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-0.7 required=3.0 tests=RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

------=_NextPart_000_0028_01DB98DC.85E07B30
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

>Previously, iomap_readpage_iter() returning 0 would break out of the loops
of
>iomap_readahead_iter(), which is what iomap_read_inline_data() relies on.
>
>However, commit d9dc477ff6a2 ("iomap: advance the iter directly on buffered
>read") changes this behavior without calling iomap_iter_advance(), which
>causes EROFS to get stuck in iomap_readpage_iter().
>
>It seems iomap_iter_advance() cannot be called in
>iomap_read_inline_data() because of the iomap_write_begin() path, so handle
>this in iomap_readpage_iter() instead.
>
>Reported-by: Bo Liu <liubo03@inspur.com>
>Fixes: d9dc477ff6a2 ("iomap: advance the iter directly on buffered read")
>Cc: Brian Foster <bfoster@redhat.com>
>Cc: Christoph Hellwig <hch@lst.de>
>Cc: "Darrick J. Wong" <djwong@kernel.org>
>Cc: Christian Brauner <brauner@kernel.org>
>Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Tested-by: Bo Liu <liubo03@inspur.com>

------=_NextPart_000_0028_01DB98DC.85E07B30
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
9w0DAgICAIAwDgYIKoZIhvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMB0GA1UdDgQWBBTk
Hdp/y3+DuDJ13Q1YzgU9iV7NdzAfBgNVHSMEGDAWgBReWQOmtExYYJFO9h61pTmmMsE1ajCCAQ8G
A1UdHwSCAQYwggECMIH/oIH8oIH5hoG6bGRhcDovLy9DTj1JTlNQVVItQ0EsQ049SlRDQTIwMTIs
Q049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3Vy
YXRpb24sREM9aG9tZSxEQz1sYW5nY2hhbyxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlz
dD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hjpodHRwOi8vSlRDQTIwMTIu
aG9tZS5sYW5nY2hhby5jb20vQ2VydEVucm9sbC9JTlNQVVItQ0EuY3JsMIIBKQYIKwYBBQUHAQEE
ggEbMIIBFzCBsQYIKwYBBQUHMAKGgaRsZGFwOi8vL0NOPUlOU1BVUi1DQSxDTj1BSUEsQ049UHVi
bGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ob21l
LERDPWxhbmdjaGFvLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlm
aWNhdGlvbkF1dGhvcml0eTBhBggrBgEFBQcwAoZVaHR0cDovL0pUQ0EyMDEyLmhvbWUubGFuZ2No
YW8uY29tL0NlcnRFbnJvbGwvSlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb21fSU5TUFVSLUNBLmNy
dDBBBgNVHREEOjA4oCIGCisGAQQBgjcUAgOgFAwSbGl1Ym8wM0BpbnNwdXIuY29tgRJsaXVibzAz
QGluc3B1ci5jb20wDQYJKoZIhvcNAQELBQADggEBAA+BaY3B3qXmvZq7g7tZLzq2VQjU//XHTmyl
58GLDWdVHsuX3lrAGwEfLVnUodpvthjtb7T7xEUzJh4F62zLFSm8HOBPH1B+6SFQKChHZeM0pauv
Xr1krRtVv82RgLsU26XrXFUPN+NcPwt7vOw1zHOiDic4anL3A9gsuDljAi2l+CA5RY05yL+8oras
EAhOYL6+ks9aB8QiCxbZzShkDTMkrh0N1DjoBLaibtnlI/fxOUYM6vgdiI+FC02G41B364ZAc1ma
bSFvGIP6cIdr/olprPQOj9cq6zMi05qUBUj22hDvhcY0TlT4fEJSrvblp/LG6qTtVI3ilUAxhe8i
9cIxggOTMIIDjwIBATBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghs
YW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA0dHV
TGwIT1/wiwAAAADR0TAJBgUrDgMCGgUAoIIB+DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTAzMTkwNjM4MDRaMCMGCSqGSIb3DQEJBDEWBBSCC3kJI5A4JpSPWwDa
RXDb1bxcSTB/BgkrBgEEAYI3EAQxcjBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJ
k/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1D
QQITfgAA0dHVTGwIT1/wiwAAAADR0TCBgQYLKoZIhvcNAQkQAgsxcqBwMFkxEzARBgoJkiaJk/Is
ZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUx
EjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA0dHVTGwIT1/wiwAAAADR0TCBkwYJKoZIhvcNAQkPMYGF
MIGCMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAICMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB4+CNebvYh6jsAoa9Qw509PEKW
rl/jL2jtX1jfFnQatnuQWaZFJPMaUDjE+NriXGkuEWThR5GhjyXhsElmSkJCEJuT7hv7LgHut1md
+2zGy0yDQ69a+3p2l2O89V/XDiwREB4spANggA0lU8RdKkft6KvDM64Lbyw3vTJXTq4qbptaNhWH
2DfVZZMXEyeD0M4qrstULn9R+t5z3K9WKUxhJCiPVsuVNjY1iCkNIyyjEfAGuFWlpR6ueL6VhyXQ
pOaSWsHktGM5AOd51XPaQvD8rGOQ666bi+x5P0Tu2hReiUgkSu7BtTEdFkPCAF+riqJGe/+1EAoy
TLPWNUJ+jnpsAAAAAAAA

------=_NextPart_000_0028_01DB98DC.85E07B30--

