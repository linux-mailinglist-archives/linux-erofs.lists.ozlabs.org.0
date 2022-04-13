Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2AB4FF744
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Apr 2022 14:58:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KdjMc0fGbz3bdp
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Apr 2022 22:58:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=kuaishou.com header.i=@kuaishou.com header.a=rsa-sha256 header.s=dkim header.b=ldsJrdMB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kuaishou.com (client-ip=103.107.217.217;
 helo=bjm7-spam01.kuaishou.com; envelope-from=tianzichen@kuaishou.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kuaishou.com header.i=@kuaishou.com header.a=rsa-sha256
 header.s=dkim header.b=ldsJrdMB; dkim-atps=neutral
X-Greylist: delayed 1775 seconds by postgrey-1.36 at boromir;
 Wed, 13 Apr 2022 22:57:42 AEST
Received: from bjm7-spam01.kuaishou.com (smtpcn03.kuaishou.com
 [103.107.217.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KdjLG0dwyz3bpD
 for <linux-erofs@lists.ozlabs.org>; Wed, 13 Apr 2022 22:57:37 +1000 (AEST)
Received: from bjm7-spam01.kuaishou.com (localhost [127.0.0.2] (may be forged))
 by bjm7-spam01.kuaishou.com with ESMTP id 23DCS7fa089540
 for <linux-erofs@lists.ozlabs.org>; Wed, 13 Apr 2022 20:28:07 +0800 (GMT-8)
 (envelope-from tianzichen@kuaishou.com)
Received: from bjm7-pm-mail26.kuaishou.com ([172.28.1.62])
 by bjm7-spam01.kuaishou.com with ESMTPS id 23DCR75u089255
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Apr 2022 20:27:07 +0800 (GMT-8)
 (envelope-from tianzichen@kuaishou.com)
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-ID: <F41F2052051878449E4DC01E52BCB8A1@kuaishou.com>
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed; 
 t=1649852827; h=from:subject:to:date:message-id;
 bh=TnyptApGhZYqd8SJSRCUR+JWQamR+5AGe393lfj5Tao=;
 b=ldsJrdMBrlcT9XZ2RBqOwGwnfTmsUQsL0PBjbpPq+xmgDQOPhNUEA1QGZh+K0MiQFFK/vXwSd/Y
 Y9wxMF7xDL/ec/MrTw4w8pdR6/bUuapp/z46yqGsQxJpWXrP0vS82FNHAOhUW4qx+g+UTLEyPEan5
 nUEHM0FTGUkeD7tnk50=
Received: from bjfk-pm-mail30.kuaishou.com (172.29.5.62) by
 bjm7-pm-mail26.kuaishou.com (172.28.1.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.14; Wed, 13 Apr 2022 20:27:07 +0800
Received: from bjfk-pm-mail30.kuaishou.com ([fe80::2534:b256:58c3:b20]) by
 bjfk-pm-mail30.kuaishou.com ([fe80::2534:b256:58c3:b20%17]) with mapi id
 15.01.2176.014; Wed, 13 Apr 2022 20:27:07 +0800
From: =?utf-8?B?55Sw5a2Q5pmo?= <tianzichen@kuaishou.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "jefflexu@linux.alibaba.com"
 <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 00/20] fscache,erofs: fscache-based on-demand read
 semantics
Thread-Topic: [PATCH v8 00/20] fscache,erofs: fscache-based on-demand read
 semantics
Thread-Index: AQHYTzHKf6eBDuhir0CXwRoLEUpF1A==
Date: Wed, 13 Apr 2022 12:27:06 +0000
Message-ID: <B58D56BF-4456-4AD4-A25F-0C9779355DEA@kuaishou.com>
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <YlLS47A9TpHyZJQi@B-P7TQMD6M-0146.local>
In-Reply-To: <YlLS47A9TpHyZJQi@B-P7TQMD6M-0146.local>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.20.112.61]
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: bjm7-spam01.kuaishou.com 23DCS7fa089540
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
 "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 "fannaihao@baidu.com" <fannaihao@baidu.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "dhowells@redhat.com" <dhowells@redhat.com>,
 "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
 "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
 "luodaowen.backend@bytedance.com" <luodaowen.backend@bytedance.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "gerry@linux.alibaba.com" <gerry@linux.alibaba.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

DQoNCj4gMjAyMuW5tDTmnIgxMOaXpSDkuIvljYg4OjUx77yMR2FvIFhpYW5nIDxoc2lhbmdrYW9A
bGludXguYWxpYmFiYS5jb20+IOWGmemBk++8mg0KPiANCj4gT24gV2VkLCBBcHIgMDYsIDIwMjIg
YXQgMDM6NTU6NTJQTSArMDgwMCwgSmVmZmxlIFh1IHdyb3RlOg0KPj4gY2hhbmdlcyBzaW5jZSB2
NzoNCj4+IC0gcmViYXNlZCB0byA1LjE4LXJjMQ0KPj4gLSBpbmNsdWRlICJjYWNoZWZpbGVzOiB1
bm1hcmsgaW5vZGUgaW4gdXNlIGluIGVycm9yIHBhdGgiIHBhdGNoIGludG8NCj4+ICB0aGlzIHBh
dGNoc2V0IHRvIGF2b2lkIHdhcm5pbmcgZnJvbSB0ZXN0IHJvYm90IChwYXRjaCAxKQ0KPj4gLSBj
YWNoZWZpbGVzOiByZW5hbWUgW2Nvb2tpZXx2b2x1bWVdX2tleV9sZW4gZmllbGQgb2Ygc3RydWN0
DQo+PiAgY2FjaGVmaWxlc19vcGVuIHRvIFtjb29raWV8dm9sdW1lXV9rZXlfc2l6ZSB0byBhdm9p
ZCBwb3RlbnRpYWwNCj4+ICBtaXN1bmRlcnN0YW5kaW5nLiBBbHNvIGFkZCBtb3JlIGRvY3VtZW50
YXRpb24gdG8NCj4+ICBpbmNsdWRlL3VhcGkvbGludXgvY2FjaGVmaWxlcy5oLiAocGF0Y2ggMykN
Cj4+IC0gY2FjaGVmaWxlczogdmFsaWQgY2hlY2sgZm9yIGVycm9yIGNvZGUgcmV0dXJuZWQgZnJv
bSB1c2VyIGRhZW1vbg0KPj4gIChwYXRjaCAzKQ0KPj4gLSBjYWNoZWZpbGVzOiBjaGFuZ2UgV0FS
Tl9PTl9PTkNFKCkgdG8gcHJfaW5mb19vbmNlKCkgd2hlbiB1c2VyIGRhZW1vbg0KPj4gIGNsb3Nl
cyBhbm9uX2ZkIHByZW1hdHVyZWx5IChwYXRjaCA0LzUpDQo+PiAtIHJlYWR5IGZvciBjb21wbGV0
ZSByZXZpZXcNCj4+IA0KPj4gDQo+PiBLZXJuZWwgUGF0Y2hzZXQNCj4+IC0tLS0tLS0tLS0tLS0t
LQ0KPj4gR2l0IHRyZWU6DQo+PiANCj4+ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9sb3N0amVmZmxl
L2xpbnV4LmdpdCBqaW5nYm8vZGV2LWVyb2ZzLWZzY2FjaGUtdjgNCj4+IA0KPj4gR2l0d2ViOg0K
Pj4gDQo+PiAgICBodHRwczovL2dpdGh1Yi5jb20vbG9zdGplZmZsZS9saW51eC9jb21taXRzL2pp
bmdiby9kZXYtZXJvZnMtZnNjYWNoZS12OA0KPj4gDQo+PiANCj4+IFVzZXIgRGFlbW9uIGZvciBR
dWljayBUZXN0DQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gR2l0IHRyZWU6DQo+
PiANCj4+ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9sb3N0amVmZmxlL2RlbWFuZC1yZWFkLWNhY2hl
ZmlsZXNkLmdpdCBtYWluDQo+PiANCj4+IEdpdHdlYjoNCj4+IA0KPj4gICAgaHR0cHM6Ly9naXRo
dWIuY29tL2xvc3RqZWZmbGUvZGVtYW5kLXJlYWQtY2FjaGVmaWxlc2QNCj4+IA0KPiANCj4gQnR3
LCB3ZSd2ZSBhbHNvIGZpbmlzaGVkIGEgcHJlbGltaW5hcnkgZW5kLXRvLWVuZCBvbi1kZW1hbmQg
ZG93bmxvYWQNCj4gZGFlbW9uIGluIG9yZGVyIHRvIHRlc3QgdGhlIGZzY2FjaGUgb24tZGVtYW5k
IGtlcm5lbCBjb2RlIGFzIGEgcmVhbA0KPiBlbmQtdG8tZW5kIHdvcmtsb2FkIGZvciBjb250YWlu
ZXIgdXNlIGNhc2VzOg0KPiANCj4gVXNlciBndWlkZTogaHR0cHM6Ly9naXRodWIuY29tL2RyYWdv
bmZseW9zcy9pbWFnZS1zZXJ2aWNlL2Jsb2IvZnNjYWNoZS9kb2NzL255ZHVzLWZzY2FjaGUubWQN
Cj4gVmlkZW86IGh0dHBzOi8veW91dHUuYmUvRjRJRjJfREVOWG8NCg0KVGVzdGVkLWJ5OiBaaWNo
ZW4gVGlhbiA8dGlhbnppY2hlbkBrdWFpc2hvdS5jb20+DQoNCj4gVGhhbmtzLA0KPiBHYW8gWGlh
bmcNCj4gDQoNCg==
