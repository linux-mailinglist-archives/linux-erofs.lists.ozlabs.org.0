Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33FD3F6D90
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 04:54:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GvVtN65Y3z2yK3
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 12:54:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1629860044;
	bh=m66WivCPY5nKQenTLKLSMBpH3a0Suw2bP5kyBDq9xXs=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=AZFsC4a6qz7ccqGtL9Et6SYbZqF9MsXFB3HwT1pB5bSF1zOZYxe3V+jPWZjHvFNpT
	 b2V2J1bMYfFzK9ct4zQNJ4Ca3bu7jeub5yY4Vx7Dv1Xf3ikN1s8jDjOzHTSGfFFouY
	 vWSVTlCO4xT+M15LFqoWxGBiWPCzppkcIaHJg3HECEot0t38cm/rkRsJVjAfuy1ogZ
	 6i3UgUgDQHmIgxEiWiRO0UFKL4uephLAZlJkoJ8lIpuL7KsmXI31VvoogIcU6N5N90
	 USiZ4LjcHdAm1fR2ahUt0wPbwLM/58l+DIu/EzaQu7SaL1SPcfpRiuvY0+7KnDSPdA
	 9LT5N/UHkkLzQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.82;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=RM0D0JiS; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310082.outbound.protection.outlook.com [40.107.131.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GvVtB377Mz2xlF
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Aug 2021 12:53:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLpkWBFNbCj9tg9LAnwdD58pu8Us3/zTMfKbQVpFb5bOBuYeIwvy14+SA7+xzuyteYRsPt3c0yhYxKPN8pbVyITQC7qJL3rBwiOBYbjxaNU9Qpfy9ZJiqAhEfCd2AHpelBF2vIeld4oIWpfvKRC5yaHbZ1UdVdbY7DX5VjxvWxlzu/kj4CLJrXVScusArrFtQztYC0tSsBIUs0wdHMdJxXBQy56NFsTudvOEa/K4OYDY1iaMPwlx04e64Ov4d7JrfDu0MSOEZGv5LqjfZ/PXGgLaGvfsWpGEoRmh7nB4bsAM99GxgvWbRSobGGvyuAGhQFts17AbP95vqRXREhuZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m66WivCPY5nKQenTLKLSMBpH3a0Suw2bP5kyBDq9xXs=;
 b=VVjFyAkmp4SePWmwwQHnR5YGApglDei+AVM7uIYJBI0x8VLoNBrnG/9HHh5ptZzVhueHK/J67XLfOOpttWFK5vw2T9WCMbOjJitqYNfU0XsRY9ejNHHELG2Z5zxJbE2PzU7AtbdwvuFt7+RurR2y/IcT7/IxIUiBXbT5csC2T6MDNci91Up937w74xPDquzZJ6Wt0wR6Zo8EmjoeLtHm68HQ1CcC7F8CXoW7s40Np77DtWACgFa5hKKinVGVKnOY+2vcyxFTtmtE8KqhWGV4uXZRuZvAA/P1a3I5bCTnw5k0IRJJjfMyiNzWwK4zalz6KUfGM3I8+tzev7FwaISkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3114.apcprd02.prod.outlook.com (2603:1096:4:62::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Wed, 25 Aug 2021 02:38:04 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5%7]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 02:38:04 +0000
Subject: Re: [PATCH v2] erofs-utils: support per-inode compress pcluster
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20210816094043.43772-1-huangjianan@oppo.com>
 <20210818042715.24416-1-huangjianan@oppo.com>
 <YSWaMjYusTMt7Ccf@B-P7TQMD6M-0146.local>
 <YSWcjYnrdUJowrLv@B-P7TQMD6M-0146.local>
Message-ID: <6b47ed31-ac98-185f-0789-1817c50f76c6@oppo.com>
Date: Wed, 25 Aug 2021 10:38:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YSWcjYnrdUJowrLv@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK0PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:203:b0::29) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.7.229] (58.252.5.73) by
 HK0PR03CA0113.apcprd03.prod.outlook.com (2603:1096:203:b0::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 02:38:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63114abf-2262-4794-14b6-08d967715ce8
X-MS-TrafficTypeDiagnostic: SG2PR02MB3114:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB31142323D084C62F608E4CB6C3C69@SG2PR02MB3114.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BurEPg5Npv34KFl2ZCgr7fcxKL5qPY/nk3XO6uoIofVQG8bXFUDCP2eRQPtFss/AkHQ/Jl4gN9p6iXMdDlzXBiW8VcDSkWFl9GBOYMHaaBHTGP5k9LlsP0zUb9EpwfgXk6X/5OvtdgPH3CrPh9ifa8TyLIC7w/8bHQONGlYw2kp01UWsqla64gnddGwyG4vl6o3SKIT5RnS1499Ds65RQOzbMknXmN5ARbJs0V+2nm/IXHhD2iQHlAwtIr/MK5XhIGPGD46N+375zxo1zK3aojxSVhcPZSybssMWuuxE1G5axH3cqNheEoocsmXOwtLCMEepk0OzrJhWCZG9+VPXZBh8AgQqU8KFZDOtRX4+J7Qoqsz2ZE/v9A7WeVz8BXpTlMmDilUORp9tHGelYqo2KyZdfr8f8csEfCKGN8V0m17u1aAFCamcuq71H16XaP6q3bLqI4sGFMUyYXWPK8GZp353K1WxSe4qnfHos5p0/F1ccFZ0fT8XNd3iziED3oRdtbdP9xE25hnahvBeoAMJh50XG46705aXaJDYKFh/OL+AvNXifWrpwhsKMBunzz8xChYX0J+E2HZFKNz3flvnnH0KyfJerdGBb7qdTh7RmpC+PZ2k5+BtW0d2thH+jeadsU/qskyXHg0WvlpVkKgdOe+FGTsn845wZ64mrYKDq2NMKA1UlVofwL3eKswawV5OfP9wDZQcHFngmf2eCOZphwtWzFFuB0vDG0JN42m+q1/FfHcIcRTdNh73dMYWMgPfR/VrFdXhpVq/2YMVUEmjSeDs0jGw1vmt/E6FcZOS/04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(6486002)(83380400001)(2906002)(4326008)(6916009)(8676002)(36756003)(8936002)(186003)(26005)(5660300002)(31696002)(478600001)(66946007)(66556008)(956004)(2616005)(16576012)(86362001)(316002)(38350700002)(38100700002)(107886003)(31686004)(66476007)(52116002)(11606007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emEwZ1UwVWd0am9ucEM2dzNWRC9vcVVPWGUrbW9KbzFwL21mbXA3elRMTkY2?=
 =?utf-8?B?ZGdJaC81aWwxWWNTWnVCMWUrQTlpVDNsOUZvUmVZd2ZKaCt2czIyN2ZoU3hU?=
 =?utf-8?B?NXN6cVh5cktYcHdzOHhqOG5IWWlGbjAvV0lYU0EycUFYSWdIeUovUExBcDRz?=
 =?utf-8?B?Nk5VVXNGYldwUDk1N2Yxem9RZDFhbXFuaDdaSFMxbWpRL1lnajZ5ZGdnaEZq?=
 =?utf-8?B?YWN0VDY1RHE5ZnBGR28rRzRNOGNNQVRBYjFnSGErVTJXMnZ6M3lHWEhoa29J?=
 =?utf-8?B?OXNQTkNuTkEySHhaWHNVUnROcEoxTlcydXZJZ2ZuQWl3VXJWODBLZkN6ZVV4?=
 =?utf-8?B?d1NPV1Q1K3dnQVM4REg1SHRTd2JNTU4zYWxPVUlPYnE1NTNPcVB3YmZXeWVz?=
 =?utf-8?B?Z2FDV0VvcWJ1SjAxMlNucUljaWlxb2lmdUY5bUJEWnVqeTZObjQ0YlN6TXpX?=
 =?utf-8?B?WWo5aVNudnMyMXkzY1lQdkR0UnM5VDdSa0xQWlR5dUhCeUUwYTdubTFoWWpo?=
 =?utf-8?B?a09DTjR2bjZ0cXlzb0RhM2ZxdmlLS0VhaDZjY3JFaHU3YkVqczBGR2o5SVZ5?=
 =?utf-8?B?blJ2QzdoKzM1S0FLZmM4dzVnNjBPOFBIaXI1TW5ucmpPMWdodmozYXVhQyta?=
 =?utf-8?B?M2c0T1ZzUm4yNkpsRmRRVjNaRHB4QlZ1VzcvV1VPTlJiWm1FdmYxcGZlUnlu?=
 =?utf-8?B?QU1Nc2tzLzdwVy9valY3aUhqWW8zRGhsRSt4bEttK09iM1RTVi9BRUx2UGlO?=
 =?utf-8?B?VXJJQWM3UUpaY2tCN0M2R0FSWEVoYm1nQ2FNSmhpeXBkYU8zRU5jMC9qZEht?=
 =?utf-8?B?dkh6V0JCVkhvOENzdXlBYkc3bFZWVzdmN0ptWHNNRkdhTkVmNXJtdEh2QVlq?=
 =?utf-8?B?VkJDYXdoeHFwSTNJeGE0SGQxWEhNYSt4WEhBNzhFYU1yTjJXQkREYWhiVzVV?=
 =?utf-8?B?WDRPbENFRzJ2RWcrMXVLMlM3RFUxL01ybXA5b0VQR2hiZDVKSi9hc2YrUmdX?=
 =?utf-8?B?NjFLZzAweWlBS04xRUxFK2tjRkNlQWJZNUZXUEhwdUFOeFNQWVByek84T2Jk?=
 =?utf-8?B?VTFmVXpHTi9aVTg2K2JiZ0gxWE9PQldlUWRqZ0N1SDVHcnNzMHlqb1J4WTk0?=
 =?utf-8?B?V0JGUlQxQ25DNEZwSFVHZFV2ay9KM0NuNEV1OWwzVVRibm9PTTkvRU4rWmVv?=
 =?utf-8?B?MU1QZEs4ajFTeGZaSVp3TmRXVG93VFZkVzBBWmd0Mmt1Tmw4elcyajFxRWlD?=
 =?utf-8?B?V2tpZ0gva3ZHZjh1eFZwbmdNZ3RmT1JTZHRnVlZrdmtrN25zTnBYbjFKOHBo?=
 =?utf-8?B?TU8yVFpmQTkzZHcrMXA3aVBSTlpJSHdVZWRJUGMwYWdUaGgyZXU5a2MwZzdw?=
 =?utf-8?B?azMzOEF5QXdRdjlCYmRySzU0ZUEzWXYxS2gwYS8ydVBjSkdCNW9EaDY3R0ZD?=
 =?utf-8?B?SHhqUkdZaVY5b2NDcHFabDRpRFc1WUw4ZkkrWDRTbVVreGRsbE9Tc0xVbUh2?=
 =?utf-8?B?QVk4YzFKOExqK2hRTDBiTFBFODJDMDFtaDlSU0ZYeGF4V204MFQrZitkMGRu?=
 =?utf-8?B?aEc3ZU1hU216VEdwUDVGbmtWK3ZZVklrOVdidGcxR290MFBXWFNkYkFwR2pP?=
 =?utf-8?B?VWFhbDdJQW52eFA1VWZWb1o1K3lxTzNVY1NhU2kydUpkWldZY05mdTB3Z1J0?=
 =?utf-8?B?Ty8weWlvbmd3eGlCMDR0WlFHRWhYcE91Ly9JUTdyc2VBQ0grY3RSK3dBai9h?=
 =?utf-8?Q?QnRIXLvvlsdETeg/mOM4WsGNCgIMpZj1a/5DSCu?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63114abf-2262-4794-14b6-08d967715ce8
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 02:38:03.9863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuFJY9K1dzt0aCfqy4W2AUxj3nqKo5WRrSgpcdPZkWX9UHKDRAbxtc4a3SMp8o/ifHyHFRMqqtXNUcnkOkHUwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3114
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
From: Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Huang Jianan <huangjianan@oppo.com>
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2021/8/25 9:27, Gao Xiang 写道:
> On Wed, Aug 25, 2021 at 09:17:38AM +0800, Gao Xiang wrote:
>> On Wed, Aug 18, 2021 at 12:27:15PM +0800, Huang Jianan via Linux-erofs wrote:
>>> Add an option to configure per-inode compression strategy. Each line
>>> of the file should be in the following form:
>>>
>>> <Regular-expression> <pcluster-in-bytes>
>>>
>>> When pcluster is 0, it means that the file shouldn't be compressed.
>>>
>>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> Sorry for the delay. Due to busy work, I will look into the details
>> this weekend. Some comments in advance.
>>
>>> ---
>>> changes since v1:
>>>   - rename c_pclusterblks to c_physical_clusterblks and place it in union
>>>   - change cfg.c_physical_clusterblks > 1 to erofs_sb_has_big_pcluster()
>>>     since it's per-inode compression strategy
>>>
>>>   include/erofs/compress_rule.h |  25 ++++++++
>> How about calling "compress_hints"? Does it sound better?
Sounds good, naming things is quite hard. 🙁
>>
>>>   include/erofs/config.h        |   1 +
>> ...
>>
>>> index 0000000..497d662
>>> --- /dev/null
>>> +++ b/lib/compress_rule.c
>>> @@ -0,0 +1,106 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * erofs-utils/lib/compress_rule.c
>>> + *
>>> + * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
>>> + * Created by Huang Jianan <huangjianan@oppo.com>
>>> + */
>>> +#include <string.h>
>>> +#include <stdlib.h>
>>> +#include "erofs/err.h"
>>> +#include "erofs/list.h"
>>> +#include "erofs/print.h"
>>> +#include "erofs/compress_rule.h"
>>> +
>>> +static LIST_HEAD(compress_rule_head);
>>> +
>>> +static void dump_regerror(int errcode, const char *s, const regex_t *preg)
>>> +{
>>> +	char str[512];
>>> +
>>> +	regerror(errcode, preg, str, sizeof(str));
>>> +	erofs_err("invalid regex %s (%s)\n", s, str);
>>> +}
>>> +
>>> +static int erofs_insert_compress_rule(const char *s, unsigned int blks)
>>> +{
>>> +	struct erofs_compress_rule *r;
>>> +	int ret = 0;
>>> +
>>> +	r = malloc(sizeof(struct erofs_compress_rule));
>>> +	if (!r)
>>> +		return -ENOMEM;
>>> +
>>> +	ret = regcomp(&r->reg, s, REG_EXTENDED|REG_NOSUB);
>>> +	if (ret) {
>>> +		dump_regerror(ret, s, &r->reg);
>>> +		goto err;
>>> +	}
>>> +	r->c_physical_clusterblks = blks;
>>> +
>>> +	list_add_tail(&r->list, &compress_rule_head);
>>> +	erofs_info("insert compress rule %s: %u", s, blks);
>>> +	return ret;
>>> +
>>> +err:
>>> +	free(r);
>>> +	return ret;
>>> +}
>>> +
>>> +unsigned int erofs_parse_pclusterblks(struct erofs_inode *inode)
>>> +{
>>> +	const char *s;
>>> +	struct erofs_compress_rule *r;
>>> +
>>> +	if (inode->c_physical_clusterblks)
>>> +		return inode->c_physical_clusterblks;
>>> +
>>> +	s = erofs_fspath(inode->i_srcpath);
>>> +
>>> +	list_for_each_entry(r, &compress_rule_head, list) {
>>> +		int ret = regexec(&r->reg, s, (size_t)0, NULL, 0);
>>> +
>>> +		if (!ret) {
>>> +			inode->c_physical_clusterblks = r->c_physical_clusterblks;
>>> +			return r->c_physical_clusterblks;
>>> +		}
>>> +		if (ret > REG_NOMATCH)
>>> +			dump_regerror(ret, s, &r->reg);
>>> +	}
>>> +
>>> +	inode->c_physical_clusterblks = cfg.c_physical_clusterblks;
>>> +	return cfg.c_physical_clusterblks;
>>> +}
>>> +
>>> +int erofs_load_compress_rule()
>>> +{
>>> +	char buf[PATH_MAX + 100];
>>> +	FILE* f;
>>> +	int ret = 0;
>>> +
>>> +	if (!cfg.compress_rule_file)
>>> +		return 0;
>>> +
>>> +	f = fopen(cfg.compress_rule_file, "r");
>>> +	if (f == NULL)
>>> +		return -errno;
>>> +
>>> +	while (fgets(buf, sizeof(buf), f)) {
>>> +		char* line = buf;
>>> +		char* s;
>>> +		unsigned int blks;
>>> +
>>> +		s = strtok(line, " ");
>>> +		blks = atoi(strtok(NULL, " "));
>>> +		if (blks % EROFS_BLKSIZ) {
>> We might need to guarantee these are power of 2.
> Oh, never mind. It's not necessary to leave pcluster power of 2.
> (I need some wake-up coffee...)
>
>> Also, how about just printing out warning message but using default "-C"
>> value instead?
ok
>>> +			erofs_err("invalid physical clustersize %u", blks);
>>> +			ret = -EINVAL;
>>> +			goto out;
>>> +		}
>>> +		erofs_insert_compress_rule(s, blks / EROFS_BLKSIZ);
>>> +	}
>>> +
>>> +out:
>>> +	fclose(f);
>>> +	return ret;
>>> +}
>> ...
>>
>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>> index 10fe14d..467e875 100644
>>> --- a/mkfs/main.c
>>> +++ b/mkfs/main.c
>>> @@ -23,6 +23,7 @@
>>>   #include "erofs/xattr.h"
>>>   #include "erofs/exclude.h"
>>>   #include "erofs/block_list.h"
>>> +#include "erofs/compress_rule.h"
>>>   
>>>   #ifdef HAVE_LIBUUID
>>>   #include <uuid.h>
>>> @@ -44,11 +45,12 @@ static struct option long_options[] = {
>>>   	{"random-pclusterblks", no_argument, NULL, 8},
>>>   #endif
>>>   	{"max-extent-bytes", required_argument, NULL, 9},
>>> +	{"compress-rule", required_argument, NULL, 10},
>>>   #ifdef WITH_ANDROID
>>> -	{"mount-point", required_argument, NULL, 10},
>>> -	{"product-out", required_argument, NULL, 11},
>>> -	{"fs-config-file", required_argument, NULL, 12},
>>> -	{"block-list-file", required_argument, NULL, 13},
>>> +	{"mount-point", required_argument, NULL, 20},
>>> +	{"product-out", required_argument, NULL, 21},
>>> +	{"fs-config-file", required_argument, NULL, 22},
>>> +	{"block-list-file", required_argument, NULL, 23},
>> I think we might clean up these first with a separated patch.
>> Use >= 256 for all of them instead.
ok, I will send a separated patch first.

Thanks,
Jianan
>> Thanks,
>> Gao Xiang

