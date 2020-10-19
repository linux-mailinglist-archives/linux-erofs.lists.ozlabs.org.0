Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE3B292165
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 05:14:11 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CF20c4DMMzDqbg
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 14:14:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:febc::60a;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=wKtLQzAH; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-hk2apc01on060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:febc::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CF20S67vNzDqWP
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Oct 2020 14:13:59 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx/oukwBlnxQADDzzsRB0tbwut9HUUbnmOC0WzjBLMkwDT55bwg+t090rn59Aiby2Scd9f9hLHv3zygb2veqvorC/oVUCyUe2Y0SEtu/ncq1eIjHXtxGXvv3q/vE0zDfqaqAWg33BcJk3TM0SZMPxxLWECb6u7VhsJSGDRMYtJhlsOQwfj54i91WUCADbv+CVL/m6NXZu3Kp34HVaeeo8uXsIS02s7eOy1NNDa8aASB/Zp6h68vBsnbL+sXEe6r3BLqLVApwrdpn28FZEwQa5taXsa55lgtU4XvQtbavrMswUBOsWC73rXfO9ifEhz/Sl+fCMXuCe+njZ/FAJDbWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcHZeB15kQ87oJNkDVco8KOu9+vtZ31spzRhKTS4/yc=;
 b=axcc3LMuSgKlK8A0/kHAHrd7KKCIZNbcxzrSWHwghDW4ZAK4WmityYDJVjEKjHwbF8KwO464ddZQVuO9W/BjK0PJOve9XTDCwCfA61ocpuW0nyZwfkE/t61PheiH43jwNrbefATcWBJhZwAu6tA8x3vxzREX399cgrVItBChj50vkCSo97oFwJvalVTeQ3uT75660bZCWGkSL+mPkM7/cIr6A1GOr+Czh2gb9e4CQ6S8hVVoluzp7q/38VUVKoUCFnmcPBqbdOiGQVuJE5aP+M82bWu/4C+aMUN9UigHopyfTYk6vLOfEpdJN0roT0Gb93lIyekJa8IU2twisrpaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcHZeB15kQ87oJNkDVco8KOu9+vtZ31spzRhKTS4/yc=;
 b=wKtLQzAHqM9lUsBXm28nhUKX5VHl3AlSvGOD5HrfBzDhETITb+H36A4kHJDM6hKRcMWtpDwCKQjDNjei1DFPN9Vs8UHCjMJmBabo5Or1U4faKcOWEj8HkQw2lx8iW1T4uD/xUTPjNLilmk7XV7XhMUh1fgfffOL8OI8n0PW4EB0=
Authentication-Results: aol.com; dkim=none (message not signed)
 header.d=none;aol.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2384.apcprd02.prod.outlook.com (2603:1096:3:1f::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Mon, 19 Oct 2020 03:13:44 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::21c8:750e:8135:b142]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::21c8:750e:8135:b142%5]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 03:13:44 +0000
Date: Mon, 19 Oct 2020 11:13:42 +0800
From: "huangjianan@oppo.com" <huangjianan@oppo.com>
To: "Gao Xiang" <hsiangkao@aol.com>
Subject: =?GB2312?B?u9i4tDogW1dJUF0gW1BBVENIIDA0LzEyXSBlcm9mcy11dGlsczogZnVzZTogYWRqdXN0IGxhcmdlciBleHRlbnQgaGFuZGxpbmc=?=
References: <20201017051621.7810-1-hsiangkao@aol.com>, 
 <20201017051621.7810-5-hsiangkao@aol.com>
X-GUID: 956159EF-FD27-453A-8D42-10C8FAAC246B
X-Has-Attach: no
X-Mailer: Foxmail 7.2.18.111[cn]
Message-ID: <2020101911134102451012@oppo.com>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart242521225423_=----"
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450 (58.255.79.104) by
 HK2PR03CA0050.apcprd03.prod.outlook.com (2603:1096:202:17::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.4 via Frontend Transport; Mon, 19 Oct 2020 03:13:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c10f247-fe17-4551-cdd1-08d873dcfc44
X-MS-TrafficTypeDiagnostic: SG2PR02MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2384CA3743BDBFAB216E48CCC31E0@SG2PR02MB2384.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJuC/rg+pIZHfBKAyjgmGu0R+XWgkLAF4Jvffz86gQr27H03qp8jYTH8Ek2GPVTjPV5v2tyZ0eJd0cVLgJ/Fe4vEwfni3DNwvpqMLiKOPrpuq2KIN2OLwF2+2MUIv0sRpiyl4n1doWM8evu/2DO6owcW3WO6zXZeNrj3mnePdy1QWY3IJSrl2qvyiJD28sjIqvo16mNlEmUYoZarPdc35z0bZPSHsU1Y7CHii23wi/tMhKmeVl8qEEsVf0dO41LTbG9+0dBGu0jkAzlxnT9BaYbc8rKL8J8m0JyyokB8UCXp8qhB/dVyWpY33si0/BH1Zmb5LJ5qOeLLp8jRtXcPad+6rRWBuaKVbyJY71x6ibz8ChHK07xtUKl31dECtpRn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(224303003)(6486002)(37786003)(2616005)(83380400001)(316002)(19627405001)(66556008)(4001150100001)(1076003)(66476007)(16526019)(186003)(26005)(66946007)(6916009)(107886003)(86362001)(8936002)(956004)(478600001)(58226001)(52116002)(36756003)(4326008)(5660300002)(54906003)(2906002)(98106002)(6496006)(11606004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6k0GCljiLvzlD8HbLLIXl154+/Q5SS+vjvcJBAZFxo69PklTdJj4G5CH81zR4wzVJRqYpGYcrtntdO1hJ02cK3xxlva4YD+8M74di0BFCX66z7cBJEmeTI+fvFRs6zMlWm6zYjI/0B4LYuF9XLQkaWnYjUV9WddXpfRAIkhlHaYgx4fjnYT8LxaGcY6An2iU35pGvIuttqzbyMhw5f2gA9ZkjtUKTmG54yWxGYvcFe6kG7SlfNprRj+iog9xGi1isryMIeLGg6qJpgefHLUIkSyonIs+7jrH1qtMaL4W9Mb82Qw5ohOCPaFbxQOfwuQbJa83FU+2vuGPCVeO88eSO6Q5oxyoYKcqmjhJLgauiEwISHgdun22ZBStUsLOyLkFLKupSeRV6UOpD13S88rPqSWmjBIImI7d/8D2Bt5Rh5fnBzvITgIpBK1ugoL0zQyzR9cfffn1J4KRKMgT2FgRVLBRgyh5wkCUM0TlYyymiuvTd/sa9TTNkWDa6a9+T2KSC5X4uVRvZ9zlIuICAbpw8UWC8+uBjtb1xEUTpXi4yGAZypftRCeJZmm1uAH4/fc5f2T4aCHttjNIGmyNzNxRsjjre0i9V5a6BNHLq3Hp71KgRP+WqCLImYT3xGFNlo52fFlu54gpiTWN5H/rm3oxwQ==
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c10f247-fe17-4551-cdd1-08d873dcfc44
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 03:13:43.8730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvCKsh4kTRMCK1nLD3jR0aX5NwA8I+PVx+Fd7Oz9tGiC+EtlsB0aZrwK+y0h2t80mxQJHIIfc+a3wr55ALRrlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2384
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
Cc: guoweichao <guoweichao@oppo.com>,
 linux-erofs <linux-erofs@lists.ozlabs.org>,
 zhangshiming <zhangshiming@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

------=_001_NextPart242521225423_=----
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGksIEdhbyBYaWFuZ6OsDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQq3orz+
yMujuiBHYW8gWGlhbmc8bWFpbHRvOmhzaWFuZ2thb0Bhb2wuY29tPg0Kt6LLzcqxvOSjuiAyMDIw
LTEwLTE3IDEzOjE2DQrK1bz+yMujuiBsaW51eC1lcm9mczxtYWlsdG86bGludXgtZXJvZnNAbGlz
dHMub3psYWJzLm9yZz4NCrOty82juiBIdWFuZyBKaWFuYW48bWFpbHRvOmh1YW5namlhbmFuQG9w
cG8uY29tPjsgTGkgR3VpZnU8bWFpbHRvOmJsdWNlLmxpZ3VpZnVAaHVhd2VpLmNvbT47IExpIEd1
aWZ1PG1haWx0bzpibHVjZS5sZWVAYWxpeXVuLmNvbT47IENoYW8gWXU8bWFpbHRvOmNoYW9Aa2Vy
bmVsLm9yZz47IEd1byBXZWljaGFvPG1haWx0bzpndW93ZWljaGFvQG9wcG8uY29tPjsgWmhhbmcg
U2hpbWluZzxtYWlsdG86emhhbmdzaGltaW5nQG9wcG8uY29tPjsgR2FvIFhpYW5nPG1haWx0bzpo
c2lhbmdrYW9AYW9sLmNvbT4NCtb3zOKjuiBbV0lQXSBbUEFUQ0ggMDQvMTJdIGVyb2ZzLXV0aWxz
OiBmdXNlOiBhZGp1c3QgbGFyZ2VyIGV4dGVudCBoYW5kbGluZw0Kc28gbW9yZSBlYXN5IHRvIHVu
ZGVyc3RhbmQuDQoNClsgbGV0J3MgZm9sZCBpbiB0byB0aGUgb3JpZ2luYWwgcGF0Y2guIF0NCkNj
OiBIdWFuZyBKaWFuYW4gPGh1YW5namlhbmFuQG9wcG8uY29tPg0KU2lnbmVkLW9mZi1ieTogR2Fv
IFhpYW5nIDxoc2lhbmdrYW9AYW9sLmNvbT4NCi0tLQ0KZnVzZS9yZWFkLmMgfCAxMyArKysrKysr
KystLS0tDQoxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZnVzZS9yZWFkLmMgYi9mdXNlL3JlYWQuYw0KaW5kZXggMGQwZTNiMGZh
NDY4Li5kZDQ0YWRhYTFjNDAgMTAwNjQ0DQotLS0gYS9mdXNlL3JlYWQuYw0KKysrIGIvZnVzZS9y
ZWFkLmMNCkBAIC0xMTIsMTIgKzExMiwxNyBAQCBzaXplX3QgZXJvZnNfcmVhZF9kYXRhX2NvbXBy
ZXNzaW9uKHN0cnVjdCBlcm9mc192bm9kZSAqdm5vZGUsIGNoYXIgKmJ1ZmZlciwNClpfRVJPRlNf
Q09NUFJFU1NJT05fTFo0IDoNClpfRVJPRlNfQ09NUFJFU1NJT05fU0hJRlRFRDsNCi0gaWYgKGVu
ZCA+PSBtYXAubV9sYSArIG1hcC5tX2xsZW4pIHsNCi0gY291bnQgPSBtYXAubV9sbGVuOw0KLSBw
YXJ0aWFsID0gIShtYXAubV9mbGFncyAmIEVST0ZTX01BUF9GVUxMX01BUFBFRCk7DQotIH0gZWxz
ZSB7DQorIC8qDQorICogdHJpbSB0byB0aGUgbmVlZGVkIHNpemUgaWYgdGhlIHJldHVybmVkIGV4
dGVudCBpcyBxdWl0ZQ0KKyAqIGxhcmdlciB0aGFuIHJlcXVlc3RlZCwgYW5kIHNldCB1cCBwYXJ0
aWFsIGZsYWcgYXMgd2VsbC4NCisgKi8NCisgaWYgKGVuZCA8IG1hcC5tX2xhICsgbWFwLm1fbGxl
bikgew0KY291bnQgPSBlbmQgLSBtYXAubV9sYTsNCnBhcnRpYWwgPSB0cnVlOw0KKyB9IGVsc2Ug
ew0KKyBBU1NFUlQoZW5kID09IG1hcC5tX2xhICsgbWFwX21fbGxlbik7DQoNCkkgdGhpbmsgeW91
IG1lYW4gbWFwLm1fbGxlbiBpbnRlc2FkIG9mIG1hcF9tX2xsZW4uDQpCZXNpZGVzLCBJIGRvbid0
IHVuZGVyc3RhbmQgd2h5IGFkZCBBU1NFUlQgaGVyZS4NCkkgdGhpbmsgdGhpcyBjb25kaXRpb24g
d2lsbCBiZSB0cnVlIGlmIG9mZnNldCtzaXplIGlzIGV4YWN0bHkgdGhlIGVuZCBvZiBhIGNvbXBy
ZXNzZWQgYmxvY2s/DQoNCisgY291bnQgPSBtYXAubV9sbGVuOw0KKyBwYXJ0aWFsID0gIShtYXAu
bV9mbGFncyAmIEVST0ZTX01BUF9GVUxMX01BUFBFRCk7DQp9DQppZiAoKG9mZl90KW1hcC5tX2xh
IDwgb2Zmc2V0KSB7DQotLQ0KMi4yNC4wDQoNClRoYW5rcywNCkppYW5hbg0KDQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQpPUFBPDQoNCrG+tefX09PKvP68sMbkuL28/rqs09BP
UFBPuavLvrXEsaPD3NDFz6KjrL32z97T2tPKvP7WuMP3tcTK1bz+yMvKudPDo6iw/LqsuPbIy7yw
yLrX6aOpoaO9+9a5yM66zsjL1NrOtL6tytrIqLXEx+m/9s/C0tTIzrrO0M7Kvcq508Oho8jnufvE
+rTtytXBy7G+08q8/qOsx+vBory00tS159fT08q8/s2o1qq3orz+yMuyosm+s/2xvtPKvP68sMbk
uL28/qGjDQoNClRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRl
bnRpYWwgaW5mb3JtYXRpb24gZnJvbSBPUFBPLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0
aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVz
ZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRp
bmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXBy
b2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50
ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1t
YWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwg
aW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCENCg==

------=_001_NextPart242521225423_=----
Content-Type: text/html;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style>body { line-height: 1.5; }blockquote { margin-top: 0px; margin-botto=
m: 0px; margin-left: 0.5em; }body { font-size: 14px; font-family: 'Microsof=
t YaHei UI'; color: rgb(0, 0, 0); line-height: 1.5; }</style>
</head>
<body>
<div><span></span>Hi, Gao Xiang=A3=AC</div>
<hr style=3D"width: 210px; height: 1px; display: none;" color=3D"#b5c4df" s=
ize=3D"1" align=3D"left">
<div><span></span></div>
<blockquote style=3D"margin-Top: 0px; margin-Bottom: 0px; margin-Left: 0.5e=
m; margin-Right: inherit">
<div>&nbsp;</div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<div style=3D"PADDING-RIGHT: 8px; PADDING-LEFT: 8px; FONT-SIZE: 12px;FONT-F=
AMILY:tahoma;COLOR:#000000; BACKGROUND: #efefef; PADDING-BOTTOM: 8px; PADDI=
NG-TOP: 8px">
<div><b>=B7=A2=BC=FE=C8=CB=A3=BA</b>&nbsp;<a href=3D"mailto:hsiangkao@aol.c=
om">Gao Xiang</a></div>
<div><b>=B7=A2=CB=CD=CA=B1=BC=E4=A3=BA</b>&nbsp;2020-10-17&nbsp;13:16</div>
<div><b>=CA=D5=BC=FE=C8=CB=A3=BA</b>&nbsp;<a href=3D"mailto:linux-erofs@lis=
ts.ozlabs.org">linux-erofs</a></div>
<div><b>=B3=AD=CB=CD=A3=BA</b>&nbsp;<a href=3D"mailto:huangjianan@oppo.com"=
>Huang Jianan</a>; <a href=3D"mailto:bluce.liguifu@huawei.com">
Li Guifu</a>; <a href=3D"mailto:bluce.lee@aliyun.com">Li Guifu</a>; <a href=
=3D"mailto:chao@kernel.org">
Chao Yu</a>; <a href=3D"mailto:guoweichao@oppo.com">Guo Weichao</a>; <a hre=
f=3D"mailto:zhangshiming@oppo.com">
Zhang Shiming</a>; <a href=3D"mailto:hsiangkao@aol.com">Gao Xiang</a></div>
<div><b>=D6=F7=CC=E2=A3=BA</b>&nbsp;[WIP] [PATCH 04/12] erofs-utils: fuse: =
adjust larger extent handling</div>
</div>
</div>
<div>
<div>so more easy to understand.</div>
<div>&nbsp;</div>
<div>[ let's fold in to the original patch. ]</div>
<div>Cc: Huang Jianan &lt;huangjianan@oppo.com&gt;</div>
<div>Signed-off-by: Gao Xiang &lt;hsiangkao@aol.com&gt;</div>
<div>---</div>
<div>fuse/read.c | 13 +++++++++----</div>
<div>1 file changed, 9 insertions(+), 4 deletions(-)</div>
<div>&nbsp;</div>
<div>diff --git a/fuse/read.c b/fuse/read.c</div>
<div>index 0d0e3b0fa468..dd44adaa1c40 100644</div>
<div>--- a/fuse/read.c</div>
<div>+++ b/fuse/read.c</div>
<div>@@ -112,12 +112,17 @@ size_t erofs_read_data_compression(struct erofs_=
vnode *vnode, char *buffer,</div>
<div>Z_EROFS_COMPRESSION_LZ4 :</div>
<div>Z_EROFS_COMPRESSION_SHIFTED;</div>
<div></div>
<div>- if (end &gt;=3D map.m_la + map.m_llen) {</div>
<div>- count =3D map.m_llen;</div>
<div>- partial =3D !(map.m_flags &amp; EROFS_MAP_FULL_MAPPED);</div>
<div>- } else {</div>
<div>+ /*</div>
<div>+ * trim to the needed size if the returned extent is quite</div>
<div>+ * larger than requested, and set up partial flag as well.</div>
<div>+ */</div>
<div>+ if (end &lt; map.m_la + map.m_llen) {</div>
<div>count =3D end - map.m_la;</div>
<div>partial =3D true;</div>
<div>+ } else {</div>
<div>+ ASSERT(end =3D=3D map.m_la + map_m_llen);</div>
<div><br>
</div>
<div>I think you mean map.m_llen intesad of map_m_llen.</div>
<div><span style=3D"font-family: Roboto, arial, sans-serif; font-size: 16px=
; font-variant-ligatures: normal; orphans: 2; white-space: nowrap; widows: =
2;">Besides, I don't understand why add ASSERT here.&nbsp;</span></div>
<div><span style=3D"font-family: Roboto, arial, sans-serif; font-size: 16px=
; orphans: 2; white-space: nowrap; widows: 2; line-height: 1.5; background-=
color: transparent;">I think this condition will be true if offset+size is&=
nbsp;exactly the end of a compressed block?</span></div>
<div><br>
</div>
<div>+ count =3D map.m_llen;</div>
<div>+ partial =3D !(map.m_flags &amp; EROFS_MAP_FULL_MAPPED);</div>
<div>}</div>
<div></div>
<div>if ((off_t)map.m_la &lt; offset) {</div>
<div>-- </div>
<div>2.24.0</div>
<div><br>
</div>
<div>Thanks,</div>
<div>Jianan</div>
<div><br>
</div>
<div>&nbsp;</div>
</div>
</blockquote>
<hr>
<div style=3D"font-size: 12px;"><strong style=3D"color: rgb(0, 107, 55); fo=
nt-family: ArialMT;">OPPO</strong></div>
<div style=3D"font-size: 12px;"><strong style=3D"color: rgb(0, 107, 55); fo=
nt-family: ArialMT; font-size: 14px;"><span style=3D"font-size: 12px;"><br>
</span></strong></div>
<div></div>
<div style=3D"color: rgb(49, 53, 59); font-family: Helvetica; font-variant-=
numeric: normal; font-variant-east-asian: normal; line-height: 22.4px; wido=
ws: 1;">
<span style=3D"color: rgb(202, 202, 200); font-family: ArialMT; font-size: =
12px;">=B1=BE=B5=E7=D7=D3=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0<s=
pan style=3D"font-stretch: normal; line-height: normal;">OPPO</span>=B9=AB=
=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=D3=CA=BC=FE=D6=
=B8=C3=F7=B5=C4=CA=D5=BC=FE=C8=CB=CA=B9=D3=C3=A3=A8=B0=FC=BA=AC=B8=F6=C8=CB=
=BC=B0=C8=BA=D7=E9=A3=A9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C8=CB=D4=DA=CE=B4=BE=
=AD=CA=DA=C8=A8=B5=C4=C7=E9=BF=F6=CF=C2=D2=D4=C8=CE=BA=CE=D0=CE=CA=BD=CA=B9=
=D3=C3=A1=A3=C8=E7=B9=FB=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC</s=
pan><span style=3D"font-family: ArialMT; color: rgb(202, 202, 200); font-si=
ze: 12px;">=C7=EB=C1=A2=BC=B4=D2=D4=B5=E7=D7=D3=D3=CA=BC=FE=CD=A8=D6=AA=B7=
=A2=BC=FE=C8=CB=B2=A2=C9=BE=B3=FD=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=
=A1=A3</span></div>
<div style=3D"color: rgb(49, 53, 59); font-family: Helvetica; font-variant-=
numeric: normal; font-variant-east-asian: normal; line-height: 22.4px; wido=
ws: 1;">
<p style=3D"margin: 0px; font-stretch: normal; line-height: normal; min-hei=
ght: 15px;">
<span style=3D"color: rgb(202, 202, 200);"><span style=3D"font-size: 12px; =
font-family: ArialMT;">This e-mail and its attachments contain confidential=
 information from OPPO</span><span style=3D"font-size: 12px; font-family: A=
rialMT; font-stretch: normal; line-height: normal;">,</span><span style=3D"=
font-size: 12px; font-family: ArialMT;">&nbsp;which
 is intended only for the person or entity whose address is listed above. A=
ny use of the information contained herein in any way&nbsp;</span><span sty=
le=3D"font-size: 12px; font-family: ArialMT; font-stretch: normal; line-hei=
ght: normal;">(</span><span style=3D"font-size: 12px; font-family: ArialMT;=
">including</span><span style=3D"font-size: 12px; font-family: ArialMT; fon=
t-stretch: normal; line-height: normal;">,</span><span style=3D"font-size: =
12px; font-family: ArialMT;">&nbsp;but
 not limited to</span><span style=3D"font-size: 12px; font-family: ArialMT;=
 font-stretch: normal; line-height: normal;">,</span><span style=3D"font-si=
ze: 12px; font-family: ArialMT;">&nbsp;total or partial disclosure</span><s=
pan style=3D"font-size: 12px; font-family: ArialMT; font-stretch: normal; l=
ine-height: normal;">,</span><span style=3D"font-size: 12px; font-family: A=
rialMT;">&nbsp;reproduction</span><span style=3D"font-size: 12px; font-fami=
ly: ArialMT; font-stretch: normal; line-height: normal;">,</span><span styl=
e=3D"font-size: 12px; font-family: ArialMT;">&nbsp;or
 dissemination</span><span style=3D"font-size: 12px; font-family: ArialMT; =
font-stretch: normal; line-height: normal;">)</span><span style=3D"font-siz=
e: 12px; font-family: ArialMT;">&nbsp;by persons other than the intended re=
cipient</span><span style=3D"font-size: 12px; font-family: ArialMT; font-st=
retch: normal; line-height: normal;">(</span><span style=3D"font-size: 12px=
; font-family: ArialMT;">s</span><span style=3D"font-size: 12px; font-famil=
y: ArialMT; font-stretch: normal; line-height: normal;">)</span><span style=
=3D"font-size: 12px; font-family: ArialMT;">&nbsp;is
 prohibited. If you receive this e-mail in error</span><span style=3D"font-=
size: 12px; font-family: ArialMT; font-stretch: normal; line-height: normal=
;">,</span><span style=3D"font-size: 12px; font-family: ArialMT;">&nbsp;ple=
ase notify the sender by phone or email immediately
 and delete it!</span></span></p>
</div>
<div></div>
</body>
</html>

------=_001_NextPart242521225423_=------
