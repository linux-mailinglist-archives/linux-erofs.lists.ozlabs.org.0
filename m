Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6DF83D309
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jan 2024 04:43:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1706240601;
	bh=1o9zHVmzDIn5dN2v2gz5L99DeC1CFZ/BpSpyqhCsk/4=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=VZag+wxBV10QFdD06pn+iAKEMmyAz/Z3ByfWRMwlwtwDlRtDm1CG0GybdCnHme/BP
	 BEuIDYIeKrJWyzYrtozTKEPPeG8VoEXAziiv/BXWY5Mma70XterNI+rxEw3a1IQD9R
	 sUtUGRDGjHl8dzibwORWB8K5hibboVDVpABcRCT3v167UGYMkafDKvs7lh3cda4gt1
	 NxT7ipivKcNiEWwQ1irFVaklb4yUxvWLmtPbYW5yAtP/Pfb0KEvCYih3kscSHonvMp
	 BsVW0p39p8bMDUPk/C+p87mjIaPNzVOte6O3AHie5GpWEX+11oqQ7NfoSwDuUNTQEV
	 Y5e8vvNM1Voqw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TLk7F572Fz3cGC
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jan 2024 14:43:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=i7bglh/+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::701; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::701])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TLk793C94z3bvd
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jan 2024 14:43:15 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH6t2dH39IC4I+uIO5uOIgG8s0wepLW/GHcFV3jRCbs8FwKvjTGTsRNWPL5WHY1ZKlGhUIsQJpogeX/4pMsLOumc1+i75q8rQT5AjxDwRemBxHRZJmklIF9zv8XEtmPJTSL+MU2FbpHLuKTZCIucf6731pGqz3hyz58b7UqSbnWzL8e5acxgOqAxofMpdixkrUffcZwsT47chopTPSd0tZJQg0uJdZSgOrn7bUsccY8S/LWvKmcOCyQg8FWIvCEangD/Z13nEUuc7mvzNxQlzdXd7mAuZEvLjUKNA0Jc5REMyt840UgJDNFql4rmED+xyUqvNwCt8WFQVehIYfI3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o9zHVmzDIn5dN2v2gz5L99DeC1CFZ/BpSpyqhCsk/4=;
 b=N9lSpuRsJeDSw/wyBKhksapwB/pYkLS/8o8mTH2Cw9xJqJVW/3qcoqamhexTRnpnhkOZ2xJTTk0rEFyXcV/t70JBIRdmonP9clOM+W7CQWoOkI3EYhg3Y9i6k8adjnrW45HeJaz29OVE2d9wmOA5OvLMARN3PJxi3NJakfwuDL16SDp6mh/SQ+UGQ2K0b8foqIdoVA1qb1h20tp+cLj4gopBk3WnZORfcO3YPvTa0duZgSAugIrl1i93A8WqWEt2qGxAv16xVSqkI9ljR9dS0oOK9fJ5YzaCj3t6jBynrJ+HL7TvB4daHHNlECT9ZSyhVpxdTUqvqnI1/10N3tQWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by PUZPR06MB5569.apcprd06.prod.outlook.com (2603:1096:301:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 03:42:48 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457%5]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 03:42:48 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Chunhai Guo
	<guochunhai@vivo.com>, "xiang@kernel.org" <xiang@kernel.org>
Subject: Re: [PATCH v2] erofs: relaxed temporary buffers allocation on
 readahead
Thread-Topic: [PATCH v2] erofs: relaxed temporary buffers allocation on
 readahead
Thread-Index:  AQHaS69Dn7c0lZTvWk6XNTojszowdLDlGDgAgAAcboCAAA1DgIAAM7CAgAX1dQCAAAGHAIAAD4CA
Date: Fri, 26 Jan 2024 03:42:48 +0000
Message-ID: <369dbe84-ae27-40f0-8945-fd06b7b628a4@vivo.com>
References: <20240120145551.1941483-1-guochunhai@vivo.com>
 <cd64ee05-e8b2-4cd0-93e5-6bf787774d1f@linux.alibaba.com>
 <0aae43b2-c37b-41c8-be3f-3ebf0bb3d052@vivo.com>
 <da8060aa-2ed4-404c-8f06-06e35a4f4d27@linux.alibaba.com>
 <cd6c4dcc-cdb9-4b38-9ef7-e953cdc47441@vivo.com>
 <66d22178-88fa-409f-a33b-bcaee905b0d0@vivo.com>
 <61c6c462-11cf-4e66-ab24-712e55f9cf19@linux.alibaba.com>
In-Reply-To: <61c6c462-11cf-4e66-ab24-712e55f9cf19@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3342:EE_|PUZPR06MB5569:EE_
x-ms-office365-filtering-correlation-id: 86c0865c-0251-41d5-bfe3-08dc1e20dda8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  C55W+QbdhM5B+DsQni76SPed9QDIhgM0hGs+hEhvsWC3V3MGE/6h9OSvNMfepLpAp3Tq0gr9mXYYv7yfeqcLyeA/bS4siMBpLZ09rAkYadyaDU4W2HDD2SnHEH2bD1/7EY1+D7i/FAi3UYRx/q1+LLgxOA0CjaYOMhMphWo0HYVW8wwYhWoJCCRq92lHypbGLnA5n6cOvXpRzdrX6DHZjncXSjXeQEwsX5lyIpgZq6qsnO2lq7kdMOU7EinEyEtga4gQHTpoWxJGjaXa0tIagAEXBdCDkgsdgHfTxI15Ub+ReZQ20RA1LeySfynrxErq3mVn2sdfKFSaMNmPFzU26EXoOAO1bYnRs6mwuAWQ/8QUITzb4j7HPddK0jqoESeIR6bahaQg2/5ARXrQ5yP76xj7zneltJBo5tqC5Myc3uPasE4JX3YxeTaEucS/CkDRQZl7c4oa4NLtp6qlUBtW1fjtpWBe3CvncsnsBvlgnavhs7tBGN6TyGddD1aYm1vWZa4JJWCTpO0m5AYuWS6rjgvrGuuUZu53xBAMkhlLJ9kfCqYsCxIXk3su7QOIxITd0TTdFDpQrbIYuKaCG5T4KG/sa087i89P1TPn4AuntoeQYbAvocxesBqfYCgUgWYuXxTYNvIu2E2q2wkINwTEVA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(122000001)(38100700002)(2906002)(86362001)(36756003)(41300700001)(31696002)(316002)(66446008)(110136005)(54906003)(66476007)(53546011)(91956017)(6506007)(478600001)(66556008)(76116006)(6512007)(966005)(45080400002)(71200400001)(8676002)(5660300002)(83380400001)(4326008)(2616005)(64756008)(26005)(6486002)(66946007)(8936002)(38070700009)(31686004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RkR2TnI3eHo3MmkvVG1wWkR2M0pJVjAwNWFNSS9XUWRLa2J6ZldTN01DdU9R?=
 =?utf-8?B?QnNTT1IrQkJHL0hVZUJ4WGxiOWVqZjcySkV4VG04VHlXeWxXNUZaaXRRTVlS?=
 =?utf-8?B?eUVlc21uSTBLbmVsYVpaVDBpN1JZL0xXcEg5d2p5V1RrcnRnSnlyRkJDQVg4?=
 =?utf-8?B?UlRsbEt0elYyZGZSVHRTN0pWWG85Rzk5dDAyL3U5U1pybm9tS0Rrd3B5ZXZp?=
 =?utf-8?B?bGxxWHFXYUN6Q1lTQVhTTDVURlcyK1pHMWdsei9UR1lNOUZUTEx5US90MmZT?=
 =?utf-8?B?eUFDT0FvRkRCZlhWVWx5dUVKejRteU5STm53eGQ4Lzl0bnhXd2lDZ3VDaysr?=
 =?utf-8?B?ckVpWlJpeE5GS280WFRZSWF6WnduTVN2UlVaSFNBV2ljZFpKdkg5c09vc1BY?=
 =?utf-8?B?KytkTHZqUHJzbFBBZW93aW56YVhpQmxrZXBYeTI5Kzd4YXRJNkhYQ1plQmtV?=
 =?utf-8?B?bFFvT2Q2OWdNNDhDaU4vT3dobnR5SVpKbm5KV280TUtMNE9rZnl5UlBiemVW?=
 =?utf-8?B?cmsycGtpYk5JdWdaV3ZJKytLSklHSkVXUE9nNkxCNWJPQlVJNmtUdnBML3FL?=
 =?utf-8?B?VGlhMnJsQ1lSYngxd1hlc3hBQm5CTXd1aE1WdTVvRHNzVEZObUZYbkVPQ2Jt?=
 =?utf-8?B?YktIT0Q5dnp6T2o3UHNjVlh3R3JKS3FyRm84T3BoUmUyb0dTTWFBM29Uc0Rh?=
 =?utf-8?B?WXYxRS92aWIvTXc1RThFclJRc1FGcXQ0S2N5Z0FadUp0MTNDVG1RTFowcVox?=
 =?utf-8?B?RGdRMCs4KzNOMWZlbnpHNTljM2R6K084TkwraENacHNhVnA0VkY2VVovUUlM?=
 =?utf-8?B?NmFQbDhDaWR3YnJJOWMxRHBhVlY5Rzg3aVRTeWZGeklzMFJBaGdqYmcvSEJX?=
 =?utf-8?B?aVc1MUpYWDMyS2trOVQ0TjZ5T1gzc0VGT2NId2kyMGZoSlVFc2xqRkRMV21U?=
 =?utf-8?B?bUoxVndnckRGWHlMMGZMcm4xbUt5T1Q3Ukd3Vmh2a2FVTTMvNGE5eldGb3Mw?=
 =?utf-8?B?TXNZc3QwbmZoWjBXQnVBZVNJcGd5K0xiRGhvUVdxOWVvenlzdDVGOUJyb0dC?=
 =?utf-8?B?T3AveU9yVVMzR0NkMDFmR1BFNmRTNEc1Sm51V3diUnNQK29SVHlpb0dSbmY4?=
 =?utf-8?B?WW1kZWZ3cXU1Uy9QSFQ4elpaQ2p6Nng5bENSUWNzVGtKcVZjUDJsMGEzMlJk?=
 =?utf-8?B?Z0dvLzgvQU9sajM0UUdUSE5ldkhNRll3KzloZlNBRXVvT09DS3V5SDJEbGJu?=
 =?utf-8?B?ME1UMUVSUmlGQ1FKMjZDSFNzQWtIMXpidExBL3lyVXN3LzdEYXlkQVFGdGln?=
 =?utf-8?B?UFRFRmNjM2R0QldoNGpyTFFzeHJLUUF5dmxZTXFtRVErM3lSem5VeS9LVXcr?=
 =?utf-8?B?M0ZnVXBKM2kwRmxWYnVvdFJWdy9HQlVidkxzMi9TR01qRzMzV1ZMRUY4S0gr?=
 =?utf-8?B?UEI3YldPbTlhdXMyZWI3K2l0SjVWV3ZpNDBXQjRjcDMrWFR6ZlA3U3VlWVdx?=
 =?utf-8?B?Z2VjbGxmTHlINWYrMnF1Y1o2cTZsdExYaUJnOHRwZlV0SFFiK2x5UGR0aEdH?=
 =?utf-8?B?SC9pdFlLdWZlaTBETGhVNzd6LzU3S0RkaW9ERXVLUzd2bGo4cmVzYmllNVJW?=
 =?utf-8?B?VmVxMklPRnNucmtwSnBLM1V3OTkzQnQ3VnN1K0pZSDFWT2FiVVRScHBDaXc2?=
 =?utf-8?B?ZGoyOUlhcE0wT1Q1OUVPdkVKQXV5YmdQditzOW1KSTdZYWNISUc5WFcvdDI3?=
 =?utf-8?B?clZuQXU4WDAvRThuQURMT285SXJobGo4ZUNLWlJRL2RxRFF3Yng1MHJidXpI?=
 =?utf-8?B?L0x3VGc4Ny90Q1JmY3pEeloxVkZ0TmJQWUhab3RDaTh3VzVEOUY5MElUeFBK?=
 =?utf-8?B?NFNBeHY1dEJUODRsdjMrb1VUeHVXN1IxV284ZC9BSVN1eGxvQ0hKWENaTFFn?=
 =?utf-8?B?RmhJdG16aDlZNWswcDh5SFAxN1JUYjBoOUYrdkg1VkpHRnNyS1Vyd3Iyb0JV?=
 =?utf-8?B?dWEvSGJiN1hOVldiMmVjK1FNWENqSVM0YXRxV2hqYVhVRXZ5Y3dvTnFWL3Ju?=
 =?utf-8?B?aGZsb1N1R2FyZVVYbjg2OEdHcU5KT3Z1cjhGNTEzYkJNbWNtYWxZRmpPNS8x?=
 =?utf-8?Q?jMI4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E215F2FF3D4F4A439E5D77E2C0C0B97A@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c0865c-0251-41d5-bfe3-08dc1e20dda8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 03:42:48.6072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6krW31DSaqXKwxxdHGzKZXqh6F2QBHPS0vrzxc8DV/IBcaG4qrmfTiey3V58hPyrlAdS3mJhZBriMDenrZ5DFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5569
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

T24gMjAyNC8xLzI2IDEwOjQ3LCBHYW8gWGlhbmcgd3JvdGU6DQo+IFvkvaDpgJrluLjkuI3kvJrm
lLbliLDmnaXoh6ogaHNpYW5na2FvQGxpbnV4LmFsaWJhYmEuY29tIOeahOeUteWtkOmCruS7tuOA
guivt+iuv+mXriBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb27v
vIzku6Xkuobop6Pov5nkuIDngrnkuLrku4DkuYjlvojph43opoFdDQo+DQo+IE9uIDIwMjQvMS8y
NiAxMDo0MSwgQ2h1bmhhaSBHdW8gd3JvdGU6DQo+PiBPbiAyMDI0LzEvMjIgMTU6NDIsIENodW5o
YWkgR3VvIHdyb3RlOg0KPj4+IE9uIDIwMjQvMS8yMiAxMjozNywgR2FvIFhpYW5nIHdyb3RlOg0K
Pj4+PiBb5L2g6YCa5bi45LiN5Lya5pS25Yiw5p2l6IeqIGhzaWFuZ2thb0BsaW51eC5hbGliYWJh
LmNvbSDnmoTnlLXlrZDpgq7ku7bjgILor7forr/pl64gaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91
dFNlbmRlcklkZW50aWZpY2F0aW9u77yM5Lul5LqG6Kej6L+Z5LiA54K55Li65LuA5LmI5b6I6YeN
6KaBXQ0KPj4+Pg0KPj4+PiBPbiAyMDI0LzEvMjIgMTE6NDksIENodW5oYWkgR3VvIHdyb3RlOg0K
Pj4+Pj4gT24gMjAyNC8xLzIyIDEwOjA3LCBHYW8gWGlhbmcgd3JvdGU6DQo+Pj4+Pj4gW+S9oOmA
muW4uOS4jeS8muaUtuWIsOadpeiHqiBoc2lhbmdrYW9AbGludXguYWxpYmFiYS5jb20g55qE55S1
5a2Q6YKu5Lu244CC6K+36K6/6ZeuIGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVu
dGlmaWNhdGlvbu+8jOS7peS6huino+i/meS4gOeCueS4uuS7gOS5iOW+iOmHjeimgV0NCj4+Pj4+
Pg0KPj4+Pj4+IE9uIDIwMjQvMS8yMCAyMjo1NSwgQ2h1bmhhaSBHdW8gd3JvdGU6DQo+Pj4+Pj4+
IEV2ZW4gd2l0aCBpbnBsYWNlIGRlY29tcHJlc3Npb24sIHNvbWV0aW1lcyBleHRyYSB0ZW1wb3Jh
cnkgYnVmZmVycyBhcmUNCj4+Pj4+Pj4gc3RpbGwgbmVlZGVkIGZvciBkZWNvbXByZXNzaW9uLiAg
SW4gbG93LW1lbW9yeSBzY2VuYXJpb3MsIGl0IHdvdWxkIGJlDQo+Pj4+Pj4+IGJldHRlciB0byB0
cnkgdG8gYWxsb2NhdGUgd2l0aCBHRlBfTk9XQUlUIG9uIHJlYWRhaGVhZCBmaXJzdC4gVGhhdCBj
YW4NCj4+Pj4+Pj4gaGVscCByZWR1Y2UgdGhlIHRpbWUgc3BlbnQgb24gcGFnZSBhbGxvY2F0aW9u
IHVuZGVyIG1lbW9yeSBwcmVzc3VyZS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVGhlcmUgaXMgYW4gYXZl
cmFnZSByZWR1Y3Rpb24gb2YgMjElIGluIHBhZ2UgYWxsb2NhdGlvbiB0aW1lIHVuZGVyDQo+Pj4+
Pj4gSXQgd291bGQgYmUgYmV0dGVyIHRvIGFkZCBhIHRhYmxlIHRvIHNob3cgdGhlIGFic29sdXRl
IG51bWJlcnMgdG9vDQo+Pj4+Pj4gKGxpa2Ugd2hhdCB5b3UgZGlkIGluIHRoZSBnbG9iYWwgcG9v
bCBjb21taXQuKSAgSWYgaXQncyBwb3NzaWJsZSwgdGhlcmUNCj4+Pj4+PiBpcyBubyBuZWVkIHRv
IHNlbmQgYSB1cGRhdGUgdmVyc2lvbiBmb3IgdGhpcywganVzdCByZXBseSB0aGUgdXBkYXRlZA0K
Pj4+Pj4+IGNvbW1pdCBtZXNzYWdlIGFuZCBJIHdpbGwgdXBkYXRlIHRoZSBjb21taXQgbWFudWFs
bHkuDQo+Pj4+PiBUaGUgdGFibGUgYmVsb3cgc2hvd3MgZGV0YWlsZWQgbnVtYmVycy4gVGhlIHJl
ZHVjdGlvbiBJIG1lbnRpb25lZCBiZWZvcmUNCj4+Pj4+IHdhcyBub3QgYWNjdXJhdGUgZW5vdWdo
LiBQbGVhc2UgaGVscCBjb3JyZWN0IHRoZSBpbXByb3ZlbWVudCBmcm9tIDIxJSB0bw0KPj4+Pj4g
MjAuMjElLg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+PiArLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tKw0KPj4+Pj4gfCAgICAgICAgICAgICAgfCB3
L28gR0ZQX05PV0FJVCB8IHcvIEdGUF9OT1dBSVQgfCAgZGlmZiAgIHwNCj4+Pj4+ICstLS0tLS0t
LS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0rDQo+Pj4+
PiB8IEF2ZXJhZ2UgKG1zKSB8ICAgICAzMzY0ICAgICAgIHwgICAgICAyNjg0ICAgICB8IC0yMC4y
MSUgfA0KPj4+Pj4gKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0tKy0tLS0tLS0tLSsNCj4+Pj4gRGlkIGl0IHRlc3Qgd2l0aG91dCB0aGUgMTZrIHNsaWRpbmcg
d2luZG93IGNoYW5nZT8NCj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZXJvZnMv
Njk3MTFkNTUtZjdhMi00MjBiLTliYTgtZmEyOTIxZjY2YTRjQHZpdm8uY29tDQo+Pj4gVGhlIHJl
c3VsdCBpcyB0ZXN0ZWQgd2l0aCA2NGsgc2xpZGluZyB3aW5kb3cgY2hhbmdlLg0KPj4+DQo+Pj4+
IENvdWxkIHlvdSBiZW5jaG1hcmsgdGhlc2UgdHdvIG9wdGltaXphdGlvbnMgdG9nZXRoZXIgdG8N
Cj4+Pj4gc2hvdyB0aGUgZXh0cmVtZSBvcHRpbWl6ZWQgY2FzZSB3aXRob3V0IGEgZ2xvYmFsIHBv
b2w/DQo+Pj4+IFdpdGggYSBuZXcgdGFibGUgaWYgcG9zc2libGU/IEkgd2lsbCBhZGQgdGhpcyB0
bw0KPj4+PiB0aGUgY29tbWl0IG1lc3NhZ2UgdG9vLg0KPj4+IE9LLiBJIHdpbGwgcmVwbHkgdG8g
dGhpcyBlbWFpbCB3aGVuIHRoZSBiZW5jaG1hcmsgaXMgZmluaXNoZWQuDQo+PiBUaGUgYmVuY2ht
YXJrIGhhcyBiZWVuIGNvbXBsZXRlZCBhbmQgdGhlIHRhYmxlIGJlbG93IHNob3dzIHRoYXQgdGhl
cmUgaXMNCj4+IGFuIGF2ZXJhZ2UgNTIuMTQlIHJlZHVjdGlvbiBpbiBwYWdlIGFsbG9jYXRpb24g
dGltZSB3aXRoIHRoZXNlIHR3bw0KPj4gb3B0aW1pemF0aW9ucy4NCj4+DQo+PiArLS0tLS0tLS0t
LS0tLS0rLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tKyB8IHwgNjRr
DQo+PiB3aW5kb3cgfCAxNmsgd2luZG93IHwgfCB8IHwgdy9vIEdGUF9OT1dBSVQgfCB3LyBHRlBf
Tk9XQUlUIHwgZGlmZiB8DQo+PiArLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tLS0rLS0tLS0tLS0tKyB8IEF2ZXJhZ2UNCj4+IChtcykgfCAzMzY0IHwgMTYxMCB8
IC01Mi4xNCUgfA0KPj4gKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0t
LS0tLS0tKy0tLS0tLS0tLSsNCj4+DQo+PiBUYWJsZSBiZWxvdyBzdW1tYXJpemVzIHRoZSByZXN1
bHRzIG9mIHRoZXNlIHRocmVlIGJlbmNobWFya3MuDQo+Pg0KPj4gKy0tLS0tLS0tLS0tLS0tKy0t
LS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0t
LS0tLS0tKw0KPj4gfCAgICAgICAgICAgICAgfCAgIDY0ayB3aW5kb3cgICB8ICAgMTZrIHdpbmRv
dyAgIHwgICA2NGsgd2luZG93ICB8IDE2aw0KPj4gd2luZG93ICB8DQo+PiB8ICAgICAgICAgICAg
ICB8IHcvbyBHRlBfTk9XQUlUIHwgdy9vIEdGUF9OT1dBSVQgfCB3LyBHRlBfTk9XQUlUIHwgdy8N
Cj4+IEdGUF9OT1dBSVQgfA0KPj4gKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0rLS0t
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKw0KPj4gfCBBdmVy
YWdlIChtcykgfCAgICAgMzM2NCAgICAgICB8ICAgICAgMjA3OSAgICAgIHwgICAgICAyNjg0IHwN
Cj4+IDE2MTAgICAgIHwNCj4+ICstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tKy0tLS0t
LS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSsNCj4+IHwgICAgIGRp
ZmYgICAgIHwgICAgICAgICAgICAgICAgfCAgICAgLTM4LjE5JSAgICB8ICAgICAtMjAuODElIHwN
Cj4+IC01Mi4xNCUgICB8DQo+PiArLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rDQo+DQo+IFRoZSB0
YWJsZXMgc2hvd3MgaW4gYSBtZXNzLCBjb3VsZCB5b3UganVzdCBsaXN0IHRoZQ0KPiBudW1iZXJz
IHNvIEkgY291bGQgcmVmaW5lIHRoaXM/DQoNClNvcnJ5IHRoYXQgdGhlcmUgbWlnaHQgYmUgc29t
ZSBpc3N1ZXMgd2l0aCBteSBlbWFpbCBjbGllbnQuIEhlcmUgYXJlIHRoZQ0KbnVtZXJpY2FsIHJl
c3VsdHMgYmVsb3cuDQogICAgIDY0ayB3aW5kb3cgdy9vIEdGUF9OT1dBSVQgOiAzMzY0DQogICAg
IDE2ayB3aW5kb3cgdy9vIEdGUF9OT1dBSVQgOiAyMDc5LCBkaWZmOiAtMzguMTklDQogICAgIDY0
ayB3aW5kb3cgdy8gIEdGUF9OT1dBSVQgOiAyNjg0LCBkaWZmOiAtMjAuODElDQogICAgIDE2ayB3
aW5kb3cgdy8gIEdGUF9OT1dBSVQgOiAxNjEwLCBkaWZmOiAtNTIuMTQlDQoNCkltYWdlcyBzaXpl
IGNvbXBhcmlzaW9uOg0KICAgICA2NGs6IDkxMTcwNDQgS0INCiAgICAgMTZrOiA5MTEzMDk2IEtC
DQoNClRoYW5rcywNCg0KPg0KPiBUaGFua3MsDQo+IEdhbyBYaWFuZw0KDQoNCg==
