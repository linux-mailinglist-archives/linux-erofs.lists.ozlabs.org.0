Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF21383D326
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jan 2024 04:57:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1706241440;
	bh=YLt2X/gAgm3TpS81Uene0dO2C+KM3v40lFCJJvNGRr4=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=AAmTTxirbfMgl2XTmkzb257NqDUF5ZuqrmvJiAWBMxvTOJiLcGTsgHG4/gj17kBB6
	 kdK/dNOcFPxt+I8t7tN9WzbNKPN6kkpiFE0448sM1x9ibtcjN2mn5WU59u4kFGzxzP
	 VE7b1mJTg1ZrSWBu6wO47Hgg3gRwqQl0bs0A8IQRJDTou9mFNO+MNd4ktMxKPQr32x
	 jv7LvqZjSz9JVyjq/MGEQGmzWk/Q18q6bVySoWcuJg+tDNns1HN9k0sz4zRyv7BYoH
	 +eSVLo+wUA+rQFEy7Ap4BRZ70WMzN5FWkb7JXhUZO27V6ZUe+bKNgFG70vghs0PW13
	 zU2T38lkrY6Ew==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TLkRN4YKdz3cGC
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jan 2024 14:57:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=NcZVJ28H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::701; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::701])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TLkRK09KTz3bwX
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jan 2024 14:57:15 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+HnQi+M73hgt2CYou3/Lq6lR0CqF7jzxm7aXT2YRbFCby2UcQeo/KLXEQDqV0OBy10+DZmuzwQn2YRX9PieeZpPMnSZJ0VLEKSRSMmUH1lj2aZiisIsrQTQCyiZMhS/pOwmHjEA1tun8qD68kK4G5XjGzwbvT1f99u2rZQEAp/Tltk/+599nCtF1St79EukpthPXydn9BBPRK8GE72XnZsrCUjruNBfX0L1NIWNUdxVYVJCzDw+MdhK4QOf9KTmvftHsLQGAvjCH/Cc2zib/ir63Dz7Aos+FTEx7bT0d2uCIBxwUmz68iXnblHngKDhpWE8Ejf9mpM393+LXBnprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLt2X/gAgm3TpS81Uene0dO2C+KM3v40lFCJJvNGRr4=;
 b=EMUiQnIoRnzNK0IKen3dpScXgou4X6ORICv8avjSbtGBZKYD1PcqxCsBE+GcQWBajFQgL2JEFIIbxxEQpv0b2QRpoG4bnR9wT7vFg7NZtY7wWqosHGPFGQIz75nZXbATdn4ccnF80oKmhlzlXhNMCIjT+kn44LjTMG7mb53NJKUttE2KQvoWz0T2uLiGlOWewcgZx0ipnH+ZvJEBht4nxatxCM5YRCy7kRjL3/BQYZtfIcxUVra95heWGfnzzDecwNn+ypJFTcub0ZurYPNftkG8J+qrUJqp4V7MWC/I9EMkAXCDA33S4nViXAlI4hOSBYhshUFix7QkYcf37pLUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by TYZPR06MB3901.apcprd06.prod.outlook.com (2603:1096:400:5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 03:56:51 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457%5]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 03:56:51 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "xiang@kernel.org"
	<xiang@kernel.org>
Subject:  =?gb2312?B?tPC4tDogW1BBVENIIHYyXSBlcm9mczogcmVsYXhlZCB0ZW1wb3JhcnkgYnVm?=
 =?gb2312?Q?fers_allocation_on_readahead?=
Thread-Topic: [PATCH v2] erofs: relaxed temporary buffers allocation on
 readahead
Thread-Index:  AQHaS69Dn7c0lZTvWk6XNTojszowdLDlGDgAgAAcboCAAA1DgIAAM7CAgAX1dQCAAAGHAIAAD4CAgAAB84CAAAGEgA==
Date: Fri, 26 Jan 2024 03:56:51 +0000
Message-ID:  <TY2PR06MB3342D2245C5E515028C33FD4BE792@TY2PR06MB3342.apcprd06.prod.outlook.com>
References: <20240120145551.1941483-1-guochunhai@vivo.com>
 <cd64ee05-e8b2-4cd0-93e5-6bf787774d1f@linux.alibaba.com>
 <0aae43b2-c37b-41c8-be3f-3ebf0bb3d052@vivo.com>
 <da8060aa-2ed4-404c-8f06-06e35a4f4d27@linux.alibaba.com>
 <cd6c4dcc-cdb9-4b38-9ef7-e953cdc47441@vivo.com>
 <66d22178-88fa-409f-a33b-bcaee905b0d0@vivo.com>
 <61c6c462-11cf-4e66-ab24-712e55f9cf19@linux.alibaba.com>
 <369dbe84-ae27-40f0-8945-fd06b7b628a4@vivo.com>
 <12768969-cea8-41c7-a9d7-fa3a3e6ca985@linux.alibaba.com>
In-Reply-To: <12768969-cea8-41c7-a9d7-fa3a3e6ca985@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3342:EE_|TYZPR06MB3901:EE_
x-ms-office365-filtering-correlation-id: 633404de-056e-47f7-94df-08dc1e22d3d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Ls5egCYXtCLmmQa3TZhbTSJ1HP0s6synESjXrdFAL6lwwNGIHbO9sxLix7e9UwFy4OvswGdbKOgY8IRM4XtVvIKQ0ORqGVZ8u+9D1TVAVUskrfMs4HRvmLPz9gn+GQHh/NgDbQI/ENpw8Xohk3He/4Mg6KQlP34ngWbseK3t0+5EwSiYl990z48Hf4/XLf0JeKvy/QTzHdfun9+Ghe0yznFlTu4KiDeWQjZzcAbS0oh4n6InG0+Z1lplSbiSoYM2dRcG8U1g7S4P2a7ly848aAhfAs08qP3gULGm6Nqxbgqx37FTG/2AdbkrWq54AdJMkFW/duuLDrE7sl0FetvCDfOFzLx4vMfd/xXBBBnuXhe/+1rgUNnArjskFqUkn4TiAa/kTO9BI9eV8T3RmaE9/nP9wgpJ7uWlw0GNldvvw/b0JBYbc4g1KhP72Crni7olOsoMHNG8TsNM4skhDzAhMytRU0IbrJfCYl+zTp8KPKS288JFThn9FitZQZ5m9b3r+oK/bti1ErGW4EZOsBlscHzrP9iJod5CmRi6t2Kk2BhGaeUfcFlJ0vB+66g+jz6xAnHwoh8MwnPiMpNM8X5U8Uhd4YsWX6PP2HqLsDG4EXQ=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39850400004)(346002)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(7696005)(316002)(966005)(45080400002)(71200400001)(478600001)(53546011)(6506007)(38100700002)(54906003)(66556008)(66946007)(66446008)(64756008)(76116006)(110136005)(66476007)(8936002)(55016003)(52536014)(4326008)(83380400001)(26005)(122000001)(9686003)(5660300002)(2906002)(86362001)(33656002)(224303003)(38070700009)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?gb2312?B?T002NTRiU0RXVzMzWGMzTTlhbTZoY3ltdThyVkt0Z3NuK1JRNExVZnpIc29Y?=
 =?gb2312?B?S1dkN1Byb0FIbFBnRmZwaGJIN09Xc05KVTBvWGJvb0lTUnlvQTlvN1ZDME5t?=
 =?gb2312?B?OW9QV3k2UHNURGhSb3dJUWt0Y21KYmUrbngvZ0VCcWpZdDBXODN5UFcxOVlP?=
 =?gb2312?B?WlZxTVVkYzhtSjI0eFk4emN4bkZkRXRSdTUxUFRZaXAwV3FDTGtSaThTNWQ3?=
 =?gb2312?B?Y21PWXp0OTBNeDFBZTFoU010Q2FGaVlVY2FhVFhXeFhyanNlRzVrd21adWVO?=
 =?gb2312?B?Y0pjc0ZqZHk3SlFXbG9yd2VqUVFNbFNqM0NNVlVCb2RFU2JTYVBZQklHSWNh?=
 =?gb2312?B?VU9mSm5JVUlnVExTdnZMWi9QL2U4TEdSY2xSRCt0dC9GQ05sOW4wNVZzczZK?=
 =?gb2312?B?VytGM2xZNS9mYlFkc2tpWVFqVEJXcmtQY0I4RDlUbmJRY0JGZ0FTR0RMdzl3?=
 =?gb2312?B?WEV1dEUwaUU5dzNLWkw5UXAzc00rUExnd0sxWmdza2pQdHZkQjRNaTlQMGFQ?=
 =?gb2312?B?VW01SkJUZjF6MUVFcDlreEZtSEw2L3VOckg2a3M0WUUycjcwRzMrU2FpcVVi?=
 =?gb2312?B?Z0l4OU1oN29wMm0wdlI4UG40M0hWaWlJRUNlbllRMDJtN3VWWmM2MldNQUZq?=
 =?gb2312?B?S0JGWkk5SEo5eEd6ZUhRRjNVRmFBZkhSOUJFaTQwaXdoc2lVTnNwZ2hBRWdE?=
 =?gb2312?B?N245d3Bydm8xdFJxdkNwNzdkRzVFMFdSQ0FSNjFDRDNTaGx6MkszOU5ZVThK?=
 =?gb2312?B?VytvSkNzc1NnMS9wMTkwajAvT3k5M3Ywb0VpUGtPaFQxaUNhVFJlU3BlL3JU?=
 =?gb2312?B?VmxTK2YyL2tFNExUdm9BNzNuYU9HVFJYNFVEeTVtT3dQdzBKT3ZkeEljZU9Z?=
 =?gb2312?B?anB0M2F1aDBzbDZBTk5sdXdoMmRUSno0elJiWVdMUFNXMGd4L29mN0ZQY0d6?=
 =?gb2312?B?eG9vRC9SWnFkUGtoQUF0SlRMZ3lYbTZoRktjb3dwNmJ0b2gyb0xHUmhQZmYz?=
 =?gb2312?B?UmNQS045MVJLWVQzTGlBb29QMzE4YTJsNTdrRkNWcDV5REhXSWxvWjVRcDBi?=
 =?gb2312?B?UlJpZWthZStsWnYyQjM5UzdrQVFtRGhpZVJpUklCSkRCaCtrcENSNlozeDRl?=
 =?gb2312?B?RWNZeDBISGlaQmJmeG5ZR3pITzRxREdUR05GWHZtTEtzYTJYSmRDUTBwdUhj?=
 =?gb2312?B?anFWZFZaVXFZMmlSZmxHZnZPa2Nzb3hIT1puYUUrOUhnbUREVTZiWnY1NVRO?=
 =?gb2312?B?dDVtblFhTXIvK1BHc0k0dWRZV2V4VmZMMk1ZR0xxSWIvQnhISFBSMHJmWWlk?=
 =?gb2312?B?eDJJZ3AwcWJMVFdQaUphMkkwNThIRTRNK0Y0M1hlN2pqaHZpeTg1R3VDT0pv?=
 =?gb2312?B?YXBTZVEyZEZCQ2RvMGFGRGJIMjd0TkRORlBOQk1Pekk5aWVpcmFjSWdTVFlI?=
 =?gb2312?B?RzFzMzJpbWNqUEltVnBZaDNhTHAzKzcyZnpDbWlRREhIZjBkZVI3N0NueTNH?=
 =?gb2312?B?ODU3MDJOVUM2WE5zc2ZUMjdXMHFIazBDaXV6bzdJZ1JWNTVZNmdnV3NMQytX?=
 =?gb2312?B?UG1SSWVNUm9Qdmw3REFyS1YyM3djRGorNDNTQU1ZakhhY1lLOGNaNVBNMzBn?=
 =?gb2312?B?cFVNaEk1dG5oSnNTbGViOUZhNmlkTDZIMnFZcm9nY0RqNjJwYlhXQ1kyYnNm?=
 =?gb2312?B?bDlyeFg4K3huQ0NreHEvVVJxQXNyZnNuelI4VExOUDZLS0pISWpVUkV6c2dG?=
 =?gb2312?B?cFFZbWlnSFJjcnhxaWlCYUdURXF6TExxOFRUSnhwWE1RWCtCUXk1ekZOMlJy?=
 =?gb2312?B?VFdveFRBNW5vT2tnbFZlNnJDRHcyNmlqeFFlMm5lQ216QjY1T3FzeWpJYjAz?=
 =?gb2312?B?OXkrejE0UUg3Ky9pK2ZEaXc3NE1NaTdDbzdrc1JtdEhqMFZtL2V1QWlaTDJS?=
 =?gb2312?B?MHhVN0dCNE8xcUxtRU5oOEEwdm1xL3dpWFQ1a2ZDWXRhZ2FXUnRhelBaZHNp?=
 =?gb2312?B?MmdTbGNFWnlsOFZwUEN5cXZXU21QVjAwRkhTdXJaVHhNdVhLWm1pU3hMTlQ0?=
 =?gb2312?B?QkQ1UXVUODB2OGxTZGhyc1oxTUVSKzZ3anpqTHVhYXZoNFRBNUdZVVdyeC95?=
 =?gb2312?Q?3DVw=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633404de-056e-47f7-94df-08dc1e22d3d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 03:56:51.1154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkXyoGb207m7CX/PykFQt8I/x7mvfhqUunzIs1nrBoFIPNVrhqXKxL7zl932+TM4VV7EwLyNUfnjS9N49C86aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3901
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

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogR2FvIFhpYW5nIDxoc2lhbmdrYW9A
bGludXguYWxpYmFiYS5jb20+DQo+ILeiy83KsbzkOiAyMDI0xOox1MIyNsjVIDExOjUwDQo+IMrV
vP7IyzogQ2h1bmhhaSBHdW8gPGd1b2NodW5oYWlAdml2by5jb20+OyB4aWFuZ0BrZXJuZWwub3Jn
DQo+ILOty806IGNoYW9Aa2VybmVsLm9yZzsgaHV5dWUyQGNvb2xwYWQuY29tOyBqZWZmbGV4dUBs
aW51eC5hbGliYWJhLmNvbTsNCj4gbGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw0KPiDW98zi
OiBSZTogW1BBVENIIHYyXSBlcm9mczogcmVsYXhlZCB0ZW1wb3JhcnkgYnVmZmVycyBhbGxvY2F0
aW9uIG9uIHJlYWRhaGVhZA0KPiANCj4gW8Tjzaizo7K7u+HK1bW9wLTX1CBoc2lhbmdrYW9AbGlu
dXguYWxpYmFiYS5jb20gtcS159fT08q8/qGjx+u3w87KDQo+IGh0dHBzOi8vYWthLm1zL0xlYXJu
QWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbqOs0tTBy73i1eLSu7XjzqrKssO0utzW2NKqXQ0KPiAN
Cj4gT24gMjAyNC8xLzI2IDExOjQyLCBDaHVuaGFpIEd1byB3cm90ZToNCj4gPiBPbiAyMDI0LzEv
MjYgMTA6NDcsIEdhbyBYaWFuZyB3cm90ZToNCj4gPj4gW8Tjzaizo7K7u+HK1bW9wLTX1CBoc2lh
bmdrYW9AbGludXguYWxpYmFiYS5jb20gtcS159fT08q8/qGjx+u3w87KDQo+ID4+IGh0dHBzOi8v
YWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbqOs0tTBy73i1eLSu7XjzqrKssO0
utzW2A0KPiDSql0NCj4gPj4NCj4gPj4gT24gMjAyNC8xLzI2IDEwOjQxLCBDaHVuaGFpIEd1byB3
cm90ZToNCj4gPj4+IE9uIDIwMjQvMS8yMiAxNTo0MiwgQ2h1bmhhaSBHdW8gd3JvdGU6DQo+ID4+
Pj4gT24gMjAyNC8xLzIyIDEyOjM3LCBHYW8gWGlhbmcgd3JvdGU6DQo+ID4+Pj4+IFvE482os6Oy
u7vhytW1vcC019QgaHNpYW5na2FvQGxpbnV4LmFsaWJhYmEuY29tILXEtefX09PKvP6ho8frt8MN
Cj4gzsoNCj4gPj4+Pj4gaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0
aW9uo6zS1MHLveLV4tK7tePOqsqyw7QNCj4gutzW2NKqXQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBPbiAy
MDI0LzEvMjIgMTE6NDksIENodW5oYWkgR3VvIHdyb3RlOg0KPiA+Pj4+Pj4gT24gMjAyNC8xLzIy
IDEwOjA3LCBHYW8gWGlhbmcgd3JvdGU6DQo+ID4+Pj4+Pj4gW8Tjzaizo7K7u+HK1bW9wLTX1CBo
c2lhbmdrYW9AbGludXguYWxpYmFiYS5jb20gtcS159fT08q8/qGjx+sNCj4gt8POyg0KPiA+Pj4+
Pj4+IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbqOs0tTBy73i
1eLSu7XjzqrKsg0KPiDDtLrc1tjSql0NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IE9uIDIwMjQvMS8y
MCAyMjo1NSwgQ2h1bmhhaSBHdW8gd3JvdGU6DQo+ID4+Pj4+Pj4+IEV2ZW4gd2l0aCBpbnBsYWNl
IGRlY29tcHJlc3Npb24sIHNvbWV0aW1lcyBleHRyYSB0ZW1wb3JhcnkNCj4gPj4+Pj4+Pj4gYnVm
ZmVycyBhcmUgc3RpbGwgbmVlZGVkIGZvciBkZWNvbXByZXNzaW9uLiAgSW4gbG93LW1lbW9yeQ0K
PiA+Pj4+Pj4+PiBzY2VuYXJpb3MsIGl0IHdvdWxkIGJlIGJldHRlciB0byB0cnkgdG8gYWxsb2Nh
dGUgd2l0aA0KPiA+Pj4+Pj4+PiBHRlBfTk9XQUlUIG9uIHJlYWRhaGVhZCBmaXJzdC4gVGhhdCBj
YW4gaGVscCByZWR1Y2UgdGhlIHRpbWUgc3BlbnQNCj4gb24gcGFnZSBhbGxvY2F0aW9uIHVuZGVy
IG1lbW9yeSBwcmVzc3VyZS4NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gVGhlcmUgaXMgYW4gYXZl
cmFnZSByZWR1Y3Rpb24gb2YgMjElIGluIHBhZ2UgYWxsb2NhdGlvbiB0aW1lDQo+ID4+Pj4+Pj4+
IHVuZGVyDQo+ID4+Pj4+Pj4gSXQgd291bGQgYmUgYmV0dGVyIHRvIGFkZCBhIHRhYmxlIHRvIHNo
b3cgdGhlIGFic29sdXRlIG51bWJlcnMNCj4gPj4+Pj4+PiB0b28gKGxpa2Ugd2hhdCB5b3UgZGlk
IGluIHRoZSBnbG9iYWwgcG9vbCBjb21taXQuKSAgSWYgaXQncw0KPiA+Pj4+Pj4+IHBvc3NpYmxl
LCB0aGVyZSBpcyBubyBuZWVkIHRvIHNlbmQgYSB1cGRhdGUgdmVyc2lvbiBmb3IgdGhpcywNCj4g
Pj4+Pj4+PiBqdXN0IHJlcGx5IHRoZSB1cGRhdGVkIGNvbW1pdCBtZXNzYWdlIGFuZCBJIHdpbGwg
dXBkYXRlIHRoZSBjb21taXQNCj4gbWFudWFsbHkuDQo+ID4+Pj4+PiBUaGUgdGFibGUgYmVsb3cg
c2hvd3MgZGV0YWlsZWQgbnVtYmVycy4gVGhlIHJlZHVjdGlvbiBJIG1lbnRpb25lZA0KPiA+Pj4+
Pj4gYmVmb3JlIHdhcyBub3QgYWNjdXJhdGUgZW5vdWdoLiBQbGVhc2UgaGVscCBjb3JyZWN0IHRo
ZQ0KPiA+Pj4+Pj4gaW1wcm92ZW1lbnQgZnJvbSAyMSUgdG8gMjAuMjElLg0KPiA+Pj4+Pj4NCj4g
Pj4+Pj4+DQo+ID4+Pj4+PiArLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0t
LS0tLS0tLS0rLS0tLS0tLS0tKw0KPiA+Pj4+Pj4gfCAgICAgICAgICAgICAgfCB3L28gR0ZQX05P
V0FJVCB8IHcvIEdGUF9OT1dBSVQgfCAgZGlmZiAgIHwNCj4gPj4+Pj4+ICstLS0tLS0tLS0tLS0t
LSstLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0rDQo+ID4+Pj4+PiB8
IEF2ZXJhZ2UgKG1zKSB8ICAgICAzMzY0ICAgICAgIHwgICAgICAyNjg0ICAgICB8IC0yMC4yMSUg
fA0KPiA+Pj4+Pj4gKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0tKy0tLS0tLS0tLSsNCj4gPj4+Pj4gRGlkIGl0IHRlc3Qgd2l0aG91dCB0aGUgMTZrIHNsaWRp
bmcgd2luZG93IGNoYW5nZT8NCj4gPj4+Pj4gaHR0cHM6Ly9hcGMwMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGDQo+ID4+Pj4+IGxvcmUua2VybmVs
Lm9yZyUyRmxpbnV4LWVyb2ZzJTJGNjk3MTFkNTUtZjdhMi00MjBiLTliYTgtZmEyOTIxZjY2YQ0K
PiA+Pj4+Pg0KPiA0YyU0MHZpdm8uY29tJmRhdGE9MDUlN0MwMiU3Q2d1b2NodW5oYWklNDB2aXZv
LmNvbSU3Q2VhZGIyZWIzZDA0DQo+IDc0DQo+ID4+Pj4+DQo+IGIzYjkwNTcwOGRjMWUyMWQ4YTAl
N0M5MjNlNDJkYzQ4ZDU0Y2JlYjU4MjFhNzk3YTY0MTJlZCU3QzAlN0MwJQ0KPiA3QzYNCj4gPj4+
Pj4NCj4gMzg0MTgzNzc5Nzg5MTg5ODYlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lN
QzR3TGpBd01EQWkNCj4gTENKUQ0KPiA+Pj4+Pg0KPiBJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhh
V3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJnNkYXRhPUkNCj4gPj4+Pj4gUXpjeGJO
aEY4WmJHMHpDbnhBUVRiYTZDM0RVNnRVQzdielphSVNMWUpFJTNEJnJlc2VydmVkPTANCj4gPj4+
PiBUaGUgcmVzdWx0IGlzIHRlc3RlZCB3aXRoIDY0ayBzbGlkaW5nIHdpbmRvdyBjaGFuZ2UuDQo+
ID4+Pj4NCj4gPj4+Pj4gQ291bGQgeW91IGJlbmNobWFyayB0aGVzZSB0d28gb3B0aW1pemF0aW9u
cyB0b2dldGhlciB0byBzaG93IHRoZQ0KPiA+Pj4+PiBleHRyZW1lIG9wdGltaXplZCBjYXNlIHdp
dGhvdXQgYSBnbG9iYWwgcG9vbD8NCj4gPj4+Pj4gV2l0aCBhIG5ldyB0YWJsZSBpZiBwb3NzaWJs
ZT8gSSB3aWxsIGFkZCB0aGlzIHRvIHRoZSBjb21taXQNCj4gPj4+Pj4gbWVzc2FnZSB0b28uDQo+
ID4+Pj4gT0suIEkgd2lsbCByZXBseSB0byB0aGlzIGVtYWlsIHdoZW4gdGhlIGJlbmNobWFyayBp
cyBmaW5pc2hlZC4NCj4gPj4+IFRoZSBiZW5jaG1hcmsgaGFzIGJlZW4gY29tcGxldGVkIGFuZCB0
aGUgdGFibGUgYmVsb3cgc2hvd3MgdGhhdA0KPiA+Pj4gdGhlcmUgaXMgYW4gYXZlcmFnZSA1Mi4x
NCUgcmVkdWN0aW9uIGluIHBhZ2UgYWxsb2NhdGlvbiB0aW1lIHdpdGgNCj4gPj4+IHRoZXNlIHR3
byBvcHRpbWl6YXRpb25zLg0KPiA+Pj4NCj4gPj4+ICstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0t
LS0tLS0tKy0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0rIHwgfCA2NGsNCj4gPj4+IHdpbmRvdyB8
IDE2ayB3aW5kb3cgfCB8IHwgfCB3L28gR0ZQX05PV0FJVCB8IHcvIEdGUF9OT1dBSVQgfCBkaWZm
IHwNCj4gPj4+ICstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0t
LSstLS0tLS0tLS0rIHwgQXZlcmFnDQo+ID4+PiArLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tKyB8IGUNCj4gPj4+IChtcykgfCAzMzY0IHwg
MTYxMCB8IC01Mi4xNCUgfA0KPiA+Pj4gKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0r
LS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLSsNCj4gPj4+DQo+ID4+PiBUYWJsZSBiZWxvdyBzdW1t
YXJpemVzIHRoZSByZXN1bHRzIG9mIHRoZXNlIHRocmVlIGJlbmNobWFya3MuDQo+ID4+Pg0KPiA+
Pj4gKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKw0KPiA+Pj4gfCAgICAgICAgICAgICAgfCAgIDY0
ayB3aW5kb3cgICB8ICAgMTZrIHdpbmRvdyAgIHwgICA2NGsgd2luZG93ICB8IDE2aw0KPiA+Pj4g
d2luZG93ICB8DQo+ID4+PiB8ICAgICAgICAgICAgICB8IHcvbyBHRlBfTk9XQUlUIHwgdy9vIEdG
UF9OT1dBSVQgfCB3LyBHRlBfTk9XQUlUIHwNCj4gPj4+IHwgdy8NCj4gPj4+IEdGUF9OT1dBSVQg
fA0KPiA+Pj4gKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0t
LSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKw0KPiA+Pj4gfCBBdmVyYWdlIChtcykg
fCAgICAgMzM2NCAgICAgICB8ICAgICAgMjA3OSAgICAgIHwgICAgICAyNjg0IHwNCj4gPj4+IDE2
MTAgICAgIHwNCj4gPj4+ICstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSsNCj4gPj4+IHwgICAgIGRp
ZmYgICAgIHwgICAgICAgICAgICAgICAgfCAgICAgLTM4LjE5JSAgICB8ICAgICAtMjAuODElIHwN
Cj4gPj4+IC01Mi4xNCUgICB8DQo+ID4+PiArLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0t
LSstLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rDQo+ID4+
DQo+ID4+IFRoZSB0YWJsZXMgc2hvd3MgaW4gYSBtZXNzLCBjb3VsZCB5b3UganVzdCBsaXN0IHRo
ZSBudW1iZXJzIHNvIEkNCj4gPj4gY291bGQgcmVmaW5lIHRoaXM/DQo+ID4NCj4gPiBTb3JyeSB0
aGF0IHRoZXJlIG1pZ2h0IGJlIHNvbWUgaXNzdWVzIHdpdGggbXkgZW1haWwgY2xpZW50LiBIZXJl
IGFyZQ0KPiA+IHRoZSBudW1lcmljYWwgcmVzdWx0cyBiZWxvdy4NCj4gPiAgICAgICA2NGsgd2lu
ZG93IHcvbyBHRlBfTk9XQUlUIDogMzM2NA0KPiA+ICAgICAgIDE2ayB3aW5kb3cgdy9vIEdGUF9O
T1dBSVQgOiAyMDc5LCBkaWZmOiAtMzguMTklDQo+ID4gICAgICAgNjRrIHdpbmRvdyB3LyAgR0ZQ
X05PV0FJVCA6IDI2ODQsIGRpZmY6IC0yMC44MSUNCj4gPiAgICAgICAxNmsgd2luZG93IHcvICBH
RlBfTk9XQUlUIDogMTYxMCwgZGlmZjogLTUyLjE0JQ0KPiA+DQo+ID4gSW1hZ2VzIHNpemUgY29t
cGFyaXNpb246DQo+ID4gICAgICAgNjRrOiA5MTE3MDQ0IEtCDQo+ID4gICAgICAgMTZrOiA5MTEz
MDk2IEtCDQo+IA0KPiBUaGF0IGlzIHdpdGggNGsgcGNsdXN0ZXIsIHllcz8gIEkgZ3Vlc3MgdGhl
IG92ZXJhbGwgaW1hZ2Ugc2l6ZSB3b24ndCBoYXZlIGdyZWF0DQo+IGltcGFjdHMsIGJ1dCBpdCBz
ZWVtcyBldmVuIGdldHRpbmcgc21hbGxlci4gOi0pDQoNClllcywgdGhpcyBpcyB3aXRoIDRrIHBj
bHVzdGVyLg0KDQpUaGFua3MsDQoNCj4gDQo+IEkgdGhpbmsgdGhpcyBvcHRpbWl6YXRpb24gd291
bGQgYmUgaGVscGZ1bCB0byBldmVyeW9uZSB3aXRob3V0IGFueSBleHRyYSBtZW1vcnkNCj4gcmVz
ZXJ2YXRpb24gKHdoaWNoIHdpbGwgYmUgZ29vZCB0b28gZm9yIG11Y2ggbXVjaCBsb3ctZW5kZWQg
ZGV2aWNlcyksIGxldCBtZQ0KPiByZXZpc2UgdGhlIGNvbW1pdCBmb3IgZm9ybWFsIHN1Ym1pc3Np
b24uLg0KPiANCj4gVGhhbmtzLA0KPiBHYW8gWGlhbmcNCj4gDQo+ID4NCj4gPiBUaGFua3MsDQo+
ID4NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+PiBHYW8gWGlhbmcNCj4gPg0KPiA+DQo=
