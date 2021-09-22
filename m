Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D5F4143B8
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 10:25:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDrvp2yXRz2yb2
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 18:25:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1632299126;
	bh=XegCBAvKZeVOdJmSb5XWJjNBpVp+aktUVrqviryLbH8=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=nAw50naknVYtvDnGuCF2SRa7I+R1otxc1Cdoa1/1ogWJjjoxdhwxedZqwOxO/UE0K
	 8tGRkZAJx+p+ZKLmtTS2oDsOzPzIW3+1CIjo2Fee5o12a2IR8m1ncdZ1MBaxuTB40l
	 U9uDPHh1PlfRCxBP6yJpzaHXMI0NqVJH6w34CZHUEQSQPbeBTsX5I7+cDea1V+UTB6
	 9wDj4121KPAFP7NDg7680LOjXkStNdV7eeLXrdXr2Cp/T1nI9/nnzlltdDPDup2/px
	 iNW/CBR9MhhTMdibnFokR04H7qgZVatYybbrIQDL/t0shVJ76oqbdSxyNVeDLp6Qaj
	 5e/R9xgODZ6yQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.81;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=l1GBWJOB; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320081.outbound.protection.outlook.com [40.107.132.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDrvf6ZDyz2yNp
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Sep 2021 18:25:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRVvGNa41tVS4psgkTp1YWEgDLXPvb5a5uvJXvwIXhnuag4YhEbk1UJSmdMBz83xdhPPa1anaFG0nsF6ubFCv29P+JIz1HnHo+PQ1BiS72dHV0Yse0T6GrwXe2NTgDMxigg+yqi+GfsJBDFRU4sGKeKioIZHPySsvd4e9YHV8ZSf4BurgHo2IAude5QrUmEeClX3cuvpELLZeUGd8outU5iniPAh18Hi3dOHuHnw8YSgL8rZ6g/+1cdtjcO196xbnMm6y63BvlUh2+XtkcTPo9ghRPIJYsn+Cq6WtjYUcpd5wvz6A28D10iFBfWYlCe7IO4IGcRJdvKmJaKh8RXLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=XegCBAvKZeVOdJmSb5XWJjNBpVp+aktUVrqviryLbH8=;
 b=P8PBSRvS/xaNMzLHQyl36vH0pWUqzPmZO8I4XgJyVjeXYvmsFrQRBdyR79RDAc90DM46QXNpTKLTK2oqLLFd7ygBBI7cTNVEVNMizYS4z2fQhsOpcnqgjpzTSBoZvpvNA4Xe734yPOm3oKbaZ5Iw8SwLFq7IZC3NMKNzINKb4slC/bVLMjI96Bwsk5iY6dcFyNBBQtDYJZJPHQ1rQy3WR3kklotJTagoD7IDx3dLR+GQRXwYYc54h31YHsfWpKUiHbBrwUab5016LLUQPEN5B9hXV/RfP4sYbXHBbVW6uy3UIsOwtYn/nnDlC0SviSJPkoI7y4ixvZ0MgO5/i0ED4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2860.apcprd02.prod.outlook.com (2603:1096:4:61::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.18; Wed, 22 Sep 2021 08:25:00 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 08:25:00 +0000
Subject: Re: [PATCH v3] ovl: fix null pointer when filesystem doesn't support
 direct IO
To: Chengguang Xu <cgxu519@139.com>, linux-unionfs@vger.kernel.org,
 miklos@szeredi.hu, linux-erofs@lists.ozlabs.org, xiang@kernel.org,
 chao@kernel.org
References: <9ef909de-1854-b4be-d272-2b4cda52329f@oppo.com>
 <20210922072326.3538-1-huangjianan@oppo.com>
 <e42a183f-274c-425f-2012-3ff0003e1fcb@139.com>
Message-ID: <919e929d-6af7-b729-9fd2-954cd1e52999@oppo.com>
Date: Wed, 22 Sep 2021 16:24:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <e42a183f-274c-425f-2012-3ff0003e1fcb@139.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR04CA0080.apcprd04.prod.outlook.com
 (2603:1096:202:15::24) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.7.229] (58.255.79.105) by
 HK2PR04CA0080.apcprd04.prod.outlook.com (2603:1096:202:15::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 08:24:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2697be2a-a0b2-46ed-5004-08d97da27785
X-MS-TrafficTypeDiagnostic: SG2PR02MB2860:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2860AA76976323B349DC7DA3C3A29@SG2PR02MB2860.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hYBokXKndR8gXNntjlaKJeUZ95C4mKxdXFf9419jNqOcOx4b8M8Kg+cnPuluuD3L+j+oCR3pjhPU/5GWhEl/uQXn2b0EmaHL5xLz3QceZKRx4jN9nmwfsdyVyN9jqJKpcr5duNlaS5lHF+r6a0L2nwC/TejEsVA9QoYOcNHbi6rdwGo5qcrtYIZh2QYB9dgdEI0trW0nu6hXMtO57Q9VWSLUiXEMZdCzGuo4exzEwRoBgUaqW1w7BJrnXwxM/ghtEXCoPb40G9HcaAUPFgSypth1wZ1Bkgbr18Ed48+jE2+DKE9g/8Zo4qxiB49d7r80KMWOGSByIBLgnc9FWSHIvC2VEeMYnVuB4A9FpU2OWbJbGqXsZodLgJhEHyCSvGTPDQQeM7gL9r8ISFVWseD/1i4ERDXWOlyIt/kglD0uHqlShrht2vm+RC6ZEjfbVFMMOd6NadOAAUEElXaoUu5igFXbHmYvOs4ju6LOTI6ZJFVNbErvuX0jIs/r81YISUrOpAG9bubknyUbH72L1ME+iLh4NO1Pxqo9WXNHHsRw3ppPLi3pmqd3qEKKdTajZmFbfoBeKkt88meDr3HI82trzIaW9fzxa7nvRNbQAPbn7q5RkExUw2vG7ejHl3J+RDy70/WOh44sWtx/yEyTTefq8wQbgBqZeq60lU3EDZP1QUO2o8OdhKzLU9qwqLvpP2QCZzTcHVvSzSm1kfdZpe4WlfFMi4mEd2GIwvJIgFcwxWrxUXuVbKjpgy6uA+QbsJMZQtVVA+N3gtWix5O5QCOtVaMrDkN1yDUuohIbU4ekmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(2906002)(38350700002)(316002)(5660300002)(66556008)(86362001)(66476007)(8676002)(66946007)(186003)(36756003)(38100700002)(8936002)(31686004)(83380400001)(2616005)(956004)(31696002)(4326008)(52116002)(26005)(6486002)(508600001)(11606007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHRISVZLK3VDYWEwOUk3clpUem0xYzJ2bjJCeTNZMWVyeU5wZFBwUWdGdHBm?=
 =?utf-8?B?ekV4MGVhdFNxWnYvM2VHMXNLOERZZ05NSFNsdjBHTDk2MVYrejV6dmwyc2hP?=
 =?utf-8?B?eHpWREdteHlhWjQ3WVVOdWZxbXNYQjBscGZiUS9ISlNuc3o4U1ZMLzRLU1Fz?=
 =?utf-8?B?ZkYwdW9hL1R5N2pXZ2cxbVNyTzVkTFlaUDMzM0Z3andRTWhnSTU0Y3paY25Y?=
 =?utf-8?B?RHlOR21XZ09QS2JSczN5Wk9yM1NvYkFRc2FKM2pQdUE1dmoxR2VsdjFuNEM1?=
 =?utf-8?B?VDhMT1c4RlpEK01hSjI1SVpUWVRDc2QwMWFUdVdxQk9LSDZuZWptd002d2Ft?=
 =?utf-8?B?VldMWmEyTTVnK21BU0VnOEFlMytWbGpxaXFRRTlEc0h0ZE9rYVNxZ1F5cFlh?=
 =?utf-8?B?MmZpRUhXZllMMUNydFRoNngzckoxMzgvTFg0VEpQcjYvQzAycVd5OW5iMjBN?=
 =?utf-8?B?Y21vU3BPOEhaQzhoK0dHRVZpSGtiTExDRDRBMzZHa3hIUHRKTmxBZ1VJWGQy?=
 =?utf-8?B?UlhqZDVNbVJoSnVLTEZsMWhiMFB4U1kvRTJHOStoL084NzNtc3hUT05ReFEx?=
 =?utf-8?B?WkFaWG1iK0RYL1FDUEIrSGo1N2xxaUlLajk0OVBVTlJCVEV3K0kzdjBZTWtY?=
 =?utf-8?B?Mjk3MVg0cTVGRFhYZnhaTnF6Z2RTaCt3SEVpT0tJM3ZqSUNsZWp2SVBhaVl0?=
 =?utf-8?B?bGNxTXRQZitNK2JLZklYOWl0U0xYRDR5bHVSN29KOWFVemMxUDJWOC9sSjV0?=
 =?utf-8?B?NGpvT2FtSTczTzFtRWo3RjNJV2xpSTl0RllPbXFjRXlSMlNXL0pzYnptQUdB?=
 =?utf-8?B?bjVCNHoyeExRZFl0OUhvNHc0WHNveldVQTFtTDZDNzB2WlJaZXdZdDhpTnNL?=
 =?utf-8?B?dmxWWDE5VHZIeGorYm0ybWFRT09YYWN4UzdBUFNYaFpmSlBqdkdodzQ4TCsz?=
 =?utf-8?B?R0t0TEhtQVpEWk00KzhoVkcyVENaWWlyVWtZVmt2NFRzTnROWkdZMFBiZzlN?=
 =?utf-8?B?SHNxVXQzVVIyU3pITXoxRWYvSStVRTYyckczdUl0bkFya2xFUDZjVHo1cnZu?=
 =?utf-8?B?bllmYW9FcHNkbDVUaVdwSmN6OEFGSENQWWxNR2ZrMTNxL21KZGFhemJKd29W?=
 =?utf-8?B?Q3RkM00zR2xiTnZ3M1lWR3oxb1JKU1U1bHVrR0cxT01DbGUxcVRwa2xHZWxE?=
 =?utf-8?B?RHBRSHZka0xBWWthZnNRWkt5RjdSRXYwZGRyU1pmVEU0M2JpUUxCaHQzMWQy?=
 =?utf-8?B?MEk5c1F3VnRjY0NFVXRIY0h6T0NRVGhZbGF0L3NVTWpGaUdzRzdmb1RDeW0r?=
 =?utf-8?B?Qy9xcFpwWXgrQjZ3aHZpNlVmOXE0cmVVK3dqTmY0R29RS3I3UDVMM2J4QTJI?=
 =?utf-8?B?QWg5K08rM3J3b0Z4QzN4bUkvWUwzYlpPcFRObUg3ZzlmOExnc0pEM1JDOU55?=
 =?utf-8?B?bDBMN2NSaVFOMHVIVmwyWGJKckl3eG1sMTg2ekI2Y24vV25Vc0RrWUlpMVVJ?=
 =?utf-8?B?aDU1MXlrOXFLdzJzY3p0VEZNODlLTGxnM1RvdW9pZkR6ZmZwUnJ5WTFjTGlK?=
 =?utf-8?B?Zy9EbkZIME5KYUZtQkw2NXBIVWJyTVBvdjRETFdTS0o1NjNpNzF0MCtMSkI4?=
 =?utf-8?B?a0xpOEdYTHkrR1VoQmlFNVgyK0NnZkJQaWlVTFpVeWp6dkJBRmkySFdLOTdL?=
 =?utf-8?B?a1E3OFdsZHBJOHBNVCt4UFBmQytjdS9zNmQrbmI0aHluR0hobm82ZldEa25R?=
 =?utf-8?Q?h8c2zJ0ho+SD7f7vHQ1IKHDKD72ds5M2cA9cfzf?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2697be2a-a0b2-46ed-5004-08d97da27785
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 08:25:00.1200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYrDVhGtI8/7dKatXCEwacqVNp3fdxkvn/GBkJONVoeAol3qfYDKGoogYkGNQjBctSKV3pHIgwzDs6w+4zkOHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2860
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org, yh@oppo.com,
 guanyuwei@oppo.com, linux-fsdevel@vger.kernel.org, guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2021/9/22 16:06, Chengguang Xu 写道:
> 在 2021/9/22 15:23, Huang Jianan 写道:
>> From: Huang Jianan <huangjianan@oppo.com>
>>
>> At present, overlayfs provides overlayfs inode to users. Overlayfs
>> inode provides ovl_aops with noop_direct_IO to avoid open failure
>> with O_DIRECT. But some compressed filesystems, such as erofs and
>> squashfs, don't support direct_IO.
>>
>> Users who use f_mapping->a_ops->direct_IO to check O_DIRECT support,
>> will read file through this way. This will cause overlayfs to access
>> a non-existent direct_IO function and cause panic due to null pointer:
>
> I just looked around the code more closely, in open_with_fake_path(),
>
> do_dentry_open() has already checked O_DIRECT open flag and 
> a_ops->direct_IO of underlying real address_space.
>
> Am I missing something?
>
>

It seems that loop_update_dio will set lo->use_dio after open file 
without set O_DIRECT.
loop_update_dio will check f_mapping->a_ops->direct_IO but it deal with 
ovl_aops with
noop _direct_IO.

So I think we still need a new aops?

Thanks,
Jianan

> Thanks,
>
> Chengguang
>
>
>>
>> Kernel panic - not syncing: CFI failure (target: 0x0)
>> CPU: 6 PID: 247 Comm: loop0
>> Call Trace:
>>   panic+0x188/0x45c
>>   __cfi_slowpath+0x0/0x254
>>   __cfi_slowpath+0x200/0x254
>>   generic_file_read_iter+0x14c/0x150
>>   vfs_iocb_iter_read+0xac/0x164
>>   ovl_read_iter+0x13c/0x2fc
>>   lo_rw_aio+0x2bc/0x458
>>   loop_queue_work+0x4a4/0xbc0
>>   kthread_worker_fn+0xf8/0x1d0
>>   loop_kthread_worker_fn+0x24/0x38
>>   kthread+0x29c/0x310
>>   ret_from_fork+0x10/0x30
>>
>> The filesystem may only support direct_IO for some file types. For
>> example, erofs supports direct_IO for uncompressed files. So return
>> -EINVAL when the file doesn't support direct_IO to fix this problem.
>>
>> Fixes: 5b910bd615ba ("ovl: fix GPF in swapfile_activate of file from 
>> overlayfs over xfs")
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> ---
>> change since v2:
>>   - Return error in ovl_open directly. (Chengguang Xu)
>>
>> Change since v1:
>>   - Return error to user rather than fall back to buffered io. 
>> (Chengguang Xu)
>>
>>   fs/overlayfs/file.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>> index d081faa55e83..a0c99ea35daf 100644
>> --- a/fs/overlayfs/file.c
>> +++ b/fs/overlayfs/file.c
>> @@ -157,6 +157,10 @@ static int ovl_open(struct inode *inode, struct 
>> file *file)
>>       if (IS_ERR(realfile))
>>           return PTR_ERR(realfile);
>>   +    if ((f->f_flags & O_DIRECT) && (!realfile->f_mapping->a_ops ||
>> +        !realfile->f_mapping->a_ops->direct_IO))
>> +        return -EINVAL;
>> +
>>       file->private_data = realfile;
>>         return 0;
>

