Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0BC3B2A44
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Jun 2021 10:21:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9Y4z4sHNz3by3
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Jun 2021 18:21:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1624522899;
	bh=5iGB020XDm5/2NZA6p7Noe9whyFVSrfhg/YJtkolVwk=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Y8/B94BX+wGuRLo9Wu2IbToBaKd06OPv0EovrIrIf6pZO3UGVre3vK6G0g8C5Wv/w
	 IVTH2WWlmHPvVvGlBFL2iyXp1EzsOQsjWrvV13tyk3uhO++95vq2fKEQawevqQoxDv
	 y8qxmNxhO94TPEEDjw1vKfjTJCiON7nWgMb50WPZNyRDBJvnfc9Quz9BJNe2j1X7Fl
	 wp/OhePXYNOaYXyK8Jzim7QZ76reSf1r4JSc8q8Fi8BPDqH1Ss6h4Iop7lm6o9GfTr
	 O85d8j9Wxewz1aGxG6KWuNATmQuTA3ydrIs5Y2lThw0HpqIra1TKL6MWeMoGsxjUDT
	 HKrc+4Cehga+g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.51;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=tJGWvVTc; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310051.outbound.protection.outlook.com [40.107.131.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G9Y4L1BcDz3084
 for <linux-erofs@lists.ozlabs.org>; Thu, 24 Jun 2021 18:21:04 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0SEcMTY3mgyX1wjAdjxxuVdr7JOhDOi/uLK9yv0Pq2J5nsIjBAg4QxK1In7jSwsmZry3qPdKWksR+D48vUI3NHgtgoDj20tM4FXtu37cjdR9+p/jSo5Vm3X5yrxe+o+xDO1/y3nWXiT6W+UY8LZ7EM5T/huEkIa22ngi0ueaE6Au5GV6VhSvCsuNsRRYXWIjJqX+G71lAknPUJfnM14/R+VYxcktMuqO8bwo9zAnmNebW7s48j6Ecx/Bj0zzX/hYurxj/YBVVv1oy33kFU560TWh2deLLxrjYqihzJXN4VsHzaYRwioDDukx72o6Rj8mBjT9cw+iQmMCm1a61QZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iGB020XDm5/2NZA6p7Noe9whyFVSrfhg/YJtkolVwk=;
 b=jvvMgdxSoZIqDornpCVyNrTXVXoL8hBEwR5uguMGkom/mKmUqtOmtRJqm2kxVcXO1l8Sg5FO59froTrCKN8IteTnkrrwQxae08v568zIjIcTYax9k2Wfl2Wv5t3admGSWhRak60T4/4HsH8n1lUfhCHAajzF3338XZP+rlWmraMs8UzapHW3WsYFCZ1STtBFMYVMP0tPH9S4JIMrFxEQQLp7B49CPPYlGKVXr6LD16zg4rqyo/y0+KEMveP8hXawdMa9lchHnQXkU+3w9EisF45P6JGF0VIPrKokfIN4sdAszZfuj3uBOmH8qq4MSnhKjkB5tvcCpDiwkWbS5K4htQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: yulong.com; dkim=none (message not signed)
 header.d=none;yulong.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4022.apcprd02.prod.outlook.com (2603:1096:4:83::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19; Thu, 24 Jun 2021 08:20:53 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::d984:518:d39c:9de5]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::d984:518:d39c:9de5%3]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 08:20:53 +0000
Subject: Re: [PATCH v4] AOSP: erofs-utils: add block list support
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20210624070234.1340-1-zbestahu@gmail.com>
 <YNQ8iuY3cDlrdD+Q@B-P7TQMD6M-0146.local>
Message-ID: <bf754a82-a56a-75ff-4b24-646bcfc9c6d9@oppo.com>
Date: Thu, 24 Jun 2021 16:20:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YNQ8iuY3cDlrdD+Q@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.252.5.73]
X-ClientProxiedBy: HKAPR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:203:c8::8) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.7.229] (58.252.5.73) by
 HKAPR03CA0003.apcprd03.prod.outlook.com (2603:1096:203:c8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.8 via Frontend Transport; Thu, 24 Jun 2021 08:20:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d4c1263-3c29-4be3-fee4-08d936e8fb68
X-MS-TrafficTypeDiagnostic: SG2PR02MB4022:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB4022E858DC4941C049268708C3079@SG2PR02MB4022.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hG7jYMVmmeXusGBl8OMYYqnmtxk1brc7MBdX2yQST4Tm19e9Oo3Zx1EtyLFIAlW0xeyM6e4Gxwzcnuw0ZWedCHTAjw2KmsGnFuq6o0f6XF+OXxB4H5nIer6/V/K7M148eCm9S7UiOf2mplTqZYTdMh/r3L2GirOE9LiuL00SntqIdDCRCb+Fy8zo7WRe1LDXERkWf1SgleJ7Iu2f+YU6oGw4Rg3f7pJOQTHhlgdaslU1I3UM3OP5cNdwBD+dqjBLKdXs9y2o19kdr/hBC8BZ6ERJr9AWlelk3br34zBFpxisk0KO2pXB7PIIuAj7V/KZKCXgLaaXQZAPyCvthFnQLU6LVK7fLsl18mV6nWl6LGevQ6Ap0Vl6KmDlJM6CEyr02DuKh2w9HKajAkizPZX88RENz2MH0zJnYMWXmz3y2ut0LqFfByR3p0kpov8EOo8K5J6KnCnkADE9cTN4ZJFeMVHNUghYpoOU3MyJF5Xv6p9+I8O+TdCwkJL1rigVHWW8OJLZGc5ly76l+lKHhcpsBJYvjs9C5HonJmYmPdTyPVm8B+ybuumHdRAUTv0ZqvQP1EUzXKMKCVvVsmZ9wJo+IhJL3qPc+lfx1nSA3Ac8Kcc+UC2RHfHaSkkdK8wYYpSQ6aV2D/5bk+tJP0DoIHe37inclkWIxRT1xa3hPJiopNo1mRfO+HNmYRDXT2Ve6DPaOOZZLV7smvFpra3t8yX51ckC2NVMLgyLds+lIhrAxnQJICF6kRKupyYF0/DAMQYssnpavw9v+Tn5zmIqS3HBE88kp7AH1w2jA/KeiGVMWcd89IIQT2BJP/Jgr1/H8A8Vx7mCHqgWgpvFExA9x0hO6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(52116002)(26005)(36756003)(186003)(956004)(31696002)(31686004)(83380400001)(38350700002)(53546011)(38100700002)(8676002)(86362001)(8936002)(2906002)(66476007)(478600001)(966005)(16526019)(316002)(2616005)(16576012)(5660300002)(66946007)(4326008)(6916009)(6486002)(66556008)(11606007)(21314003)(45980500001)(43740500002)(309714004)(10090945008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?allmVURVdmNwUm9ZQjZ2WjJuNnhQcGhtZ2ZVNlNOVWM0Ym9xVnRZZGoyUk5M?=
 =?utf-8?B?QUVzVU9TanlZS0tmUVRzcFdsYUIvek1HcFJwMTRTKzJxUGpMaG5pZVlvelFK?=
 =?utf-8?B?aXA3M3BvRXlyN1crL1c1T3VTRXBKQmVvalcvdXdvRklKVUVwelZNTmV1WG9z?=
 =?utf-8?B?V1NpU0F2aTh6K3pVMUkydDVoK1dUUFFvQ1cvamZDN3cxU21CODkxeUhCekkv?=
 =?utf-8?B?RkxQeVBYQ0VDSmRlWGlZODFSM3FVMU5RVE1xN002TFZta2xqbnhwdW14TEJH?=
 =?utf-8?B?em04aEswK1pmZE40UWs5NXBrOVFYVHVpMVAvWHpuYUdsbDVFNnFhN3V2OURn?=
 =?utf-8?B?VCtkWW9FenBicTcxNG8xNlNERTJ4aGNyTU5GSXBMQURlWWZmUlpuY2owbnRK?=
 =?utf-8?B?WEdxa3NTOGF5Qy9BNkxOQy9LUXcxVExiVlMwb2RUU203NlN4aml4OExxTWZx?=
 =?utf-8?B?a3FYd210Y2NacmRrZlhLRHdYc1d0SmcvV2JRRGU1YkVoSjdzM0ZxOWJxVU9R?=
 =?utf-8?B?THNHZEpibXQyNnErMnF2SGJBdG81YmhMakIxa1FYTHY3bTh4cFpnV3BmLzhH?=
 =?utf-8?B?THFaVkFUMDFvMmVwemJlSStuSEEvRldJcXBqbUNwYUQyWlI1ZWhSalN6SWFQ?=
 =?utf-8?B?ZDJ6aDFDMDg0M2lSSm0yWm42OVdQbVc2bGw2aE9QNjBMTGlHT0J1ejNMaFJU?=
 =?utf-8?B?b0U3cnFKUkQyS0dxVWE3ZklwY3pIQ0RBaC9mc0hzblJWVDEwUFdHREtDUlBk?=
 =?utf-8?B?RkZGSzZGbkk1WUhiaDZnUFI3aEN1M0tKNlRZRnNhZVZvNFFMdG5iWlpHdGhh?=
 =?utf-8?B?UDBFdlFUNlozMS9ZNTdFVXJVb2lJMmxNWXhuV2xJckFVaTRMbnhGTFVYKzEr?=
 =?utf-8?B?RmZybE9zVGFpTjAvY3hvNVY2Wi9kWm4wTFhlS0lDZDl4Y25WenlIU1NzYUpo?=
 =?utf-8?B?eE44TDhsT3RMRHFYTHBrZUthdEpzcmxobkFxcWo2R3JVUFpWUlZBY1RVd0x6?=
 =?utf-8?B?azdpQjhjMnZzWTBUUzg1dGhsQ0FiZUR5aVFGbXJoc3F6R3A3bmlLTmdIcXBU?=
 =?utf-8?B?b2l3ZFJaN3o0OUZMVHhlQy9HanFCd2dlN2xHZktId0tQc0NrUlpUcmtvQTN4?=
 =?utf-8?B?VmQ4K1FJQWsrMHNNMTNCOXZ0SnRvNis4QWZ3OGQ5UjQ0UWV3NFk2QVV1Ymt0?=
 =?utf-8?B?SWtGdUxPVjQzemNsRzE2eklPZjRueW1BYmxMVmhneE82V05nYUdBMTBhWTkr?=
 =?utf-8?B?b1dOdTdkRDN6aEtaTmkzMmNFaStpNUNldjkvbmZVbWF5OEc3VWlFT20yNldS?=
 =?utf-8?B?OS9XRlI3L1prUU5ka0ZuWlJsdWxrL29RWkF4VVBidHRFOUhIeFVOSjNKclVS?=
 =?utf-8?B?bTdJUlhGZGdjY3NvNHBCRXZCcFVwZmxleHFLNk12Tk0vT0ljQzhyeGdVWGVv?=
 =?utf-8?B?Vng5SmcvYWhSQXFmNU9ZaU1ySUhmamZDVGFpSnoxV0w4YzBDK1dvR3N2ZXIw?=
 =?utf-8?B?dDc0S2k0Y1FLNWZ5ZVQ2dDROMWRvRE9xREloRFBFUEZMTXovdlJ4djhVYXRr?=
 =?utf-8?B?TnFYdWlnRFBCU2dYWlY4ZlZ0Mi9zM0J2bmsvd2J3cmhDRmt0QzVqM3ZLa2NI?=
 =?utf-8?B?K1R3ZnpmS0l2ejlUZnAxNGxhMFA1ZWt6QTI3RGZSNE56Ykh4bHlPUjFkOWRv?=
 =?utf-8?B?cEs3SWhnNHN1Q0xKekFwQnc1eGxEbjU4UTlsZ0ZUQnhWNWcwbEpwWUNQSkNi?=
 =?utf-8?Q?eEzbWcHR8E28aYlLjWt00iBtuu2luVWQklHKI5L?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4c1263-3c29-4be3-fee4-08d936e8fb68
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 08:20:53.1608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SN037mEaoZ4eTdnfDca6/oQs46qXRfYblsx2rPKetXX2j16aJe8WHzy6f2W0vpjsVYyMa95iMNVMfOIxUvwYaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4022
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
Cc: Yue Hu <zbestahu@gmail.com>, yh@oppo.com, huyue2@yulong.com,
 xiang@kernel.org, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

This verison works well.

Tested-by: Huang Jianan <huangjianan@oppo.com>

Thanks,

Jianan

On 2021/6/24 16:04, Gao Xiang wrote:
> [hsiangkao@linux.alibaba.com 与之前向你发送电子邮件的用户相似，但可能不是其人。请访问 http://aka.ms/LearnAboutSenderIdentification，了解这种情况的风险所在。]
>
> On Thu, Jun 24, 2021 at 03:02:34PM +0800, Yue Hu wrote:
>> From: Yue Hu <huyue2@yulong.com>
>>
>> Android update engine will treat EROFS filesystem image as one single
>> file. Let's add block list support to optimize OTA size.
>>
>> Signed-off-by: Yue Hu <huyue2@yulong.com>
>> Signed-off-by: Gao Xiang <xiang@kernel.org>
>> Signed-off-by: Li Guifu <blucerlee@gmail.com>
>> Tested-by: Yue Hu <huyue2@yulong.com>
>> ---
> Hi Jianan,
>
> would you mind test on your side based on this version as well?
> (some 'Tested-by:' would be much appreciated here...)
>
> Thanks,
> Gao Xiang
>
>>   include/erofs/block_list.h | 27 ++++++++++++++
>>   include/erofs/config.h     |  1 +
>>   lib/block_list.c           | 89 ++++++++++++++++++++++++++++++++++++++++++++++
>>   lib/compress.c             |  2 ++
>>   lib/inode.c                |  6 ++++
>>   mkfs/main.c                | 14 ++++++++
>>   6 files changed, 139 insertions(+)
>>   create mode 100644 include/erofs/block_list.h
>>   create mode 100644 lib/block_list.c
>>
>> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
>> new file mode 100644
>> index 0000000..7756d8a
>> --- /dev/null
>> +++ b/include/erofs/block_list.h
>> @@ -0,0 +1,27 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * erofs-utils/include/erofs/block_list.h
>> + *
>> + * Copyright (C), 2021, Coolpad Group Limited.
>> + * Created by Yue Hu <huyue2@yulong.com>
>> + */
>> +#ifndef __EROFS_BLOCK_LIST_H
>> +#define __EROFS_BLOCK_LIST_H
>> +
>> +#include "internal.h"
>> +
>> +#ifdef WITH_ANDROID
>> +int erofs_droid_blocklist_fopen(void);
>> +void erofs_droid_blocklist_fclose(void);
>> +void erofs_droid_blocklist_write(struct erofs_inode *inode,
>> +                              erofs_blk_t blk_start, erofs_blk_t nblocks);
>> +void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
>> +                                       erofs_blk_t blkaddr);
>> +#else
>> +static inline void erofs_droid_blocklist_write(struct erofs_inode *inode,
>> +                              erofs_blk_t blk_start, erofs_blk_t nblocks) {}
>> +static inline
>> +void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
>> +                                       erofs_blk_t blkaddr) {}
>> +#endif
>> +#endif
>> diff --git a/include/erofs/config.h b/include/erofs/config.h
>> index d140a73..67e7a0f 100644
>> --- a/include/erofs/config.h
>> +++ b/include/erofs/config.h
>> @@ -65,6 +65,7 @@ struct erofs_configure {
>>        char *mount_point;
>>        char *target_out_path;
>>        char *fs_config_file;
>> +     char *block_list_file;
>>   #endif
>>   };
>>
>> diff --git a/lib/block_list.c b/lib/block_list.c
>> new file mode 100644
>> index 0000000..959f9bc
>> --- /dev/null
>> +++ b/lib/block_list.c
>> @@ -0,0 +1,89 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * erofs-utils/lib/block_list.c
>> + *
>> + * Copyright (C), 2021, Coolpad Group Limited.
>> + * Created by Yue Hu <huyue2@yulong.com>
>> + */
>> +#ifdef WITH_ANDROID
>> +#include <stdio.h>
>> +#include <sys/stat.h>
>> +#include "erofs/block_list.h"
>> +
>> +#define pr_fmt(fmt) "EROFS block_list: " FUNC_LINE_FMT fmt "\n"
>> +#include "erofs/print.h"
>> +
>> +static FILE *block_list_fp = NULL;
>> +
>> +int erofs_droid_blocklist_fopen(void)
>> +{
>> +     if (block_list_fp)
>> +             return 0;
>> +
>> +     block_list_fp = fopen(cfg.block_list_file, "w");
>> +
>> +     if (!block_list_fp)
>> +             return -1;
>> +     return 0;
>> +}
>> +
>> +void erofs_droid_blocklist_fclose(void)
>> +{
>> +     if (!block_list_fp)
>> +             return;
>> +
>> +     fclose(block_list_fp);
>> +     block_list_fp = NULL;
>> +}
>> +
>> +static void blocklist_write(const char *path, erofs_blk_t blk_start,
>> +                         erofs_blk_t nblocks, bool has_tail)
>> +{
>> +     const char *fspath = erofs_fspath(path);
>> +
>> +     fprintf(block_list_fp, "/%s", cfg.mount_point);
>> +
>> +     if (fspath[0] != '/')
>> +             fprintf(block_list_fp, "/");
>> +
>> +     if (nblocks == 1)
>> +             fprintf(block_list_fp, "%s %u", fspath, blk_start);
>> +     else
>> +             fprintf(block_list_fp, "%s %u-%u", fspath, blk_start,
>> +                     blk_start + nblocks - 1);
>> +
>> +     if (!has_tail)
>> +             fprintf(block_list_fp, "\n");
>> +}
>> +
>> +void erofs_droid_blocklist_write(struct erofs_inode *inode,
>> +                              erofs_blk_t blk_start, erofs_blk_t nblocks)
>> +{
>> +     if (!block_list_fp || !cfg.mount_point || !nblocks)
>> +             return;
>> +
>> +     blocklist_write(inode->i_srcpath, blk_start, nblocks,
>> +                     !!inode->idata_size);
>> +}
>> +
>> +void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
>> +                                       erofs_blk_t blkaddr)
>> +{
>> +     if (!block_list_fp || !cfg.mount_point)
>> +             return;
>> +
>> +     /* XXX: a bit hacky.. may need a better approach */
>> +     if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
>> +             return;
>> +
>> +     if (erofs_blknr(inode->i_size)) { // its block list has been output before
>> +             if (blkaddr == NULL_ADDR)
>> +                     fprintf(block_list_fp, "\n");
>> +             else
>> +                     fprintf(block_list_fp, " %u\n", blkaddr);
>> +             return;
>> +     }
>> +     if (blkaddr != NULL_ADDR)
>> +             blocklist_write(inode->i_srcpath, blkaddr, 1, false);
>> +}
>> +#endif
>> diff --git a/lib/compress.c b/lib/compress.c
>> index 2093bfd..af0c720 100644
>> --- a/lib/compress.c
>> +++ b/lib/compress.c
>> @@ -18,6 +18,7 @@
>>   #include "erofs/cache.h"
>>   #include "erofs/compress.h"
>>   #include "compressor.h"
>> +#include "erofs/block_list.h"
>>
>>   static struct erofs_compress compresshandle;
>>   static int compressionlevel;
>> @@ -571,6 +572,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
>>                DBG_BUGON(ret);
>>        }
>>        inode->compressmeta = compressmeta;
>> +     erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
>>        return 0;
>>
>>   err_bdrop:
>> diff --git a/lib/inode.c b/lib/inode.c
>> index 787e5b4..4134f8a 100644
>> --- a/lib/inode.c
>> +++ b/lib/inode.c
>> @@ -21,6 +21,7 @@
>>   #include "erofs/compress.h"
>>   #include "erofs/xattr.h"
>>   #include "erofs/exclude.h"
>> +#include "erofs/block_list.h"
>>
>>   #define S_SHIFT                 12
>>   static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
>> @@ -369,6 +370,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
>>                        return -EIO;
>>                }
>>        }
>> +     erofs_droid_blocklist_write(inode, inode->u.i_blkaddr, nblocks);
>>        return 0;
>>   }
>>
>> @@ -638,6 +640,8 @@ int erofs_write_tail_end(struct erofs_inode *inode)
>>
>>                ibh->fsprivate = erofs_igrab(inode);
>>                ibh->op = &erofs_write_inline_bhops;
>> +
>> +             erofs_droid_blocklist_write_tail_end(inode, NULL_ADDR);
>>        } else {
>>                int ret;
>>                erofs_off_t pos;
>> @@ -657,6 +661,8 @@ int erofs_write_tail_end(struct erofs_inode *inode)
>>                inode->idata_size = 0;
>>                free(inode->idata);
>>                inode->idata = NULL;
>> +
>> +             erofs_droid_blocklist_write_tail_end(inode, erofs_blknr(pos));
>>        }
>>   out:
>>        /* now bh_data can drop directly */
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index e476189..28539da 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -22,6 +22,7 @@
>>   #include "erofs/compress.h"
>>   #include "erofs/xattr.h"
>>   #include "erofs/exclude.h"
>> +#include "erofs/block_list.h"
>>
>>   #ifdef HAVE_LIBUUID
>>   #include <uuid.h>
>> @@ -47,6 +48,7 @@ static struct option long_options[] = {
>>        {"mount-point", required_argument, NULL, 10},
>>        {"product-out", required_argument, NULL, 11},
>>        {"fs-config-file", required_argument, NULL, 12},
>> +     {"block-list-file", required_argument, NULL, 13},
>>   #endif
>>        {0, 0, 0, 0},
>>   };
>> @@ -95,6 +97,7 @@ static void usage(void)
>>              " --mount-point=X       X=prefix of target fs path (default: /)\n"
>>              " --product-out=X       X=product_out directory\n"
>>              " --fs-config-file=X    X=fs_config file\n"
>> +           " --block-list-file=X    X=block_list file\n"
>>   #endif
>>              "\nAvailable compressors are: ", stderr);
>>        print_available_compressors(stderr, ", ");
>> @@ -293,6 +296,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>>                case 12:
>>                        cfg.fs_config_file = optarg;
>>                        break;
>> +             case 13:
>> +                     cfg.block_list_file = optarg;
>> +                     break;
>>   #endif
>>                case 'C':
>>                        i = strtoull(optarg, &endptr, 0);
>> @@ -541,6 +547,11 @@ int main(int argc, char **argv)
>>                erofs_err("failed to load fs config %s", cfg.fs_config_file);
>>                return 1;
>>        }
>> +
>> +     if (cfg.block_list_file && erofs_droid_blocklist_fopen() < 0) {
>> +             erofs_err("failed to open %s", cfg.block_list_file);
>> +             return 1;
>> +     }
>>   #endif
>>
>>        erofs_show_config();
>> @@ -607,6 +618,9 @@ int main(int argc, char **argv)
>>                err = erofs_mkfs_superblock_csum_set();
>>   exit:
>>        z_erofs_compress_exit();
>> +#ifdef WITH_ANDROID
>> +     erofs_droid_blocklist_fclose();
>> +#endif
>>        dev_close();
>>        erofs_cleanup_exclude_rules();
>>        erofs_exit_configure();
>> --
>> 1.9.1
