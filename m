Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E2292201
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 06:50:16 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CF47V3JnWzDqWk
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 15:50:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=52.100.182.227;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=1P+kf4uA; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-hk2apc01hn2227.outbound.protection.outlook.com [52.100.182.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CF47N2qghzDqNT
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Oct 2020 15:50:05 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPycuU53G4zfUonBYAYJdv4QECF+bv8EWP1+Mazh3N1YG1336p9+qGKQ3x2kt1m9SXYG4Y0FQ1XtgB+9kKl76dglnabm4klZWt4/nmUt+lBjP18OiKsGqmcHVaoOcrtxL/2NECczTz4XQdJEcrOCLH475GwFKixQvOZE+yFMnZOEXYukHboMfaFvUk7WqFj03daGq4Q/xZxCEgb+kLaCtaZEaGwSXvYnLFgVwHwZI5GpRUX9Ur99nzUN1bljROS0MVUNn3zkbzoFdxzJT9O43OM/tZw8yCOLw9fY7N3R1mMd00aSZouIOHRw5sxLOzuM+VeFrz+DCoa94UcRo3KQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDVhSL9+4wG3rkt3hQ9q4+UPDqidzqIMTvg8w9b+yY8=;
 b=lpwwBUh03INwe3eVlqYffjIp1MzNzg5pQLnJz7bXeYNUaRp9f78lSJoOn9MYZqk6db1TGU5rV63RBNSwcN98BRE5BYkd+0powSlIgNtfxfAjkej7M3aIcnX4zatLiDYgoq3CXYYrT5YbFwgFVAxc403Nwxzx//9u+s5qxaypajhVZ5SPi/7H1zAe7HB07lQoeqvHnlzt1raGSgG5a6xjXAqtqjs+BcFREJjkywdXVRbGP9691WN4LH7syz29JVX3414NlYmWMsroVo5BcQ9rx8AvjhAlCMEl4zU+UUmXWvjoh7hb8ULb0R1Okxim/G8zd4dh45p3CPx6xOIzsb2D2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDVhSL9+4wG3rkt3hQ9q4+UPDqidzqIMTvg8w9b+yY8=;
 b=1P+kf4uAnEaHNa2zRDGzR6jECJAm+2KvGHs6rfxEXdkLs6CqNirYODuG+TqgPTLe79GjnQj50rd+iYLjJtbDUbGcFei3A6ViTbzOdS6h5pVyQQRbvhnMcG1ZlvVFeWFFOeBI/jspZaYYqFQVZUNp4G2PGoL7xY+9EB4HsmZlfnQ=
Authentication-Results: aol.com; dkim=none (message not signed)
 header.d=none;aol.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3847.apcprd02.prod.outlook.com (2603:1096:4:29::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Mon, 19 Oct 2020 04:49:52 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::21c8:750e:8135:b142]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::21c8:750e:8135:b142%5]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 04:49:52 +0000
Date: Mon, 19 Oct 2020 12:49:51 +0800
From: "Huang Jianan" <huangjianan@oppo.com>
To: "Gao Xiang" <hsiangkao@aol.com>
Subject: =?utf-8?B?5Zue5aSNOiBSZTogW1dJUF0gW1BBVENIIDA0LzEyXSBlcm9mcy11dGlsczogZnVzZTogYWRqdXN0IGxhcmdlciBleHRlbnQgaGFuZGxpbmc=?=
References: <20201017051621.7810-1-hsiangkao@aol.com>, 
 <20201017051621.7810-5-hsiangkao@aol.com>, 
 <2020101911134102451012@oppo.com>, 
 <20201019033251.GA29138@hsiangkao-HP-ZHAN-66-Pro-G1>
X-GUID: ABFA63DA-61E1-45E5-86C5-55A7D2385C4B
X-Has-Attach: no
X-Mailer: Foxmail 7.2.18.111[cn]
Message-ID: <2020101912494966296411@oppo.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR04CA0051.apcprd04.prod.outlook.com
 (2603:1096:202:14::19) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450 (58.252.5.72) by
 HK2PR04CA0051.apcprd04.prod.outlook.com (2603:1096:202:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22 via Frontend Transport; Mon, 19 Oct 2020 04:49:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7966cff-b34c-4b12-ecd2-08d873ea6ab4
X-MS-TrafficTypeDiagnostic: SG2PR02MB3847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB384780E6BBBB4F42C6C6718EC31E0@SG2PR02MB3847.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaHsUbOOyTs596TsmHwupK3+0x3HjOKWzZadyRoxHmo0RcNZGBct1DSm2QnAIZZObPgiOmYwLCSgyINpDDqfMS4FY02ZjxZfIcBJdIBXTGyTc8yTKQu5w8VyGZciPl+lnadazwPfg5PpHgPnlpckh+ihZXOqAn0uKU7hsGOI6YVEOGm8L/MJY6RUKx8tVG0XwaQXqpSdyaUMxKiDuxhHgSU2NgKxdVCoCyKSaiwMEo8UZXomDV8YFI8ReDh+ZbNE94bWzcck+uh5zH32o26brl0sTj81tC+6oBqDcW2R0cUYSC6k9Ut+hpTRFiIHrpeANeARrLbqnNLtUDgfmcy1Pz9FaUogrP7oWlZ+ma32vxdFy1e07TJSAT94EatmixCJTm4SeXVsepsj1dFfaUxQM2D28DJHNrLOQUDJK1y0woeDm0w3WexCYZoXrBZs6qHGpxhQIHV4SL5rqb+cnzQ80oRP6b3q5fqgR9eTYO0cEq0hEGDlG3xLlWsCqrZP+iOJuEZ9lgna672hj1n9+vCtcrxQebY0+PfwCn8UtCGVT3KkE6CSCeO5Dh+BWslkx/RpIcp0kN7/q6Q5btXKiDnNynsKtfx9kGDh9eS6iet+IIpyx4jIGInTVx1Mtd8D6S7mIPQJ6c1yBVYwAfpZ0e9GHJJayQEbDUEk+CKRKqW5ZGoEa0GxMMI23NowkEFVwpZpOHREn4TZcV+N1DXd5sh/Rj1sEDzYrQMUyvM4lYSE3hU6K2nBgs0m6t6/2dNcOU5sK7Sko8ltXi/bHx4mXzHtxai8IVc8eTQpr6XFTcTV2IsYVVMencNKEk+P0MDIr5uF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:5; SRV:;
 IPV:NLI; SFV:SPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:OSPM;
 SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(66946007)(58226001)(316002)(224303003)(2906002)(6496006)(66556008)(52116002)(66476007)(98106002)(5660300002)(37786003)(1076003)(956004)(2616005)(186003)(8936002)(16526019)(54906003)(26005)(6916009)(107886003)(6486002)(4326008)(478600001)(86362001)(83380400001)(36756003)(4001150100001)(534134004)(534874004)(534864004);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData: htKyiRTypmuuBFWuHr2em1oG40CBllROkqV2Ahz2/z51Pz7+hAlpILv8dCy64Prz1qTgqprhsnrYqMQ7jqvT/pFuMc78+bnuAgy1t6qzJ0g/RieSj34H85qi6aE8MhLNfdmNIU2sHtf8BuKASY+GFrYzfbYluMvF23wMDT2oAym0Wo26aJDvz3fPbGlVMJbWx9V6G8ZlI567+wydIDInZfYjDTOOMaQbuU7hJp3ImEcFmJdpZNYiTA5Tztyd+Y87gV/Upc2AL2tUO9Xh1Gsh7DkAjS/UVJeK4hqfrNLGSz9Lue0buwU92l08sqywRaPgT+kuqA1R7AJx61t4T3je40gAiMZYhlHQTPJNLvwhL0na5nLOjxgO9FBXs9TtvUJsLRI3ibEiOzhKkSa/id1QiMVtaJnlsdH9R6vFmTYBEZBtnw9y6IeKm6xGtgLHICuvsm1lV/IAHPLhzmhvR1qG7LiCx5hQk9Q88JrLDPXnSxfKWXb9TEbdvgVuwb5GrXc0E00yxoutIbVsjkBPQwlke0IpdNlD5nOAdwssfBAgjej8AigewoWDQw1XSVBrldoZgJQ6r2+Nx/wuVO+sbcrpbHfFMDY5ZbiWx0HfJ/3uOQB6nmqAyywnBdryQETVxDeWPy/ygfwcGz8mDmGs/80zbw==
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7966cff-b34c-4b12-ecd2-08d873ea6ab4
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 04:49:52.4597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYE22+EabR5crhSMNBQdYzGO8Lmz3SWQMPxl3p0FSJpU9qtJl6Dx89Pd00ks6LICo1qlOaeeqn+IQ/ue6VAFHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3847
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
Cc: zhangshiming <zhangshiming@oppo.com>,
 linux-erofs <linux-erofs@lists.ozlabs.org>, guoweichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

SGksIEdhbyBYaWFuZywNClRoYW5rcyBmb3IgeW91IGFuc3dlciwgSSB1bmRlcnN0YW5kIG5vdy4N
CkluIGFkZGl0aW9uLCBJIHNlbnQgYSBwYXRjaCB0byBmaXggdGhlIGNsZXJpY2FsIGVycm9yIGhl
cmUuDQpJdCBzZWVtcyB0aGF0IHRoZSBjb21waWxhdGlvbiB3b24ndCBiZSBhZmZlY3RlZCB1bmRl
ciB0aGUgZGVmYXVsdCBjb25maWd1cmF0aW9uLg0KDQpUaGFua3MsDQpKaWFuYW4NCi0tLS0tLS0t
LS0tLS0tDQpIdWFuZyBKaWFuYW4NCj5IaSBKaWFuYW4sDQo+DQo+T24gTW9uLCBPY3QgMTksIDIw
MjAgYXQgMTE6MTM6NDJBTSArMDgwMCwgaHVhbmdqaWFuYW5Ab3Bwby5jb20gd3JvdGU6DQo+PiBI
aSwgR2FvIFhpYW5n6ZSf5pak5ou3DQo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPj4NCj4+IOmUn+aWpOaLt+mUn+aWpOaLt+mUn+WJv++9j+aLtyBHYW8gWGlhbmc8bWFpbHRv
OmhzaWFuZ2thb0Bhb2wuY29tPg0KPj4g6ZSf5pak5ou36ZSf5pak5ou35pe26ZSf5oiS77yaIDIw
MjAtMTAtMTcgMTM6MTYNCj4+IOmUn+enuOeht+aLt+mUn+WJv++9j+aLtyBsaW51eC1lcm9mczxt
YWlsdG86bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZz4NCj4+IOmUn+aWpOaLt+mUn+mFte+9
j+aLtyBIdWFuZyBKaWFuYW48bWFpbHRvOmh1YW5namlhbmFuQG9wcG8uY29tPjsgTGkgR3VpZnU8
bWFpbHRvOmJsdWNlLmxpZ3VpZnVAaHVhd2VpLmNvbT47IExpIEd1aWZ1PG1haWx0bzpibHVjZS5s
ZWVAYWxpeXVuLmNvbT47IENoYW8gWXU8bWFpbHRvOmNoYW9Aa2VybmVsLm9yZz47IEd1byBXZWlj
aGFvPG1haWx0bzpndW93ZWljaGFvQG9wcG8uY29tPjsgWmhhbmcgU2hpbWluZzxtYWlsdG86emhh
bmdzaGltaW5nQG9wcG8uY29tPjsgR2FvIFhpYW5nPG1haWx0bzpoc2lhbmdrYW9AYW9sLmNvbT4N
Cj4+IOmUn+aWpOaLt+mUn+ino++8miBbV0lQXSBbUEFUQ0ggMDQvMTJdIGVyb2ZzLXV0aWxzOiBm
dXNlOiBhZGp1c3QgbGFyZ2VyIGV4dGVudCBoYW5kbGluZw0KPj4gc28gbW9yZSBlYXN5IHRvIHVu
ZGVyc3RhbmQuDQo+Pg0KPj4gWyBsZXQncyBmb2xkIGluIHRvIHRoZSBvcmlnaW5hbCBwYXRjaC4g
XQ0KPj4gQ2M6IEh1YW5nIEppYW5hbiA8aHVhbmdqaWFuYW5Ab3Bwby5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBHYW8gWGlhbmcgPGhzaWFuZ2thb0Bhb2wuY29tPg0KPj4gLS0tDQo+PiBmdXNlL3Jl
YWQuYyB8IDEzICsrKysrKysrKy0tLS0NCj4+IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Z1c2UvcmVhZC5jIGIvZnVz
ZS9yZWFkLmMNCj4+IGluZGV4IDBkMGUzYjBmYTQ2OC4uZGQ0NGFkYWExYzQwIDEwMDY0NA0KPj4g
LS0tIGEvZnVzZS9yZWFkLmMNCj4+ICsrKyBiL2Z1c2UvcmVhZC5jDQo+PiBAQCAtMTEyLDEyICsx
MTIsMTcgQEAgc2l6ZV90IGVyb2ZzX3JlYWRfZGF0YV9jb21wcmVzc2lvbihzdHJ1Y3QgZXJvZnNf
dm5vZGUgKnZub2RlLCBjaGFyICpidWZmZXIsDQo+PiBaX0VST0ZTX0NPTVBSRVNTSU9OX0xaNCA6
DQo+PiBaX0VST0ZTX0NPTVBSRVNTSU9OX1NISUZURUQ7DQo+PiAtIGlmIChlbmQgPj0gbWFwLm1f
bGEgKyBtYXAubV9sbGVuKSB7DQo+PiAtIGNvdW50ID0gbWFwLm1fbGxlbjsNCj4+IC0gcGFydGlh
bCA9ICEobWFwLm1fZmxhZ3MgJiBFUk9GU19NQVBfRlVMTF9NQVBQRUQpOw0KPj4gLSB9IGVsc2Ug
ew0KPj4gKyAvKg0KPj4gKyAqIHRyaW0gdG8gdGhlIG5lZWRlZCBzaXplIGlmIHRoZSByZXR1cm5l
ZCBleHRlbnQgaXMgcXVpdGUNCj4+ICsgKiBsYXJnZXIgdGhhbiByZXF1ZXN0ZWQsIGFuZCBzZXQg
dXAgcGFydGlhbCBmbGFnIGFzIHdlbGwuDQo+PiArICovDQo+PiArIGlmIChlbmQgPCBtYXAubV9s
YSArIG1hcC5tX2xsZW4pIHsNCj4+IGNvdW50ID0gZW5kIC0gbWFwLm1fbGE7DQo+PiBwYXJ0aWFs
ID0gdHJ1ZTsNCj4+ICsgfSBlbHNlIHsNCj4+ICsgQVNTRVJUKGVuZCA9PSBtYXAubV9sYSArIG1h
cF9tX2xsZW4pOw0KPj4NCj4+IEkgdGhpbmsgeW91IG1lYW4gbWFwLm1fbGxlbiBpbnRlc2FkIG9m
IG1hcF9tX2xsZW4uDQo+PiBCZXNpZGVzLCBJIGRvbid0IHVuZGVyc3RhbmQgd2h5IGFkZCBBU1NF
UlQgaGVyZS4NCj4+IEkgdGhpbmsgdGhpcyBjb25kaXRpb24gd2lsbCBiZSB0cnVlIGlmIG9mZnNl
dCtzaXplIGlzIGV4YWN0bHkgdGhlIGVuZCBvZiBhIGNvbXByZXNzZWQgYmxvY2s/DQo+DQo+VGhh
bmtzIGZvciB5b3VyIHF1ZXN0aW9uLg0KPlRoZSBpZGVhIGlzIHRoYXQgd2UgcmVxdWVzdGVkIHRo
ZSBleHRlbnQgd2l0aA0KPg0KPiAgICAgICBtYXAubV9sYSA9IGVuZCAtIDE7DQo+DQo+ICAgICAg
IHJldCA9IHpfZXJvZnNfbWFwX2Jsb2Nrc19pdGVyKHZub2RlLCAmbWFwKTsNCj4gICAgICAgaWYg
KHJldCkNCj4gICAgICAgcmV0dXJuIHJldDsNCj4NCj5zbyB0aGUgZXh0ZW50IG11c3QgaW5jbHVk
ZSAiZW5kIC0gMSIsIHNvDQo+aXQncyBpbXBvc3NpYmxlIHRoYXQgImVuZCA+IG1hcC5tX2xhICsg
bWFwLm1fbGxlbiINCj4oaW52YWxpZCByZXR1cm4pLg0KPg0KPm9yIHRoZSBlbnRpcmUgZXh0ZW50
IHdvdWxkIGJlIGhvbGVkIGV4dGVudCwgYW55d2F5LA0KPnRoYXQgaXMgYW5vdGhlciBleHRlbnQg
cmF0aGVyIHRoYW4gYSBkYXRhIGV4dGVudC4NCj4NCj4oQlRXLCB0aGUgdXAtdG8tZGF0ZSBjb21t
aXRzIGlzIGF0DQo+aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQveGlhbmcvZXJvZnMtdXRpbHMuZ2l0L2xvZy8/aD13aXAvZXhwZXJpbWVudGFsX2Z1c2UNCj5r
aW5kbHkgY2hlY2sgb3V0IHRoZW0gYXMgd2VsbCA6KSApDQo+DQo+VGhhbmtzLA0KPkdhbyBYaWFu
Zw0KPg0KPg0KPj4NCj4+ICsgY291bnQgPSBtYXAubV9sbGVuOw0KPj4gKyBwYXJ0aWFsID0gISht
YXAubV9mbGFncyAmIEVST0ZTX01BUF9GVUxMX01BUFBFRCk7DQo+PiB9DQo+PiBpZiAoKG9mZl90
KW1hcC5tX2xhIDwgb2Zmc2V0KSB7DQo+PiAtLQ0KPj4gMi4yNC4wDQo+Pg0KPj4gVGhhbmtzLA0K
Pj4gSmlhbmFuDQo+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KT1BQTw0KDQrm
nKznlLXlrZDpgq7ku7blj4rlhbbpmYTku7blkKvmnIlPUFBP5YWs5Y+455qE5L+d5a+G5L+h5oGv
77yM5LuF6ZmQ5LqO6YKu5Lu25oyH5piO55qE5pS25Lu25Lq65L2/55So77yI5YyF5ZCr5Liq5Lq6
5Y+K576k57uE77yJ44CC56aB5q2i5Lu75L2V5Lq65Zyo5pyq57uP5o6I5p2D55qE5oOF5Ya15LiL
5Lul5Lu75L2V5b2i5byP5L2/55So44CC5aaC5p6c5oKo6ZSZ5pS25LqG5pys6YKu5Lu277yM6K+3
56uL5Y2z5Lul55S15a2Q6YKu5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu25Y+K
5YW26ZmE5Lu244CCDQoNClRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBj
b25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSBPUFBPLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5
IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4g
QW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChp
bmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJl
LCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRo
aXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3Ig
ZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCENCg==
