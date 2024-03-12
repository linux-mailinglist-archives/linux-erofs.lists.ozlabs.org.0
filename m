Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8EF879183
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 10:57:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tv8Fn36vLz3dLl
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 20:57:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=manchester.ac.uk (client-ip=2a01:111:f403:261b::701; helo=gbr01-cwx-obe.outbound.protection.outlook.com; envelope-from=gael.donval@manchester.ac.uk; receiver=lists.ozlabs.org)
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:261b::701])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tv8Fh4sKTz3cSL
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Mar 2024 20:57:24 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4RkV6yIhcSg/RWQLoTUz5m1g+eYF1kqysFGd8OakbM8mI8VwPoEEjh2udS5WnPk+Ha0HbSvk0ekyADRXT8Hmp81ibSahJ8TdGAqgrFOxQHM7K/Tx4uY87k+m1fFLcWTIABgOiXEEBm09cXdbu5IJcMXs4/ky7mxRC51SH6Sx/jfR+6wakbTijhqTP0UWjdaKrb3Lcu9oRkJWXehyAv0PNRfCJXGc0rIO8RKyL5uWQREpT6O9upqxnf7WTrHfKcY8nvNpTmVpfEhizQIwcpM14ExXTUX4WnKFFheOO5DK/IiYR13sqLD2l03o9/hevoVh4dlaNeLRDgVHp5vmUv8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SROXXBGcrxcmz6Mlq1F5fzSqa7C8wreIo+DZ2J+Owno=;
 b=TDSLtd6Z9zIx4ZauVSe2oe4W6A8bHPGGngA6EsBC/K1zJ47m1mHQFqglBAzIseWKC9VYXpbVLtDsFrucFeXlhTXvwfD+H8AC7HQeNCzz9Jqat04akGkjY7gVQWW9bBGOogPwuHnmm/F6soYW0d3J2kpC01V1UvENcvVrm/BW5AU98px1PpicfNHtNY2nUl2rkl/qR+158XK+UkGV7pJ83D1OZQjrNUVAuhjRwFoEXedWEZHDJgynux9i1WhM1C04vP8IUbvjEF4GVJWpD5E3zbxaxBEq0AkZ+2l7KZyzRc6gmjkGPgvAvuIhYzYeQ/74d0MgoxtRMZ9wA0CtRYlWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=manchester.ac.uk; dmarc=pass action=none
 header.from=manchester.ac.uk; dkim=pass header.d=manchester.ac.uk; arc=none
Received: from LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cb::14)
 by LO2P265MB2975.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:173::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:57:03 +0000
Received: from LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3e09:1ac4:faf1:bd15]) by LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3e09:1ac4:faf1:bd15%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 09:57:03 +0000
From: Gael Donval <gael.donval@manchester.ac.uk>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: mkfs.erofs fails (failed to build shared xattrs, err 61)
Thread-Topic: mkfs.erofs fails (failed to build shared xattrs, err 61)
Thread-Index: AQHadGOiPlVwdje8XEOnbl0bbKegWQ==
Date: Tue, 12 Mar 2024 09:57:03 +0000
Message-ID: <4abed942399fb29933f0fa85cc55d3d795ae8bcd.camel@manchester.ac.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=manchester.ac.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB6406:EE_|LO2P265MB2975:EE_
x-ms-office365-filtering-correlation-id: 759558a5-b3b2-46f2-13a2-08dc427ac4ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  UnwYgeviOdMJexDMKkXfZ11LUz20hSiL/mbby+C2n7ZbmINV+KbQ9xLug07S0hZwN5wmTdt32wJq9wPR2lqZeDa2PT6gI12iU2/CGXGczBCB4RKzEZkWzlruMvenS+RWsuGFBMqraXojHzXKbm4JsGBTW0rw2cIRP0nK9Qo2p95pHZkUUsdKINIpfnJpHhCuJQWEFL5Qm7z1ICnNqC5csb8Fae9awbC+HlNgwWWDajfRGzxkUDkEvKFyiBbQ6dKKqk7zIaRPlszP0uJjvFjxc8X/k/cd1efYiTMAb98T6BvYuTivoIbbCYuImClqeKHh918R/FasJs9ikRyeEDwLq62qhEvi0bQv/D3l5hrH76LEKswE/X+tJSJ6OT2hUJ1SQdWj9y84D9Gy09mxPULFboFnHErXAsxqegX6CZLeHn0JjrMkpo7btwkaeqZvBPE2PIXKw0GfBl7ce0TCgWAPGLrlm8ODRpeCksZW1u2mwk68Pg1nLeAKPT3NCZNrwC2AxjbZfJkF+bZ9EbDZxJ4/PUrzISxSP3PuwTtEdUIWi2oOD0E6ddGMbwbQ2iE1/5ujJRw6sf5bKFXAqorkcoFrtMNWwuMmvkkdrOkDIdHLDTww53qnffkhFkP/jhNjOAPCD6wTrwQByAi1XaaR89PQR8KSs/H7CVOkcWIo0tQUVcTUiC4eRgZqPSjFAEKg5pFnjGhojs+BFa67s8euPYFPNaLAHDfX0aHmUkyYEpnH2IY=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?b2VyK3I5Uzl4WFowVDk5QU5jNDVEYVk2SUNsMlUwOHpNaFlRMmJScSs3MHYy?=
 =?utf-8?B?eGFXVGxCZEpmRHZjcXNuTGhLcTFtTFl4ZG9pVFBWZFI3MXY2K2ZTYzFGRGs5?=
 =?utf-8?B?MVkwRUNmSVZSUmgyajBVdnhSUUkvcHR2WSttZldhVXhidEhjY2JDNFVud3g1?=
 =?utf-8?B?ejVpSElUVmFydUhiOC9UdFloZE1ZVm5sZmVtcWxQa3k2YkQxalhubDdkeHVH?=
 =?utf-8?B?eXF6T2FHWE9CUFZtRnNWZ1pUVytYWmdBUElpVnVDMXFFbTdRNnd3L01nV0JK?=
 =?utf-8?B?K1hnSTUvbnJzS3J1OWlIdE5teEtpaG16RzdWRWM2bi95dC9kRWJLa2Y2OG4w?=
 =?utf-8?B?T1RReHBMbUJHaXMyOGVabUdtS2wrUS9tUnZ5b2syUVhjaEU4bjNDb1pPUjhv?=
 =?utf-8?B?MTNMdm5neG91RndEdjZic25sZGYzb1d2OTJYRVRnYUFiRWxBdXBrOUlBNVdi?=
 =?utf-8?B?MlFtcTlQVEFxU2pEVlZLL05xc1p4aVpKaG9XbEJZc0h5aTB5emR5c1hLZXJ2?=
 =?utf-8?B?YzEySzZFUlpPTUdKR0NUZTFZcStNZ3A3bmUySURTSmNUSkc1UzJYeklRU1J3?=
 =?utf-8?B?ZU1rZlRPNFExdC8rSDA2dkRaUWRBOWZMV3BpZ2NVVmd1R241UWI4TTU2YTdX?=
 =?utf-8?B?cExiZWgrR2JNUXFHVHBZVUR2Sndad2RqaDZvSThsNnZrdDBCZVNBakVKMVlI?=
 =?utf-8?B?L3RxamNudVZtTjQwZGk1L00xUzFOZzZqMGxqMmZIeWpuTUtsVm03U3RXeE43?=
 =?utf-8?B?azhLNmw3ZU1tWkdxVktKMVFLZkQ0WmJqRXFiZjFxTVJkVFVBTmZzNnJvaTl5?=
 =?utf-8?B?Y1pscWV6YlBCSXdNdjFCb2FDRkxQTUtRUnJHUE9QL2JhQkRCNTB1QlhBaEtX?=
 =?utf-8?B?WHhNb3BlZ3hGSzlWSkdjZ3k4WDRMQzJVVHpDRzUxYnREbmdIM0lsVzFTd1dH?=
 =?utf-8?B?WitDMWhMcU9sR2IzTnorRnBvc01xaFpmclNEcFFvdUljbE1RY2J4M0xacm9m?=
 =?utf-8?B?bm9BQmdRcXFhZ0lSMjhVT0FMTFBjVG0xZmRDZGFZK2dYWFVVcEpFS0VYVmxD?=
 =?utf-8?B?Y0NGanAzblpuZ3FaZGhZMFBrVkF3RDZYejFRUjFHdFVYZ2YyQzMzQ3JQdEla?=
 =?utf-8?B?STRDZFBUWDRXOFV5ZmdoRlhja05GNXVSbFdIVFJsTDB5MlFJVlVLbjBNMUgy?=
 =?utf-8?B?b1QzeWI2U3ZSNWJ2LzU4ZTZGa0pvdlVBK2ZlY0hBazdUaHhHVmFtWmdmZ1RI?=
 =?utf-8?B?VTIwV1lPR3lpb1VTL2cyNUN2Y3NEYSsrZDZQSmlMQzlaeDFrREtqeENMSFFr?=
 =?utf-8?B?WkxESWJVTGJ2R0ZCOTB2azhEa0FnM2lqc2JTWVlpVkpobm5MeUVJSWJ1Z3hs?=
 =?utf-8?B?Q0pMV1Q1Q3BXQ3FvL1RnTW1Gb3pQdVpoL1lKSlNIMUxIeGhxUUQybDcyQ0NI?=
 =?utf-8?B?L3VobXdNMVM0ZEk0ZVl1TFdnOC8wamlkdzE3T0MwUksvdWdERHBiMHRsMXl1?=
 =?utf-8?B?TkhsTUJudUtBMXpOTjhCb2NYZkZRUXErb0xEWEo0NzBGV0doOUM5MzlsU1Fq?=
 =?utf-8?B?UzZPTFR3dS9WQkRhbWdheFFIWWlQNlk5N1BRRGZqNmczeUwxRHhGVzhpK0RE?=
 =?utf-8?B?Q1JoS3hsWlI5TFBTVWtPd0dhcEUzQlhKaEJPaHE0SUpoU0VlbjRKMEVJVEMw?=
 =?utf-8?B?cUM5TkRmSmxlR0ZRc3RkTEtFNGFVNTNQWG1yVGlsTDg1dXFUaFF3WVBMZEhV?=
 =?utf-8?B?S0hBblN1bHIyWXZ1SWlWbWw1bE45STh3WVFjNnZVeE1GTk1rc09KYllSVk9h?=
 =?utf-8?B?RnNJdEE5eHFsU2dXU0tnazIwQjVCMWpvN01HRGY2c0pIL2gyYW5iVE10N2Rq?=
 =?utf-8?B?ZHUyT1VrZlZFWkY3dWtZMVFpbThVQWJVdUFpMUhTaW9Vdk1nUHVmNkJScW03?=
 =?utf-8?B?WVdFQ1FoMHh1S05HSHV0SGVRMzVmWHlSbnk4bko1K3lYWHBKcmxGQlJRd3Zi?=
 =?utf-8?B?OEtsSEREejg3ZjVDK0c0R0dpczV6Uy9CdGpUUmRXaXJWNWcwc0FrRWgyb0Q5?=
 =?utf-8?B?RkUvZjY1cC8yY2p6U2N1RzkzSG1OTGlQR24wTVROSjF2dFZqSEVWeU9nQXB3?=
 =?utf-8?B?eFdEVTlDZGNoVldFeU54aEFrbW9vSVdUZkU2dHJwODErV0tnWU5QV0JjV1pU?=
 =?utf-8?Q?8JaHg5zGoAQnzq47aAmX4js=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72ED86F6967C3042A9501EAAFC519E0A@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: manchester.ac.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 759558a5-b3b2-46f2-13a2-08dc427ac4ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 09:57:03.2407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c152cb07-614e-4abb-818a-f035cfa91a77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QhJ0C2/r16e4ZfjQJU+cwfMttG4Gnf/ilwcmJa7KnAhaELGmAoN9KhVb/XU/RUqYJTCveK3/jheS1GXDNJtyrSD8SqncaU7dqKyiiJmDzWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2975
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

RGVhciBsaXN0LA0KDQogICAkIG1rZGlyIGZvbyAmJiB0b3VjaCBmb28vYmFyICYmIG1rZnMuZXJv
ZnMgZm9vLmVyb2ZzLmltZyBmb28NCiAgIA0KICAgbWtmcy5lcm9mcyAxLjcuMQ0KICAgPEU+IGVy
b2ZzOiBmYWlsZWQgdG8gYnVpbGQgc2hhcmVkIHhhdHRyczogW0Vycm9yIDYxXSBObyBkYXRhIGF2
YWlsYWJsZQ0KICAgPEU+IGVyb2ZzOiAJQ291bGQgbm90IGZvcm1hdCB0aGUgZGV2aWNlIDogW0Vy
cm9yIDYxXSBObyBkYXRhIGF2YWlsYWJsZQ0KICAgDQpUaGF0IGlzIGF0IGEgbG9jYXRpb24gYmFj
a2VkIGJ5IEJUUkZTIChidHJmcy1wcm9ncyB2Ni43LjEpIG9uIGtlcm5lbCA2LjguMC4NCg0KSWYg
SSB1c2UgYSBUTVBGUy1zdXBwb3J0ZWQgZm9sZGVyIGluc3RlYWQgYWxsIGdvZXMgd2VsbC4NCg0K
DQpPZiBjb3Vyc2UgKE5CICIteC0xIiksDQoNCiAgICQgbWtkaXIgZm9vICYmIHRvdWNoIGZvby9i
YXIgJiYgbWtmcy5lcm9mcyAteC0xIGZvby5lcm9mcy5pbWcgZm9vDQoNCmFsc28gd29ya3MgYnV0
IGlzIG5vdCBob3cgbWtmcy5lcm9mcyBpcyBtZWFudCB0byB3b3JrIGluIHRoZSBnZW5lcmFsIGNh
c2UuDQoNCktpbmQgcmVnYXJkcywNCkdhw6tsDQo=
