Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1FD292175
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 05:38:18 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CF2XS1LCDzDqNk
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 14:38:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:febe::624;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=SXUK3QDe; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-pu1apc01on0624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:febe::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CF2XM1tKYzDqJ1
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Oct 2020 14:38:08 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEvVVfZc4XtV4QEEB9xgWvgedoXNAwL8Kuksid1Ub/cAJTHPAivwnomb1K9KtRjk6QWbtdBImpRjFUNq8tA5QlsPg9X/VuhiwoMzufO4jmFlrsqyitxlvFksU+LdVGumTecqoMJgDsfX4sWmeuAgLOxga+yqr8HKdMZpcgyxjaeHpEBdxpyCLsqgNtiOGGUx5il+MUZM0gv6X10plfG2J6ANmGQXMVIVWu5YKLzOw499//MN/7M2Ypl7mqFS417rqLdWJL3xVtATPFksCwfUnp/bArazV1B6TTKzlr6VoHJCS5d8v6F5dh3PgQWJyD8dRpe+EymLiHwwsPpDoikIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2klvWMVglo0cmII+Cs1Xcp8pswA/CIesd7txIUZSoM=;
 b=QZA97msXafg+30y7c1nZafpKShvF7lMCWRec3AdjqJP4BFuHoaRMEqoBmUQdIcb/9j7dkDyFyUKDqcB+aRG28XCw6zJB1UY6pIyTIPVwlIiU1kM7GxwWY8XcQUu3cFm8jpGOx5vfGPtsXOelihoQJ1Wskw6IUUqnMrIBAE/L48vq6vUW1kRCMA+Ozq02BbdgF6a+PPPKRr9kVqPzPvHbYplR57y/nhE9vClPDl2BGj8rNEou7IOCHtWdLVLIMH2pgkHsVbCPJjITZu6HHtVnCcEepzU2rSUWJ5Pqt1fZfA7wlfqHrcwgNo37f1jbs0+w5hkTbcFPsakCIlGVk/b2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2klvWMVglo0cmII+Cs1Xcp8pswA/CIesd7txIUZSoM=;
 b=SXUK3QDeJ5TcSRH3d3nfKe7z1vG7v66o0OJwym2AZsugtCP56vEVAf261TtG+sAoWCR8VPmx3KdzKKQFr2UvvipcCbjBHIqeBggYUIwDh5r8Sw5SZZl2XiyskIaqtuemZuY1j4GCVV88BFUKGiEM8g5ktnqSAOWTnojbHoNNMew=
Authentication-Results: aol.com; dkim=none (message not signed)
 header.d=none;aol.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4458.apcprd02.prod.outlook.com (2603:1096:0:d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.24; Mon, 19 Oct 2020 03:37:52 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::21c8:750e:8135:b142]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::21c8:750e:8135:b142%5]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 03:37:52 +0000
Date: Mon, 19 Oct 2020 11:37:51 +0800
From: "Huang Jianan" <huangjianan@oppo.com>
To: "Gao Xiang" <hsiangkao@aol.com>
Subject: =?utf-8?B?5Zue5aSNOiBbV0lQXSBbUEFUQ0ggMDQvMTJdIGVyb2ZzLXV0aWxzOiBmdXNlOiBhZGp1c3QgbGFyZ2VyIGV4dGVudCBoYW5kbGluZw==?=
References: <20201017051621.7810-1-hsiangkao@aol.com>, 
 <20201017051621.7810-5-hsiangkao@aol.com>
X-GUID: 085A024C-4653-4ABC-B8FD-C0FB1AB6D66C
X-Has-Attach: no
X-Mailer: Foxmail 7.2.18.111[cn]
Message-ID: <202010191137499960533@oppo.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450 (58.252.5.72) by
 HKAPR04CA0012.apcprd04.prod.outlook.com (2603:1096:203:d0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20 via Frontend Transport; Mon, 19 Oct 2020 03:37:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af481b59-7d34-4b4b-0f6f-08d873e05bd8
X-MS-TrafficTypeDiagnostic: SG2PR02MB4458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB4458A162B1033140FEE73275C31E0@SG2PR02MB4458.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXIlMUc2OiteQi9/gmljNE+CsvtC5IFz2xVum/0JxrVqdAb+2Gc3KPjYrhJFzWeUtBaOklj9cFRSGWPcQqOuZ6U5l8hbinYILxxr2GS//uq/mVoc+GrxkDzUHl60h9aaCRdUyiIdJm+DD4vMX3rQ5KQpOp0dn37+tJqTxmLoMOQogekF5NzzrQ3oglGxX8oa2K9jS+8JrZkxw64QHhAfTy6RHJA5YhQAxn+8p5acHOvtgkkBSDMpY+XqdIUZHBbH+pVxp+dR7Bq4+uua7nqjSEBR7zYbMoSPJCAG3BQ9NWaO2Qj3I8+UuAE98b4WvKk6ggQ6s612WBxepvSfz8H/3FuLklqRxrZJoAEy63uqNG66KDtwbnU3jcFb6IPboML2ctvi4XPqEon7jyhsvpH2LQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(107886003)(6486002)(54906003)(478600001)(1076003)(4326008)(98106002)(66556008)(956004)(2616005)(224303003)(16526019)(2906002)(186003)(6916009)(83380400001)(86362001)(26005)(58226001)(36756003)(8936002)(6496006)(37786003)(5660300002)(66946007)(52116002)(316002)(66476007)(11606004)(73376008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MQeLR/O3jJkb/ROOig2NXzZFePY4uPjtcnIS2CKf/Jq6X7tSCCQDcLNbYvepUbLjc792KqIuyDE/jXlKHfpN/1GlQmkwl8qC1ebLb1DRc6LSkVGXYBLz41KPoHUnsAr9GTxfZvlgd2kAdZXKWXZfUMGn6l7DHNyEC37hKSzcqbKubR6tSRHvn6ALwCP/0bPMa5U5paGj/gQoIZKwtQVtDTniANynxm8A4Sy5PUa03ZJHYeDk5u6i53XZnJ/ajPck9l1IxHnZeCxV2d4fi8WGZBCy/wRoF93Krq8rpXiOPn+z56hoWdL7iqqLSMjc1osCH8xi4J0ic8/yc4hiP7zR90fvG045wD7bOeD6ZR7k4u0bG+xP5AEbF2FCgCklzpgfq+PtyUOEtQqf6GY8bVcvF87+ZKJfZ5ZqbqYsH2fLIvAVfFbNpP8aHhDgVpXpU/Dck2KrbkBFdiZ9FlJp7pFhEUWI6KXOgZ4qX2ySGgltmY04V3CmYyoFI/QaBvU6AjOdhEOc9GuPvuL4OzyztCitGPAgnpD4GPKnLLzBe5hraIuReG8fyduTGLNnyL+aMjr499H/cXucmnyyqi5Pi1eG9KH0odL8rnyZDQONcGA5GajO0Rp2hQCGt2Yg44rRzx5JQbpp8tJNQwvTEIqoa2/jIg==
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af481b59-7d34-4b4b-0f6f-08d873e05bd8
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 03:37:52.5608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPamvwyk6Wtg3gvc/gezbbFBgBsHwwGA/p+ZKAjRR6JqjL6FplUsdR3eTa66Dhwoq/5n8VDpQt2+pUCRq61MBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4458
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

SGksIEdhbyBYaWFuZywNClNvcnJ5IGZvciB0aGUgZm9ybWF0IG9mIHRoZSBwcmV2aW91cyBlbWFp
bC4NCg0KPnNvIG1vcmUgZWFzeSB0byB1bmRlcnN0YW5kLg0KPg0KPlsgbGV0J3MgZm9sZCBpbiB0
byB0aGUgb3JpZ2luYWwgcGF0Y2guIF0NCj5DYzogSHVhbmcgSmlhbmFuIDxodWFuZ2ppYW5hbkBv
cHBvLmNvbT4NCj5TaWduZWQtb2ZmLWJ5OiBHYW8gWGlhbmcgPGhzaWFuZ2thb0Bhb2wuY29tPg0K
Pi0tLQ0KPiBmdXNlL3JlYWQuYyB8IDEzICsrKysrKysrKy0tLS0NCj4gMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0IGEvZnVzZS9y
ZWFkLmMgYi9mdXNlL3JlYWQuYw0KPmluZGV4IDBkMGUzYjBmYTQ2OC4uZGQ0NGFkYWExYzQwIDEw
MDY0NA0KPi0tLSBhL2Z1c2UvcmVhZC5jDQo+KysrIGIvZnVzZS9yZWFkLmMNCj5AQCAtMTEyLDEy
ICsxMTIsMTcgQEAgc2l6ZV90IGVyb2ZzX3JlYWRfZGF0YV9jb21wcmVzc2lvbihzdHJ1Y3QgZXJv
ZnNfdm5vZGUgKnZub2RlLCBjaGFyICpidWZmZXIsDQo+IFpfRVJPRlNfQ09NUFJFU1NJT05fTFo0
IDoNCj4gWl9FUk9GU19DT01QUkVTU0lPTl9TSElGVEVEOw0KPg0KPi0gICAgICBpZiAoZW5kID49
IG1hcC5tX2xhICsgbWFwLm1fbGxlbikgew0KPi0gICAgICBjb3VudCA9IG1hcC5tX2xsZW47DQo+
LSAgICAgIHBhcnRpYWwgPSAhKG1hcC5tX2ZsYWdzICYgRVJPRlNfTUFQX0ZVTExfTUFQUEVEKTsN
Cj4tICAgICAgfSBlbHNlIHsNCj4rICAgICAgLyoNCj4rICAgICAgKiB0cmltIHRvIHRoZSBuZWVk
ZWQgc2l6ZSBpZiB0aGUgcmV0dXJuZWQgZXh0ZW50IGlzIHF1aXRlDQo+KyAgICAgICogbGFyZ2Vy
IHRoYW4gcmVxdWVzdGVkLCBhbmQgc2V0IHVwIHBhcnRpYWwgZmxhZyBhcyB3ZWxsLg0KPisgICAg
ICAqLw0KPisgICAgICBpZiAoZW5kIDwgbWFwLm1fbGEgKyBtYXAubV9sbGVuKSB7DQo+IGNvdW50
ID0gZW5kIC0gbWFwLm1fbGE7DQo+IHBhcnRpYWwgPSB0cnVlOw0KPisgICAgICB9IGVsc2Ugew0K
PisgICAgICBBU1NFUlQoZW5kID09IG1hcC5tX2xhICsgbWFwX21fbGxlbik7DQoNCkkgdGhpbmsg
eW91IG1lYW4gbWFwLm1fbGxlbiBpbnRlc2FkIG9mIG1hcF9tX2xsZW4uDQpCZXNpZGVzLCBJIGRv
bid0IHVuZGVyc3RhbmQgd2h5IGFkZCBBU1NFUlQgaGVyZS4NCkkgdGhpbmsgdGhpcyBjb25kaXRp
b24gd2lsbCBiZSB0cnVlIGlmIG9mZnNldCtzaXplIGlzIGV4YWN0bHkgdGhlIGVuZCBvZiBhIGNv
bXByZXNzZWQgYmxvY2s/DQoNCj4rICAgICAgY291bnQgPSBtYXAubV9sbGVuOw0KPisgICAgICBw
YXJ0aWFsID0gIShtYXAubV9mbGFncyAmIEVST0ZTX01BUF9GVUxMX01BUFBFRCk7DQo+IH0NCj4N
Cj4gaWYgKChvZmZfdCltYXAubV9sYSA8IG9mZnNldCkgew0KPi0tDQo+Mi4yNC4wDQo+DQoNClRo
YW5rcywNCkppYW5hbg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCk9QUE8NCg0K
5pys55S15a2Q6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJT1BQT+WFrOWPuOeahOS/neWvhuS/oeaB
r++8jOS7hemZkOS6jumCruS7tuaMh+aYjueahOaUtuS7tuS6uuS9v+eUqO+8iOWMheWQq+S4quS6
uuWPiue+pOe7hO+8ieOAguemgeatouS7u+S9leS6uuWcqOacque7j+aOiOadg+eahOaDheWGteS4
i+S7peS7u+S9leW9ouW8j+S9v+eUqOOAguWmguaenOaCqOmUmeaUtuS6huacrOmCruS7tu+8jOiv
t+eri+WNs+S7peeUteWtkOmCruS7tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZpOacrOmCruS7tuWP
iuWFtumZhOS7tuOAgg0KDQpUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4g
Y29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gT1BQTywgd2hpY2ggaXMgaW50ZW5kZWQgb25s
eSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUu
IEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAo
aW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3Vy
ZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4g
dGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0
aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9y
IGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhDQo=
