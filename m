Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE954E4EC1
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Mar 2022 09:55:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KNhxr4gsRz2ywp
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Mar 2022 19:54:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=kuaishou.com header.i=@kuaishou.com header.a=rsa-sha256 header.s=dkim header.b=BgOYdr0W;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kuaishou.com (client-ip=103.107.216.241;
 helo=bjfk-gateway01.kuaishou.com; envelope-from=tianzichen@kuaishou.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kuaishou.com header.i=@kuaishou.com header.a=rsa-sha256
 header.s=dkim header.b=BgOYdr0W; dkim-atps=neutral
X-Greylist: delayed 862 seconds by postgrey-1.36 at boromir;
 Wed, 23 Mar 2022 19:54:48 AEDT
Received: from bjfk-gateway01.kuaishou.com (smtpcn02.kuaishou.com
 [103.107.216.241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KNhxh1GPPz2xCB
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Mar 2022 19:54:45 +1100 (AEDT)
Received: from bjfk-gateway01.kuaishou.com (localhost [127.0.0.2] (may be
 forged)) by bjfk-gateway01.kuaishou.com with ESMTP id 22N8eSO1015991
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Mar 2022 16:40:28 +0800 (GMT-8)
 (envelope-from tianzichen@kuaishou.com)
Received: from bjfk-pm-mail30.kuaishou.com ([172.29.5.62])
 by bjfk-gateway01.kuaishou.com with ESMTPS id 22N8c83w014939
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Mar 2022 16:38:08 +0800 (GMT-8)
 (envelope-from tianzichen@kuaishou.com)
Content-Language: zh-CN
Content-Type: multipart/alternative;
 boundary="_000_B6EA31D4877C450EBF892879044B9EADkuaishoucom_"
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed; 
 t=1648024688; h=from:subject:to:date:message-id;
 bh=4kL7tQZDTAgVsXKxnGPv0KZ902+QYaSJkq0VF7eBHoY=;
 b=BgOYdr0W358QcMux6zPV1cL+nd2aHIJbOZssfvD11yg2JIqUVjB9KDLRLABqYRpnKJQNbU4NtuL
 Z9pq2IXiACQLRUpYdWd+lVyD9pg/SnpN8JHylnWXOO9c5rEf4Bgd/8uYurNyfE8sLH53B22Ny1V2B
 r2dCM+fAsgxs5PuSppY=
Received: from bjfk-pm-mail30.kuaishou.com (172.29.5.62) by
 bjfk-pm-mail30.kuaishou.com (172.29.5.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.14; Wed, 23 Mar 2022 16:38:07 +0800
Received: from bjfk-pm-mail30.kuaishou.com ([fe80::2534:b256:58c3:b20]) by
 bjfk-pm-mail30.kuaishou.com ([fe80::2534:b256:58c3:b20%17]) with mapi id
 15.01.2176.014; Wed, 23 Mar 2022 16:38:07 +0800
From: =?utf-8?B?55Sw5a2Q5pmo?= <tianzichen@kuaishou.com>
To: "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v5 00/22] fscache, erofs: fscache-based on-demand read
 semantics
Thread-Topic: [PATCH v5 00/22] fscache, erofs: fscache-based on-demand read
 semantics
Thread-Index: AQHYPpFSpObg91d1C0qJ04JyRDD9Sw==
Date: Wed, 23 Mar 2022 08:38:07 +0000
Message-ID: <B6EA31D4-877C-450E-BF89-2879044B9EAD@kuaishou.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.20.112.31]
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: bjfk-gateway01.kuaishou.com 22N8eSO1015991
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "dhowells@redhat.com" <dhowells@redhat.com>,
 "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
 "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
 "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "luodaowen.backend@bytedance.com" <luodaowen.backend@bytedance.com>,
 "gerry@linux.alibaba.com" <gerry@linux.alibaba.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--_000_B6EA31D4877C450EBF892879044B9EADkuaishoucom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhpcyBzb2x1dGlvbiBsb29rcyBnb29kLCBhbmQgd2XigJkgcmUgYWxzbyBpbnRlcmVzdGVkICBp
biBpdCAsICBwbGVhc2UgYWNjZWxlcmF0ZSBpdHMgcHJvZ3Jlc3Mgc28gd2UgY2FuIHVzZSBpdC4N
Cg0KQmVzdCB3aXNoZXMsDQp6aWNoZW4NCg==

--_000_B6EA31D4877C450EBF892879044B9EADkuaishoucom_
Content-Type: text/html; charset="utf-8"
Content-ID: <F1CEFBBF477C7A4BB0CA656FDCF9E72A@kuaishou.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5IHN0eWxlPSJ3b3JkLXdy
YXA6IGJyZWFrLXdvcmQ7IC13ZWJraXQtbmJzcC1tb2RlOiBzcGFjZTsgLXdlYmtpdC1saW5lLWJy
ZWFrOiBhZnRlci13aGl0ZS1zcGFjZTsiIGNsYXNzPSIiPg0KPGRpdiBjbGFzcz0iIj48Zm9udCBz
aXplPSI0IiBjbGFzcz0iIj5UaGlzIHNvbHV0aW9uIGxvb2tzIGdvb2QsIGFuZCB3ZeKAmSByZSBh
bHNvIGludGVyZXN0ZWQgJm5ic3A7aW4gaXQgLCAmbmJzcDtwbGVhc2UgYWNjZWxlcmF0ZSBpdHMg
cHJvZ3Jlc3Mgc28gd2UgY2FuIHVzZSBpdC48L2ZvbnQ+PC9kaXY+DQo8ZGl2IGNsYXNzPSIiPjxm
b250IHNpemU9IjQiIGNsYXNzPSIiPjxiciBjbGFzcz0iIj4NCkJlc3Qgd2lzaGVzLDwvZm9udD48
L2Rpdj4NCjxkaXYgY2xhc3M9IiI+PGZvbnQgc2l6ZT0iNCIgY2xhc3M9IiI+emljaGVuPC9mb250
PjwvZGl2Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_B6EA31D4877C450EBF892879044B9EADkuaishoucom_--
