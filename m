Return-Path: <linux-erofs+bounces-3174-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCJRO48NzmmnkgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3174-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:32:47 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 27461384833
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:32:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmX8q6Zg3z2xln;
	Thu, 02 Apr 2026 17:32:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775111563;
	cv=pass; b=U+1WeiaWr2YTU9VmF3BfmifV7S4Hz7FW6LSPTfsszH5VOpB5VvZ03U1cDaVXYo8XmsrHczTaWkI18Qe+h7q+43kVEvslIB35qL2XVXpn1/PrQ9Gj+93W1+CFTurFG3zorZ7aJ/+7hVk/CdTDL3pYIKs34mE9yxW+YRMPN1oRZDPD3f9JBiRP6v4h9Bkx8g6Xxdfq/kdl3eqHETiP5e590vpPP7qAkdd5FJhmWteLGLRdlDqF+XzU+d1m01QbJ/LIz4g/2OPqwIIbwZtGmLtW9JAjHESuc4doNHIuvNqyR/Fb6jj9q1PYfZOqd8KVpjVXFHHehyJ8EAXhnyPINOuzUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775111563; c=relaxed/relaxed;
	bh=g/bfbi+uanKRjAz5oRr9fXpTgp9BS4uc7wqRKXMVf8Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YAAkLugt1zCZJiM1JivUGTbvk0+gIzNyKbKvcnEsL7OF+pP/4iQEtqvYScdzwUxWwXpt5DnKPcd4KYDOprHEftoGcvRTrW3aCJM9Xs7GGxZ3/5wA/3MFA2zCter+h+JOOSkLaNFLBpiPc8akr5L8ytxPv9bGQxWdvXGX08J42C9INCPYOtKe3luGfi6/cM09dVsyzepk5Lv3viugv6Kp/OJAwL2Q0bmrnbNEzjKu1ZgZ6RN6NYkiKalWY9ig+qsKoREqnpR2QRQEv0L/TW6gzr3epARZwQnZ1aHVm0Zdv7Y6SjBMihrFpCdQA7QLwFAigYm2WGVJNQ1xhxSQ3kUTqg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=O+E7aX83; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=O+E7aX83;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmX8q1J3bz2yYy
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 17:32:43 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmZAS2821USx44LFApe4gVB60uuELmfn5VfeKefOcx5uM9oqKmzwVPVNKOExFdq0ITdGntP05lO71/NLYu7nTk9ZbZouHQv0EO39EBvbukOInIDQyK57+s5Fu3vh7zwaTTXEmF5L+sLC/l+uS46Q9TQhZnD3EjSNVCwHJjT2j9hyfcx0pSbVmfh/cWCouoTMjFDv2xPBg3kv6FBOADMmB2K/jb0XxTGVtbEtPCbAteFsSsaN2MecGE4UQ/dRors3c2x2Su7GloO0sQuh4id3duy/fQ9Jsd+oIhcMzSBP6RqUL5XpzcB32ZyZfQSR1g9Y71QeCPdM4QTFDjlouqJBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/bfbi+uanKRjAz5oRr9fXpTgp9BS4uc7wqRKXMVf8Y=;
 b=vpC6ax/dxCKyQvKTnTcpjBswmlQU5/O/+ZxDp5aEOe6EvT6AzbgL4hy3chFVTYwT5sNdfsY+wKSPkG918rnSmu1z6K2UQogZL/iXkWhGcfaLMGbhoKYa6g4+ZSzVBGiF5+WWbgOzVRP8yRxf8rHIS/krEvBfSCOOYUdncgzv+ejFmxkFS7wAUZh/iu0GMDM20CnKaNABytndmEPLGeGvsLEKRR2RFoV5XXFJrBvho/VHPU8DFP0wH/1XlSlycS/E6Fs5vcapkvMmQ8i5aNT4PTdC9b4vIj9z751K75lN16+oS2t26yuTelgKsScbUGbW/sfoGOk0A/mvF1AINPJTTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/bfbi+uanKRjAz5oRr9fXpTgp9BS4uc7wqRKXMVf8Y=;
 b=O+E7aX83xD4v/ZEZJrPSQMoo+FPTpTsZP3bxTPpOvLaflHeyNLc78AnWrIgHKeM5X/8mN/brdyT2WBg6TnRnH9BcKs7gh2Bro50djGZC05aPT/pTbWl/4ux1ThbZqYeWxMV8ZSrgHB6bDcX7flgPM6m85xDDnMEf+BeSYp6/xv2DWSect0hAjKeNZdf0ufVtcXVNsyOssQOfQogmZ7hq1ZwG40OxtqOJFeIN2xGdomYX8tVMsuOoaJcUZ0LHcgG/LO3yV6KkLOtQapYYgJYHxZ/i79fZ3JYeqYbJTX/tMcJ5LdEMJeW3+35C70d9mlCnrvtG8EBoBRuWvsjs4+mSzQ==
Received: from SE3PR06MB8257.apcprd06.prod.outlook.com (2603:1096:101:2ee::17)
 by SEYPR06MB8288.apcprd06.prod.outlook.com (2603:1096:101:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 06:32:32 +0000
Received: from SE3PR06MB8257.apcprd06.prod.outlook.com
 ([fe80::881c:180e:661d:eb93]) by SE3PR06MB8257.apcprd06.prod.outlook.com
 ([fe80::881c:180e:661d:eb93%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 06:32:32 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] erofs-utils: switch other source files into MIT
 license
Thread-Topic: [PATCH 2/2] erofs-utils: switch other source files into MIT
 license
Thread-Index: AQHcwmdG9pNuZgoE6k+j29O7CRI8lbXLUCcA
Date: Thu, 2 Apr 2026 06:32:32 +0000
Message-ID: <c232c632-03b1-4d7d-b5af-7ed896b2f1c6@vivo.com>
References: <20260402060907.2268323-1-hsiangkao@linux.alibaba.com>
 <20260402060907.2268323-2-hsiangkao@linux.alibaba.com>
In-Reply-To: <20260402060907.2268323-2-hsiangkao@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8257:EE_|SEYPR06MB8288:EE_
x-ms-office365-filtering-correlation-id: eec12eb9-0c51-4d2c-c8a1-08de90819efa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 RRKGwO+taCdjy6SM4Z8M3cz6TqH85wpTYq8JbY+ghMX2ZTcfCk1GEYfakU56GZBYx7QHrOl3bWuosBc/Ymp1G5gOcWAYAbKXrXhDU3vzkodR85vLPDs5B6zlw2kmxnIc72kYWOKvReHlfdLCfoucFPNxp1ExNsYcFit6gXEMjEktOR/PclisSJo7wiKfob9kCKB3lgwNlRT0d3EFEZF7s56s0m7O+PY1o6XL989S5T0XLEDnetxnpu1/U9DuQgRgix+Af6m3Ij1nbnR5EDU013hKtbe4EWBSJHj1TjUEz4fLLnzWaVniQEIl7ieFl66lo25cm37LEFmc2nc5dzJpY7LrOkIi6Gdr3qt16AtGwMWRkVLHiwjzCyRkqa/Xm4LoKFJKSS2UxmeWNruMZz1UXMYZffzzNUrOv5lXifhH6csZUgfvR89CpZNwKQq+O1aMzd7oebpHUDXnxsfYNIK9Zm63NWZITGpoe7R+c4fTuq7+1uKBKIMR95yVCAMCoPhlByCfB+PlHpoejymTw2s81gvAXkCN0v87eWPyrJ3ol+YQ5h4mj5w4c+vjWr391Rh8/6ryrhyDedVztO9Z/meAqGyPoDpdcrbMXa6+FDwggRStJv30+fRU6pv74qF1iET1OjpclpfrMKqh0idWzn7zWB/nxeQ9k1Svz5YpfiQuCNKIDXRr+7deE0wXRpqccjEmUcUNIGyzC/VVu5cDMv9Vn1x4NrA53873mkcm8YimsNrCZtsNjN4W48uzqA8nwNys5v7hDRXmyRgRblKgnd5QTPD3b+wJhsL6IvlKkuIhhgQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR06MB8257.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QW9qcmpkSXNkSUdDT0x0bHdXU2RJU1dQU0Z1VUU3M2pkYUppb1N6Wm5pc05q?=
 =?utf-8?B?QWk2OWVkUXdPbE5XeXAxQmJ3T3pSVk53ZzVNM2tzdGhHS05WSkV6T0E0Qm9S?=
 =?utf-8?B?OWFpQ3h0RWdwWllJM01OSllsdWxnYTVUem40K3dpQy8xRlI5RVFVc2lWOVhB?=
 =?utf-8?B?ZGFZRmlKL1NxaFpGN0lxNTVrMUtsY2oyYUQzaXB0SzI0QXJ1eFdoNWJOMC9k?=
 =?utf-8?B?M3phSGtDOWRtYjlsWmZlV2U4Q2tveDlqWVJVYm9KVG5jNGhUNHJrdjdCSzFI?=
 =?utf-8?B?dG9vTlo4SkxOZHVqNzZ0WmZxNmJDOThDQVlGZzMwRWxGazcrRTg3SmN3QmRk?=
 =?utf-8?B?S1ZqRWlUMytQYzBnSkFkeG91N1dleTZJczZZVjlpZlBPa0s5dzJFMFdjQjdi?=
 =?utf-8?B?ZW9BT3FjeHlYRmFhS2Z5cWtiOFJMdmlaOUU1VjFxdDBQNHIwbE5HYnA1MUNT?=
 =?utf-8?B?S2JUdDNsUGdDalNMZkppNkYvdkVjZm5FQTR4SHkrdGNScE1wOFMzMUUvOEJi?=
 =?utf-8?B?M1BER1E4YnpqOEYvS1pSR0RsWnN0dDdUWkw2NE5hREhkUXZ4OE5HZ3dHNjhP?=
 =?utf-8?B?Z0xub1N0cmhqYnBFZnRvZmsvWlF4bFZCRTR2K09WQi9mRVN3NWVYckh4RUEv?=
 =?utf-8?B?cUJlYnFIVlBjSGpPNDZNQytwVDlZb2JCZzUrbW5pM2tFRjVoYnBvdFlYbGhh?=
 =?utf-8?B?YU5vV0NyMzkrb1pBWjBOZUtsSnY4N3V3LzFWOFFQcW5PK0dMeTZxcFI2bVBm?=
 =?utf-8?B?azhoYUQyN3YvSkQrVzdOYjI4TklneUJNRTdzZ1BsTytINnZFeVlNTHpPc0NS?=
 =?utf-8?B?a21LOUpCNXFsMmw0akU2MXVQMURycnd2SEUyUjlzSmF6YnhhZnNZclF5TVR3?=
 =?utf-8?B?V3ExeVhhdDVUQUlHS2FLdlYwUDVXY01iTTdhZm1pQndOUVRYeEJYZTFPcDd4?=
 =?utf-8?B?aWVQc3RhcFVnZzVDMXZDR2NHMUNsTitsaEFuM0R5TDFOSzVlQkZxK0pOd0Rx?=
 =?utf-8?B?R2NIU2hNamR4cVZJenhTeFRSc1ZQN0tvcFNoZ3AxMHE4WjN4ZkhnSFFUYklQ?=
 =?utf-8?B?SFhVUkZNbnlNYXFRbWRkSDFDdjJsSktyNlhGczVIUlVWakt5MW9kcUdkTWxZ?=
 =?utf-8?B?VG4rVGhQdjI4YktvQmU5clNTdGNFc0NCTkpkZlZvck9hRU8wNk1MWThDSDFn?=
 =?utf-8?B?NlFqY0cveDRPek5UdTYra29PeHFiQzgxWjBManBZRVlUcTN1MzR2SzlPeC9t?=
 =?utf-8?B?dEpvTENKK0RJMFEvMmZuWXFmejNtTFl3OXN6VkltTG9BaER4T0dPMW1tL1Jy?=
 =?utf-8?B?bTh3SVFaN3pnQzhDTTJyNDdzb21kS1hSWDlXRUhSanZVd09ra0FzS2pmTGRk?=
 =?utf-8?B?VjRobTNKZHZ2MWoxbHZHc1dpdTNtUmlOY2pzcksxS1NOZzlqVUZGdnlyK1Ar?=
 =?utf-8?B?K2J6cGJkejFVUVRpbkRCNldMNGJqY2NGaDVtV25Sby81NU9MS21iSHo1STgv?=
 =?utf-8?B?Mkw2VnVraStmd1oxcGJPNGNwWWd4WDBMSjgvNFNUcUpYdzA3aHUxRlMrNGVY?=
 =?utf-8?B?UDlyaExGVnhLc1BJdDNqa3BpVi96d29rMXRKSllQb0hwdHFRN1JudE80QVYr?=
 =?utf-8?B?YThFRnFRekE4YkdtbFdjTFlxM1daUVJlaVd3cEdlZjRZdXpPNUVORjlJcjU2?=
 =?utf-8?B?SjNxR2JCa3R2V1ZHeTBjMkZ2blZ3RjU1a1lrTFZ5eXo2UW5vLzhZSTQ2MFI3?=
 =?utf-8?B?Nk1JSkU4TkhXMk5JYWE2TE9qSFNwUms0ajFXSm5SWTdmZDhhOHM4TVR2STdy?=
 =?utf-8?B?VkFta1J1K1k5YWVFNVhCT09qb1d1QnpoMWtyUldIdFkzNmNGMHdQejlMWndO?=
 =?utf-8?B?RFhkZ0p6dWw1TThaODg2SzdEY21NYW5qNDI5WmdnMlVCUGlFNlo1a2RnRHF1?=
 =?utf-8?B?Yk1CZ1pocHA1QWJhSXF1MnNNM1RpSXlBcjI0dHY2d1ZHSi9yUDJiclNLOTFk?=
 =?utf-8?B?VHFHMjM2bXFHWFQ4MVllS2RYMHh4ckR6NHcxODByMWhHR3BHWllXc2xqRjVS?=
 =?utf-8?B?TFRzUGlacExET3pSczRxMXNnVlU0eWVVS1FLZStkUklrdG5VanhSYjFhbjhv?=
 =?utf-8?B?VzBwVmI4TTM4QUhXSWFoalV1S3hOTTRURWdVNVUzZ0dLTS9KTkpodGNHQTRy?=
 =?utf-8?B?dGRqZjY1TllEalVlOWg2VkpaZ2xUdlhsZmgrY0NCUWRBdys2Z053anliUlpM?=
 =?utf-8?B?cS9BM2xDcFI3cEFOVU90SEYyczV0TUxNU09UNzNyRGhJUXU0LzJrc0N2SXY1?=
 =?utf-8?Q?IxcIuG55Kk9EW0bxKK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49C5F5865352BC46B37CEE8C58905578@apcprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eec12eb9-0c51-4d2c-c8a1-08de90819efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 06:32:32.5154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CigWZzFjSrcDVpoeR4wjkyUajKinF35vM1o++9F38oKk+H9Me2M/U5ENh9l+ortDdnD/JwSiZbxfO6/2wYAPaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8288
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.10 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[guochunhai@vivo.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guochunhai@vivo.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3174-lists,linux-erofs=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 27461384833
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gNC8yLzIwMjYgMjowOSBQTSwgR2FvIFhpYW5nIHdyb3RlOg0KPiBMZXQncyBzd2l0Y2ggb3Ro
ZXIgc291cmNlIGZpbGVzIHRvIE1JVCBsaWNlbnNlIHNpbmNlIHdlJ3JlIGFic29sdXRlbHkNCj4g
Tk9UIHdvcmtpbmcgb24gc2VjcmV0IHJvY2tldCBzY2llbmNlLCBzbyBsaWNlbnNlcyBzaG91bGQg
bm90IGJlDQo+IGEgYm90dGxlbmVjayB0byBpbm5vdmF0aW9uIGluIHRoZSBDbG91ZCBOYXRpdmUg
YW5kIEFJIGVyYS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogR2FvIFhpYW5nIDxoc2lhbmdrYW9AbGlu
dXguYWxpYmFiYS5jb20+DQoNClJldmlld2VkLWJ5OiBDaHVuaGFpIEd1byA8Z3VvY2h1bmhhaUB2
aXZvLmNvbT4NCg0KDQpUaGFua3MsDQoNCg==

