Return-Path: <linux-erofs+bounces-564-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1604AFD3EF
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 19:02:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bc6pn208Vz3bVW;
	Wed,  9 Jul 2025 03:02:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751994129;
	cv=pass; b=Y6by/5T6ZV3VyyTSspbH3QggGwQe747W3scZQcZSo4EyRPkLckQiXauf26p9tDhaUsckdMRT+dDUz1gij6samqH1q/qA5myqLlUwgnXXapiF+anBSOBY4sML1bdOBYMfg5WSWaLgv8zH71tXthMjJjYZSgx0hgiOMrL5AVHN9/fVK9SzjIvFK8hUB9bTjGabRQiCV9iZKzzxM5j4U7C3BQkjZ1NmBx/yFpgHeejI25CO4I6Gyiprty5rHrwGmnTcuiYCIItOC9jMjp/fLKIDav/dWcVwdnJMz1lLI1vpR1DHkFJWotmOk1YuulUJiZ98KECpQ4Wk2tJd4NJFIybqaw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751994129; c=relaxed/relaxed;
	bh=8WEcifdiWHs52T6sIW/VAyZvuHeUTksxAdW79RR6C0o=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MWH74r9ZoBrWQx38Dk8rMuAnRbP2sGC5jneG169D9xdUECmfuYz5E4rlxffJ/JLTgCfClsEJeDH54ucmu379BOPBLF43Tb/YJedLKSlLg7I92chj0W4RHjUL3MbxCNyHW74befFFh0DblsMl6Up7cM5LFzxYSFpytx0KPoJSdgHDkHBULAHo65XNt52QSScTtSRCyejV6H1BMuHpNopr5FZ3/y5vrCpe6vYMyZ34/8yuYnUEBJ5Ljm71IX2HI+qcfAxzjPAYoYVs3paprBG76Lq9g8m99qE2K+gsL4YfPLULTr1W5ZRJVFmq7m6g6KxyooBCbikPY9tSpi2TkARmGg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Sp9T3pC3; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=jan.kiszka@siemens.com; receiver=lists.ozlabs.org) smtp.mailfrom=siemens.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Sp9T3pC3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siemens.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=jan.kiszka@siemens.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bc6pl3d8tz30Wn
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 03:02:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2pMsYKLReXSSpxvDO2Q1cNSMd1LoWSqhBNJ5N06atQsSFJg00ubB9A8QCZfpvHS5a9rf0oTpwZGie3R8gO8hIdImy7JqaUISaFPUUy2QGFnhp7xhlPZbhRwLECac+nv4XU1BkrlH50UxD8+0uyrCEUOjBzI8aS7+HTktAATI86uQc6F0lrOcE2quXzq7xwnC/QCwkldCjmTYOIHML0qCgyh7IGZp48SDgaTJ2ghz7Q2+D/Yub1Il0cfTJyWuXK9GyHrIBypkJe0QC2dNjpV8RR46oxLV4xBW++2Qc95fsRfu2J0BfDtNQ3dkmB6bNVqhH+JNApOaVum3q4eXBhtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WEcifdiWHs52T6sIW/VAyZvuHeUTksxAdW79RR6C0o=;
 b=WoNOsMAUodRWtagJa1JRtR0+6T4SE5MfBN1rcEUERUn4+Mxep0LrFBGEe3in3xlfwXS7IJ+lHRQtPvPHg2tK3gXvSG/LupkroWU7524nD+FBBL8uykdJFScWe8wPwQfMfygLys7UQ7aKC0DEJY60ERzrRHQKzIQRpq4wfR0WtyqmwmJMh+bvha0YSc8vtycf6OXujjqNOnJK9gVIrwnrrUxqawC8wWSrTjGsa8blA6vKH6tV/Dct7LM2JAPpCXnm+u9wX+G3fUynRc0FMjQj0jDxY2WFR1KvXzxG5phsGxNGc5aAPyTKXFbW87HDR0fkpqvFyvBfgG5URoyjRORsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WEcifdiWHs52T6sIW/VAyZvuHeUTksxAdW79RR6C0o=;
 b=Sp9T3pC3fgRLiEQvvxZsyRgJY6YVxWyTCPJOKorbF0PGmyCiL0iBMmGREktN1DaQrQA2E8+j8/4kSjzQ/zycCo5m02vbigaEcXeAy9KQAlc8v3JsH2t0nyQmbSsBrujO/MHyMkAFPABct9ZNyOjM+TsShJSwg0jT939g3I1CR/ZO96GYMLHuQRZIHnhR3pbSzTTYP5VuBTF1E1PW4Kp2CcHvfCR7ey8QojNHOMIBHXspqu7MFfysrs3tVSFZiyzGNco3kW9S1Be0TMP2rk5JLlzK+yU+NRVQ8uAfrH9ryxk09g5VTl65ZeBzfBfXsnL+x3JchjeyvnIbXKo9kvB7aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB9328.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 17:01:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 17:01:43 +0000
Message-ID: <eb879ced-600a-4dd3-a9d6-3c391b4460c2@siemens.com>
Date: Tue, 8 Jul 2025 19:01:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Executable loading issues with erofs on arm?
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com>
 <452a2155-ab3b-43d1-8783-0f1db13a675f@siemens.com>
 <bab2d726-5c2f-4fe0-83d4-f83a0c248add@linux.alibaba.com>
 <81a3d28b-4570-4d44-8ed6-51158353c0ff@siemens.com>
 <6216008a-dc0c-4f90-a67c-36bead99d7f2@linux.alibaba.com>
 <2bfd263e-d6f7-4dcd-adf5-2518ba34c36b@linux.alibaba.com>
 <edcffe3e-95f3-46ba-b281-33631a7653e5@linux.alibaba.com>
 <7f9d35af-d71b-46c5-b0ea-216bbf68dfe7@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7f9d35af-d71b-46c5-b0ea-216bbf68dfe7@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d86da31-89e6-4309-f1f0-08ddbe411d90
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzZvbEt2ajJjSFpQQTBjQjd0SE13S0ZSa3U4VFcxZElRMzJrY0J1UnduRkRj?=
 =?utf-8?B?eFBvN1JJSmNtaEppOVFEVnhGaloxOXd5bDRpQzBiNUh5R3FONDRSeEpDRGhC?=
 =?utf-8?B?Z2FDNzVEdDJrTlBIMUJlcWNXNUY2OXg4dVJVODBhUkZPZzBycUVoVythUEhX?=
 =?utf-8?B?eTcvMzJkR3AwWndKRnpSeXZRcmtJQnlUaHFLNFRqN2lXVGI4cUVSYmhKMlZr?=
 =?utf-8?B?OGovOXBLSG5BOVhDTFo3YUJFcHdnci85NWJ1UUQ1dGVNaXB3ckQyL0ZDWnV2?=
 =?utf-8?B?NGdVUUdCUnFQYXJVVk1QcC9CY0V4TFp5ekM0d2VwRnEzdGcyNmJxaklLMU52?=
 =?utf-8?B?eDhsQWRPVnBvQTlhcTArbGE4ci9NcmpCcUdDOEMzVFVtdHlPbE1qN1ZvMmtJ?=
 =?utf-8?B?TU1Da3ArK2p1c1NhN3pZYnZJU0MxVkFnb0MzYk1XK1FQL2JERVN5WDA1SEpH?=
 =?utf-8?B?RFd1dkxNVXZ5WCt6d3lmdzBLSkRVY1ovYk5XaFVxM1BlRzRnbnI0dzU0azRC?=
 =?utf-8?B?c3BYMnBpR1VTWTB6Uk5VcHZ1YUFqVEhsUDZiQ1hvdTVhR0V4MmsrVHBvM3pE?=
 =?utf-8?B?VnpBaHUxZ3NKWnN5cEhxK2NiT0NOVnp4ZXdYbEY3d2lhbEx4WlY5Z3pBQ2ZD?=
 =?utf-8?B?OEc0Q1l3bStPazFEMjliNFJxVS8ydzlKQ2RQT1ozbDJWWVpCYXc4cVFxY3lS?=
 =?utf-8?B?OGdmakhtK1lwSWYzckNsaHJkWGxTMTlQSHllQ0p6TGVaYytKNllQVG9ZTGVL?=
 =?utf-8?B?Qi9CbmJ1NldXYUFtSk5hSWRySmtjRDgrSXc0RWQrTEV4L0gxdy9teVE3Vnpi?=
 =?utf-8?B?T01hL3FCZ3dSWnZZd2VtLzVBbC94VW9QNGlMZk9oemN2aWgxY3gyOUc2ZjZU?=
 =?utf-8?B?UUFmUmdmWmpiaXluTEllRmZyMk9SS05MM1R4Rm1HY3ZQaTQvRkplM1BWZTVF?=
 =?utf-8?B?cFNIcFQ2aFhxaitMUzg5L2plT2dnTWhmTXltMTdjOHhqMWo3TzUrdlFiTFVl?=
 =?utf-8?B?dmUvZTBLZitEM0tyeHFmK0wvelJDVEt5M2R5YmVHOXREeFA1M29IclNZT0tM?=
 =?utf-8?B?cVNYQUxvZlp4clZSeFg1STk4NndIZzVscWRUMVJBMlhPOGp1dkpFUUNaVHVt?=
 =?utf-8?B?ai9EYjlvL3hiRk1maDFrYjYvR002T0x6ajVSQkU1Tndtb3ljRmVjdzM4Rmty?=
 =?utf-8?B?bHJCc2EzdnlzeGNVeFdFRWczQzRrbGhldFI0WWhOSzlOTVI1S1lpREJWODBr?=
 =?utf-8?B?eEFoZWlYQUtKZUo4eE5qd2N6Zzd2UnB6cU1vS1hLVzR1T2dLSnFKNkxmVzZq?=
 =?utf-8?B?M3VOQm9SaCtYL2YwVWpNMk1udEZmVEFWcDdraWFFQ2Q1SEpueURRRUNJcmhQ?=
 =?utf-8?B?c0dTdW8xTTk1VlJNNkszb3d3akZ4TUlsNk1FNS82YVpwYVdPVysyUE1obDNm?=
 =?utf-8?B?R1hscXljdXhMVCtWZStsWkxjNmhIZTU0Q2hNZzRnQkpKL2srVDZ6MEFLdUZl?=
 =?utf-8?B?S2t5dkFEVC9rVTNIVW52TnQ5NkhCY3NwbGhkZWY4cFJuUnBEUmFHck1JUFRS?=
 =?utf-8?B?Y0kwbUduSklsWFRGRkc1RnV1aGg5cktGbnJCN3VKNFBsNEFseURYOTJzcFA2?=
 =?utf-8?B?Y1lCK1dJckRuM0hHM0ZZelVoSGZSSlR3eDdzeEdYNkEzWUx6M1NBc2ZLaG41?=
 =?utf-8?B?VXkwb2tScUJoMVB3NGkzUm43WXh3Qk55UGxnbjlESG1PK0dFWmlOR0xXY202?=
 =?utf-8?B?Vkx5Y1BPVkYxZE9FWSt6RHYvVmxXTW81MW04ZWMyYlVkUTl1dW9sbCt6THZs?=
 =?utf-8?B?ZjlRdUlYNVBJZURNQVlQb2E4RXNiZysvck01WTZTUjVOMzVzZkhlYVRKTmRS?=
 =?utf-8?B?aWZtcXIrcFRKNnQ0Z0NkVTV0MytZUEFTTHRONHZYMm1hTW5hemhtekNWVUEy?=
 =?utf-8?Q?hyBo8FEH8jw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGFoZEtkV0xSWFZWSzNHcXl2UlJiNGo0VGRzdk9wZ1RSWGdzWGRRaGo3RzIz?=
 =?utf-8?B?WVlTb0hjSmhrek53T0pIU3FPU015Tm1tUFVHNldYZS9uV2xmbnVMR1haV2s4?=
 =?utf-8?B?b0JkM2R2SHNBb0pOeWJpT0NXWmw2bGVaN0V2Uzdud3JlbmVLY0JGejlyb3Vz?=
 =?utf-8?B?ZnFHOUtiY2pmRUw2WUJvdStiZ0xpZm4rSXFNM2lqOGZKem03My9walRXSDAz?=
 =?utf-8?B?L3J6a2xwYVVtQ1dSa2tJZmMzY1ZXZzdWcXRtNWVVcEZoa1VqZDFuZTg2SFpI?=
 =?utf-8?B?NGxQSlUyV1dCZVVGQitpcEM0ZnR5WEZKS0RtR3lnR2JBUWhxRGRTQmQySEtI?=
 =?utf-8?B?RGsvbDY2d211QjhQQ3NzK2hDYnF5TU1XYjAxMnhSdDR3WGFIb3RDRGZLQ2dK?=
 =?utf-8?B?OWwwY1NrQXRqZUpGbXJrMXdQL3Z5WlJQVUw3VW9BV3EzMVZlb0J1c1piWmxO?=
 =?utf-8?B?Q1Z5dThQenJpOXF0am15YlR5WVJkQjFFQjdhelMxM3dxWVpaL1hVWWFTQjhC?=
 =?utf-8?B?dFdGTU5neFpDRktBM1Zha285SUdCYXFyWVFQZlZndi8vQlBRZWEwK29UWUIw?=
 =?utf-8?B?cStGbW05M21oZFNYSEVLVk5nbFNkaDZ6Z1F1RVl6b3d6TWI4N1dCN2VCQmhq?=
 =?utf-8?B?d0ZFQUExZGRWZTVkZ1M4TFo0Vm5RYzgrc3JoTzFxSXhyOU4zWHlsRjd4NjZX?=
 =?utf-8?B?bnQyODJ3dVNpOElnTXVSUzJIRUVlQ04rUGNCM09EMVIrYXk5NCs1WkpXMlNN?=
 =?utf-8?B?dlpOL1A1VFAyeXFYSE0zREVMM09RV056eDJkR2h3TGk1K3I0VXJSK0p4ZnJR?=
 =?utf-8?B?WW10dEtmS1hENU9lQ3N1am8wTW9hN204T21NY2Y1azUxV2Q2YTdDR2RXaFBt?=
 =?utf-8?B?U2ZzS0lpWmdhNmFOSXFOWmJuTmI1VllaYTlES3FkbTBGSjJkTmtZTTlJQldl?=
 =?utf-8?B?Y0dPa0RuR0NORFRYczVZNmNSdDMwOVRvYkxSbExmNndIZmdDNnV0WE42RU1H?=
 =?utf-8?B?dklHUFpEajQyNEF0QkhUS1htbUEzZnNHbWZXN2V5YitwNDRSUk95Q1BaZVM2?=
 =?utf-8?B?SG1GVXlHeVZ5N0trQ0tGZmJTR1ZzakZqRENnYWV1ZEhiNDhuV0ZtNEk3TXpT?=
 =?utf-8?B?bDBGQUVHSmdIOWcyVEFDZGdHMU9xa1g4YUpCY3ViZkUra1JoSm8yVWhQNGdl?=
 =?utf-8?B?ekM1M0FKb1p3Tnk1MzBwMWFHWDU0MVBMVzU2SSt2aUdnV3dDa1pCM0pUUkN2?=
 =?utf-8?B?YVNzZVgyWE9GQ1oxSHRsY0FPR0VSaC9taEZ6UzlDcHJmK1BiVXJjWXN5NHJ0?=
 =?utf-8?B?QXdHVkZaN0hqcGlnQWlZdWhHZ1pDZW9zakNiY3ZlNmxuQlZPSk1tSlBxVlFO?=
 =?utf-8?B?YXYvRTMvRzk5UHdXQXNGTnUwU3FIbnY3UTBFMnVuZUdiK3cvbDhKOGZ3L1Zn?=
 =?utf-8?B?Vzg0ZHBhODNscXIxc0JZY3d5TlZKeVd1STdhdWZMbkg5TUdwMVlRcFFmeDIr?=
 =?utf-8?B?TDRCeStDZStzclpLZVNNSEtFcDNjUFpZeFg2bmpCbnd2VjJZK1d4TE5nOWd2?=
 =?utf-8?B?Sng0Q2ZQcy81RUdMZHovNy93Y0pUenBqU1pDem45MXRKOU9sT2VqeW9SL0FL?=
 =?utf-8?B?djByQ29ta3JFZ2FFTjlIVGdqYTBtSlJoNTNBUmtib1pmS2lLbTFTYThsSUNY?=
 =?utf-8?B?RXpsbnhHMTRnL1A4bkxwVlA3RERwMlptUVVvUUVEc1YxeUZzUkd4clFsUVk1?=
 =?utf-8?B?MElGQ1ZUekppTmc2VVhrSSt1QkpNcG5aNzZvQ0k4WDRCUmlUTVdzNEpaRmFp?=
 =?utf-8?B?UjRtT1U4Z3YvWkFQWi9CdklzQVV2V3lsejNsTDJha3prM0N5d245bzhBbXVT?=
 =?utf-8?B?S2t1YVpidnNob1oramNPS04yVTJrQ2Qxa2I1RlhGRUtyMjAwTEd3d0krS20v?=
 =?utf-8?B?TVhBWDVTdXRwbWZ3VGIwR0dzNXNxWFZsajNNQ2V3SGpSRzRpMXkzeXowTkdM?=
 =?utf-8?B?eTZMVmFmNEZVMVE5N1VZVWpaWXdRZ0lpekJ2WE0vMjh3SW9UakZtdUZtZTNN?=
 =?utf-8?B?UzdGVDNUeGZZbzVCVWRtRGxBZTZISStzTFlQcFRCeCtXL0tjQlhXckpVSVh0?=
 =?utf-8?Q?0M0LngIHYV8g6fROtO1T+1EO9?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d86da31-89e6-4309-f1f0-08ddbe411d90
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 17:01:43.5969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbL5yF7U0586DnxIT7ahW3pQhHTU1ck9B5d+McTpKfbhyKkl1bj5WEo2E8InVWqijbtESvKrFBXleyWx4o1cDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9328
X-Spam-Status: No, score=-0.7 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 08.07.25 18:39, Jan Kiszka wrote:
> On 08.07.25 17:57, Gao Xiang wrote:
>>
>>
>> On 2025/7/8 23:36, Gao Xiang wrote:
>>>
>>>
>>> On 2025/7/8 23:32, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2025/7/8 23:22, Jan Kiszka wrote:
>>>>> On 08.07.25 17:12, Gao Xiang wrote:
>>>>>> Hi Jan,
>>>>>>
>>>>>> On 2025/7/8 20:43, Jan Kiszka wrote:
>>>>>>> On 08.07.25 14:41, Jan Kiszka wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> for some days, I'm trying to understand if we have an integration
>>>>>>>> issue
>>>>>>>> with erofs or rather some upstream bug. After playing with various
>>>>>>>> parameters, it rather looks like the latter:
>>>>>>>>
>>>>>>>> $ ls -l erofs-dir/
>>>>>>>> total 132
>>>>>>>> -rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
>>>>>>>> (from Debian bookworm)
>>>>>>>> $ mkfs.erofs -z lz4hc erofs.img erofs-dir/
>>>>>>>> mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm
>>>>>>>> 1.5)
>>>>>>>> Build completed.
>>>>>>>> ------
>>>>>>>> Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
>>>>>>>> Filesystem total blocks: 17 (of 4096-byte blocks)
>>>>>>>> Filesystem total inodes: 2
>>>>>>>> Filesystem total metadata blocks: 1
>>>>>>>> Filesystem total deduplicated bytes (of source files): 0
>>>>>>>>
>>>>>>>> Now I have 6.15-rc5 and a defconfig-close setting for the 32-bit ARM
>>>>>>>> target BeagleBone Black. When booting into init=/bin/sh, then
>>>>>>>> running
>>>>>>>>
>>>>>>>> # mount -t erofs /dev/mmcblk0p1 /mnt
>>>>>>>> erofs (device mmcblk0p1): mounted with root inode @ nid 36.
>>>>>>>> # /mnt/dash
>>>>>>>> Segmentation fault
>>>
>>> Two extra quick questions:
>>>   - If the segfault happens, then if you run /mnt/dash again, does
>>>     segfault still happen?
>>>
>>>   - If the /mnt/dash segfault happens, then if you run
>>>       cat /mnt/dash > /dev/null
>>>       /mnt/dash
>>>     does segfault still happen?
>>
>> Oh, sorry I didn't read the full hints, could you check if
>> the following patch resolve the issue (space-damaged)?
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 6a329c329f43..701490b3ef7d 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -245,6 +245,7 @@ void erofs_onlinefolio_end(struct folio *folio, int
>> err)
>>         if (v & ~EROFS_ONLINEFOLIO_EIO)
>>                 return;
>>         folio->private = 0;
>> +       flush_dcache_folio(folio);
>>         folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
>>  }
>>
> 
> Yeah, indeed that seem to have helped with the minimal test. Will do the
> full scenario test (complete rootfs) next.
> 

And that looks good as! Thanks a lot for that quick fix - hoping that is
the real solution already.

BTW, that change does not look very specific to the armhf arch, rather
like we were lucky that it didn't hit elsewhere, right?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

