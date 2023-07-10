Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F6D74CB46
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 06:35:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=Dh6BYA5I;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qzrm53Lznz3bY2
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 14:35:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=Dh6BYA5I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::70f; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070f.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::70f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qzrlz4dblz30M1
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 14:35:43 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjrucPcqr8RTvEeolIexvWr2kRpgGugm/Obo/6mioKkFNGI40CphJiOveX6Fzah3u2tKGAeozFqbk86cqj3HdZ4Y/ipSWT3LFgCriq1s9DOdGq64Y/i1fWAXssrazrHhacq6Qvo5nLxOoHWmfNqChVDlTCE4Vlo9ChCyZy+KcXnVeD8L2017A7H2oAvH2Zca65w71RRxMFXlBreRmvWVw/8nydpM57d2rwl0hpYG/C3mu1JmHLn4IiISVafC1SHrhNVD0tNBHuNG6shQyHQrbUQXIJvogv02Vswr2hp2WDUqarNYJSw8sosxuGf+ccegDHLNOiyBCwqgmqWxpefFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ze9qgJJyPjD5gF4+p7JIdEHiBKqwK52dnQIQFsDaYw=;
 b=No/t9l60VwOhkEP0da5i5dnNdMYnpOpH95U/nqt1N26WczaXqK3O73aEnSsxfc6JzXXR/emFVcSm2wWZWnmPCcCGK7YgoOQ4jU052cv9zyK8pUF7tUG57lvRfkMWcmACl0KsiZhQQ5ar3GO/Pkex2MlM0No7pvE24PtvnGOrDltNwkewuu2ocoDWYNPgdgHahgt8QN6ueb6VY2ouAO9ZjFuIr5n7lnOFm+8A7g5ETy4LXOWCVJB4RcM3kr0KgCiOifFPNB4JpW0PRSxtszegFaIWYTlt0ESkZuWqZrLH+3W7XjEiq97k09PxVP94SRE4Z8sZ6Kdoaoo8AwKfuJ7olA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ze9qgJJyPjD5gF4+p7JIdEHiBKqwK52dnQIQFsDaYw=;
 b=Dh6BYA5I9C7jQIqLa48Reb+s0rsbYC1iY5AcqDQEp4i9dkj5Gwiz4T0QH2d4Te4T5RG/FPZUnEm+a+w0OiC4iisydvxb1+id4TDJA3pFWCytOeb6I9R3Q4aEhfJsBpzufEuHv+wrK98vVK27BdupEHTi2iKzdYaLk9vr2MPBeEyqnmM7ZIzaFLSjSKrBVF+vzj8+1zjJiyThxI6aXTTl+8EKgYidw9VtQg3N8pJJP3jqWlqbak/bGDbzd3n4XvwztbcgXtmqmW4MmjI4UjcE5Vwldh0xccmXzGAJow4mTW8fQSOy8w4Sq5hbXN6yPuZq0aiC4omK5bXdhN+R8SdeDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com (2603:1096:4:97::23) by
 TYSPR06MB6337.apcprd06.prod.outlook.com (2603:1096:400:42b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.26; Mon, 10 Jul 2023 04:35:22 +0000
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::a05b:2f8b:fba5:50fb]) by SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::a05b:2f8b:fba5:50fb%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 04:35:22 +0000
Message-ID: <ac05d6e3-79b4-a470-2a30-8c809c277209@vivo.com>
Date: Mon, 10 Jul 2023 12:35:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH] erofs: fix two loop issues when read page beyond EOF
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 "xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org" <chao@kernel.org>
References: <20230708062432.67344-1-guochunhai@vivo.com>
 <97875049-8df9-e041-61ca-d90723ba6e82@linux.alibaba.com>
 <d6ee4571-64d6-ebd2-4adb-83f33e5e608d@vivo.com>
 <fd738d38-17de-4b61-e4e8-d4f98ef8d1db@linux.alibaba.com>
From: Chunhai Guo <guochunhai@vivo.com>
In-Reply-To: <fd738d38-17de-4b61-e4e8-d4f98ef8d1db@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To SG2PR06MB3338.apcprd06.prod.outlook.com
 (2603:1096:4:97::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3338:EE_|TYSPR06MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: f64e2124-defa-44fd-a851-08db80ff1269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	gYgZDnoNMKXgjkXb2sA35lU6J/dwMdToQejHYY8e/o9SSOY6sBEa3Oi7oLLUm/x69YCSSZACBaUDNc6JWdi80vH6VATgrMbBvCybf+feDvjXNTFQB72B+CWcKQEHkr+NK5EoEh64VNUkI6Bo6g+n5uMxlxSaIdquRlzUGDXq/zpwAsm2t0+wWcD4I4sCSOIKtKYrciHoo2mZ9MV46nkyPXQXgjawdmxjkOssCDoinVWI67xcIfNluhEjwvTFVU2wGAWqEp4cGvzbtWfBfOnHu91Ax/ivXpcCPITFftjZDuCQL/F4RAX/PVSB3ruOLqAo3HPLsXwZ4nJZ0kHbrD9YJQggkZ2WwSIsOqIw/GWViBh1+UNo8f5XJfmI9n47yZTdM1KvqX0rgB3Iu0ciRyiPTm0G/W+DO5dJ7eTXQIeu6P5TVT+Oeq6klRTaKsPhbcr+EFVCECsbusWr3QZ/xNO/csxS+f94cvTDEi1d4FQtSunwAuOkF1sx45Md+tAC4db5wjL/aRE/CJ2C6qQ3GEwLV5Zfs5cf2y4uNFrrPvdeG3Lv80uJw68A42Wx02MD7ngCD++D9qBwpCkFac15PrZKOJZ/IVAXFo8RKX3DyqqjaIXmPLjtv2V/Zdp/U18KN5LAB27Ln459QUESng98wg899A==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3338.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(86362001)(31696002)(38100700002)(31686004)(36756003)(6666004)(110136005)(54906003)(6486002)(53546011)(26005)(6506007)(186003)(6512007)(2616005)(2906002)(66556008)(316002)(478600001)(66946007)(8676002)(8936002)(66476007)(5660300002)(83380400001)(4326008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?RlFKblJrNHdzamJwRmJLbklHdmNITngyb1JCVVZGR25KcnphRTlkcmVidWdP?=
 =?utf-8?B?dTd6anRoVU9haWxNV3kyL0hjNGlTaXVpZ2FBYXZRMlYxeUlQbDk2NHN0L0E1?=
 =?utf-8?B?bEFHSXdHbjNyanh0QmtkaU5KWjRoeTgxUVBxQmkrN3pzME02d0dpSk1seHlG?=
 =?utf-8?B?NWpBT3d6Y0dWczVTdVBNeUt4MDVwZFZFKzcrUXcxdHpVanRoQWtvcHduU2RG?=
 =?utf-8?B?SHBEL0pnVWFvRURZZ1FtVk9IcUxINUVuMDhvUHRUMy93SWhFS1JueXhSR3Nu?=
 =?utf-8?B?WmhEVFZnVUJuZ2tlZUtnKyt0djZ3VnZtRC9Gekd5cGhRVkl3MCtXS3B6bmxy?=
 =?utf-8?B?UzBzbUFNWjRLczduSTFrQy9HdzFnR0pwRHVTaWdRdDdwMVpTNWxBN1diOEhJ?=
 =?utf-8?B?d0k2STBVZ25WRTNXMWNJV0VUNzVpb2ZkcGEwWlNLdUJFQWNlemxpeE5JZWRp?=
 =?utf-8?B?V1VpdnZqdk52MEQ1RTAreFhiYjhCYXQwOUVISll4eG1tdGphd0RGOGYvMGZZ?=
 =?utf-8?B?azg0M0lpZXZmWEVFaFZhSThVWTNHbGFsVkhkZXFoVDZETk1nbkw0MlZEcFdK?=
 =?utf-8?B?eTdIdzdtTk1yaENNVlhmbU9tTjBoL0tVL2k4ZFpaeTVSUEdpQWZESUwzczVU?=
 =?utf-8?B?enczM1ZBSHhLQ1d5RWVFSHNmWTRvTG5hM2NkdndaVGdjWVI3OFU3emVmSWhj?=
 =?utf-8?B?MW1xS0U3OWh0S2czVmFNK0l6OTZ1V2I1cyt0QXB2WUdFZm91M1YyUlFCYWI5?=
 =?utf-8?B?WlRWOUQ2ZWlMWm1QRXRnNVJQQWhQelhJQlliaXZEa2doL1ExTVFTd0RYUGJS?=
 =?utf-8?B?TjFuVXZhUm1rUEtEOWsvOXkyQmdIcm1ucG9xMDhLZ2FXM1Rob25vNjUrcGV0?=
 =?utf-8?B?Z3pkTVY1N3ExeTM0enN5UUV3T3gyS0t1aURaYlh5YXlpRW52SDJCRk14WWIv?=
 =?utf-8?B?QnNNK1FwNjQxQVJ2YUZyY3J3ZWxVWVMzY3oxWWI4eDkwWUpXbW8wQUtPYnlj?=
 =?utf-8?B?dE5wenJaWmlxS2JhK0JrL0NWVWpiMEhlMk1rNjUvZXEzNkh5NFBpNG9nZCtD?=
 =?utf-8?B?SGV5L0U1NzZvVzZNMW1BSUtDVWdRQlFhbFBxSExlcnhtKzlmakxyODZzUUdZ?=
 =?utf-8?B?VW55Y05IKzI3MHRFVlVwdnAzZW9oMUYzT2Q1VEFsUFZvaElnSWFQa3UyQ2Vs?=
 =?utf-8?B?a3lMVWRtWWZRTmZjM3BLUk9HZWpZK0VBbjNYQkRUSWxoVFNvbVFWYy8yTmN0?=
 =?utf-8?B?ckRlL2xOUGNzelJqWit4bHdIS0d0WWhDWUxvcjR1Z2JqZWl0NC9ONWMxQVB6?=
 =?utf-8?B?ZWdpK1dpa3psajhkSnFzUStZZGU4SWhCV2JsWnE0SHJOMElPN1pEczU1S3NW?=
 =?utf-8?B?clZrUmFpbFAwcFc2aUw4NkliQmxuUTZQeW9aUTY0Lzd0OTY1R2RhNEZVSzRE?=
 =?utf-8?B?NXduTGZacXFXdHBidXdzdkZyWnU4alREdUxIMWJqc0VmK0VudjF5ekhCSVpa?=
 =?utf-8?B?SmRKY1ozRFVkUStSaXlZTTRJeVFpY0tJdERkbEZxcERGYWp2Z1BXakRKZUh3?=
 =?utf-8?B?aitjZzlLM0tjZHAwcHFoOVY1Wm9mVHNaSWFEblRpZHRJN0kxaXAyNk5ydlh1?=
 =?utf-8?B?SlFKamR6cUIybVpXZEx5aEFMa040V0xiTDdvNVZhR3htcFpKSTlVS1kwRWFX?=
 =?utf-8?B?Qko0cForTFBIaXdsTWpGajVWbnphV3I4V1dkeU9lbzdaa3F6Y0FqWkFMeGxI?=
 =?utf-8?B?dGtYTjkvNnNGSktCNGRGUzFqYlM5NGp1eU1QNitHVlBIdDVtVnZacDVzMFMw?=
 =?utf-8?B?R0hPOFpyTUJwZGZxOSswTVZiMXEyQysrOFI5MG1jQVhPam9jVFdXWFFoSzNV?=
 =?utf-8?B?UTFhcFcyRU1TN2MvcS83Vk9nRElxSXE2UHJFdCt5ci9PWjJmZ3RLbkVqUzNN?=
 =?utf-8?B?ZFpjcDNxMDNPRUQvNTdlUnQ2QWxEQnhQdzhBVWRVU1NiSElRbHpzZmVqSCtN?=
 =?utf-8?B?WTRhYnErRyt3cE9OWS9EV2wyOXAyWnhvVDB6Wm1NUTlUMFhFVzQ3VVdQT0s4?=
 =?utf-8?B?RCs1NU80dzVQTkcvQ2k5dFVHbzNLcnl6MUpYa3Zwa0lMc0pqTG5VWWFFNzBy?=
 =?utf-8?Q?lsyomwc5UmCqvxxXItxGNikzc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64e2124-defa-44fd-a851-08db80ff1269
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3338.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 04:35:21.8439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0FEsJCvWAqhZezgXWjp5ytrYMTvqpfCR3Hl7pxE7lEmkDXQWzzudPgIHuV8fAT0DXA0/BNyR5E9fBulLkpdPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6337
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
Cc: "huyue2@coolpad.com" <huyue2@coolpad.com>, "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/10 11:37, Gao Xiang wrote:
> 
> 
> On 2023/7/10 11:32, Chunhai Guo wrote:
>> Hi Xiang,
>>
>> On 2023/7/8 17:00, Gao Xiang wrote:
>>> Hi Chunhai,
>>>
>>> On 2023/7/8 14:24, Chunhai Guo wrote:
>>>> When z_erofs_read_folio() reads a page with an offset far beyond EOF, two
>>>> issues may occur:
>>>> - z_erofs_pcluster_readmore() may take a long time to loop when the offset
>>>>      is big enough, which is unnecessary.
>>>>        - For example, it will loop 4691368 times and take about 27 seconds
>>>>          with following case.
>>>>            - offset = 19217289215
>>>>            - inode_size = 1442672
>>>> - z_erofs_do_read_page() may loop infinitely due to the inappropriate
>>>>      truncation in the below statement. Since the offset is 64 bits and
>>>> min_t() truncates the result to 32 bits. The solution is to replace
>>>> unsigned int with another 64-bit type, such as erofs_off_t.
>>>>        cur = end - min_t(unsigned int, offset + end - map->m_la, end);
>>>>        - For example:
>>>>            - offset = 0x400160000
>>>>            - end = 0x370
>>>>            - map->m_la = 0x160370
>>>>            - offset + end - map->m_la = 0x400000000
>>>>            - offset + end - map->m_la = 0x00000000 (truncated as unsigned int)
>>>
>>> Thanks for the catch!
>>>
>>> Could you split these two into two patches?
>>>
>>> how about using:
>>> cur = end - min_t(erofs_off_t, offend + end - map->m_la, end)
>>> for this?
>>>
>>> since cur and end are all [0, PAGE_SIZE - 1] for now, and
>>> folio_size() later.
>>
>> OK. I will split the patch.
>>
>> Sorry that I can not understand what is 'offend' refer to and what do you mean. Could you please describe it more clearly?
> 
> Sorry, there is a typo here, I meant 'offset'.
> 
> `cur` and `end` both are not exceed 4096 if your page_size
> is 4096.
> 
> Does
> cur = end - min_t(erofs_off_t, offset + end - map->m_la, end)
> 
> fix your issue?

Yes. I think this will fix this issue. Do you mean the below change is 
unncessary?
 >>>> -    unsigned int cur, end, spiltted;
 >>>> +    erofs_off_t cur, end;
 >>>> +    unsigned int spiltted;

> 
>>
>>>>        - Expected result:
>>>>            - cur = 0
>>>>        - Actual result:
>>>>            - cur = 0x370
>>>>
>>>> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
>>>> ---
>>>>     fs/erofs/zdata.c | 13 ++++++++++---
>>>>     1 file changed, 10 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>>>> index 5f1890e309c6..6abbd4510076 100644
>>>> --- a/fs/erofs/zdata.c
>>>> +++ b/fs/erofs/zdata.c
>>>> @@ -972,7 +972,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>>>>         struct erofs_map_blocks *const map = &fe->map;
>>>>         const loff_t offset = page_offset(page);
>>>>         bool tight = true, exclusive;
>>>> -    unsigned int cur, end, spiltted;
>>>> +    erofs_off_t cur, end;
>>>> +    unsigned int spiltted;
>>>>         int err = 0;
>>>>         /* register locked file pages as online pages in pack */
>>>> @@ -1035,7 +1036,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>>>>          */
>>>>         tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
>>>> -    cur = end - min_t(unsigned int, offset + end - map->m_la, end);
>>>> +    cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
>>>>         if (!(map->m_flags & EROFS_MAP_MAPPED)) {
>>>>             zero_user_segment(page, cur, end);
>>>>             goto next_part;
>>>> @@ -1841,7 +1842,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
>>>>         }
>>>>         cur = map->m_la + map->m_llen - 1;
>>>> -    while (cur >= end) {
>>>> +    while ((cur >= end) && (cur < i_size_read(inode))) {
>>>>             pgoff_t index = cur >> PAGE_SHIFT;
>>>>             struct page *page;
>>>> @@ -1876,6 +1877,12 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
>>>>         trace_erofs_readpage(page, false);
>>>>         f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
>>>> +    /* when trying to read beyond EOF, return zero page directly */
>>>> +    if (f.headoffset >= i_size_read(inode)) {
>>>> +        zero_user_segment(page, 0, PAGE_SIZE);
>>>> +        return 0;
>>>> +    }
>>> Do we really need to optimize this rare case?
>>> I guess the follow readmore fix is enough, thoughts? >
>>> Thanks,
>>> Gao Xiang
>>
>> Since the code is constantly being updated and someone may encounter this bug again, I think we had better fix it if possible.
> 
> z_erofs_do_read_page() already covers this case so I'm
> not sure why we need to add another logic here.

You are right. I have removed this logic and sent the patch.

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks.
>> Guo Chunhai
