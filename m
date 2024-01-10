Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEC98293D0
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jan 2024 07:46:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1704869173;
	bh=5K4y7rHQ7MrdwadygIRJVNRpct81//6ylRUZRHvKyjs=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=A8gh9Fx9sKFO9vg7iG/3fDnCUeyk+RSAIBrbk2bEgLZ2ZSPobq5PKVEI+QIcSCQ/h
	 AOe22vX+TqvfqUM9o/ZaL0Dlbr1xo/EGwxXdVA03/SQ2YUt6ur0Dtw65V12IYbgIEv
	 mxjK77B9fkwCtX4MkRbsfxbbYaUVJXcM8LhkECus6s3/gjLWoqCy3viA8FLJUIyyTI
	 yWuA7/hfRK7LIDj27+XQsoUTiKdEv/5CIC0e37r6JXqWuDIjzcm/YgTDnS9tINh9QC
	 ZK85xxM8dYC3Q0wilLZrkykhsj0Ni5GSZDZyMzvFucB413WD9mtAcLCz9AZnDgFO0C
	 5+s4TFkAp9sTg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T8yxd0RCZz3bT8
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jan 2024 17:46:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=fHBpdaxp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::706; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20706.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::706])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T8yxT6QmWz2yRS
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jan 2024 17:46:03 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeQQu2KWnGGrp9U2chRdksKhDv3gMRgOZDpcKWgNUxyZnPKhfFnnzQDwcM18+p11GRbDHCv+/Gj3NKyvKfNcZSnF0pM0mosVhvlmQ70dhECf3U+fH5e9DAFeTVfRiYFwsMqRdvGhEyaN07P+Krus898TuNJx911msvbu4Dn2TgpkdFL/DUhHoj41smE69QPx4FeesC248Xa5HACfSQLASVkrBibgDaLAJwElsODvdnvF8Dk/JZzCdCL5mWZAhKTxjUbgDw3LW2oTg1Pwwm0EoS2RKri36C7ER66UDoqXt52dNSKoyNWKApGCkOXy5iQzTDVjncj0fWot0v1jZY6vAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K4y7rHQ7MrdwadygIRJVNRpct81//6ylRUZRHvKyjs=;
 b=Jb1Hw6TqAdDYI1u/IEpATA+tkEbked33jAmj2TUvMF4ohPfcJALCKeLjcjzNbBe6U7YoC5wc3D2OwN+KyqYCHJ0tzQNtTQHEW5en5MOJvK9So+USo4RKR63ZgIiUEQ3dPT7DgTpRPFWUL+wc1Kse6egL3pPOfHhRjEeeG5SeXHPVafHh/JBGqjQHEqwRQUaCBGwYZ262mpK7pUvQ6jqIjbBX6PDrO1fjWqNJoqdDDw1ECfQTtApTPLT+mg6HG0M61P+8e8p5+edu6ArCoHGB/3oLKTCv+XKmlqSoBUSZQfj7+1dNOEyN1TZKyii4nApD2vf0HiT4WjOIU0bEoVP8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by SI2PR06MB4155.apcprd06.prod.outlook.com (2603:1096:4:f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 06:45:41 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 06:45:41 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Chunhai Guo
	<guochunhai@vivo.com>, "xiang@kernel.org" <xiang@kernel.org>
Subject: Re: [PATCH v2] erofs: add a global page pool for lz4 decompression
Thread-Topic: [PATCH v2] erofs: add a global page pool for lz4 decompression
Thread-Index: AQHaQs3UldOOo8Jqr0yxFc+knidg3rDRdDcAgAEnboA=
Date: Wed, 10 Jan 2024 06:45:41 +0000
Message-ID: <a5c5acb5-2ad1-41e1-8b86-344394baacbf@vivo.com>
References: <20240109074143.4138783-1-guochunhai@vivo.com>
 <d8a104d4-1a58-423a-ba12-ea82d622de48@linux.alibaba.com>
In-Reply-To: <d8a104d4-1a58-423a-ba12-ea82d622de48@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3342:EE_|SI2PR06MB4155:EE_
x-ms-office365-filtering-correlation-id: bc3b54e3-c23d-448b-40bd-08dc11a7c35b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  jC/QbaheufaAYDoggquPMaDKW5TKzecs4+fWj34M2hyG/heP0gowRZdl6b3nYYol/3NBJv0vMZExSB4kJrUmp36VJ7gXf/W88IOSnkQt8+6ZD0oBUicEyT012EunqnOeyudWpiOJhtCt/Qizafe53nR0xEg28fsXsdZ2QDcBhVNG6nve4UJUzUcLLaE8CVDmPEosuXZ7yJxLe3ufaXoWQUOiRqmYs/+oi6E3lPu+0gDXRom4zxLYREsAHVEK04MLYrmQjjeeXSQnrbYjR7cL/b1WzJJ7DcWNeYGYhkTUTYbHvBMg2hVIix5hlBG3kYG59LH90pA/EIg52TknO71qDAomlKwFaWDvw3LQxxjs4GulJ12K7ew/cq8tqdMmPZ3RyC5/bVPfftpx2bJFyASJIEr9LJoZqoZVbsZhzs2KyWQIfa+v6NI5+kM+Pm3UQeXRbrCX34ZTsNw73/tU2Quyl/76fR33Pbx0z2YJV34i+bthIMQTH77x36LekcgGI68YdFIab49bnv/xAUYwPZFupc0X7huyekBXEWWdRvnnZctFEZwLnsSPqqeLweyDf0uEGFa7WhhK/vUUSqejm7npbckrFQmYU8UOS7jDw4WqV0b87xfF/TbtXyxzufYYnxV0k94hWdXA64M23iSaAFaA6Q==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(4326008)(41300700001)(38100700002)(83380400001)(8936002)(66556008)(8676002)(66476007)(66446008)(64756008)(316002)(54906003)(110136005)(2616005)(26005)(122000001)(31686004)(36756003)(53546011)(6512007)(76116006)(91956017)(66946007)(2906002)(71200400001)(966005)(31696002)(38070700009)(478600001)(6506007)(6486002)(5660300002)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?M216cjMyL2pLbWlmL2FCbXpraGxwZE8wZmNqeWtuRWVCM1loek9LTk03ekZJ?=
 =?utf-8?B?ZzJtaHdCd1dzSkxQTzhiSld6TWZmU2ZtM04zczVmazE1bHBoR051NXFMYkdp?=
 =?utf-8?B?SnhmMm1TWmtiUWV6UVhaZ0prdWFZOFBMbElvK1hMQVdRY1h6ZzNhTElBL3FJ?=
 =?utf-8?B?ZmFyUC9RdkJQd0JhYUJXRTd2R3kvV2E1M0U5N21uV3RDNThZNFcrRlgzTys5?=
 =?utf-8?B?RUdPMFFvb0FmbmpqTk0xbEVaOEhOSG5ndm9UVEFHcDJuU1dCcjJvRkdPazFq?=
 =?utf-8?B?YktoSXdmRzRwNzNmcjlOc0ZER3pITXpSNUVVbENEN3NpUGlndzVHNkZUbmNp?=
 =?utf-8?B?Y0FpSTJHR0ZkcGF3alVxWmZlazRTVTBCeE9SVXRLZ25MNTZ4dGl6eVRvRjNw?=
 =?utf-8?B?QVpLRHc2M0tKN2MrYk1iUjdaem9YSnRLRVZjbFM0cTJBbU8xeldidHZRY1JD?=
 =?utf-8?B?MnFUdFVvejJEekdaYllUOHNNa1JjcGpSODZYcVd1Z21yc1J2ZWp0U1dQVkhk?=
 =?utf-8?B?THo3TEViUlIxRXRPQXV0OXVuaFpvRk1oM283azN2Z3ZaN2FXRWhLTDFLK1Rz?=
 =?utf-8?B?T3FNR052bGV5VkgxUkE1K1YvVEhtSnlkT3hlR2lOc2g1bzVObGdjczVzeUdx?=
 =?utf-8?B?d2dmZ21XSXFnMVdRSlg0Q1VuNFJsR1I1d1pTNmc1emNod3IrL3R2Wko4SmFm?=
 =?utf-8?B?MGdocVFrS0VZU2hsL21GaDQ3UW8xclRzMTVCWVJ1YXlzclhXNkxVb3B1VmhX?=
 =?utf-8?B?L2h3VmIxcjBOdzRwbDhhZnFWWXplYUk4U2t6ZFdYSVJZc3NMeHRYNURnL25M?=
 =?utf-8?B?MnVBTDhvRVNhZmwrSUpDM0JZZ1Z2VW9DNVRMc1FWVmN2Yk1ESWhOVmxXMEgw?=
 =?utf-8?B?YkdCdGhuNENMSlpIQ2pxbDBiZjFyblp4NU1QbUxpMmNuK0JkdERDbHdEM3E1?=
 =?utf-8?B?QkRvR3JOYmpOUllJUjhoUThQZTZBbHc1NmVuR2JTZ0dsblpIZ1Uvd2RvYmp2?=
 =?utf-8?B?NmVqOVlkZjZydkErTlB6WjhMSE1LbVZvaUhWNFpUSmxuYStmMDNiTkR6YVB5?=
 =?utf-8?B?TTJ6cGpzNCtUSVpFa0VEcU9NaXdrMUl5Mm54VUsrVFkxK1NBcWE5cnFqUDNh?=
 =?utf-8?B?aVNtZzYyZFlJTDFyeWF0N0hPR1dpYkUweFBSdGtuNWFSY0RqQnNwTlZlQ0V4?=
 =?utf-8?B?YUxMNEk4cTl3Y2Z5bEJzNGJTditySHBRZ1ZYT3NkUWdtOXBJVUJDaE5GeXNZ?=
 =?utf-8?B?OHNXblNkYTM3L0duaTRWeEdoZkpBRGg0MXJqKzM0cG81ZVdtZ055ZHU2SzJV?=
 =?utf-8?B?MWp1Snc0b1Yxa3MwMm5hNE9yMGRnQisrdkZWRmY5MGlXNTdnMkNkaW1QQTFa?=
 =?utf-8?B?aEhoRDRnQUJnY2RBNUNhZmpXVGZvV0ZpVGFrczRjWU0yMzg1SWFjTlpyU1hW?=
 =?utf-8?B?NFlVS2hMMG5Sd1NWczRRVGZwcmh0VzRoVmx0dlhYTHQ5bTkveS8raGhNdmdF?=
 =?utf-8?B?Q2JwYXdXR0pkMTZyVkJBZ0tiT1NBSHEzMmliSUJTVG5MRllpTDNMOE5JYzRX?=
 =?utf-8?B?M05VNnA1czMwK3FoQ3FJTEViVzc3VGlmYXZ3cHA5MjVaNTNjYk9IRzdjN25V?=
 =?utf-8?B?a2tONU5zY3pzRTJBUFRLc0pjdWlFczk1SUZuUHFHeEdDVm00TFI4SzFmM2Zr?=
 =?utf-8?B?Q2YzU2tFMTNRcEVEcEVmR3AwOTJiK1ZlRlh1dWZVVUE2YVBEMGhBSkNZUjkx?=
 =?utf-8?B?cDNQdW9XbXdpcVk2c2QwUHR2TlRFSzBnNkl3MUh5U3RoS1IrWHhiazM5emVO?=
 =?utf-8?B?NUw2RGZnVFJSMXpISmhDWWhKMVd0bUM3MC9VaXdqNmxpVmJGN29iQVcwRy90?=
 =?utf-8?B?Y2lGN1RFYk1LUFl4cjJ4NERVdytjblk2TnNIUnUwS0hLTzVYWHphQjVXZTFm?=
 =?utf-8?B?a2laWEtFVzN0WGE4TW9zMjdrdTFGWG05RERxaEVQVkhKSW9QTjNGV2NPcmNN?=
 =?utf-8?B?R3cya1Q1dWFGaFh2bzl4eGg0QkhHVHNxWHZsM2lFWUF5Tk1WclpVd1M1STVV?=
 =?utf-8?B?a2RBTHlKcG9EeFI5OGJQbUhuN014dkRUWDBXZEZ2dk82azk1ZHp4KzI0dmo4?=
 =?utf-8?Q?ALlU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66343647C6EF874882B19420BD0CA913@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3b54e3-c23d-448b-40bd-08dc11a7c35b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 06:45:41.4256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5TbWhbeRWNAElmKQkGHInS+IerRazQJ9moTQOU/bWvSvrGP+49RXewI8e2CM7rkjIjYJzM6eK+gCGiWOhw2EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4155
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
From: Chunhai Guo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chunhai Guo <guochunhai@vivo.com>
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>, "huyue2@coolpad.com" <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

T24gMjAyNC8xLzkgMjE6MDgsIEdhbyBYaWFuZyB3cm90ZToNCj4gW+S9oOmAmuW4uOS4jeS8muaU
tuWIsOadpeiHqiBoc2lhbmdrYW9AbGludXguYWxpYmFiYS5jb20g55qE55S15a2Q6YKu5Lu244CC
6K+36K6/6ZeuIGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbu+8
jOS7peS6huino+i/meS4gOeCueS4uuS7gOS5iOW+iOmHjeimgV0NCj4NCj4gSGkgQ2h1bmhhaSwN
Cj4NCj4gT24gMjAyNC8xLzkgMTU6NDEsIENodW5oYWkgR3VvIHdyb3RlOg0KPj4gVXNpbmcgYSBn
bG9iYWwgcGFnZSBwb29sIGZvciBMWjQgZGVjb21wcmVzc2lvbiBzaWduaWZpY2FudGx5IHJlZHVj
ZXMgdGhlDQo+PiB0aW1lIHNwZW50IG9uIHBhZ2UgYWxsb2NhdGlvbiBpbiBsb3cgbWVtb3J5IHNj
ZW5hcmlvcy4NCj4+DQo+PiBUaGUgdGFibGUgYmVsb3cgc2hvd3MgdGhlIHJlZHVjdGlvbiBpbiB0
aW1lIHNwZW50IG9uIHBhZ2UgYWxsb2NhdGlvbiBmb3INCj4+IExaNCBkZWNvbXByZXNzaW9uIHdo
ZW4gdXNpbmcgYSBnbG9iYWwgcGFnZSBwb29sLiAgVGhlIHJlc3VsdHMgd2VyZQ0KPj4gb2J0YWlu
ZWQgZnJvbSBtdWx0aS1hcHAgbGF1bmNoIGJlbmNobWFya3Mgb24gQVJNNjQgQW5kcm9pZCBkZXZp
Y2VzDQo+PiBydW5uaW5nIHRoZSA1LjE1IGtlcm5lbCB3aXRoIGFuIDgtY29yZSBDUFUgYW5kIDhH
QiBvZiBtZW1vcnkuICBJbiB0aGUNCj4+IGJlbmNobWFyaywgd2UgbGF1bmNoZWQgMTYgZnJlcXVl
bnRseS11c2VkIGFwcHMsIGFuZCB0aGUgY2FtZXJhIGFwcCB3YXMNCj4+IHRoZSBsYXN0IG9uZSBp
biBlYWNoIHJvdW5kLiBUaGUgZGF0YSBpbiB0aGUgdGFibGUgaXMgdGhlIGF2ZXJhZ2UgdGltZSBv
Zg0KPj4gY2FtZXJhIGFwcCBmb3IgZWFjaCByb3VuZC4NCj4+IEFmdGVyIHVzaW5nIHRoZSBwYWdl
IHBvb2wsIHRoZXJlIHdhcyBhbiBhdmVyYWdlIGltcHJvdmVtZW50IG9mIDE1MG1zIGluDQo+PiB0
aGUgbGF1bmNoIHRpbWUgb2YgdGhlIGNhbWVyYSBhcHAsIHdoaWNoIHdhcyBvYnRhaW5lZCBmcm9t
IHN5c3RyYWNlIGxvZy4NCj4+ICstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0t
LS0tLS0tLS0rLS0tLS0tLS0tKw0KPj4gfCAgICAgICAgICAgICAgfCB3L28gcGFnZSBwb29sIHwg
dy8gcGFnZSBwb29sIHwgIGRpZmYgICB8DQo+PiArLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLSsNCj4+IHwgQXZlcmFnZSAobXMpIHwgICAgIDM0
MzQgICAgICB8ICAgICAgMjEgICAgICB8IC05OS4zOCUgfA0KPj4gKy0tLS0tLS0tLS0tLS0tKy0t
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0rDQo+Pg0KPj4gQmFzZWQgb24g
dGhlIGJlbmNobWFyayBsb2dzLCA2NCBwYWdlcyBhcmUgc3VmZmljaWVudCBmb3IgOTUlIG9mDQo+
PiBzY2VuYXJpb3MuIFRoaXMgdmFsdWUgY2FuIGJlIGFkanVzdGVkIGZyb20gdGhlIG1vZHVsZSBw
YXJhbWV0ZXIuIFRoZQ0KPj4gZGVmYXVsdCB2YWx1ZSBpcyAwLg0KPj4NCj4+IFRoaXMgcGF0Y2gg
Y3VycmVudGx5IG9ubHkgc3VwcG9ydHMgdGhlIExaNCBkZWNvbXByZXNzb3IsIG90aGVyDQo+PiBk
ZWNvbXByZXNzb3JzIHdpbGwgYmUgc3VwcG9ydGVkIGluIHRoZSBuZXh0IHN0ZXAuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogQ2h1bmhhaSBHdW8gPGd1b2NodW5oYWlAdml2by5jb20+DQo+DQo+IFRo
aXMgcGF0Y2ggbG9va3MgZ29vZCB0byBtZSwgeWV0IHdlJ3JlIGluIHRoZSBtZXJnZSB3aW5kb3cg
Zm9yIHY2LjguDQo+IEkgd2lsbCBhZGRyZXNzIGl0IGFmdGVyIC1yYzEgaXMgb3V0IHNpbmNlIG5v
IHN0YWJsZSB0YWcgdGhlc2UgZGF5cy4NCj4NCj4gQWxzbyBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8g
YWRkIHNvbWUgcmVzdWx0cyBvZiBjaGFuZ2luZyBtYXhfZGlzdGFuY2UNCj4gaWYgeW91IGhhdmUg
bW9yZSB0aW1lIHRvIHRlc3QuDQoNCk9LLiBJIHdpbGwgcmVwbHkgdG8gdGhpcyBlbWFpbCB3aGVu
IHRoZSBleHBlcmltZW50IGlzIGZpbmlzaGVkLg0KDQpUaGFua3MuDQoNCj4NCj4gVGhhbmtzLA0K
PiBHYW8gWGlhbmcNCg0KDQo=
