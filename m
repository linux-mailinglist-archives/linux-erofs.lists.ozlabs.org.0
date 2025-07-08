Return-Path: <linux-erofs+bounces-566-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCCEAFD542
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 19:24:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bc7Jf0nVNz3bVW;
	Wed,  9 Jul 2025 03:24:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751995474;
	cv=pass; b=G7SVTKD1NtVHPFZcfNAIIotxUSfJKN9JgtJvLGnWLVuAKX/GBR92bUAYlrWRX5OvQpRHqg1/9kY83XlCSD0/ZzMBZKKAW89TCotcfFG1ung48XQnlTO7dxPkzfeuK/Avm+01mpr1JvNYKB2BuUUGqMxsfPgz9FC7E3yvnKkqVEr6jLbsLUi2D+CXsm5FcAwA9yXJNe/XqWeWa7rPillcDjc27eMf7JZlua9SQUNwy5f47ZSyLIWTpFP91uMwllHFlYkCoIsDMkxdpKqevwkY+0gB+ro2z4e17Av6nGGuerovW4gVD8JK3rqQiKnP0gBipCA7VmZz8xZ/h1BV0PD0Xw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751995474; c=relaxed/relaxed;
	bh=rq5l1C9QRM7+loeI4sIz6eFkeAZKl3wJ+5oorTz1mFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SffGyWU7aYmGiPjN+jDQ6G6P5sG8wSFIp5aJOuNDnaYLlQz1P1O3CakZdAb3d6B0f3usYEU1vB7TyZwVUB6hHwWgN8AiBD9hkPJYD2wYoBi9lOodOganJVkvQdo7TUszdMyC+GRMtg4iB7ILk6jTYiC5Z9Ev7XFxu3DbQIJ0/X0zX6NiBvsTk1gXoH51I6+ema8tANZ7Zsx+XjxVY3JRksXsMrD7aUo5cWN4vvSj+OUEAySDrel3AzuCEHoWDZ7k+WOqWliZS1uzG94X0Q4TQfsuxOTmjY40X6a1BR6wuNOwnHCZZ2Jgw8yEpE/2Cox/B/pfUU09Q0vsnTTlVj1LZg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=UWCS5wPf; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=jan.kiszka@siemens.com; receiver=lists.ozlabs.org) smtp.mailfrom=siemens.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=UWCS5wPf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siemens.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=jan.kiszka@siemens.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bc7Jc41Zfz30Wn
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 03:24:31 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKki9sId2La5MLTEf5pkaK340d+tYDa7tUcke+LCZoRhb9CnXT2kE2NMXqohiEGWHQc5dnZIq4JkkYWPh8FPY35KlNrxP6qHsZwEjiHVfEoWUvbk6hECU2vmc8bSYAfiLfaV1nSxyeKmvSdY+NOKTxD+Dh2F9WWQz1lETVzkc4nBKqUnfGVX4anGZRcHHbYw/k4ai/E/9x/br/pYqk5wPWI7aURP5m8EO3ntNC4eZvMBWTnAZzjTBBqeLwHk3RtedEYc/h1sAmo5ErNN/EMf1OTIgQPdDph3cpo8WwVUAAe/eQXg6chAi3q2DD7cnNmjBCpajStq90yuExfhw+4Uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rq5l1C9QRM7+loeI4sIz6eFkeAZKl3wJ+5oorTz1mFw=;
 b=Un6x+0RRZXbyS69fMMp9xn/GSrdJWvEJGUtTLFGLn4q1GR64vjZuO7JK3eRGACyRVTUYrx2kktluD0j0ygW+M1XmKEVUPM2kBpbcRvZeo4iT1vzXKU09TocA9R7/aDQ4+B8v7w1I8r+DdWJiU+Q71dp1qK03b1fLTq+Qllk91o+9vuDENdHIZ5XJm4SH0pGWllRCmUejH5/D584MUE6hWnT1YvWoEtA7WKhHENbTSC6u9HMK1YRmUgDjRd3AgxkcHYTpgPHr7ANKj4SeqPW4y2M8TnDKTnrLMK5Jo/Mhw6odHDmwIGtquj5slMKAJwE3HJY9bd8/blebSlXIUZtXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq5l1C9QRM7+loeI4sIz6eFkeAZKl3wJ+5oorTz1mFw=;
 b=UWCS5wPfmQA4KC7JXQd1Pc0JAKAfm/S9khBGuSyq6yaWKbIk/OwLhZcSC7ARVUyu2SP04mZxlIIPG2ZyjDfa0r1VavU6l2qU3OsT2jtH8uSjLVq+nW0y0BijkzWtUoxPFR2tG3Z/gg1I01DKgk6QCZCTs8hrn07sOtOhGYGfpTiK2+FWYbmwyexa7ljEKQiUp0A2Ok9t2idgVooMMFskyBBJhPaKX62d35Q9dPYhCRWhckGwhUS9uP78sX1hZnPZOJVE/BsP3jEAsMtexy+TD4Pl+I9eeNW9xOXmu9/lqNwjEagO43PlvBi1xjc7+OtdMEAxivHZthgKy7mjrB/j2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8989.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 17:24:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 17:24:08 +0000
Message-ID: <72c30e9e-e444-4013-ad7c-36ab5655147b@siemens.com>
Date: Tue, 8 Jul 2025 19:24:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Executable loading issues with erofs on arm?
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stefan Kerkmann <s.kerkmann@pengutronix.de>
References: <38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com>
 <452a2155-ab3b-43d1-8783-0f1db13a675f@siemens.com>
 <bab2d726-5c2f-4fe0-83d4-f83a0c248add@linux.alibaba.com>
 <81a3d28b-4570-4d44-8ed6-51158353c0ff@siemens.com>
 <6216008a-dc0c-4f90-a67c-36bead99d7f2@linux.alibaba.com>
 <2bfd263e-d6f7-4dcd-adf5-2518ba34c36b@linux.alibaba.com>
 <edcffe3e-95f3-46ba-b281-33631a7653e5@linux.alibaba.com>
 <7f9d35af-d71b-46c5-b0ea-216bbf68dfe7@siemens.com>
 <eb879ced-600a-4dd3-a9d6-3c391b4460c2@siemens.com>
 <17432623-6d5d-4a8d-b4ae-8099c589b5e4@linux.alibaba.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <17432623-6d5d-4a8d-b4ae-8099c589b5e4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db0830f-6ff5-48ef-1c0a-08ddbe443f46
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3VEaVduMjJ4dG5Kc2I2UWxPSW0wTHpXL29Pa1hsV1FWNHlQSGxYazRjUW8r?=
 =?utf-8?B?eVdxSWpvR0FCdXFFeFNUY2EzTGtNdWZzd2FHZzhiUEkwKytlUEZoUCtvSm9X?=
 =?utf-8?B?emwzUHRzNEpKYXhMclMwbzRTM0tmNzNZRWFHYzNKUnFsdUIrK1JOMGVZNlAy?=
 =?utf-8?B?bG5kSjlwMEZXOS9od3lJZHZpa2l2M1p4V051Y29hbDV3dFJxc1RreEwzS3FS?=
 =?utf-8?B?bXlkTkl6bzU4c3E0UjR6dWVabDFhMEJTT0t4MG5PUE5naDFicG10Q1JZSUtV?=
 =?utf-8?B?RVRXT1Nla3l1eldUUlZyejdNZS9ySklTTDQ4SlFkRDVqU2R6c2FxM0ZYZWhY?=
 =?utf-8?B?bFpEbFZxRTlrcElObjd4cmxCZUlWWDlmSXlSa2tUZEhLUW0rd2wxcnp1bm1W?=
 =?utf-8?B?Q1FNczltbkdiNFVlTi8vMVpoWUFoTldBQzFsSjRBcFNML2xsY0ZKZ3o5UDBx?=
 =?utf-8?B?cVJWY1lMTzl5UEV0SStidmw1cS8zaUYzUXQ3a1J6MjN3elVLRjNpSmpocVFR?=
 =?utf-8?B?ME1XSElVYVlWUFJXQnpLQWF1YnBRaXVjaGNHRnh6ZzJqQWV5ZmwxMDBSRGtz?=
 =?utf-8?B?WVREYU5iaWhXbjJnL29zbXZEcVl5MlUwVEZPZ2FzZzJGQnBHcnNKWkFhYU5P?=
 =?utf-8?B?OTROQXg4NjlQc1JCUU9kMkpHVDRrZjBPZ2Vtem9jM3BOTXM3Q1VoVWZOTitC?=
 =?utf-8?B?TFdCTzhJcSs2WjI0VXZDUkptL3VhRVdYZDFhQmpwQnlZT0Nzd3VoVDAySmoz?=
 =?utf-8?B?NGFESWNwNFZvME5JRm10eWFGemYxam1jemwrczNBSVZrY0xBRHptcVdVWTJS?=
 =?utf-8?B?cGZMeWovZStXa01oYU41YVdBTlp2UTMxOXcrL0w4MDYvcFFIYXNWdEdSYVQ0?=
 =?utf-8?B?b0hvWjM2UTlsTVpoemErbjZUcHljRjBlOTdHbzhNenVwT2ZyWC9nSHdaaXht?=
 =?utf-8?B?ZXNneEMrcU5OS1dFRmNET2lYelpKVTd6WTNIR0pBbnZxcURKdTBoUVBYcFdP?=
 =?utf-8?B?WTdDYzYxRGhKdjd2R2tLaVBwY2txcEZRZ1hZMm5ubkQ0ckVCenFOeE1GempU?=
 =?utf-8?B?OEVaa2RrUHZMSkFBRnd0ZHFCdlRPQVZKRmRTU1AxSEdPRldQL3JCaWx4SEJo?=
 =?utf-8?B?RUtEcDQ4QUxBSysrVU5HbERUb1BCR1gvMDhreVZpa2diNnBMbmFkSDdMNHRV?=
 =?utf-8?B?ckFKMEdEaXlBbmVzNE12QWUxNUJucUdwbHJWVFV2SmtIYmNhNFB2LzhXcEJP?=
 =?utf-8?B?ZW9wWnd3WmpCTDVyMlhvUC9GVUlBQjZaMGpIbzFOSzZwQWgwUWpjRkpnLzI3?=
 =?utf-8?B?MjNjN3hHLytqT0V4eU0rOXFFRmlRTEFNNC9pZGt3Q2thQmtuSUpqY0dpUitJ?=
 =?utf-8?B?MTlXK0pPRHRUUlIwbTg4VUxkbWVOR1AzbWdxWjFTbU5pbjB4QXNaT1lKUys2?=
 =?utf-8?B?d1JrS2RTaDQ1VzgvWkNKK1dNajhLWWhGYXdzbTJPMDQ1QlRlZkg2U3JWbHM2?=
 =?utf-8?B?MkxTWWNlcFFBMlBPU1M0M0ZmbWRndXUxWlJhb0JYWEVXOHEwdVU5dEVPTGZq?=
 =?utf-8?B?SjZadmVQN0hvLzloZ2JmYWZtUGJXY3o1STVyVFNrK0hQR3Uzc1I4dEZFM042?=
 =?utf-8?B?TXpJZWtGK3cyT01CUzNvTU5OME9RSktNTnFsb2NnaThMZ2lOTlBPSGNiVXJH?=
 =?utf-8?B?NW05cE9rY0QxNllueUxKTkdjNkt1akwvN1hRUUIrSVY0QXA2Slpmd2wyNHNF?=
 =?utf-8?B?aGZRMjlMOWc2UzFacHRXcnQwcHhKelB6bCtyaEtXZjJwMFlwZkhPdU1EQmc1?=
 =?utf-8?B?ZWhKUERvSXhvTllwSXpkU1JBV1E2bWZuVkU2ZmdNVEFyZ2ZEMDRHcXI1UUZm?=
 =?utf-8?B?SWQ1a1UxYkxOcTRWSFh1NkxnR0xIcmJEbGJFSE1FY3lMcU14RnpyOXNhS0xF?=
 =?utf-8?Q?MFaEg0h+Mhs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjlqdWQ4b1RKemRiQUQwV2VmZzZRaENhNWpaczdvYnREVk5HMWx0M3lha2NK?=
 =?utf-8?B?QUtDdDhhOU5ndWVHdS9FTVNIb3RQNk1HY0JCRUVpRnliT05oTThkZUlFUWNZ?=
 =?utf-8?B?ZUdySk1JamV4cXBHVzg3dDJaSmJVb2NHcDl0aVozWUpRMWNRMW13UGtyVE4v?=
 =?utf-8?B?N1RNRlZyWG1Ycmw3RmVMRkV5bHE1dUVhbjhhd3I3bGRkOVIrYmVmOVJuYjZD?=
 =?utf-8?B?YXVPcEhkWW1QZlJwS3ZucWptMkNqTndCaUphVWpIVU81c014NThueE5vRVFM?=
 =?utf-8?B?NHBIS3N5YTVpb0xITjEvcy9SRkNGeGRXNTJxWm1hRTJGdHh6bzhTVExEemw0?=
 =?utf-8?B?QnN2RHkzTUgxR0tCTVh1Tml5ZDZHR2hiZ1BDTWI1L1d1UXAyS1Y2RTlvWnd5?=
 =?utf-8?B?cmJ6RVc1aHJxR3FwdTRmRUREU1MrRkJISTBKVndmQlZQVnFLbmFhSDVlVTdz?=
 =?utf-8?B?RUw5d1NSS1Jxb2NmenZqNFdqalRGNEh0anpaMEhXTTI3N3VkajhwQnpwZ2tz?=
 =?utf-8?B?RmZyL2FPZUQvZFpsU3BOU1c0TXArVWIzanZHSVVsU2hKUVUzV2I5bzM0U2RN?=
 =?utf-8?B?TWJXVDdrNytlSEVqWTR3SkFzTVZnU1E2MUdPcW91TTc4azZaKytNZ3RKdk9s?=
 =?utf-8?B?cWd4ZHR3NkZqeG1ONklyRjh0OFFSalpQTUU0dUpnN2M1SVZmdzFWdUE1OXJ0?=
 =?utf-8?B?dk1ZZVUxaitzV3VPN1ZpbzZxTFUvNWFCL0ZQSUNvakgzRW5TWXFVTUxaY01a?=
 =?utf-8?B?cFkwdnAwd1Z2REdYRzhRYnRpNnZiR2FraDJIWi9RQlUzbGFRbGd6cjB1WFpK?=
 =?utf-8?B?ZnJsR3cxcFdCdmtHV2RMRmNZdUZjMzZXcnpUVXJ1WXZTT203MUkycWZ5UGZI?=
 =?utf-8?B?UUtYejhHYVl6N0wzeEN2cmlnVkxJTGtSWGVUNHhBZXFMeXpaWW0zWUhYZ0dZ?=
 =?utf-8?B?TitoQ0VIdFAyTUFzVnFLVTRMczdKMFZTR3VIZmd1WGdmNEVJZGRSa2xwTW8r?=
 =?utf-8?B?a1RTbUQ2cHNhcTRQZ3RxcjhTZTdhVDF1T0phWEVTclIzRlZCWm5zeXpVdElx?=
 =?utf-8?B?YzNiblJlNVdDVUpoK2NQczVpSFNNZGtycDJIdnlmZGZEd2xkN3J2OEhlUnhL?=
 =?utf-8?B?QmRIamp4SDBaZVVwNnNmWENWYzBBWVJ6N2ZJS1poeXY0ZW9WS01oVjFFM0U4?=
 =?utf-8?B?VkJyb0NjL1RDdnJRUEdtSWxBTERnaTk2WVdwOGFQTlpwVEFucDBYcDY4Yksr?=
 =?utf-8?B?ZThJVFdSNlBBUWRjVDVjL253V0lIUE1VOFArblVHVkxnQnhpb0hkTkJwcDNJ?=
 =?utf-8?B?YmZLLzdKOStzR0s1QzVKbk45T0VmVDBMWm5GUFFENVV1U0Yvcm5Fc2RFN3dJ?=
 =?utf-8?B?TDJwZWNBUzM5ZFpKZld6Rk4xcUdscXVpdDdHd3JSYnB1SnRhTzJ3NTN3QVhV?=
 =?utf-8?B?TlhaNE1mOWQ0V0E5U3djdHFYbmZyZldWYkxjUGdKc0dqYmFoenBiRjdFVEFm?=
 =?utf-8?B?WGIxNHVtTVFTdkI2a0Z1Vll2RGQ2RWUzNGViVWs5SmNjUHpmTStlK2JjMGE0?=
 =?utf-8?B?RXNMRFJJODY0bFR1TlFaR3ErVllscDNMeGxwVUI1R1NRc2pQM1dkVUlSTFJG?=
 =?utf-8?B?dTh1ZlRRQVZnZWNNdExsYW9KclovK1ZWZENZY3p2ZDBIbFQzcmpWMDlrRm5v?=
 =?utf-8?B?N005S1RRWk9GU2FMeGZPeHZPVnJycnprc3RQblhKVHRWaFl0WUVlcCtBQitk?=
 =?utf-8?B?Zy91dklteUE5aHl3MEVEaG9KUEtQSzY3c0liUEFZRVpITlQwN0JNdUdOb1BM?=
 =?utf-8?B?OEJ2NUdkcTgreG1MUDJJWmRPT3d1T2o2VzllSTNVb0NwM0d4UnFzU2FQV0Vp?=
 =?utf-8?B?SW1UQytHOUxLUUxkK1ZZUEtRRnJwa3pGUUxha1JndlNmZTRxVjZGNXVZbHFV?=
 =?utf-8?B?OHNUNG1TRm45TEdzMzgxWVhtK0UyazlsR0E3Tk5SVU5QVUNNd1pTWjFXWCtF?=
 =?utf-8?B?SEJKdkNVQ3dQTkNvbWJHWGNVdHloMm5FYTIremNtNk1GTjJ2WDlmWGgxOE51?=
 =?utf-8?B?L2RiYlVmWG1xdUg4SEc1ME9MM0VuMGRGcnhISEtVUlJqZFF3MExIM1hTOVhB?=
 =?utf-8?Q?aSEomQl6SkJJzxhWn3YNhsL6t?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db0830f-6ff5-48ef-1c0a-08ddbe443f46
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 17:24:08.6303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6o3a1ElDIcPFJDXmWjGJtXceXlrUxekvBqr6AAUjbzP+4EqS55wa0Ujm5ndN7qai5yCkDw4oK8StjhXL2rqfrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8989
X-Spam-Status: No, score=-0.7 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 08.07.25 19:09, Gao Xiang wrote:
> 
> 
> On 2025/7/9 01:01, Jan Kiszka wrote:
>> On 08.07.25 18:39, Jan Kiszka wrote:
>>> On 08.07.25 17:57, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2025/7/8 23:36, Gao Xiang wrote:
>>>>>
>>>>>
>>>>> On 2025/7/8 23:32, Gao Xiang wrote:
>>>>>>
>>>>>>
>>>>>> On 2025/7/8 23:22, Jan Kiszka wrote:
>>>>>>> On 08.07.25 17:12, Gao Xiang wrote:
>>>>>>>> Hi Jan,
>>>>>>>>
>>>>>>>> On 2025/7/8 20:43, Jan Kiszka wrote:
>>>>>>>>> On 08.07.25 14:41, Jan Kiszka wrote:
>>>>>>>>>> Hi all,
>>>>>>>>>>
>>>>>>>>>> for some days, I'm trying to understand if we have an integration
>>>>>>>>>> issue
>>>>>>>>>> with erofs or rather some upstream bug. After playing with
>>>>>>>>>> various
>>>>>>>>>> parameters, it rather looks like the latter:
>>>>>>>>>>
>>>>>>>>>> $ ls -l erofs-dir/
>>>>>>>>>> total 132
>>>>>>>>>> -rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
>>>>>>>>>> (from Debian bookworm)
>>>>>>>>>> $ mkfs.erofs -z lz4hc erofs.img erofs-dir/
>>>>>>>>>> mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm
>>>>>>>>>> 1.5)
>>>>>>>>>> Build completed.
>>>>>>>>>> ------
>>>>>>>>>> Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
>>>>>>>>>> Filesystem total blocks: 17 (of 4096-byte blocks)
>>>>>>>>>> Filesystem total inodes: 2
>>>>>>>>>> Filesystem total metadata blocks: 1
>>>>>>>>>> Filesystem total deduplicated bytes (of source files): 0
>>>>>>>>>>
>>>>>>>>>> Now I have 6.15-rc5 and a defconfig-close setting for the 32-
>>>>>>>>>> bit ARM
>>>>>>>>>> target BeagleBone Black. When booting into init=/bin/sh, then
>>>>>>>>>> running
>>>>>>>>>>
>>>>>>>>>> # mount -t erofs /dev/mmcblk0p1 /mnt
>>>>>>>>>> erofs (device mmcblk0p1): mounted with root inode @ nid 36.
>>>>>>>>>> # /mnt/dash
>>>>>>>>>> Segmentation fault
>>>>>
>>>>> Two extra quick questions:
>>>>>    - If the segfault happens, then if you run /mnt/dash again, does
>>>>>      segfault still happen?
>>>>>
>>>>>    - If the /mnt/dash segfault happens, then if you run
>>>>>        cat /mnt/dash > /dev/null
>>>>>        /mnt/dash
>>>>>      does segfault still happen?
>>>>
>>>> Oh, sorry I didn't read the full hints, could you check if
>>>> the following patch resolve the issue (space-damaged)?
>>>>
>>>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>>>> index 6a329c329f43..701490b3ef7d 100644
>>>> --- a/fs/erofs/data.c
>>>> +++ b/fs/erofs/data.c
>>>> @@ -245,6 +245,7 @@ void erofs_onlinefolio_end(struct folio *folio, int
>>>> err)
>>>>          if (v & ~EROFS_ONLINEFOLIO_EIO)
>>>>                  return;
>>>>          folio->private = 0;
>>>> +       flush_dcache_folio(folio);
>>>>          folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
>>>>   }
>>>>
>>>
>>> Yeah, indeed that seem to have helped with the minimal test. Will do the
>>> full scenario test (complete rootfs) next.
>>>
>>
>> And that looks good as! Thanks a lot for that quick fix - hoping that is
>> the real solution already.
>>
>> BTW, that change does not look very specific to the armhf arch, rather
>> like we were lucky that it didn't hit elsewhere, right?
> 
> I may submit a formal patch tomorrow.
> 

Great thanks. I quickly checked backports, and it fits cleanly on 6.12,
but at least 6.1 requires more work to find a home there as well.

> This issue doesn't impact x86 and arm64. For example on arm64,
> PG_dcache_clean is clear when it's a new page cache folio.
> 
> But it seems on arm platform flush_dcache_folio() does more
> to handle D-cache aliasing so some caching setup may be
> impacted.

Yeah, that would explain it. And Stefan (on CC) was on an arm32 as well
back then.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

