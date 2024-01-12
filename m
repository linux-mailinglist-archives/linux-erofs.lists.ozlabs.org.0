Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B892A82B94A
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jan 2024 02:58:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1705024735;
	bh=7Ik5lTapjsvp49SrXET6a2TGmNOxbZligxEyKvdO42k=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=S7noEvW4+2sezmYcPh/k+VXWOnn6ge5hhh0+mb4ZRSnum6qA6znnkJHJ5jkA2pT9I
	 f6UOwGuTqxsGZpK+mHG7wGDMa0XmVpRNu2n3xb3Yb06gUIv3sb2UIkGbxpK5uCYvqm
	 4/YNPF/qYpbaj/2au4Dj5Sg0m+Tk0FMHp68RVevb90c3g5Poj475bPPNAhoJCuW9FB
	 NtU0XALty4c3A3gBW2eyd73/YcYoMzVJo9rFbLM3KjEIe6TtHt4a4GFq0FGyqLgQHi
	 GqWxFALNYkOH8CztIdy3F7mnCWR36uL+ZuoN2xquCaRl1X8+gsAeUj9LpKA+9xdmWB
	 NFxP4uU33qrmQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TB4TC0v8yz3dXC
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jan 2024 12:58:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=E26S7DNF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::703; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20703.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::703])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TB4T35zRdz3dWw
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jan 2024 12:58:46 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nes4QGCF3zQ86ruNQu97NoO5vrQoZf2ESGFOej0MPgE/UEHeAojAYMpUyGxK9LmIQH0ps636Eyup0TezmQPIPCu+xSOGiqLwJ6fCBxwCEIDBL7r6zGRhqMl4WuV+zORD1MK1RvFUizWYzREmYW92Vv+CtmeMweRPOw/H9bNpUh7ogQXqKkiKTvpF/xX+fPOUJQRzfVMMR99y+BhuekV8Nbse1WMrJiHENOJYbY0G+Fsax/zFlnQxTWAhQ0wk1qt1rYjjagF0tHpaVSPNuBufj5A+AM3gTx+M20Fwz+sVUclzWnzjxzBvTuL8M2zT5ZQfRc1nv+V70Wt1WqjdjBjyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ik5lTapjsvp49SrXET6a2TGmNOxbZligxEyKvdO42k=;
 b=iPHd4CYD5c93vWJTAdh5DZCDAC8/1Xju7is7rO954BrKL6oqTX2Bec/5gUADiSnUuagk9eYfBgIB6tzquHmyESroj/NduFelrbixnxxrEzhxxN6g2E6JwkbJHU6/pHfJLtlJjJMQBJ91hyrG/iM/sxAdMho4h2IR75SKxN2r5sRgzWI/7rELz1w1Cvqz3BvljZtfmZ+1oDgy0hVm8PNaYUI6knSwOdDUQZWGQrmNARZjPXuZjDw3t8roN1ksyCVfpkCKZFvm11In8TMaRGYWvFS7D5ucb4N3SbWtFy9aAVkPbXX0G9/6BKjjUbSj2a5QKSIC1Ob/4iy6dxyWr8bZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by TY0PR06MB4982.apcprd06.prod.outlook.com (2603:1096:400:1ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 01:58:26 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457%5]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 01:58:26 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Chunhai Guo
	<guochunhai@vivo.com>, "xiang@kernel.org" <xiang@kernel.org>
Subject: Re: [PATCH v2] erofs: add a global page pool for lz4 decompression
Thread-Topic: [PATCH v2] erofs: add a global page pool for lz4 decompression
Thread-Index: AQHaQs3UldOOo8Jqr0yxFc+knidg3rDRdDcAgAEnboCAAtRngA==
Date: Fri, 12 Jan 2024 01:58:26 +0000
Message-ID: <69711d55-f7a2-420b-9ba8-fa2921f66a4c@vivo.com>
References: <20240109074143.4138783-1-guochunhai@vivo.com>
 <d8a104d4-1a58-423a-ba12-ea82d622de48@linux.alibaba.com>
 <a5c5acb5-2ad1-41e1-8b86-344394baacbf@vivo.com>
In-Reply-To: <a5c5acb5-2ad1-41e1-8b86-344394baacbf@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3342:EE_|TY0PR06MB4982:EE_
x-ms-office365-filtering-correlation-id: 85c7fb91-dd52-4117-2eda-08dc1311f72d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ++c7FTCTGIPpeTBEyjYYNixam6WyN7updBOWzC/fwUAJqq30PAsdQzsJdPmCw86m1TlRJ/GjCYrNtcsWE1vFYVg7nzOHHDKsaNZXh77Bb7jwCsnOdKS2kQDk/4Uft1PDAOxLfMD2V/Inn6JlD6cHaWc3E2x4io+HLhGt/g+3WaYM7WYyWixu5rfBNQ99W/jp4bezPgxljiHLsH5c02sA+C3AN+DGsYPA7XGqGztk/uZyCScOJneY3+uTAB9teHS6hTHARhBVln7nJHV3mcXk1AEtwKP/Ah6rbDIFHnYZ1gEp7jkYGDNkjfYS7iu2d21WdWch8BIXZjk6RV+XIDlDdIbGqgdcRmv7LbFJZnfWoVlU6Q1GHseKN6rTxn0ZqoxQ1x6TYn21LxfuhIrmgT9Z3UkUxafbSDB1LCjI56ckddQQ6oRKmxF/PsQiyq84i7ON1qTkBl+Hq1oFrS/W7iufvYHbeQPrMag0Hs1M2fhuBYJFBLxtNjpOQLoT594JlBGP8ItdcJBd3MdCB6lZIXQI54dVab2DXixtdTBVUIXRtSj4bXbYe9HfY4xN0EtcUV2ad00wyXv32byV8NSlrN/gVWConT0M6F2dCtSWN4XR2RvsStDbs070P+6HMveg7/SO+vHy1uAJwhgwuwB740vSQQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(71200400001)(2616005)(26005)(478600001)(966005)(6506007)(6512007)(53546011)(38070700009)(83380400001)(5660300002)(2906002)(41300700001)(76116006)(4326008)(6486002)(54906003)(66556008)(66476007)(64756008)(66446008)(316002)(8676002)(66946007)(110136005)(8936002)(91956017)(86362001)(31696002)(122000001)(38100700002)(36756003)(31686004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?aDVjU0RRL2FXTlIrcWovZlJvdTd2QVVtSko4WVZmK1V0cm9keXNza3NHSGd0?=
 =?utf-8?B?emRVdWJZdmhYUHp3eEYvcXAvNjRGOTlCYTdZMVJ6UkVwSVI0ZjVEQy9CNmFM?=
 =?utf-8?B?L0dmOGhaUU52anpyZkNOZ3U1ZlY3QmF4cTcxNC9sc01BOTJMWVNuUnpUTlYy?=
 =?utf-8?B?aldSQWxNa0QveE1yRkFaU2NwTzV1VnppWVRibXloUDY5aGtQUTZJMHJGVzFO?=
 =?utf-8?B?QjA2alp0bGFkd05qb1pIa084aE43ZDdwdUxuT08wRm1EVTVkZUEwNU9mTVMz?=
 =?utf-8?B?dS92L3oraHZ6Wk5kOEUxdEczKzJHcG05ckJGR1BXVDQ5T3lvNnllS2lRZkJp?=
 =?utf-8?B?ZEJySWpZMUVuSnpiNXhsWnY2eGdDUStBNlREZDF1YWVwRTUrVnI3SHkySWEv?=
 =?utf-8?B?SmloaDNCQWQ0WWlRajVaRlJSTG1xeU1BTnRXNHhzSisvNU9FSHVDY3lhWWl4?=
 =?utf-8?B?MituTERDbkRqakZySGl2QlU1d0FkaEN6eXM1dHhXRGUya2MzS256UHV0UFV0?=
 =?utf-8?B?VHh3VTE5NFVraHNzbTNpanEyWHhTcGcvcFlwV1l2a1IreUhWZTFJc2ZTTWU2?=
 =?utf-8?B?aTF0R2NoUENvWHFjaUVVZ3JlVnpIMFVLNFA0dTBxdTEwem5NNjc0SU9kb3ds?=
 =?utf-8?B?SXB6aHlLbzhtU2IrWWF6QzF5dlo4OHVPbmd3L3FuMGhOVGlWanQxdVFjVk5B?=
 =?utf-8?B?Q1NZWldLb0FGSEt3bllZM0UwaVU3eDQvdVFqTFlkVmYwRXMxNCtHUitWdlU4?=
 =?utf-8?B?WW1KcmdsYW9IS1huR0JLL2pUTFNYNWlkU3puTFhDeExobVVwZHZjTjEzM3FR?=
 =?utf-8?B?c1lVVUdldXN1REUyRWNvMFFtTS9sdUZ4d1ZVSUtlWEhacjc1c2tzbGwvQ0ZR?=
 =?utf-8?B?VnRpQmFBTEtITTJzbTVrdXlqd1QyVUJzeGNVekMydjY5UVJSdUhKSnI1QXl0?=
 =?utf-8?B?ZlBFM1A4THk0cjhOVnNCYUhXcit4ZDFSc2lXZ0dKRXl6ZUJINHEyOWJaRFEz?=
 =?utf-8?B?SFBDNDMyWWk2S3JYWmkrUE9IS2JVQ05WZHorTU1GdUZMamFnQi9KQW1Bblcy?=
 =?utf-8?B?ZGJMMmxMZ2RzbDVYM1gxZ29kc0FVejdmQVR3bjk4Ym5iVWVFbEttbHNhMVJy?=
 =?utf-8?B?bFNUZk52Uk0wTnhIRUxxRHNidllFVTFwSnlSK0ZIUzZTamt5MVd4ZjNYRll6?=
 =?utf-8?B?c2NNSGM1YlFDdDBFUEtIc2hXZDdhMFg3NXJZbnRqOVJaYmNFS1pVdXYvQzIz?=
 =?utf-8?B?c2JWeDN4MEtIRUtiZTcvdlBlSTZReTdiRk5YMVBzQ3N1ZDdqWTh0NkJUZmdy?=
 =?utf-8?B?RmI4RWxoNWtFemdVamtKTkJTZ214b3JxKzNZOFdjSVNsVFhJeW12c2Y4NXpY?=
 =?utf-8?B?WnRaV2ljS1dHL0pUVFNLcm5KamRpU0hnU3FFL0xxa01URmtERTdBR1hGSVh2?=
 =?utf-8?B?c3NPZE1waW5xRmZjWVZUKzdNSGdxZ3JxWWxMRUVMSUxOOHpkc3FqaU1zT3Br?=
 =?utf-8?B?bXJtZ1lsSm41TmMzVWlBV2pYQjY1YTJESlloTlQ2R2pFWVpBTmZ6N3pydzZq?=
 =?utf-8?B?bndJUzRTSFRUTXppN1kySmdMRWpMcFVCTVRFaUpIaFdjV1d0dVkvWWl4ZnVv?=
 =?utf-8?B?am9LcDNlWDFwZzdUdFFmTWtwZGdFUVRsZ2ViKytyWjc0bzJnSWtzTGsrV3Q4?=
 =?utf-8?B?dmJlckVTY1NqSlduZDZTeWxrRGR6ZFRIUFRTNFBwMW5lV1RxbEJVTG10a0xs?=
 =?utf-8?B?MEZrcjF0YUsxbDloaGhybzBSQ1pKWkdIYTFNSnUxZmhPM0pmZUtBRHNkMWo3?=
 =?utf-8?B?S25USGRaRThsS3lTOGVldEY2d0l3VnRFVDB3M3J4TmRDcnVsSGJsOUZXQk1F?=
 =?utf-8?B?VFdCVEZML1hTVU1uYUZCMVRGL1M2dlh4UE5qd2pFaU9HclBiSm5DUlI3dGx0?=
 =?utf-8?B?cEl0cVQvalk0WC9Yczkyc1N6b2Z2VlhKQnlOYmNxNTdRM1czaGh5eTluRlg1?=
 =?utf-8?B?a1VwNXhyQ2hnRTdrb012VGJmT2FwWUdZZUpISkovTWtHMS9XZmdoU2k1NTRV?=
 =?utf-8?B?a2w1V0J4OUg5UlZwd05TS0w2dTlXd3hCc1lNWTI2RVFPT2VOclNlVWg4bFEz?=
 =?utf-8?Q?iDaY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02EA834C2B96114E911CCD32848B0E0C@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c7fb91-dd52-4117-2eda-08dc1311f72d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 01:58:26.1524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7PyRP1WvxAIiM3iZ1AqPMMDESecz+wSQ+177vs4ni1aVTqagA0RWOpUQetdvD+fQ53odpRzNIo1RDAAowFgbxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB4982
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

T24gMjAyNC8xLzEwIDE0OjQ1LCBDaHVuaGFpIEd1byB3cm90ZToNCj4gT24gMjAyNC8xLzkgMjE6
MDgsIEdhbyBYaWFuZyB3cm90ZToNCj4+IFvkvaDpgJrluLjkuI3kvJrmlLbliLDmnaXoh6ogaHNp
YW5na2FvQGxpbnV4LmFsaWJhYmEuY29tIOeahOeUteWtkOmCruS7tuOAguivt+iuv+mXriANCj4+
IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbu+8jOS7peS6huin
o+i/meS4gOeCueS4uuS7gOS5iOW+iOmHjeimgV0NCj4+DQo+PiBIaSBDaHVuaGFpLA0KPj4NCj4+
IE9uIDIwMjQvMS85IDE1OjQxLCBDaHVuaGFpIEd1byB3cm90ZToNCj4+PiBVc2luZyBhIGdsb2Jh
bCBwYWdlIHBvb2wgZm9yIExaNCBkZWNvbXByZXNzaW9uIHNpZ25pZmljYW50bHkgcmVkdWNlcyAN
Cj4+PiB0aGUNCj4+PiB0aW1lIHNwZW50IG9uIHBhZ2UgYWxsb2NhdGlvbiBpbiBsb3cgbWVtb3J5
IHNjZW5hcmlvcy4NCj4+Pg0KPj4+IFRoZSB0YWJsZSBiZWxvdyBzaG93cyB0aGUgcmVkdWN0aW9u
IGluIHRpbWUgc3BlbnQgb24gcGFnZSBhbGxvY2F0aW9uIA0KPj4+IGZvcg0KPj4+IExaNCBkZWNv
bXByZXNzaW9uIHdoZW4gdXNpbmcgYSBnbG9iYWwgcGFnZSBwb29sLsKgIFRoZSByZXN1bHRzIHdl
cmUNCj4+PiBvYnRhaW5lZCBmcm9tIG11bHRpLWFwcCBsYXVuY2ggYmVuY2htYXJrcyBvbiBBUk02
NCBBbmRyb2lkIGRldmljZXMNCj4+PiBydW5uaW5nIHRoZSA1LjE1IGtlcm5lbCB3aXRoIGFuIDgt
Y29yZSBDUFUgYW5kIDhHQiBvZiBtZW1vcnkuIEluIHRoZQ0KPj4+IGJlbmNobWFyaywgd2UgbGF1
bmNoZWQgMTYgZnJlcXVlbnRseS11c2VkIGFwcHMsIGFuZCB0aGUgY2FtZXJhIGFwcCB3YXMNCj4+
PiB0aGUgbGFzdCBvbmUgaW4gZWFjaCByb3VuZC4gVGhlIGRhdGEgaW4gdGhlIHRhYmxlIGlzIHRo
ZSBhdmVyYWdlIA0KPj4+IHRpbWUgb2YNCj4+PiBjYW1lcmEgYXBwIGZvciBlYWNoIHJvdW5kLg0K
Pj4+IEFmdGVyIHVzaW5nIHRoZSBwYWdlIHBvb2wsIHRoZXJlIHdhcyBhbiBhdmVyYWdlIGltcHJv
dmVtZW50IG9mIDE1MG1zIGluDQo+Pj4gdGhlIGxhdW5jaCB0aW1lIG9mIHRoZSBjYW1lcmEgYXBw
LCB3aGljaCB3YXMgb2J0YWluZWQgZnJvbSBzeXN0cmFjZSANCj4+PiBsb2cuDQo+Pj4gKy0tLS0t
LS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0rDQo+Pj4g
fMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgdy9vIHBhZ2UgcG9vbCB8IHcvIHBhZ2UgcG9v
bCB8wqAgZGlmZsKgwqAgfA0KPj4+ICstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rLS0t
LS0tLS0tLS0tLS0rLS0tLS0tLS0tKw0KPj4+IHwgQXZlcmFnZSAobXMpIHzCoMKgwqDCoCAzNDM0
wqDCoMKgwqDCoCB8wqDCoMKgwqDCoCAyMcKgwqDCoMKgwqAgfCAtOTkuMzglIHwNCj4+PiArLS0t
LS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLSsNCj4+
Pg0KPj4+IEJhc2VkIG9uIHRoZSBiZW5jaG1hcmsgbG9ncywgNjQgcGFnZXMgYXJlIHN1ZmZpY2ll
bnQgZm9yIDk1JSBvZg0KPj4+IHNjZW5hcmlvcy4gVGhpcyB2YWx1ZSBjYW4gYmUgYWRqdXN0ZWQg
ZnJvbSB0aGUgbW9kdWxlIHBhcmFtZXRlci4gVGhlDQo+Pj4gZGVmYXVsdCB2YWx1ZSBpcyAwLg0K
Pj4+DQo+Pj4gVGhpcyBwYXRjaCBjdXJyZW50bHkgb25seSBzdXBwb3J0cyB0aGUgTFo0IGRlY29t
cHJlc3Nvciwgb3RoZXINCj4+PiBkZWNvbXByZXNzb3JzIHdpbGwgYmUgc3VwcG9ydGVkIGluIHRo
ZSBuZXh0IHN0ZXAuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHVuaGFpIEd1byA8Z3VvY2h1
bmhhaUB2aXZvLmNvbT4NCj4+DQo+PiBUaGlzIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUsIHlldCB3
ZSdyZSBpbiB0aGUgbWVyZ2Ugd2luZG93IGZvciB2Ni44Lg0KPj4gSSB3aWxsIGFkZHJlc3MgaXQg
YWZ0ZXIgLXJjMSBpcyBvdXQgc2luY2Ugbm8gc3RhYmxlIHRhZyB0aGVzZSBkYXlzLg0KPj4NCj4+
IEFsc28gaXQgd291bGQgYmUgYmV0dGVyIHRvIGFkZCBzb21lIHJlc3VsdHMgb2YgY2hhbmdpbmcg
bWF4X2Rpc3RhbmNlDQo+PiBpZiB5b3UgaGF2ZSBtb3JlIHRpbWUgdG8gdGVzdC4NCj4NCj4gT0su
IEkgd2lsbCByZXBseSB0byB0aGlzIGVtYWlsIHdoZW4gdGhlIGV4cGVyaW1lbnQgaXMgZmluaXNo
ZWQuDQoNCkRlYXIgWGlhbmcsDQoNClRoZSBleHBlcmltZW50IGlzIGRvbmUgYW5kIHRhYmxlIGJl
bG93IHNob3dzIHRoZSByZXN1bHRzLiBXZSBjYW4gZmluZCANCnRoYXQgYSAxNmsgc2xpZGluZyB3
aW5kb3cgcmVkdWNlcyAzOC4yJSBvZiB0aW1lIHVzZWQgaW4gcGFnZSBhbGxvY2F0aW9uIA0KZm9y
IExaNCBkZWNvbXByZXNzaW9uIGNvbXBhcmVkIHRvIGEgNjRrIHNsaWRpbmcgd2luZG93LiBIb3dl
dmVyLCB1c2luZyBhIA0KZ2xvYmFsIHBhZ2UgcG9vbCBpcyBzdGlsbCBmYXIgYmV0dGVyIHRoYW4g
Ym90aCBvZiB0aGVtLg0KDQorLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tLS0tKy0tLS0tLS0tLSsNCnzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2NGsg
d2luZG93wqAgfMKgIDE2ayB3aW5kb3fCoCB8wqAgZGlmZsKgwqAgfA0KKy0tLS0tLS0tLS0tLS0t
Ky0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0rDQp8IEF2ZXJhZ2UgKG1z
KSB8wqDCoMKgwqAgMzM2NMKgwqDCoMKgwqAgfMKgwqDCoMKgwqAgMjA3OcKgwqDCoCB8IC0zOC4y
JcKgIHwNCistLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0rLS0t
LS0tLS0tKw0KDQpUaGFua3MsDQoNCj4NCj4gVGhhbmtzLg0KPg0KPj4NCj4+IFRoYW5rcywNCj4+
IEdhbyBYaWFuZw0KPg0KPg0KDQo=
