Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF482D2BAF
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 14:12:09 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cr0vV2tZKzDqCk
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 00:12:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.50;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=i2W3Bxxr; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300050.outbound.protection.outlook.com [40.107.130.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cr0pj0djrzDqZP
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 00:07:55 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIWr8pxBtphsodYhmP33IAgAnqZBsDuRE1M+YQv10woaDpARbKN6wYvdNvujOMMSxEE/aYBtDwvKhGZkqh3/AwuNd3AHHzRAlY/5NOCCmSa7nLvuMDj8Rhdd4vBW+U/EmzpVMRgZk8BRGy48cOGMk5mobsl6m9tiUxybgtIoI2z69iSGnWUmcBvGo7f5hXrHlZ946FCobtJWpf127AVL9tJyOljTmSd+JYsyFIkn2OtMFuJ2gu8wOBizMNcCscPrghNngINpPfXwYGwp89BbKlAIvnR3WRjBdProuOmj9bVzs3sKnTdTJzUaMBdTt+jR9PSZag5hjGImGxjF8peq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHWcQIp1k+nRfes+eIBDe1jcDx+25PGKDNQ7+IfgCo8=;
 b=Vxntc4/n46GO40oC4EoDiFfnF3zaKPRSnCwZDswcp23KwU6Lx1tJatoEStPVUw//OmBFL/Jy5HsNpH2Sf4w6uzK6KAHcGWsm9/bmMPkaTwCtz4ShprEj29Nk1fBLt5oTo4WlQVfquhzCEEjroHm/dTV6Busl7S8UAOmPkAw2ltbsslMrHvXkWyyVmsiFoUroWLtP8fWHqitXvskwtRHzIDAeR1M65oTrS40Ef6obI1Evtqppa90InAWoN8yuHEWKmn1VhPjIUELdVfO7nDr1AWadg+0yZf4TBl2jwnijyy4KMre4MIvNwTTIJJpejIQJnHJF+5uhO7MX0fogOxG6lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHWcQIp1k+nRfes+eIBDe1jcDx+25PGKDNQ7+IfgCo8=;
 b=i2W3BxxrnQdaM/tsmTCEAz9Z3bBtxioy3NIVfCBcxz8dwDiAE/P47aJV+b+THP7Kc3WuShAP2vc/2UDUvUP5T8sw/Hmr6pdib82QALpLX0rKtKLC/wQ9uyQnmSK04JtwHTSux6wJFmt4MrAXsP4lnxbyor257BHXc0TLRWVhWpc=
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3273.apcprd02.prod.outlook.com (2603:1096:4:48::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Tue, 8 Dec 2020 13:07:38 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 13:07:38 +0000
Subject: Re: [PATCH v2] erofs: fix wrong address in erofs_get_block
To: Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20201208093133.5865-1-huangjianan@oppo.com>
 <9fb238a9-ad1e-cf7b-7b42-291e5f0e8929@huawei.com>
From: Huang Jianan <huangjianan@oppo.com>
Message-ID: <a511255c-c3bf-c0b1-0fec-ad85764f7ec6@oppo.com>
Date: Tue, 8 Dec 2020 21:07:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <9fb238a9-ad1e-cf7b-7b42-291e5f0e8929@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HKAPR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:203:c9::6) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.252.5.72) by
 HKAPR03CA0019.apcprd03.prod.outlook.com (2603:1096:203:c9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.5 via Frontend Transport; Tue, 8 Dec 2020 13:07:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 565e1e66-750c-49df-fd41-08d89b7a3c82
X-MS-TrafficTypeDiagnostic: SG2PR02MB3273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB32732F9CA7343F046FC02103C3CD0@SG2PR02MB3273.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:359;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xrM0X3dPuAqXMeaxLehdIXZjJKOMQewCMDny8gdvQNmUls+/ofJ+jG/BqHD3cXR47UfZZzByV2af0k/XPTMHWrR8tkbx7726PaRFh/VD1fwyu8anrj3rbJHv/741c/s1+RXczJiy6hchnKNEtUxP7CbxNz9UYHjyzJu6bHQHqqtBDgyqL2439x2ERYqy98MO/xxdnzvV3sbqqsK3PVjJqEafiVaKNPs1qcYoTXz7bwsoRQInIAiYNgUM8Ox4jx1PeyOvMdo38hef9y8j7s7rIAcsyRRnT6aZ7Ta15rSo6bVAlAae+9TKAcOpF5W3zPAbCAxC2BFCEEjyXnVRcyTD+HwtVYqey7d/4Z0aPUFvn07Slx03K/47JpUCbW3HWJPzImI5Pg+mQGap/UICMsRJtpN8m74v1QgQV3tSa+ADN7NFVNEdnWX/DTbtC50mlBflcFxg3lPT+rTEr4+cdIjdKLB0nPeo5IQr0k5ZzYuuCXQE1AhmmrEF1LwnoWnJ7YzoBtZ3FcnYifYrbjvYgd8tVnvwXp2NFp7M8aJqeQrt1WU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(34490700003)(31696002)(6666004)(5660300002)(508600001)(2616005)(8936002)(66556008)(36756003)(4326008)(8676002)(66476007)(66946007)(2906002)(86362001)(16526019)(956004)(186003)(26005)(6486002)(53546011)(52116002)(966005)(16576012)(83380400001)(107886003)(31686004)(11606006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?am51dWg2ZVJOKzcyWW81OU80WWJNNTB4bEdjd2VpTThvY0R6Z1ZpYTlKMklr?=
 =?utf-8?B?Yjd2bjI3OHpkc0dUR2NQL01CODdLSDkxZEIrdzdWNHBwM3dkL0tPWDVza212?=
 =?utf-8?B?ZG9weEV0U2VDbHlaZXdXTTRsNkR5WWJiaXpxME9CWklIT2xOMDVsUTFLRFh4?=
 =?utf-8?B?azFYQ0d4Z2s2UXRoQkNTYW16dFR5M3IrMjE0bVV6c1o4bWY3WWtVMmJNVGFY?=
 =?utf-8?B?d2g3Zk4xQXRTcWp3S0VxYjVhSmEraUd5cjkxUEFtdUFjQnhMU0ZYMTRGdk5J?=
 =?utf-8?B?WGhwd2hBaW1ERVVvdnR4cTJVbWhwWVBsbjFrb1dCR3BiMXVYS2czand3TVZz?=
 =?utf-8?B?bjJnU1VadEhOMEZ1Yk5SQ3NKdjVBcE5Uenh0VDhEdzlmSUV5bmxHRmhWOGcv?=
 =?utf-8?B?ZWcyR2VTM3NEOGdWTTZqU1ZCZTJkRjNxaFpRbGhkei9rWUtnRWlUUGxyVHRZ?=
 =?utf-8?B?bkZiRTY3RERZb1dKb0dCOFJtcm00V1V6cTlwSVpvM1Q2Qkdhb083TVFKS3Jq?=
 =?utf-8?B?cEp3N1hYdFlvcDhxeTVFTnlmb1RqZnBzYlIwc3lKVmRVb2Fmd242Y3JGRGFm?=
 =?utf-8?B?YmZQZEZNKzBLSC9GUkJsZXljTXZXV2Z3TWxlQmdyNkRJb2FmSEpCMDY3Zi9k?=
 =?utf-8?B?WWQ5RnBsMXRHQ1NJOThlWm1wRCtBZk5oVjlLTHdvWjUxejlLTXVndkVZMDBs?=
 =?utf-8?B?K2w4VGNmSTVaTmtPV1pPWVVYNDRzeGpUbXk5VU1lQVgyVnBwMnVOK2xuMU9Z?=
 =?utf-8?B?MW5tUkphWk80Zmx1VVAwNzA3RXpOdFJYekVSc3RwSi9vVEZjTHZobWx3d0Mz?=
 =?utf-8?B?NytUUWtkVWVVZWc3UjBlK2V1UWVXZktzOVZ4OFQ3UStKSnRpQVpIZWtzUVNK?=
 =?utf-8?B?dUlHMzl3VDBNS1F3cmlvSXBNeWQ2ZXBYUm8rUGFKL1FNLzFueWdhUDBiRXp5?=
 =?utf-8?B?TzVMcGJxb2pvYVdqTDVyMDRpSU0wck5XaUtOU2d3Vm5FdEpsR2c0enVRS2FY?=
 =?utf-8?B?WkoxSU13ZzViSmVxTXZrMVRYV2krWWQvc3V0WjVmZE1iWkNVUWVWYXBsaThS?=
 =?utf-8?B?aWw4azhiSU1BOHZySVRsUXVabExoTmtiZTBSQkcyWlJYeWQ2Q2dBV3MxRUhU?=
 =?utf-8?B?WGxNVU5Zc05wbnlCME01bWdUb3FQTlJyMzBCaWoxb3V0am1DN0pyQTRpZVlI?=
 =?utf-8?B?U1hONWQxbFVlK2JhWWVXRkNuZmlqcDNtT0UyL0pmM1ExWjhrUEVzNHNtVytJ?=
 =?utf-8?B?MDYzaU5SUU5ncTBobTFROXZpMDAwWExLL1E3c1hFVU5CT0pwZG5oblBHYkdO?=
 =?utf-8?Q?2JDg16/Msa5Hc=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565e1e66-750c-49df-fd41-08d89b7a3c82
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 13:07:38.1944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xTCTrnrcAr2ZC/MOYumxQxUJQ9XAk8t75Ge9NYVh8NFkscUrlMYknwDwPkHvDiJm/BjO/tbr4EO2/CAXpDYyQ==
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
Cc: guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


在 2020/12/8 17:48, Chao Yu 写道:
> On 2020/12/8 17:31, Huang Jianan wrote:
>> iblock indicates the number of i_blkbits-sized blocks rather than
>> sectors, fix it.
>>
>> If the data has a disk mapping, map_bh should be used to read the
>> correct data from the device.
>
> Thanks for the fix, I was misled by sector_t type...
>
> What about avoiding using generic_block_bmap() which uses buffer_head
> structure, it limits mapped size to 32-bits:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=b876f4c94c3d1688edea021d45a528571499e0b9 
>
>
> Thanks,
>
Thanks for the suggestion, I will send a patch v3 to drop 
generic_block_bmap.
>>
>> Fixes: 9da681e017a3 ("staging: erofs: support bmap")
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
>> ---
>>   fs/erofs/data.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 347be146884c..aad3fb68d6c8 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -316,7 +316,7 @@ static int erofs_get_block(struct inode *inode, 
>> sector_t iblock,
>>                  struct buffer_head *bh, int create)
>>   {
>>       struct erofs_map_blocks map = {
>> -        .m_la = iblock << 9,
>> +        .m_la = blknr_to_addr(iblock),
>>       };
>>       int err;
>>   @@ -325,7 +325,7 @@ static int erofs_get_block(struct inode *inode, 
>> sector_t iblock,
>>           return err;
>>         if (map.m_flags & EROFS_MAP_MAPPED)
>> -        bh->b_blocknr = erofs_blknr(map.m_pa);
>> +        map_bh(bh, inode->i_sb, erofs_blknr(map.m_pa));
>>         return err;
>>   }
>>
