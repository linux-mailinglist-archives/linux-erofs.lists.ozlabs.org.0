Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ED42D418A
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 12:59:16 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrbDx5pv8zDqKr
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 22:59:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.51;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=ibQ7U5Tw; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300051.outbound.protection.outlook.com [40.107.130.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Crb7V6bkrzDqnp
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 22:54:27 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqrmApDU5onsrWsJ2JsarTNNZNqDQk82gzsVDkjcY6CW9t7klwe8G8SBGS0mfSL0qce6KfhuczUD1aNNDd5WaJhw41ZjNIkTiEQMt7UJPsOSpe/zKqjBsKzH3aJEbDpcVf/SdzcaCAr/8Ejr0dRqcoBUCO2AygvSvy21iatossOVLuzctISLreHZrRY2O7/zjRFC/piPE7qiLrWPyTnuTrWjeSzcVS1rk8I0AeYOg9BfsMuGGX+/19luvKY4+1TkigGv/QmKR52eWqLWZSCnZI9L72PqmBkWtVn/q5KMXk4KlMQlyGU7bIJfg3lvpsWMT6hfJZbmIWgwbXXZdrFcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o97pzVBlTB7Cx/WOvQLiv64xtY8R28bhlc8fvJ1zT34=;
 b=YmlTwznZ8twuiv9gOsb+2950ZNpZF4xdFpUiWri+NHiDERANM2df2Ad7XGyxZ395SjEWCDAbLUyrkvZj5Z3rMy9ywzKXEd2sO9/Yz/FVs7u6L5XifD49FCwGvBVTdrR6zkParRSBog/f48sOq12XDZROtFyy7BYzlFA8ktA6ZOpmUc6Bg/sxxTpJFMywEPpzB/slyLyUd+z7fkIGIbBI7rrCElmpUEUqYbcparLvMajRW4u3/uEGqTyMrlf6snjtZsvQxBPPvGUR0QG7Kx/gSR5geHIqEUQdMYjvFi8g0Lm3Zzkj3mlLUxGQfC3VkC/R+lAgay4BnB4Ir8X4jCBW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o97pzVBlTB7Cx/WOvQLiv64xtY8R28bhlc8fvJ1zT34=;
 b=ibQ7U5TwkdPTLJ7qG+jJ5+6fNw3WQXsI7dxvqBpkLP91Fm3BjJvRjq2/5v9Ynmv0tTeUihvaImNVeqkJyymajWNPIBCL6SyMkBD6PMKtAf66DiUKhJnqQVoLNGjAHeMbbKq9yoXaIiy86r3Aj2oQMh68lTbnhiiIJ2MNZfHyQ0M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2778.apcprd02.prod.outlook.com (2603:1096:4:59::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 9 Dec 2020 11:54:15 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 11:54:15 +0000
Subject: Re: [PATCH v4] erofs: avoid using generic_block_bmap
To: Gao Xiang <hsiangkao@redhat.com>, Chao Yu <yuchao0@huawei.com>
References: <20201209023930.15554-1-huangjianan@oppo.com>
 <23527fc2-811b-321e-10f1-cb5b50affdbb@huawei.com>
 <20201209113941.GB105731@xiangao.remote.csb>
From: Huang Jianan <huangjianan@oppo.com>
Message-ID: <140a1614-bd76-6196-c63f-cec8e287b4d0@oppo.com>
Date: Wed, 9 Dec 2020 19:54:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20201209113941.GB105731@xiangao.remote.csb>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.255.79.104) by
 HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.7 via Frontend Transport; Wed, 9 Dec 2020 11:54:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31bc16fe-b715-48a8-9e77-08d89c392711
X-MS-TrafficTypeDiagnostic: SG2PR02MB2778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2778106683FC3292CD0D9F8AC3CC0@SG2PR02MB2778.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZtj5h9kTdydQmczzG6+dCTvDnbDTWeZNu+ak5cyg6Utayy4N7TI5gRoWSr3kfTelB3X9Kyslj99hxJ8dXeinYnfJ9ld0BOnusykFDD6T6+tYr1u9K7De7T8R6iAzw3oW80ZxgZph9Gjd44Z3PF58lm2+XogkI2OtZPn6YMQSg7FwqtbYvzcOjqSbp0N42msnfP1Lq1lbncPmO4wN+m0HlWXbpZ1m832v1iNGTufxIlUbWK01EOO8u0gFXHPnPhvuQntud4/edAknNOvuEivbsSg8XqoVe6PRbUezTeCF2WnKjVa9YqyEf59jLxtxqA0DpG3ZwjZrSqB+CKQotbNnOGYWHTCX9owZx5XOe8lbZ0ygcgJjFczCfAdSDweSGY/uSMZYSifOuGsG94K3n/YSGyFuyPXrX/nDmRrd3jY/6JWkcSruC1lirg1P+MS/r1RgCneukTu/CcBpENrk63t9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(186003)(26005)(2906002)(4326008)(16526019)(52116002)(53546011)(8936002)(36756003)(6486002)(6666004)(5660300002)(83380400001)(31686004)(86362001)(2616005)(956004)(8676002)(316002)(66946007)(66556008)(16576012)(478600001)(66476007)(31696002)(110136005)(41533002)(11606006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZWk4UWxkbkhmcnZseHpYMFBmNnRQMnB6R2RzTGNIZVJiK0ZkQXkxc1BDOU9s?=
 =?utf-8?B?MC9oeWVvdEE3cEYydWlNNkY0S1Z6TUdkQ1hhNnRFRE0yNzVJM3VSOWoyWGRL?=
 =?utf-8?B?ekFYWXlXaGxJbzlLcms0eVVtUURqU0tBMitRZE1pK3BQdlJ6VWNzbE5nb0k5?=
 =?utf-8?B?NEdoc0tUVVRzSVd4OFhNNEQ2YkVrdWZkRjgvM0JXQnV6WktSV0xLZkl0a0Iz?=
 =?utf-8?B?ZTNDaGJEY09VN0c5ZHp1bzlQVEhHQmVDaHJ2aVlaaEkzczFMNkZid08yYzZ3?=
 =?utf-8?B?VTEwTEJTeURkVWhuQlpXcGYzL0hxSFByUjlVb1JINzE1WnFpUW1BdHZQaW14?=
 =?utf-8?B?MFVKT29rMmlMN0hxVTlUMzhDcHQwQnVCT2t5WGRyd01QRXZySWtzVkFvejVR?=
 =?utf-8?B?dnA4bUE4NmorOGZBUEJzSmh2dEpJRFRaMk9TaEZMMVdJWFNpb3JWd1d5WVF4?=
 =?utf-8?B?TDNGRGxYT1l3T3pRMnNkbzM3RmJuc3hkT0FmSE9SeFVvME8rcmpSMndJdTNG?=
 =?utf-8?B?bnJJNDI2dlFsbzhCbVRmUm5vaCtRSzlRZEUwbjVmd2VHNFM2bXU2RlNQbXR5?=
 =?utf-8?B?SG9RTFFId1A1T3pKNGxabnQ1N1c3dlRaaFV2ZXFxVDhBU214K24wUjBFNjEx?=
 =?utf-8?B?VlhYQ2dHQ0R4Smt2eU83ZGVlei8rdGJCVWFGTE5tQStMeUNidmxIZWkwTGJn?=
 =?utf-8?B?UDQwemg1VE8zRXdVK1o3MEhlY0Z2c3d2Ui80TzZlaXhaTjZETWVTSU1MRkpx?=
 =?utf-8?B?VTQ2em40M2N5RityQXlpaWRxTkJkemg5cmxFamxHbnRkS1czRmkwTm8xMXNX?=
 =?utf-8?B?c1BYMC9jUk1UUHozQ2QxcE1kaEJ1c0Iva0VUNVo3VURDZjUvcG9XVmx3MU9r?=
 =?utf-8?B?ejN5OVRnMThrYnM1RTJMeUQ1YjVnYUs4RXY0Q3BNdWd4ODBTanRqQ0kxbVQr?=
 =?utf-8?B?bXFOc25ib3hVRE9TYmdXZE1SaDUrK1BkL0ZnakwyZkluNUdjTlNWNG9Iajc0?=
 =?utf-8?B?NWN2ZXBsYTFsY2Zpajg3elFIY09GSGszY1V3aDRscHArUWg2SGRhUlU0SGdE?=
 =?utf-8?B?MUdIUDdRWE0vdTV6TDNtaWJxSWJXRHR3ME1kWS9xYWFNVEFDNE5oMGlWVXFB?=
 =?utf-8?B?UjkrVDBCc1g5NXZ2Wk5OZCtLQU0vTUhUdEpNMjhZUTFMWlk4STdaSDAyNUdp?=
 =?utf-8?B?YUNlWkFkOWVJcDk1am5uSkoyQTJEeEkwU2JjVHZ1SHhrbGV4VS93azFqaGpZ?=
 =?utf-8?B?T3hlVm5hY3JRbjk0eDRQWVMyaHB1WENJazdoN2ZZZEVwVzJQL3dBSWhUaU53?=
 =?utf-8?Q?2Zsoe8sh30z5KrzV7UuFMXChyQdVodnoIN?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 11:54:15.4300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bc16fe-b715-48a8-9e77-08d89c392711
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pz8UWE7s/Lo6ap38o5f8fQtGm/e8PisU69AMAu0tnpqOOng1h404fG2RDixfZScQwC6nsCJeIzQfjlSpgmk/aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2778
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
Cc: zhangshiming@oppo.com, linux-erofs@lists.ozlabs.org, guoweichao@oppo.com,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Thanks for review, i will update it soon.

在 2020/12/9 19:39, Gao Xiang 写道:
> Hi Jianan,
>
> On Wed, Dec 09, 2020 at 06:08:41PM +0800, Chao Yu wrote:
>> On 2020/12/9 10:39, Huang Jianan wrote:
>>> iblock indicates the number of i_blkbits-sized blocks rather than
>>> sectors.
>>>
>>> In addition, considering buffer_head limits mapped size to 32-bits,
>>> should avoid using generic_block_bmap.
>>>
>>> Fixes: 9da681e017a3 ("staging: erofs: support bmap")
>>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>>> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> Could you send out an updated version? I might get a point to freeze
> dev branch since it needs some time on linux-next....
>
> Thanks,
> Gao Xiang
>
>>> ---
>>>    fs/erofs/data.c | 30 ++++++++++--------------------
>>>    1 file changed, 10 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>>> index 347be146884c..d6ea0a216b57 100644
>>> --- a/fs/erofs/data.c
>>> +++ b/fs/erofs/data.c
>>> @@ -312,36 +312,26 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
>>>    		submit_bio(bio);
>>>    }
>>> -static int erofs_get_block(struct inode *inode, sector_t iblock,
>>> -			   struct buffer_head *bh, int create)
>>> -{
>>> -	struct erofs_map_blocks map = {
>>> -		.m_la = iblock << 9,
>>> -	};
>>> -	int err;
>>> -
>>> -	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
>>> -	if (err)
>>> -		return err;
>>> -
>>> -	if (map.m_flags & EROFS_MAP_MAPPED)
>>> -		bh->b_blocknr = erofs_blknr(map.m_pa);
>>> -
>>> -	return err;
>>> -}
>>> -
>>>    static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>>>    {
>>>    	struct inode *inode = mapping->host;
>>> +	struct erofs_map_blocks map = {
>>> +		.m_la = blknr_to_addr(block),
>>> +	};
>>> +	sector_t blknr = 0;
>> It could be removed?
>>
>>>    	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
>>>    		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
>>>    		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
>>> -			return 0;
>> return 0;
>>
>>> +			goto out;
>>>    	}
>>> -	return generic_block_bmap(mapping, block, erofs_get_block);
>>> +	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
>>> +		blknr = erofs_blknr(map.m_pa);
>> return erofs_blknr(map.m_pa);
>>
>>> +
>>> +out:
>>> +	return blknr;
>> return 0;
>>
>> Anyway, LGTM.
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> Thanks,
>>
>>>    }
>>>    /* for uncompressed (aligned) files and raw access for other files */
>>>
