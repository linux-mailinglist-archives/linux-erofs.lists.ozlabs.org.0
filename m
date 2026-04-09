Return-Path: <linux-erofs+bounces-3238-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAclGNCB12knPAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3238-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 12:39:12 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4183C939C
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 12:39:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frxHw18qQz2ygG;
	Thu, 09 Apr 2026 20:39:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:d40d::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775731148;
	cv=pass; b=B87qotOLEvhBC7noqFguxR5Go8qi7fwPRSeGZbpMrZ++XhAUv36TNawlR+TDPNvz6i+WBoPNoXIxCcJqxopDdhSgL60uidRL4mgOetD2trvLWlbdwxbHNNwk2F5vzS2bwdO7IOpYdR0LnvpF7Qq3e3ijLzLPwiBdc4ah6rP/1xm1JZB/Jh3VyhD+PuqcC8MFtzBiib+26nRzID3u2fXaUps7nRgCUkjRNPeSeGh/8aJQWPTwiR/5Hnr9Zhp3lXqcSzZOh+vMeLvYzGlB6Z7FsKL8P/VTsQ/+JCDRI0L3LuP7yrQVq7+0K0oCOMJbq2gm3hHcBDVC/tL2iGFIg58+AA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775731148; c=relaxed/relaxed;
	bh=XWOtbV/eJS54D3qzObNAAk9vEylWH8M9XoU3o/H3KAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LF8duhA/alq66Q+72WJhj65yO8f8xDIy44BdXr7e++9Seqn6wnECiOxHWwCTHmTdL2pcjiMSHA+6HiylNahC0cJPlBo5G9TVcnkoXuCSp/XpembuuewAoqYDCBT2rm2v7Lbo04BDH8EOdPRAprMonbKT6ESmiZPAg9GUVmNLZx1klbpwIXzEEwntU8SQBEKX3pN28cBpMi3h27WdvaxKqRoYN/ZtanhCcCcE+H8V2sa+Zh6OzDPPB/6Bt3EVFR5FR5/G/+RU/q6PUhahm7mE1P0Y/xIu19eUrsYIA7MNaimfnK7wIMS/89Nn4cfPlBxdwqfSvP1nr8Jad2rIFmoXJg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com; dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ouSmajb9; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:d40d::; helo=sy8pr01cu002.outbound.protection.outlook.com; envelope-from=moonafterrain@outlook.com; receiver=lists.ozlabs.org) smtp.mailfrom=outlook.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ouSmajb9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=2a01:111:f403:d40d::; helo=sy8pr01cu002.outbound.protection.outlook.com; envelope-from=moonafterrain@outlook.com; receiver=lists.ozlabs.org)
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn190100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d40d::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frxHv07wPz2xpt
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 20:39:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFK9E/IL/Wsv64yOOaMNIgnLdSJeYJpErHjrji/HQ0r7FCZGdOMeLuR7TtKDMOoroV1iBEj5Ck1gJ5cRU+Kj7BDtXOBjkd5nltz7xmpoQDuFEuhpR9H75rcD0UrFVU4XoAQgCaWghIf9cg9LLI8asb89MJvOe1mbMEF7h0yvs14b5ty4YJjrz4c0RTJDPXbKWkoORJ4u7olQYpKcxNn4L2uusmwxuMETqTal374iMAy/pW9UAQcecoCUI9o3hCwN0m5bht45WHpVBPOzb6kBSLLue51gDuocr1AWs1v4nkrcCzFSatnay+Tx7af5uMJQamCjXac1qx1XpevksFnHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWOtbV/eJS54D3qzObNAAk9vEylWH8M9XoU3o/H3KAI=;
 b=UjtyIP8/WeXn4INcvICyxVbveSVVERUAjKXHtypo3pMuj7IETS/yJQXXaP1Tqw3Ip9nohkt9n2FLuRU4dEjoxbFKNQi4bxgNzfHd6AWmCBROjZmuZovQPSbBQZOwa8sKOSmMfyB9hS+S8LQh/HHKKGdsF58yGcIdpdwchcZ1uxNLxsXq3nHTpmQvFKtUBagPKtg3RZWMbsoLs0kaO1d8z3+7pHY/suQTUfvGjEbAT1Fp+JG98KmXn49slWX1p5ilmbbtfhbgxY1dksl5H9zsJHphldBbWc3jWfqKF0fL7jeWbkMIkK3NTG1R1Z3TKAZ6sck4x+URg2dmeZ3tGPoV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWOtbV/eJS54D3qzObNAAk9vEylWH8M9XoU3o/H3KAI=;
 b=ouSmajb9RnLDoK7nAvM7Qx++qdWZVx/HB9aVQ3njyij/cY0S+ijac8TswmexJWOvERkAZdCUlH/FVGfcZ09/9s6X6lL11yJJgBxsDZd12T202ZKoPtrYXgbnAPjiMumVOggznNBiROjwgAhacsIPpAzMkTFui/A9gc1koDxyat+6Houf7sKdd8TQfIDKdPljEGhAKNZZ0P/+AhsVIaQpL2Hbc22M31cc4jsDjowx8YkwcnjNxLarQ/aRovsM0gpF+aE4NJkwwZhDSsM/Crcv2eNXdxtOdYLLXcjogLqVj/x0+vpw2s7jA6FTcgjjuG7fqbE6SnaaeMZM0W17zqmbJg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY8PR01MB9032.ausprd01.prod.outlook.com (2603:10c6:10:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 10:38:42 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 10:38:42 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu
	<zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
	<dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo
	<guochunhai@vivo.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
Thread-Topic: [PATCH] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
Thread-Index: AQHcx+59WJTQzAOqcU+DqK3g7FYXK7XWVQWAgAA1IoA=
Date: Thu, 9 Apr 2026 10:38:42 +0000
Message-ID: <3F909329-EB34-4B5E-A26D-081D9031DE01@outlook.com>
References:
 <SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <31b4e893-44f4-49b4-935f-9cf37b5a0790@linux.alibaba.com>
In-Reply-To: <31b4e893-44f4-49b4-935f-9cf37b5a0790@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SY8PR01MB9032:EE_
x-ms-office365-filtering-correlation-id: 1dc0557b-c356-4956-92b8-08de96242b84
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|41001999006|461199028|15080799012|19110799012|31061999003|51005399006|8060799015|22091999003|24121999003|12121999013|440099028|3412199025|26121999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2ytJNpkS/3CDNK1Gp2Yj1E/5UEzl1vnviWN7jSb3a8urlyM+aCfe0J82oZf9?=
 =?us-ascii?Q?3f1yuncptvNmRf2cADFZ7r/rE07lNWkwvXFIsbLgs7Gm+zBPs7XtOZYmAjhd?=
 =?us-ascii?Q?7tLrZuFNFnyUaCcCDYoYD3dgwaGsDp6NoYpiXh08dv6H243Nt14AwiqLEF4q?=
 =?us-ascii?Q?/p5w4Gm+Z4f2YMj66DDbRHzC97OpG2a3u8QNpkxxTRTS97/AuwjMGQz4SglK?=
 =?us-ascii?Q?iYWm2g3eUNuh1BHCYwtQrTS1x7M8jIM24JlOYnAm2bsjVn87L0JfcGqP8zI6?=
 =?us-ascii?Q?FmrEGiGN46kML5/IiVBhOPj8O0OrgJK+Y6eTYjlNUwGGuSrJgQ4Iw8AdnxPf?=
 =?us-ascii?Q?9XcUV7YoEWjSpuFZVo8/e2Z6oc/R8EkEY2w+HgPir/qiPuECA3VmDnbaNzvk?=
 =?us-ascii?Q?JD2FKD5wdP/uDT5pjO9jcs4jtqHP38F7EvLygKobAV9s82jcAfr/o6sOZpJE?=
 =?us-ascii?Q?dmvvoLQJu59xuWMD+kPm1Ri2s4YLoO8mhtQUW9BsBxmUHokCPUZ4ILLA0pBM?=
 =?us-ascii?Q?wcieHRB9fTvWYkA42qcePtDHej0tfd87EY1QW2OJhNQvCaVKSskjgxTIdOTJ?=
 =?us-ascii?Q?YyORSu+Z+O4e4YjeWNzU8n1X1iRdtH5zZW+uFi/Z2ICw0ObOl7MTLH5eZwty?=
 =?us-ascii?Q?UZ3HLwLuGgDUGLTv+qDBsBG1hYygC1GT9alA+kzIsTMlNGi7ss6MFDVMDOax?=
 =?us-ascii?Q?RBc/XXaw9khVW6ONHgp7rTsVqU8JMgwZ7mGER1Bw86EjbPUSP/E79exa4hqv?=
 =?us-ascii?Q?us+WgcFzAjc2tNtl700ztdU/bG9h8cByJ8SaIioPRl6GmeqBpQlKdBQV6GQ1?=
 =?us-ascii?Q?cPGgk572lfQ2q2FR2O/kx8PRB0BKHya93mZ2mOjol+0Kb0QS+XNNgjjQ+p5A?=
 =?us-ascii?Q?tgJJM/llqaOrIxXHzJcVmtZ8ZRLiwBPxndRHwqMuTDgw7wOSE8uN7Zv5+9Nt?=
 =?us-ascii?Q?9QVawsqNGNluZPBr/c1FNPBi1oWj55ntM/seLbmjkQywtXqwr9AJqG+WmII1?=
 =?us-ascii?Q?KICZtNNZj24TObI1bAsJBtQiSFB/aGa0VLbZymt7G9L3Ek2jNxrIWsfPoC+y?=
 =?us-ascii?Q?jwDo1+1R?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zsEZPd9u7El7n7+LeNUKjqxSBZYLx2JXBCp6b1tt55yoRQJbm/zkMMapMWbI?=
 =?us-ascii?Q?0JZOLg8SRiZ8x6gzSXFXsf18nlAFrfV/fTxqdH1hRB7I3rLxcbaWJ5aPoWF7?=
 =?us-ascii?Q?x8UEaVdS2/Yyjk8F6YM7m6qLr9JFLzmBAXgGM1MU9cDJgHF6foOuqZ49OZ72?=
 =?us-ascii?Q?kT16+UE8q9lCKW+HusMj1v2GSm5L7k4HWPqbRWvgaGWZ90cVUocYpY0JQDmx?=
 =?us-ascii?Q?2SoMPq0H8pZttHP/Nw+H8tWimwpZ04BP/vbp+2jvsiXX19NzCC4ZNjggnac+?=
 =?us-ascii?Q?kUd7J3ysTDX4evcPxC/7zJO+YWGs8AM5uzy0uum3xPfMXnVgtr3hP8BVlb3N?=
 =?us-ascii?Q?xqC9p9iRcmjXB4dygA51cs0+PmJx3aR4+gD6BqZ4qcs/X1id5D/2yTL5fjTK?=
 =?us-ascii?Q?5RIrMmPLq0JIElLHyUAD65WoNh65cdILAkknpUYNwphcUdtM2RkFDmQy5SSY?=
 =?us-ascii?Q?2QYjTGHR6umSFxyii4WQY1AmvRpxCY2G/FrbSswFNursYmYwt1D9cY65ZIZn?=
 =?us-ascii?Q?bblwuuIetoGeQZdqLg+UTJC9LKxrn3hhTJZzrAMZZGsPUVjNpKosst6kO5Gg?=
 =?us-ascii?Q?FZMQHX/ekHZ5KZ5mlXWTzvgNDqwmO0AaAEswB1LTiIxwRn+XJ688xl2oC1ia?=
 =?us-ascii?Q?Mb8FoCCCr/2bPja3+G1yp6L8sjGJlXyJ+rfRAsji1cZeqqeXIkRF2n1ku8e/?=
 =?us-ascii?Q?A2qtaKJS3k+xyCbyi/f3wp3fvpCDIR1sMdPPwiNaZSOldJZ3ofMNaPpGbEgz?=
 =?us-ascii?Q?pu537Y7PujrVYhvL9Flok7M/Zs1TcG3XK/8eHhlQFZ9aYMDoyeEzSltdkXZN?=
 =?us-ascii?Q?DzCjAP0A7BtgJzBVbnM5/2ZVXEC+Zy5YqcBcg64fV8QGIpLcjl+Hj1O/HJFY?=
 =?us-ascii?Q?LMr+iPmJg1mW7wTbQq6YFU3skauAGgyxOcb/C0rN8fO+t2ICwggU0HwBDilO?=
 =?us-ascii?Q?fldqNhRtIe5VaqZzHQ5uZw/sG1tQ1T8s1MblVG+h6KQGmE81xVEKKd6VlybY?=
 =?us-ascii?Q?LAt6oz/FWdVP888mM3y2F2qHNvA4QzVGCBI3YoVDalnKRhzXwUVPrdEH687e?=
 =?us-ascii?Q?uHpidpJJdX5pinxfyJYV/nN6qc6mvONTEuN30yWMqCnSPJsINUxu7oeAUgmV?=
 =?us-ascii?Q?QhIFfJ16mfIZuBjhKMWsR48/OqyGt4ugSI7gENlvO3IA2BF5ng3BRWVIK7x8?=
 =?us-ascii?Q?LbEc9wsVU8cAak+oPXyhtj90JHU4sC5xo29NUS0xK5c3jBZ8iPCGpTD8/XnX?=
 =?us-ascii?Q?rYhywvZ2O1XY23ZIJOQ9X54no9YjalEzOeOBWJg9rFmNK+TzTgvYp4n6NsT9?=
 =?us-ascii?Q?QY2LTnsxI7ii1CZtmn7gKpRHQ/MCcpKTW7ayRJZZdHl25qtj7M/hEDBq0Jxg?=
 =?us-ascii?Q?SZ7DJ5nAy+9F83lCZeswQBk/bKyiwixwCeFc4F6Uzn+C3I103Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32CD674898504E49A6692FA0864AC33A@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc0557b-c356-4956-92b8-08de96242b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 10:38:42.5707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8PR01MB9032
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-3238-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[moonafterrain@outlook.com,linux-erofs@lists.ozlabs.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 0B4183C939C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Gao Xiang,

Thank you for the review.
=20
On Thu, Apr 09, 2026 at 03:28:21PM +0800, Gao Xiang wrote:

> For this kind of stuff, do you have a reproducer?

I constructed a crafted EROFS image declaring plen=3D8192 and i_size=3D4096=
, giving
inpages=3D2 and outpages=3D1. Tested under QEMU with kernel (v7.0-rc6) plus=
 a temporary
pr_warn trace in z_erofs_lz4_handle_overlap():

[   12.889652] erofs: BOUNDARY CHECK: outpages=3D1 < inpages=3D2

The image mounts and the decompressor is reached with
partial_decoding=3Dfalse and outpages < inpages.

> I'm not sure what you're saying, but I don't think
> you really understand the entire logic.
>=20
> `m_la + m_llen` should not be page-aligned for typical
> erofs images, you can just mkfs.erofs -zlz4hc with some
> file and check it yourself.
>=20
> BTW, I just check upstream, and the inplace branch
> works prefectly.

During testing I observed that the inplace branch was not entered with
my crafted image and incorrectly concluded it was structurally unreachable.
I apologize for the incorrect analysis.

Later, I crafted another image :

	COMPRESSED_FULL layout, h_advise=3D0x0007 (32-byte extents)
	feature_compat=3D0, 5 blocks total

	Extent 0: lstart=3D0,    pstart=3D4096,  plen=3D8192 (LZ4)
	Extent 1: lstart=3D2000, pstart=3D12288, plen=3D4096 (LZ4)
	i_size=3D4096
	Block 0: superblock + inodes + extent records
	Block 1-2: extent 0 compressed data (non-zero padded)
	Block 3: extent 1 compressed data
	Block 4: padding

Mounted with cache_strategy=3Ddisabled, reading the file triggers:

[   11.454290] BUG: unable to handle page fault for address: ffffed1100fecf=
57
[   11.459901] Oops: Oops: 0000 [#1] SMP KASAN NOPTI
[   11.466542] RIP: 0010:z_erofs_lz4_decompress+0x888/0x10f0

Thanks,
Junrui Luo=

