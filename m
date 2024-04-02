Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68312894EA9
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 11:26:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712049976;
	bh=Rb+OIAIF+erJGHP4kr6s8n5no+BsBgKb4C/l9VcGn/g=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=iAbH8xeRutEl5TkTz9ljhaJvFyi60cc+a68ACKUklo6wxCclzvbS86sDt8hY5qF33
	 FPVtFYttwIA+vkfyzBM22SbsjsTcnIL2+oty4A5LE/KiRxWPI2pVQM1tDwn/4DyNHl
	 fRumyrUQPCCGEHTI/Ke+/2qVFx+YE6j7T7FF2YIWiQe2ChyUicoM5Yvogsx4vkt0zV
	 6G4aTbyrEllL2489urFfuo0Cm5t+DZQpvHQy3TyDDDBgjlmMSPzYtSAlKsStcVlfP6
	 1aDWnt52KAM5aIcpKAg5Hd+CfP7KehVNolfdUvtQyivL4D5FN6Fdka7ynHpuuEmPpg
	 YLZQ7NmJS3C6A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V82Z01Zfhz3dRs
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 20:26:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=I5P5pllD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c400::])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V82Yt0Njmz3cgk
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 20:26:08 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9WkzLAkGqxIBSSCIE32Kfypv6dTogbXk0mLY3h0bM5wq8exfcbqzEyvgLZjNJnjH0alyZUoBrULgTob+2NvulqIjk2GkXmFqwOvxbdS66bo0DaShzsQ4tIt6eeKPf61HAjT+c8g4cKvy4C8AMCoajCud4VNXIWlbUjkxdS/y9e+EhIarhKN2ckHdjqGL/vLBGLLFCyQuHaFaU3B3PONTY/lZyDnMrdONBSgLidWEIQjlp7Lk8sGl+36lKwElueIaBSLcy9C+5DfLensFWAF9/zEh3qHSUBm3q7AQmLcQSoe9wQG60O94ii7kGvs47aIJW5TQGM1Mt9DDSEfp2eEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rb+OIAIF+erJGHP4kr6s8n5no+BsBgKb4C/l9VcGn/g=;
 b=L1GEVeyWJ/yMz8bHloSy7xH3WhqKkTPDqtIX42OT6TyBiWh1+A9tvn0+ZrNLaVqyLJqhSyukvo8Ta0vpY8bh1avbWW3JkYKWHGc6GEI1FzinQ0bS256xogUoO19n5ajN7AC5Y5z7JTxnMXn/2t7zVf6LWVDPa6v85cQ19KW2DW5y3YcvrcmYqhQEeolBxY3VfV520JM4OakFmGUZkMruSWwTCPDok6YY84IBf85Zqrb2467iMe0yBG1v0MMClFO4aI4TUdsdn4Zbs14trk2Nc6QK3OwYfksq45gxLMYaR5LxERA2s5yxLKAzDjbatO8ui69DR1oojBcGWpkIHhtnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by TYUPR06MB6175.apcprd06.prod.outlook.com (2603:1096:400:35f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 09:25:43 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 09:25:43 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Chunhai Guo
	<guochunhai@vivo.com>, "xiang@kernel.org" <xiang@kernel.org>
Subject: Re: [PATCH v2] erofs: do not use pagepool in z_erofs_gbuf_growsize()
Thread-Topic: [PATCH v2] erofs: do not use pagepool in z_erofs_gbuf_growsize()
Thread-Index: AQHahN5RiLcObxgypUmRIOsTtm7AubFUtOyAgAAAz4A=
Date: Tue, 2 Apr 2024 09:25:43 +0000
Message-ID: <930eeeb8-c4f9-49d4-8459-267740c6c590@vivo.com>
References: <20240402092757.2635257-1-guochunhai@vivo.com>
 <3b6bf073-cf44-49ee-b24e-a7a21ad40ad7@linux.alibaba.com>
In-Reply-To: <3b6bf073-cf44-49ee-b24e-a7a21ad40ad7@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7096:EE_|TYUPR06MB6175:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  XFopWTFateMo6VpN4gF2bfOytCH6ZmFD84QzrMr1LnRQxsyY2mAv3psao+7AkaTehML5/t66dRa/Da1JpGcXDZ1JYFYc/307lPcK3dyMajcSlxxQbwBZPCNS0zw7n1rXPRe28+W1bPZOe9060v/C28cXpUtmkXFGllXlMJPtoNTPE7VTZFyGKBtXMF7FYxd0u7VfbedFIc4K37Vdc0Y22epuXDte7shq8u+SqTmnqt9uypMqKZwsxZmbzfr05EKhaIK0sAgmv/zqGEGlzUsU8JPrB6cDeA6Z0nvrsMubtimP7gmz3y8eUahJ1OAAg9SXH2EjRHhgTojvWMNKPtwopCGJqF2Mp9EWdBKooz06408t8R8mbwRsi0/H2YDcMPQvvkFsZ0CHOjUfaixgYTI7pi0vROh/QqChmbHF45vLbQa17bwMhxWDo8UEpZlcbbt1JrMDSdOO2nXsqpBvHUSxZX77726YbExbp1wupqrKgkpO4YaEYxKP1o7VxWN453oGH+ygKUITL2ilClLarWDg8Qt/03h2FkiRXChUGmpTCFATBaCjLVs40agoJOS40hvTlZQTzbY/SJcqnT1KJjKNlLJa6ksvaPJBTalUI+zfbUXzOdIaCZ6YxtEgTHTlPco/CIw59TqZCgGDJANvZW19ce1x5VcpZWCjx66W6gOgU6Q=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WDlWaFRlYUhCM2NwTklDOVZFazdhUkVaQTl2UVVQN3ZYUjJ4cVdMN0I1bEt5?=
 =?utf-8?B?VzV0ejhFRFFFUU44NldDMkw4dTNLSm40MVgwVUZvQm1nOXV6ZEY3aFdwUXF6?=
 =?utf-8?B?ZGJ3dE1TM0pvV3h2NDdiNVlwNE14eFd1L3AxMFA1YldNcE52eGo5KzJhVEdG?=
 =?utf-8?B?d3lGL2pSTEJKcVFmNCtvaHZXYXoxUFZXTC9kR1YwMlV4dERja1pFYmc0U3l3?=
 =?utf-8?B?WGhPbHZrMmMvQ01pVFJvL2o3UWIyT2xoRU9XUWZ5VTEwNEtaN2dsWmFKUWlt?=
 =?utf-8?B?SnhmTUgrRzJFUmQ4VFpHVUhNSkRwaEl1cUlEQlpZMzZLOE1IMi9odXdwdjhE?=
 =?utf-8?B?eWxQYlJNT3Nlb2dndUQ1ekRIN0lKVXlreTFTNnc0VDJ6UzNOZmtqTFhVZFZW?=
 =?utf-8?B?K1VBOERSRXFXc3o2UXI4Ui90ZGg1T1RidXU3eEFGV3NIYlRjMGJaUEFGbXhK?=
 =?utf-8?B?YjJMUXZ1SGdnSU43ajg5ZkQ0M2VCeU1XYlFvUmhNeVBFVGlNZEhUMjFqa1Zz?=
 =?utf-8?B?aWRpWlF0bXh3TjRiTHl5dmFuODhOdkVlcUNNR1ZXeFErZkoxZ0FOZm5ycVcr?=
 =?utf-8?B?MEJxM1BzbUhQdVlqNkRrM1ZnNlBEeWpONCt3dkZqZFVVeTJGYWdVYUxVOE9j?=
 =?utf-8?B?dWFPMzE5UEo3dTF0VEM5TEx4S2MyWnpuMXVBeGpyZjJnd2U1anhMRjNmQUtY?=
 =?utf-8?B?RXVxbXVPWmFYaTV0YXhsdHJWUTJFZFFyU1p4S1JQdWRZU25Nd292YUpJSmRp?=
 =?utf-8?B?VEJjRkhXVUtLcUU5RUN3bW01TFk4L3p0L1Q0Y0xyVldSR2FlZlN6SWcvUFQ5?=
 =?utf-8?B?YXFaenpKODNEUmlwS3kwVmRzb2pWay9RRVdtNmo0L1VsakF0U0F1Y3dqRXZK?=
 =?utf-8?B?bk4xNUNYbU1pSGlxd1MyTUUrV0JGT1JBeXk2OGo3VXcyVjRSZzhqNmZyS3NS?=
 =?utf-8?B?UkNrU3NKNkViMGVDcGdMVHJvdVF4aUhISkdTNlNmaFBrdzlYR2o2Tm1CMHB5?=
 =?utf-8?B?WHJIWlNoakFUamxEQ3BJUFBvU3VacTVCR25OaTlVYWVJOFQ4dE1PNW5ZY29B?=
 =?utf-8?B?UEl1ZUFmMDYyWWNPcE1iK2p1RkhVT3hZUkhHODE5NW9MT2FscUxlYmp0M1lF?=
 =?utf-8?B?NkYwVjNEcmFZQ0NOSkJVOFJEbXdaYys5ODRtTkx2UE1aMDE4WVN1L05yTXBw?=
 =?utf-8?B?WS8xZG9MQmFVd1lpL2FLTzZwMHd5ZTlCK1VPYlMrcWhvanRkbkRySTc2bHI4?=
 =?utf-8?B?bVBKNnR1RU81dUduS1BqOUthMU5LKzZDNmtJT2hVNVVRR1dVS3EzOUtsZHNM?=
 =?utf-8?B?azk5TG9PdGtRNmwvVUFHVVdaZlZxSjhLZHlmNXIweXJjS1daR2krQVVUWmdm?=
 =?utf-8?B?WCtURkJWKzZ2SkNvTUhzZFIvaUlobHpjOHRKcW4ySmFaejRSWkNBVU9FdlVo?=
 =?utf-8?B?WHJBd1dMUHdvVzM3ZHhZeWkraHcweEU1aVZVVklIdmVVYko1RkpiNE9rR1Y0?=
 =?utf-8?B?VWQzSW1GdEpzNnNiOWxlNWxlWGNEcUV1REVzbzVvcTNMU2dLdlRlM1IrVkFC?=
 =?utf-8?B?SXl6aVNLY0NPZDdtbDRmY3V0SWtBWmF5alpzV0Z6VXFHTWJ3RlhJT3ZJZ25U?=
 =?utf-8?B?amgvOVJkcWExUVNyRlNEWGsydWNDWlpLN2ZzTkhVSVhDbDFPOFVBRzY1cDlh?=
 =?utf-8?B?OUZGdHdWSDJFLzdPN0RVUWJoUDFUUTlBRWFxeEI3ZGZ4RjNkTCtYQVNGdGdM?=
 =?utf-8?B?Zm5sbHVVc3FXTEVSWmtuRUJzN2paOUIxb0wweE1nUEpUcjJIWFZobmlYMEkr?=
 =?utf-8?B?NXdWUjhnVVFmNEZiLzIvc3BCbVh5bS9ISTlPaGdmUEtMSG1RYzRzcDRhS1V4?=
 =?utf-8?B?VkpET3U5WHhVNFBiSENDWm1aTmJXd3ZJZkRZV0Z2R2NadlpiKzE0cVZ0c0pm?=
 =?utf-8?B?L2xPb04yWmNxLzh0bUR3QzJzbm9Wd0w0VkdUbEJNOVo5STREcm5waXZVcElD?=
 =?utf-8?B?VW1DREprSzNtUWozMGNEZnd5VDE2M0xOaEttUHk0WmZnRk52U2hUeS9lR3A5?=
 =?utf-8?B?TWQ3bEN0ZDk1M1NXMGNpaHVidFB3V0U0Q1lhWXNCamUvbVhoY1lreDFXOHox?=
 =?utf-8?Q?9U3Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1627F6075144304C944F68BF3CAF1010@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22c86eb-2b0a-40e6-f43c-08dc52f6deec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 09:25:43.4905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQ/7cwwnRB719L0ewxz2fnpPNGLWcIk1WvzI+FXiWFdvqebKeJrVHG0gfD4gUjIj59IBt1zvO1VCpHelQ8Y3Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6175
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

5ZyoIDIwMjQvNC8yIDE3OjIyLCBHYW8gWGlhbmcg5YaZ6YGTOg0KPg0KPiBPbiAyMDI0LzQvMiAx
NzoyNywgQ2h1bmhhaSBHdW8gd3JvdGU6DQo+PiBMZXQncyB1c2UgYWxsb2NfcGFnZXNfYnVsa19h
cnJheSgpIGZvciBzaW1wbGljaXR5IGFuZCBnZXQgcmlkIG9mDQo+PiB1bm5lY2Vzc2FyeSBwYWdl
cG9vbC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHVuaGFpIEd1byA8Z3VvY2h1bmhhaUB2aXZv
LmNvbT4NCj4+IC0tLQ0KPiBXb3VsZCB5b3UgbWluZCBhZGRpbmcgYSBjaGFuZ2Vsb2cgaGVyZSBu
ZXh0IHRpbWU/IG5vDQo+IG1hdHRlciBob3cgc2hvcnQgdGhlIHRleHQgaXMuDQo+DQo+IFJldmll
d2VkLWJ5OiBHYW8gWGlhbmcgPGhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbT4NCj4NCj4gVGhh
bmtzLA0KPiBHYW8gWGlhbmcNCkdvdCBpdC4gVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQo+
PiAgICBmcy9lcm9mcy96dXRpbC5jIHwgNjcgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygr
KSwgMzYgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2ZzL2Vyb2ZzL3p1dGlsLmMg
Yi9mcy9lcm9mcy96dXRpbC5jDQo+PiBpbmRleCBlMTM4MDY2ODE3NjMuLjk2ODdjYWQ4YmU5NiAx
MDA2NDQNCj4+IC0tLSBhL2ZzL2Vyb2ZzL3p1dGlsLmMNCj4+ICsrKyBiL2ZzL2Vyb2ZzL3p1dGls
LmMNCj4+IEBAIC02MCw2MyArNjAsNTggQEAgdm9pZCB6X2Vyb2ZzX3B1dF9nYnVmKHZvaWQgKnB0
cikgX19yZWxlYXNlcyhnYnVmLT5sb2NrKQ0KPj4gICAgaW50IHpfZXJvZnNfZ2J1Zl9ncm93c2l6
ZSh1bnNpZ25lZCBpbnQgbnJwYWdlcykNCj4+ICAgIHsNCj4+ICAgIAlzdGF0aWMgREVGSU5FX01V
VEVYKGdidWZfcmVzaXplX211dGV4KTsNCj4+IC0Jc3RydWN0IHBhZ2UgKnBhZ2Vwb29sID0gTlVM
TDsNCj4+IC0JaW50IGRlbHRhLCByZXQsIGksIGo7DQo+PiArCXN0cnVjdCBwYWdlICoqdG1wX3Bh
Z2VzID0gTlVMTDsNCj4+ICsJc3RydWN0IHpfZXJvZnNfZ2J1ZiAqZ2J1ZjsNCj4+ICsJdm9pZCAq
cHRyLCAqb2xkX3B0cjsNCj4+ICsJaW50IGxhc3QsIGksIGo7DQo+PiAgICANCj4+ICAgIAltdXRl
eF9sb2NrKCZnYnVmX3Jlc2l6ZV9tdXRleCk7DQo+PiAtCWRlbHRhID0gbnJwYWdlcyAtIHpfZXJv
ZnNfZ2J1Zl9ucnBhZ2VzOw0KPj4gLQlyZXQgPSAwOw0KPj4gICAgCS8qIGF2b2lkIHNocmlua2lu
ZyBnYnVmcywgc2luY2Ugbm8gaWRlYSBob3cgbWFueSBmc2VzIHJlbHkgb24gKi8NCj4+IC0JaWYg
KGRlbHRhIDw9IDApDQo+PiAtCQlnb3RvIG91dDsNCj4+ICsJaWYgKG5ycGFnZXMgPD0gel9lcm9m
c19nYnVmX25ycGFnZXMpIHsNCj4+ICsJCW11dGV4X3VubG9jaygmZ2J1Zl9yZXNpemVfbXV0ZXgp
Ow0KPj4gKwkJcmV0dXJuIDA7DQo+PiArCX0NCj4+ICAgIA0KPj4gICAgCWZvciAoaSA9IDA7IGkg
PCB6X2Vyb2ZzX2didWZfY291bnQ7ICsraSkgew0KPj4gLQkJc3RydWN0IHpfZXJvZnNfZ2J1ZiAq
Z2J1ZiA9ICZ6X2Vyb2ZzX2didWZwb29sW2ldOw0KPj4gLQkJc3RydWN0IHBhZ2UgKipwYWdlcywg
Kip0bXBfcGFnZXM7DQo+PiAtCQl2b2lkICpwdHIsICpvbGRfcHRyID0gTlVMTDsNCj4+IC0NCj4+
IC0JCXJldCA9IC1FTk9NRU07DQo+PiArCQlnYnVmID0gJnpfZXJvZnNfZ2J1ZnBvb2xbaV07DQo+
PiAgICAJCXRtcF9wYWdlcyA9IGtjYWxsb2MobnJwYWdlcywgc2l6ZW9mKCp0bXBfcGFnZXMpLCBH
RlBfS0VSTkVMKTsNCj4+ICAgIAkJaWYgKCF0bXBfcGFnZXMpDQo+PiAtCQkJYnJlYWs7DQo+PiAt
CQlmb3IgKGogPSAwOyBqIDwgbnJwYWdlczsgKytqKSB7DQo+PiAtCQkJdG1wX3BhZ2VzW2pdID0g
ZXJvZnNfYWxsb2NwYWdlKCZwYWdlcG9vbCwgR0ZQX0tFUk5FTCk7DQo+PiAtCQkJaWYgKCF0bXBf
cGFnZXNbal0pDQo+PiAtCQkJCWdvdG8gZnJlZV9wYWdlYXJyYXk7DQo+PiAtCQl9DQo+PiArCQkJ
Z290byBvdXQ7DQo+PiArDQo+PiArCQlmb3IgKGogPSAwOyBqIDwgZ2J1Zi0+bnJwYWdlczsgKytq
KQ0KPj4gKwkJCXRtcF9wYWdlc1tqXSA9IGdidWYtPnBhZ2VzW2pdOw0KPj4gKwkJZG8gew0KPj4g
KwkJCWxhc3QgPSBqOw0KPj4gKwkJCWogPSBhbGxvY19wYWdlc19idWxrX2FycmF5KEdGUF9LRVJO
RUwsIG5ycGFnZXMsDQo+PiArCQkJCQkJICAgdG1wX3BhZ2VzKTsNCj4+ICsJCQlpZiAobGFzdCA9
PSBqKQ0KPj4gKwkJCQlnb3RvIG91dDsNCj4+ICsJCX0gd2hpbGUgKGogIT0gbnJwYWdlcyk7DQo+
PiArDQo+PiAgICAJCXB0ciA9IHZtYXAodG1wX3BhZ2VzLCBucnBhZ2VzLCBWTV9NQVAsIFBBR0Vf
S0VSTkVMKTsNCj4+ICAgIAkJaWYgKCFwdHIpDQo+PiAtCQkJZ290byBmcmVlX3BhZ2VhcnJheTsN
Cj4+ICsJCQlnb3RvIG91dDsNCj4+ICAgIA0KPj4gLQkJcGFnZXMgPSB0bXBfcGFnZXM7DQo+PiAg
ICAJCXNwaW5fbG9jaygmZ2J1Zi0+bG9jayk7DQo+PiArCQlrZnJlZShnYnVmLT5wYWdlcyk7DQo+
PiArCQlnYnVmLT5wYWdlcyA9IHRtcF9wYWdlczsNCj4+ICAgIAkJb2xkX3B0ciA9IGdidWYtPnB0
cjsNCj4+ICAgIAkJZ2J1Zi0+cHRyID0gcHRyOw0KPj4gLQkJdG1wX3BhZ2VzID0gZ2J1Zi0+cGFn
ZXM7DQo+PiAtCQlnYnVmLT5wYWdlcyA9IHBhZ2VzOw0KPj4gLQkJaiA9IGdidWYtPm5ycGFnZXM7
DQo+PiAgICAJCWdidWYtPm5ycGFnZXMgPSBucnBhZ2VzOw0KPj4gICAgCQlzcGluX3VubG9jaygm
Z2J1Zi0+bG9jayk7DQo+PiAtCQlyZXQgPSAwOw0KPj4gLQkJaWYgKCF0bXBfcGFnZXMpIHsNCj4+
IC0JCQlEQkdfQlVHT04ob2xkX3B0cik7DQo+PiAtCQkJY29udGludWU7DQo+PiAtCQl9DQo+PiAt
DQo+PiAgICAJCWlmIChvbGRfcHRyKQ0KPj4gICAgCQkJdnVubWFwKG9sZF9wdHIpOw0KPj4gLWZy
ZWVfcGFnZWFycmF5Og0KPj4gLQkJd2hpbGUgKGopDQo+PiAtCQkJZXJvZnNfcGFnZXBvb2xfYWRk
KCZwYWdlcG9vbCwgdG1wX3BhZ2VzWy0tal0pOw0KPj4gLQkJa2ZyZWUodG1wX3BhZ2VzKTsNCj4+
IC0JCWlmIChyZXQpDQo+PiAtCQkJYnJlYWs7DQo+PiAgICAJfQ0KPj4gICAgCXpfZXJvZnNfZ2J1
Zl9ucnBhZ2VzID0gbnJwYWdlczsNCj4+IC0JZXJvZnNfcmVsZWFzZV9wYWdlcygmcGFnZXBvb2wp
Ow0KPj4gICAgb3V0Og0KPj4gKwlpZiAoaSA8IHpfZXJvZnNfZ2J1Zl9jb3VudCAmJiB0bXBfcGFn
ZXMpIHsNCj4+ICsJCWZvciAoaiA9IDA7IGogPCBucnBhZ2VzOyArK2opDQo+PiArCQkJaWYgKHRt
cF9wYWdlc1tqXSAmJiB0bXBfcGFnZXNbal0gIT0gZ2J1Zi0+cGFnZXNbal0pDQo+PiArCQkJCV9f
ZnJlZV9wYWdlKHRtcF9wYWdlc1tqXSk7DQo+PiArCQlrZnJlZSh0bXBfcGFnZXMpOw0KPj4gKwl9
DQo+PiAgICAJbXV0ZXhfdW5sb2NrKCZnYnVmX3Jlc2l6ZV9tdXRleCk7DQo+PiAtCXJldHVybiBy
ZXQ7DQo+PiArCXJldHVybiBpIDwgel9lcm9mc19nYnVmX2NvdW50ID8gLUVOT01FTSA6IDA7DQo+
PiAgICB9DQo+PiAgICANCj4+ICAgIGludCBfX2luaXQgel9lcm9mc19nYnVmX2luaXQodm9pZCkN
Cg0KDQo=
