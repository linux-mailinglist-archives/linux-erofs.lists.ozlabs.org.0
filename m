Return-Path: <linux-erofs+bounces-3176-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FttKsgQzmmnkgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3176-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:46:32 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A6F384A6E
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:46:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmXSh3lLVz2ySk;
	Thu, 02 Apr 2026 17:46:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775112388;
	cv=pass; b=aKqFrwnbg3+MnsjYE5VIVI9/Q7eFjdx30vOI/ou+0AxLnTiCZ/fI2u4OqzCUItSD0bQqdWCCwCBbf4VYKVsitwMXpwajaz13r4dgweXQqG0i8o9ga0DN8O8wKmirSdYSPlZ64vwUl4Znjg4AEFVNNsJEdMXAm1Amb8tjj0frcIOER9lQGuyXB4N3GBXhNkD0L5yz2kvoGev1CieOFxZN6NUzLCx7Rf6yWe5TC+wOG4N1wXsJ5VSJE3ySbIRRAtIf/+InYCZh2HxRRIQVAIZ6Dvpd5oxk3yc1OAVrJkb8teyxVdZFLVIXPcCWFGvc41adWv3cQYxwVYXNNwAo6Ob5gw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775112388; c=relaxed/relaxed;
	bh=IS6qz+xqjizV0dHZTmh6gRGwUo01kSxSh0xCrNtu9M4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M+vx8iPhtmgA+mSRBMBiaWRg5I9Vq/kZrMIfWj+IaDzEGDCj4Vq5w4t8k6awcN8cmNtSoxA4PTd1OS69xUTqZtryv+pM6zsocmq716/UELxQAcd7gsA0/FWbfvfiZjwoV5vt3h8W1RPYHpkQpIM0naT8+Og+MVylNq19/sErVSg66t0C9qDrzpwuZoQfCwdnSe8SZt7i59UzwFWRO6MrABE0uxkn3eWChsD763kJp3QLgcMyNxvzIuCPWxXUm8mQLCdOyYkBWfNnrek9CVJecY466ZcJnrgVd9Jyz31wLBYoDRy+ZAN+n58U1/q01W953JJiIwhKfJeFoCWULL5J2Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=kTPGP9cv; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=kTPGP9cv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmXSg1dRjz2xln
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 17:46:26 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8svE+HfSTTiRXOerhigFZ/1t6NyE9cgqTrs7Yib8kPOZP2OdfdmQWOOC5ekybJaZx9TLcXwINxDnRlNcmiuxUQXpOqOJlFn2YfCsAvZ2xUudYB3/YyuLa4o0pBs6MUEJgoq+QSvORANCw0+Rx4FjrmSzDOGu13pLuQZ4VQtbOp4/r7OuuxdXkZ9fEQXDf1v8wq4+PxiAL87gpyh59HvnDEl+5Iatl/5bK7oeF896KXdmozpIwiiNlyn0VCn70TZ0Qrya5fFuAZZXSgvc/ZscmEwQaF4tlCJDNarDzWJn4hwGAZ1ToYsaqMIx9xWlRJpSIM/g31KS8moM1SMOeeMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS6qz+xqjizV0dHZTmh6gRGwUo01kSxSh0xCrNtu9M4=;
 b=yTkt65dFiY3XjoPi832n0A1hO6vLyvmYLcIvcroU6OldINTTCF2OTVRV5SFSlvnBunUgZaCgbZqQ2RmouqZHuL8dePsZxYFYPo6pNEFfI6T8cpI23/WzE7Y2D9NLKPD19KO2O9Vy7QQBS9nUqK0cIrQ/yOSAAC8TV1U/okZK8MkKJQ1wRcd7k92ZlDQg71r13DbPSlykLcsZM9X3exU3kD6np/BgIR9xtHWaao+Cd9lOUTW6ArWPUKFvAxXIDlPGrMcyRFe3g91Df3wiRCMhqfnGGxdWthLfwttAHN9y2fDglWRzFrCac5Moq680BsikrPKcV0rzl0EH+27rA47ltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS6qz+xqjizV0dHZTmh6gRGwUo01kSxSh0xCrNtu9M4=;
 b=kTPGP9cv1/JEpn7cGw3T3COcyu2OdwlHzUxTB4GaXmie+dDhrY7ty/0NvQAtC6RbPlKn7TxQzC9d6r0UIrwnEG4u96aZ2hIYnqMtyUIEo8Peb+eyraGWLrP/6dxeJcw726UxXhdjZhUP5CLnMIabSqh9uAJGW9msjZ/udUD2hRHCGb6AJn/qDk7jM2W30a0FWNFmIBBYZGQkFRnHmNPZpKD62F94A55zBjgvGybp6TJQC7bfGYZ4YaNQAU8XP1TsrktqO5D/sfJT3eZKdXwKxNgdUcyihORuT0ZIAhWxqizyAaIhHRlr7XVmoLXzAwOeibfupOugL3bOSBtZqhNKig==
Received: from SE3PR06MB8257.apcprd06.prod.outlook.com (2603:1096:101:2ee::17)
 by SEYPR06MB6506.apcprd06.prod.outlook.com (2603:1096:101:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 06:46:00 +0000
Received: from SE3PR06MB8257.apcprd06.prod.outlook.com
 ([fe80::881c:180e:661d:eb93]) by SE3PR06MB8257.apcprd06.prod.outlook.com
 ([fe80::881c:180e:661d:eb93%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 06:46:00 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Christian
 Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] erofs: verify metadata accesses for file-backed mounts
Thread-Topic: [PATCH] erofs: verify metadata accesses for file-backed mounts
Thread-Index: AQHcv+vXZNonbdE9ZUq2OgcBOLC0fbXLWOCA
Date: Thu, 2 Apr 2026 06:46:00 +0000
Message-ID: <9c3971ef-3868-44a6-8feb-847222d8d575@vivo.com>
References: <20260330022031.2107239-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20260330022031.2107239-1-hsiangkao@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8257:EE_|SEYPR06MB6506:EE_
x-ms-office365-filtering-correlation-id: 78254ad5-272b-45be-5c66-08de9083806d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 +/Z5u4pofBDCZvt2CiuA+pHFytMpwXgI+L9oG2kVLBd7b0uQqoGITznMdG89q7+fO9CkQk1ThOHyDplHFjI0/oFE+2zUhwtioxKlZAoSLdP+T4gnJwAYgPZGZ5D8mEj1h8WOLS8Cja3zmPfs6SYA51WvrwlsO99Scg8sp+KuJrPraapgh6+6kbfQkbcrjoUm/telsFsbhpUZas/c46zkzkhKPJyCNvhLKXWSMiAvD83OhSh2kIr5IoBWWutuoHeG2e35Btv/qN6AqdcyWo0NI4DeVeAPgiPaofcY49GVsSRBumN4ynVA/33buo6490ZTWKsnlxuZObbgfmfUdn4GWcAWmnPWt+2/T1HTy8pwOWuIS8RZDbOF+Y2bS1E0tX+wxyPg0Sxv9oc4NWS8I90yoybPzKnI/ijHDxkLb6a9/8hi8E7GUA3QPDy2zJa+INr8uR/UTZux1kpIh8Nb82NWL4F3dF/KvHhrPqnciS42O2fLPX0aZV1Dl5CS17LJgYuMFQAv++/5EVwRzuJySNDZrg/pSF5taWzFKPkZAX37h6/zUrJgb+IjLa1Pw5WHleyV8JR5fz+pnH+uwLpPR2s+m+sDQe/oqFX3PiXBpJ7DBsrfrOs4BZlMvG+5rR7kXIH/B4ytU9YjXxcXaaL/kFY46/oEBEajiK8ih/JMbSnYYJVwvAUe4BYMJjjcDZgWXSCQh7NQWjD0w1BovSDPXYDlj9QzKec9KMyBvyEk0CKQ3JHsBZ9I7HBjq9nh2yiUFUnD8JXdz43s5DHtD+IUmkoPKbjag/GJlWqxU74IlcwiuKc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR06MB8257.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGhONHQxNnE1c2h0eHBYR3VQOFplWm13VnhCcGYvaXJ3eitZRFFmVEt2aDhk?=
 =?utf-8?B?dHZFd3I3OTBENm55NzV4aXJaU2NFNEdDUUh3bXZKNGtkajA1NVNHT1hrb3Jj?=
 =?utf-8?B?UUJhYUl6U0xFRW81VkY1T1I2eWgxbW4wYlJaR25nYUJuOXJWdDdaSWhCY0Vw?=
 =?utf-8?B?U3Jvb1BTRHdYYTZscHBibjZiN2R4ZGV6UFVPQjMybG5XZGNTYkNySytQdnJP?=
 =?utf-8?B?dVQ5NnRHR3doK3QxRVB1cjNoWHk5eXdmSHdCUCtIeWhQUDBKTUZ4aTM5MXFP?=
 =?utf-8?B?NTFvN3dIWlZkMzUvUHFxbDJLNjFBSGM1dFozbjlqQlN4WUY2VzNRR2VmSkUx?=
 =?utf-8?B?VTRJaWlpNG1BM0FqSWxOWkFTR210MlI4THVQL085VHN0ZW50UUMxaU15OVVQ?=
 =?utf-8?B?WGFZaG9qK2FlS2dOSXdsNlRUakdLK2RST0NPamp5ZSsrTGtQNUx4eWhqb2VF?=
 =?utf-8?B?MC9ZYVFYUEIyRXZsOEQwL0NEVXQzSEovc3NMVVdzRHc5bUkwZko3S0o2bHYr?=
 =?utf-8?B?d2lEQkVYT2ZEb0RaOHZoOEZOMVBoWk53dEJOVkdwZGJpN0pwb2s1NG5lWE43?=
 =?utf-8?B?b0RTWUtGaE1oQU4wcjZ6dDJWZFlmOGl6VDdLQ1RWMzB5V1dZZVI4by9VNEZx?=
 =?utf-8?B?NWdkSGFXbENBamhLNldvTTVzZDZwby8zSFZUVFlRSjNOOFUyUW1kNGZMdEhF?=
 =?utf-8?B?czY2S1RlRkY1VC9tTnNPam1qWDQzWUcvVEQrbFllS1p2dnp2WGlkL1VXbUh0?=
 =?utf-8?B?eis4b3VSYUJxVWpLTVUwQlZwVWtweWI0Z1lmOS82dFlXQWlLZkc1dDRWa0RC?=
 =?utf-8?B?amhPcHNwU3V6VUJvOFgzVW5jUnZpTjVoUzd3SENzdXJ3S3I0emUwWkpxSG5t?=
 =?utf-8?B?SkowbEhYcHJEZDRKMWY4UnZuL25vQldMYmJkMGNpaTJWMTJjTUtlRUxmTzlr?=
 =?utf-8?B?WTVaQVdGV1QwK2NUa213UytMTzVneEV0dnpaU2RoQk9EWENlOU9Fb0QwN0pB?=
 =?utf-8?B?ZnQweGs0Ulk5a3lpMW5ON28zakQ0TnFXY2NjQ2hNS0ZLQkpKTkIyRUVtcHlY?=
 =?utf-8?B?STlHaGNyNm1lNUN2d0M3TGZiTStXT0VSTUEyOU5DUlZndjZ4SktWcURCVEpN?=
 =?utf-8?B?OFhVMnJTSTV2YW1LRWFvYzlCekhDNUtTM2JBQnhXckdDR2dmNVNQYWRqT3Nz?=
 =?utf-8?B?d21JdG94MldERjV6ZmFvTHQvRlorQThMd1JwMm1mR0Z5cXkyZVNxZ2taSDFs?=
 =?utf-8?B?b3FiaTRudUdVTE9NZERVL2VtRlE4N0t5Z0tNbnM4b3BkUm4vYlIwMmxGN21U?=
 =?utf-8?B?N2lkeFFLTWlzUlJja0FCb1lta2tYQjZtbEpkbHpOZkxIYW8velgwOEh4VlQ5?=
 =?utf-8?B?U2N0Rk9yUWRRYldrU1E4UCtNakRZVWpidzBQYXhzdFBRM2hWTG1JaTBhSU1Y?=
 =?utf-8?B?WGIyVFF2a0xyaUU5VWViNU03TGY4b1RMSVpVMk95OE1BeXRZSndFTXExSlJP?=
 =?utf-8?B?Q3RmQjdMN0NwZGdMQmYwbzhselM5bDR2b2FuY1hBNG9JbGpDMUEyc21GOWt5?=
 =?utf-8?B?RE9OV2xBWHNaSGwvMXNpK2N4YWszdGd5ZVozVjBoK3NudnZlTTdyRFBQZStN?=
 =?utf-8?B?ZkMzdXNmcWs4cmQ5UURwZTl2RnZJNWVMZkpHTkdvd0lIazc4VmNGMkZaN1pD?=
 =?utf-8?B?cmtrZ1NaRld3UkRjbU5FZFFmdFdTYk4yZU9PZ2NaeVBjRS8xY3M2LzRBN3pC?=
 =?utf-8?B?K0RpellVOVJtN1pqNXFkVmM1RDE3aCtHNWN4SzQva3BLTUp0VjRYZUwrVklr?=
 =?utf-8?B?b3ZzK0IrUmRpZG8vV3lZRDYvbjhkYXZUU0xtM2hpdloreTFOYmViUDFZM1lV?=
 =?utf-8?B?WmNDZndZOGMwdDh5bVhEcVhFZWhFcGNyZG5GY04vZTZ3YlNNT0tXU3h2MXdi?=
 =?utf-8?B?SmdaZ29aRnIzSUQrQzZnRFpDNWZnTnRqUEJCdm5TVUlnZDJ3NTFQSkNhOGtE?=
 =?utf-8?B?RGFtbWVxaE80Y0ZZcktTSm94MWlqL0FLYkpiallDTFZ4VGJ1ZmdXckNqdTBz?=
 =?utf-8?B?aERSbVJNVEQyKzVDNVFnSzVjc1JsdXhpUEZab3Yzbit1ZzlmZDNGSUppZWZa?=
 =?utf-8?B?ckEvRG1mWXhwWWQ1bk9WOTVLL2pUaDZjWFdkSTZ1dUpqbEF3aGpqV3RIckpF?=
 =?utf-8?B?cWRqN0k5SnR1eFhQOVRlTU5mQkFGVE9VK0hiekQ0d09INHFuaUdodHVmRHhy?=
 =?utf-8?B?KzVZdlVxZExuZkdCNTNLZGlCclc5Y1FUL2lUWXMvT2NOVnZiVytqUUxraXM3?=
 =?utf-8?Q?jS7+cgZTBzan8ZRq4q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF984008F888EA49BB91FEC17F5A47F2@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB8257.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78254ad5-272b-45be-5c66-08de9083806d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 06:46:00.2793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwBtALuFv7SWqCtjp4gbhXuSuGxJ7DmMbuyRtkMd6gUUm6NhwWpb1wnEpafGvbviQr1tSOKYzLNntNnbRi7hmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6506
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.10 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.19)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:jack@suse.cz,m:brauner@kernel.org,m:amir73il@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[guochunhai@vivo.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3176-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guochunhai@vivo.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,vivo.com:dkim,vivo.com:email,vivo.com:mid]
X-Rspamd-Queue-Id: 17A6F384A6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMy8zMC8yMDI2IDEwOjIwIEFNLCBHYW8gWGlhbmcgd3JvdGU6DQo+IEZvciBmaWxlLWJhY2tl
ZCBtb3VudHMsIG1ldGFkYXRhIGlzIGZldGNoZWQgdmlhIHRoZSBwYWdlIGNhY2hlIG9mDQo+IGJh
Y2tpbmcgaW5vZGVzIHRvIGF2b2lkIGRvdWJsZSBjYWNoaW5nIGFuZCByZWR1bmRhbnQgY29weSBv
cHMsIHdoaWNoIGlzDQo+IGN1cnJlbnRseSB1c2VkIGJ5IEFuZHJvaWQgQVBFWGVzLCBDb21wb3Nl
RlMgYW5kIGNvbnRhaW5lcmQgZm9yIGV4YW1wbGUuDQo+IEhvd2V2ZXIsIHJ3X3ZlcmlmeV9hcmVh
KCkgd2FzIG1pc3NpbmcgcHJpb3IgdG8gbWV0YWRhdGEgYWNjZXNzZXMuDQo+DQo+IFNpbWlsYXIg
dG8gdmZzX2lvY2JfaXRlcl9yZWFkKCksIGZpeCB0aGlzIGJ5Og0KPiAgIC0gRW5hYmxpbmcgZmFu
b3RpZnkgcHJlLWNvbnRlbnQgaG9va3Mgb24gbWV0YWRhdGEgYWNjZXNzZXM7DQo+ICAgLSBzZWN1
cml0eV9maWxlX3Blcm1pc3Npb24oKSBmb3Igc2VjdXJpdHkgbW9kdWxlcy4NCj4NCj4gVmVyaWZp
ZWQgdGhhdCBmYW5vdGlmeSBwcmUtY29udGVudCBob29rcyBub3cgd29ya3MgY29ycmVjdGx5Lg0K
Pg0KPiBGaXhlczogZmIxNzY3NTAyNjZhICgiZXJvZnM6IGFkZCBmaWxlLWJhY2tlZCBtb3VudCBz
dXBwb3J0IikNCj4gQWNrZWQtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEdhbyBYaWFuZyA8aHNpYW5na2FvQGxpbnV4LmFsaWJhYmEuY29t
Pg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IENodW5oYWkgR3VvIDxndW9jaHVuaGFpQHZpdm8uY29t
Pg0KDQoNClRoYW5rcywNCg0K

