Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAED733E7E3
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Mar 2021 04:54:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F0brq2c11z2yjB
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Mar 2021 14:54:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1615953291;
	bh=emx4+dsVNBp4mEp1NgXfjx9/cFu9fKJ4iDXi5g/et8s=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HKIRayv2Q5KA+I18iF+2AXCG3urKAHTvjbSbu6q2VbhsSYblyNbY9Osyjq8Sbf9CY
	 C87wchlbCqWcTLREAKF237uN2APM9i/dy0F0fAZSUSiNj5mBn5cTsxOFBHR/nrymWh
	 lqKybzg2S2bC3F127EkUosgg7gbhZiZzziNbeK/K8JCKllQ73LJi3trx/2QsRhiq7E
	 /M0mAXlNCvIdx5sVPPhWuMuhEDSQBttha6PRq/2ngO4DnGFOxQN2KLSmKG9bbX6a27
	 yqjqX/fBH6DoaUTwGP/AJQCWJjMjxW1KzJARiY8PSA0eM4yUAm2s+67dTnxvnMydy6
	 pxpbNSuaj+2cA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.45;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="signature verification failed" (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=l84n7ATR; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320045.outbound.protection.outlook.com [40.107.132.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F0brj4XqQz2xZv
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Mar 2021 14:54:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dqb7BtLdESVhwrbH1i7WG7QF+q1tdOS45OhKbY3lN4BSb0kptk4JBzmDXzbDmOjTwrJNh4eZ6y7JXzpY5ayonHY7V7Lz+38CJwrbFlSnn9YWQDFTQu3wL7f4neDwHzgwvMSpKSyZALsC3WZnUbYLbUlQcXMqDiysiQvAHf844Ax06nZ2dXRxBS6tQZLWJMEVqlaex7e/JNilV+8x+g0EhhOrkZCBFLo6quEQXn85aoPah4+bRn61r0yiue6e2uq6uCWG3bmXA+NPCU+JVlQF6/7D5vwO6G3NaZvV5bsejTTUfbCfWUGaQTPychFFzWLdIYQLFVllbw1Uz5WUEjkqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsjBBuU5ukhJj2DruAAtTEWX4b951N6wajNi7cACRtA=;
 b=Rj/TxGoH8kUmXddb+gFML18qz7EAeOOTm3aywUPHzN0SgZ46nA+hCVDLS5xXaNbpUEjdIP9QbmCvSQGEMjBLutL3ng2hIu145K21aojYnYgA/J1nBDndlsdF8lHP4Bn37UAs1kInFXhoMzJYA1f+bu16/ls1x/J1aWWD1/21GPB24BYIpaen6LTgdHib6Bj2QDMzmWtjG6kNfhNKGQ5r4OB+/5S7hlfS+keO/XiKxqBOe3c6VlJqgZ0aSED/fpvvPROteT/7kZz2QvxI34qmKYE1mqRITD6vE7o7Tirvru1aHJCLDjmePVCa1ClBlM4PLhi5yVYRwb6El+z2/M+FNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3273.apcprd02.prod.outlook.com (2603:1096:4:48::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Wed, 17 Mar 2021 03:54:19 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 03:54:18 +0000
Subject: Re: [PATCH v6 2/2] erofs: decompress in endio if possible
To: Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20210316031515.90954-1-huangjianan@oppo.com>
 <20210316031515.90954-2-huangjianan@oppo.com>
 <cb51e5de-bfb9-509d-e165-243157404cb9@huawei.com>
Message-ID: <d763d340-a982-c56f-26b5-5c7045301c5b@oppo.com>
Date: Wed, 17 Mar 2021 11:54:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <cb51e5de-bfb9-509d-e165-243157404cb9@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.255.79.104) by
 HKAPR04CA0015.apcprd04.prod.outlook.com (2603:1096:203:d0::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 03:54:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de6d1489-13c1-460b-3a83-08d8e8f85720
X-MS-TrafficTypeDiagnostic: SG2PR02MB3273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3273DDED99C6BB98395436BDC36A9@SG2PR02MB3273.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02HWhcXjrrFayQf8Qk/EZbQBMJ/NhXeh6ZOfO/L5UltsWuugrCACZhWanh2OQlP2L9R6kb+q3DjehzBw6B/y8UXRle/Sr3XN+YCBwCUZv6/4bJI9x3+S2pWmWO+DTm5wMX4zKYDfkk2a0fgUcThmRKNvVK7AjgG9UZtXRuVqZBboquXx1gSS147Ft8mDnStQpbrzjvMLBPG0ulW8KozMtXlhZHibu2BZSk0jJ8ywdCPAM7pS4MrvrkTzEQqNid7sgK+LHknU5qWhxxE2Oh2JzWenoxFuYmTwO3+4K0MioCMw6islLhm2PcCTajzgbkIxfgYJapMyHA2a2CEknaSGyHTca5wjsiyCy0adVuuSQCF4CXPf9mcqkdAfHg3WSDdcqSmAqGiOqpFMI2QfDzJJWnhei4TCF/CE3MlFOP1mNAPp3ZcOB6Ls79L9Aru04PogC3a3KfbWLvEzl/lnQcrUgDwVjyo6nUF2Uuyoi8Eo4WMqnWF5thlv426cRGTKZq6hxozwYVekMBJLxpe/X0vNpOQwrE4PmyBwbNc1z6Eeiq2xrET9dsF/itdF+bEPFAp1wL7QHhylOiRrl0X4XJhxsKn2rZ0aOs7/p44shwmtHC982Fi5F4fo9l6TMmnjBJAxCb8qCgnbjxGOY9BFH+QK78jAmaX4zJvH4kri9aJpp8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(26005)(316002)(8676002)(16576012)(2616005)(31696002)(956004)(86362001)(16526019)(2906002)(31686004)(186003)(478600001)(36756003)(83380400001)(66556008)(8936002)(66476007)(6486002)(66946007)(4326008)(52116002)(53546011)(107886003)(5660300002)(11606007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?vDMQ0SZe22TUh5mn02znLGNt95F1cmPwZPSwnLf1wTo2K5JP7iag0hyQ?=
 =?Windows-1252?Q?RfIKJA/5qCU0MAg/8/fCabzIuinUhKQnGzgyia6r02wo6JE5MOycx7+0?=
 =?Windows-1252?Q?nSoAUhFmtYtfV2iFV3T3BsBmizd4qMUl1UvM3abLZNwNrmDRs3gGAq6x?=
 =?Windows-1252?Q?J6pKicLPeS8CSKgSWCCukmEEkO2gB+mA0hl02DPdCNsz7igb1Be5Hoze?=
 =?Windows-1252?Q?ixvUU6mp4gmMLCoFN4c2dYtby43KewRFllBHyQpnlMSZBUZrVge3rHsY?=
 =?Windows-1252?Q?G0/qYgMIBQdc8CI1w/sovq/cVHvutY7t6ySbn4YdxvCcxJgjopfOpXRE?=
 =?Windows-1252?Q?m5gMLOy5uQ4iW7nT7yJOvv/cT7xzGRnrbEt+AmKb2MLqH+4xtMz0L4W2?=
 =?Windows-1252?Q?MSIN1lTSeasCqLqayIOYpRdO7iA/C9JlmHgt7je37rC06TGCYgtTJ6o8?=
 =?Windows-1252?Q?ztyEAzjaAq4sIWuTfAKnlIm2A3WCPW+E8ixPRHjrFFF3vfp8NhJs9lJy?=
 =?Windows-1252?Q?48Q/uTQekSfBaJk06OcCZa7sItFGWlodSPqVV+Q0gXbJNxQy28z4t/Y8?=
 =?Windows-1252?Q?I3HD0d7DkSrFz50V7QMYYyXUyYcvIX7yBUlcKIP2LmszaBQIuQG1GDGW?=
 =?Windows-1252?Q?MzWkH4yoyv1ahvdMdgTkvYcPTJ2xlIZVceBBoltKBIVHtjSbkvxkF8c4?=
 =?Windows-1252?Q?rUKBmCX3tUuEE3kWdP1SGIgISyoCjyzZKePTGOze3pYqg7KDlmw1zA16?=
 =?Windows-1252?Q?T6vU8kRTqxIy4m6LbQmT9yiqDEc8cp2kUvvzKbJJDUsL/2SpiwzSXiTo?=
 =?Windows-1252?Q?JLduL0or5De325ckhnin7jIx+9ECWRBzO9+k1aQuVgHP+prlzWkHXlDD?=
 =?Windows-1252?Q?pi5LrNXk4nOnL73et4BUtJLynuN6QWrO+UhVa1urB0qsf4af/8KlrMOJ?=
 =?Windows-1252?Q?Wby47lKZFGda/1nY8tHv2QycSzfGriwLywotdmP6tXEjemxeVpgNlOrq?=
 =?Windows-1252?Q?JMWt6Vf8EJxzgCO64skCglO5qPOEChoYrDapD/8ECyLhH5ByJkjh31Dc?=
 =?Windows-1252?Q?jPuWMGdg+yFxD68er8yb26/QcTbtjGlnwdqNwqadiu6bxOBDKPH0WJw4?=
 =?Windows-1252?Q?WyVvCZWKNRyIuz9iekex61Ru0JMVGj27RjE0uexfrePO+zvumIUEmhm5?=
 =?Windows-1252?Q?8Zym1BtPhiWX2uKg9w9etjiLXDZD8MlFFCj95N9/CQfs3TWrgXJN8/Hp?=
 =?Windows-1252?Q?drnzAveFx3rbNeEhyp06XbQFhFyDxvNPZUr94bYiO/8wy5Y7zqrY6R1R?=
 =?Windows-1252?Q?ZArdpEWsq3R1auBQuvCeYbpJQLuTf2jxqAIy9UW8981ETv9Qj7iG46lt?=
 =?Windows-1252?Q?J0TUVvJEkiP2X3l6IJGG1dHbxMxSplG/A6vXpDG5SZ9mHuDouJEFhrUc?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6d1489-13c1-460b-3a83-08d8e8f85720
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 03:54:18.5917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hacxR4aoHKplTqaTsCJ5L1I6oKXDLRmDy5wG4jXCEvJbNIoGwLDEELzaKlHew12znb+R645a/zcRb6rVbXA/DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3273
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
Cc: zhangshiming@oppo.com, guoweichao@oppo.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2021/3/16 16:26, Chao Yu wrote:
> Hi Jianan,
>
> On 2021/3/16 11:15, Huang Jianan via Linux-erofs wrote:
>> z_erofs_decompressqueue_endio may not be executed in the atomic
>> context, for example, when dm-verity is turned on. In this scenario,
>> data can be decompressed directly to get rid of additional kworker
>> scheduling overhead. Also, it makes no sense to apply synchronous
>> decompression for such case.
>
> It looks this patch does more than one things:
> - combine dm-verity and erofs workqueue
> - change policy of decompression in context of thread
>
> Normally, we do one thing in one patch, by this way, we will be 
> benefit in
> scenario of when backporting patches and bisecting problematic patch with
> minimum granularity, and also it will help reviewer to focus on reviewing
> single code logic by following patch's goal.
>
> So IMO, it would be better to separate this patch into two.
>
Thanks for the suggestion, I will send a new patch set.
> One more thing is could you explain a little bit more about why we 
> need to
> change policy of decompression in context of thread? for better 
> performance?
>
Sync decompression was introduced to get rid of additional kworker 
scheduling

overhead. But there is no such overhead in if we try to decompress 
directly in

z_erofs_decompressqueue_endio . Therefore, it  should be better to turn off

sync decompression to avoid the current thread waiting in z_erofs_runqueue.

> BTW, code looks clean to me. :)
>
> Thanks,
>
>>
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
>> Reviewed-by: Gao Xiang <hsiangkao@redhat.com>
>> ---
>>   fs/erofs/internal.h |  2 ++
>>   fs/erofs/super.c    |  1 +
>>   fs/erofs/zdata.c    | 15 +++++++++++++--
>>   3 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 67a7ec945686..fbc4040715be 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -50,6 +50,8 @@ struct erofs_fs_context {
>>   #ifdef CONFIG_EROFS_FS_ZIP
>>       /* current strategy of how to use managed cache */
>>       unsigned char cache_strategy;
>> +    /* strategy of sync decompression (false - auto, true - force 
>> on) */
>> +    bool readahead_sync_decompress;
>>         /* threshold for decompression synchronously */
>>       unsigned int max_sync_decompress_pages;
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index d5a6b9b888a5..0445d09b6331 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -200,6 +200,7 @@ static void erofs_default_options(struct 
>> erofs_fs_context *ctx)
>>   #ifdef CONFIG_EROFS_FS_ZIP
>>       ctx->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
>>       ctx->max_sync_decompress_pages = 3;
>> +    ctx->readahead_sync_decompress = false;
>>   #endif
>>   #ifdef CONFIG_EROFS_FS_XATTR
>>       set_opt(ctx, XATTR_USER);
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index 6cb356c4217b..25a0c4890d0a 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -706,9 +706,12 @@ static int z_erofs_do_read_page(struct 
>> z_erofs_decompress_frontend *fe,
>>       goto out;
>>   }
>>   +static void z_erofs_decompressqueue_work(struct work_struct *work);
>>   static void z_erofs_decompress_kickoff(struct 
>> z_erofs_decompressqueue *io,
>>                          bool sync, int bios)
>>   {
>> +    struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
>> +
>>       /* wake up the caller thread for sync decompression */
>>       if (sync) {
>>           unsigned long flags;
>> @@ -720,8 +723,15 @@ static void z_erofs_decompress_kickoff(struct 
>> z_erofs_decompressqueue *io,
>>           return;
>>       }
>>   -    if (!atomic_add_return(bios, &io->pending_bios))
>> +    if (atomic_add_return(bios, &io->pending_bios))
>> +        return;
>> +    /* Use workqueue and sync decompression for atomic contexts only */
>> +    if (in_atomic() || irqs_disabled()) {
>>           queue_work(z_erofs_workqueue, &io->u.work);
>> +        sbi->ctx.readahead_sync_decompress = true;
>> +        return;
>> +    }
>> +    z_erofs_decompressqueue_work(&io->u.work);
>>   }
>>     static bool z_erofs_page_is_invalidated(struct page *page)
>> @@ -1333,7 +1343,8 @@ static void z_erofs_readahead(struct 
>> readahead_control *rac)
>>       struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
>>         unsigned int nr_pages = readahead_count(rac);
>> -    bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages);
>> +    bool sync = (sbi->ctx.readahead_sync_decompress &&
>> +            nr_pages <= sbi->ctx.max_sync_decompress_pages);
>>       struct z_erofs_decompress_frontend f = 
>> DECOMPRESS_FRONTEND_INIT(inode);
>>       struct page *page, *head = NULL;
>>       LIST_HEAD(pagepool);
>>
