Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3A54C0D26
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Feb 2022 08:20:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K3S9B1gl7z3bT0
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Feb 2022 18:19:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1645600798;
	bh=JmTbGIb26yj3zaDL2VFZaOLZCkrec8mdQyFdSswTlhY=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cggJy5KAbQuJKpGBH6wFOok3ja2nqY4rqI1YWkHEdM/OAeCysZ/mgFPXx8ptqG/AM
	 P0eqYzBT5hr4CnS7jWI1pp15Xxbld7HG8EYHSZ3L55OEL9B20dYvjhc9G+bKuvb8t1
	 MAB1VvfcScePsINKLWgst/8vWmw/aEdr44Il7d1OkStGiYI6w3ocETGmQ4eSNX/2B+
	 JFYY+50T6MqfzxOXdj9R9cKPSSpsAMZtTpuWuIOzM4tlJnrjIl9nnTKDz/iBZD6P41
	 oJK5ZGGTHqFxmqcKv1n7Qnge5Yyp8K+2ov3SOsXm1WoxiNBq2yw+YM2d3W21dXj+qE
	 Vla1eXE4FQU1g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:feab::60c;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=IG0BxED3; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K3S9310WXz30NP
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Feb 2022 18:19:48 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+h83aWBMHWsifbrNcpzxDK6RA6u2iR8TPsME0itsM6/91mVHafVZe3uc3VvvEd+BGQJivpP0OEHvqZTvXd6JO2w+vpjAYg+uP79+wbk9i4Mdy53z87EaZDcVnet2wjvQh6CBFGlsyzbxzAQEVddMLfCES3G4Gx0R5zeaOVQYIpJv6bdoItpAHybX1Aq3pi4CUHstEydCLK1EhM/II3fb9BKOjaKhGZWyXTv1f+4zKdEVGNmW1mmSQbkr3/6dYH5OxrNWMXiJXSe6N55PKxajDJFpjHyLxubmYZortZ4fo/4BggLjuNF27MeSu2FHQ6rO71VIsr9KwsUo2Gh8Vk6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmTbGIb26yj3zaDL2VFZaOLZCkrec8mdQyFdSswTlhY=;
 b=Nkj8/Of/OFR0A008mg8hY8t441qawCoTrfK2dIsyHgD4tO7u0/bz+t2Scb7sMDLZ37dcktuCa2dP2fZrYwt/JOyIeCGEG9sBoe++0h7qgE+lbxYcbtCdl41Qq2ttWCDHubRhkwsvcia+YvnnhkYY3tA4pLLyTmJEZahZQmNmt0sQ4oUf44+vhnb6XHqjDQQGuBub1nygKLwH62jTQXJffpMi5WLw4fuUGceuIJK+XSAGwdZy9SE/Pyl/DLXtlv6U1hJL531M8FmsvRDX5brbfVqnKwMDYpAdH0l/sbtimVnsqporcBKkBFnxqXEulQ9kGanzVOUh7w1so/p5dRSDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from HK2PR02MB4097.apcprd02.prod.outlook.com (2603:1096:202:2f::14)
 by HK2PR02MB4260.apcprd02.prod.outlook.com (2603:1096:202:30::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 07:19:25 +0000
Received: from HK2PR02MB4097.apcprd02.prod.outlook.com
 ([fe80::6c6b:1529:6aa3:6a75]) by HK2PR02MB4097.apcprd02.prod.outlook.com
 ([fe80::6c6b:1529:6aa3:6a75%3]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 07:19:25 +0000
Message-ID: <73b61b0f-5051-bda8-503d-3804d2205b3c@oppo.com>
Date: Wed, 23 Feb 2022 15:19:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] erofs-utils: fix memory leak when load compress hints file
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20220218031137.18716-1-huangjianan@oppo.com>
 <20220218031137.18716-2-huangjianan@oppo.com>
 <Yg9Ejqjt+y7HPaOv@B-P7TQMD6M-0146.local>
In-Reply-To: <Yg9Ejqjt+y7HPaOv@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0147.apcprd06.prod.outlook.com
 (2603:1096:1:1f::25) To HK2PR02MB4097.apcprd02.prod.outlook.com
 (2603:1096:202:2f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16275d90-a2b4-40a1-fc7c-08d9f69cd271
X-MS-TrafficTypeDiagnostic: HK2PR02MB4260:EE_
X-Microsoft-Antispam-PRVS: <HK2PR02MB4260FF745E09A6E0866716C9C33C9@HK2PR02MB4260.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8dAl7WN32bBPJpZOKlzGeNdd0MykPEHl3eL+rvZ8mXGfotWTcjy22K3KycCdGIYRj5HzA9RJFeFMTjbU+ghMsF2CpUh1zxAetQ2nRTvWEqmxcHjWJYwxwaVyOrcF6g1KVqc/zIUZEqdR4Jy5DONRgWMqUMd6La9R+X5giWg0/alfu7hhxt649v6dFeZEYqjpnaXPtP8solaj+i8+rOQiuCCSBzJ2H/i4ZZn6Y6gDwfgL6b2fB170iBqjzOs48w1OpZ9h13KKjn2+mc+iRg/cyIFkegErXf0TK7Fwdp81utJkhdKLNEQFo2BCWQWQZ4LzbOHiDmfEbyS7RMu2DAIsgCIdZbEMh0kh6y8HtjYsA75jBqana4q00JyvUsMZbzjdaoX6SCkRIwz+WzJttIhuNAyYZ+AyhBBfS3JOUsp317GO/TbYGsv/qQveL4DTKCFREX4ZS1rvriQy6HH1AHk/esz3sIBkWZWBNqe8R9ENYL16UKIwKAlDFt4AvtH0D9gL80bdzUekUgeoU4PGBJMeq/+kFNgO5f1cyvRDtEpc1qrTnWM8f83rh/fIMGz1Qt6YVhRlz8SQJyWJJzxFSCX+fCzH4ab+ZO2sMy1wufuOZ3F6+iRl9NVgodFK/NakwZUL3DMlcrvSTo3EXiQZrMwno6pGZqXZqjt9uIGGY0x764IxELK5xOeEhOSPJm2S6ZE34EsmcvRP1dAH2VvPew8DFAruUWltZTUrF4owMDk+VdKZ1FOza3HV5iY9KJJw9xd3/66U2QFMhrAwp4GifJOS+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK2PR02MB4097.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(5660300002)(6916009)(38100700002)(31686004)(316002)(36756003)(83380400001)(8676002)(66556008)(66476007)(66946007)(4326008)(6486002)(6666004)(52116002)(508600001)(6512007)(107886003)(31696002)(2616005)(86362001)(2906002)(8936002)(38350700002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDZNMFh2TDkzSWJzaVloZUZJVitWU0E2ZGJsM2ZoaFF2RVBVVTZFWnN2MXZV?=
 =?utf-8?B?bi80L1FXa1pzamN4Z2NGR1BqMGJTYVlveWtUZWV1L1JnKzU3bklOWHJVVTdC?=
 =?utf-8?B?T25TTE5zYk5BNXVuOTZRMGx0MGJtMXhuNWRCZTByRXJEUzNjTVdVdjIvcWhs?=
 =?utf-8?B?V2xXSkdkL3BSQUJUcmNEVXB6cTFyM0pTN2VHcDI4YUtmb1M1VmtlODBEcDRM?=
 =?utf-8?B?TzZVVHZPbHVoZXZSUUxVU1BraXJTSlBWd2ZBUTJBdU56L1hMbzhyNEphYmJm?=
 =?utf-8?B?a1JGLzBBV0tkYkJ0TEhSRHQrNDB3SUZJWS81RUpmSFhrWFJMQWxPalBoZmpO?=
 =?utf-8?B?YjZ1VlBYejFhUGZhNEUzcU5aQlVrWmY3V1lHVGNUQ21EbVE3RkpLRHZvRGYw?=
 =?utf-8?B?VFdUc2JoUjdrUUVZVSttWksxekNCQ1dOSjRBaElxbVgwZEJlWWZ5TVFpNktE?=
 =?utf-8?B?bE85SG5KdHJvUzdSNk5KT01jY1FQdG9ySnFJK3NDTmt3UTM0VXFmVUhvanlj?=
 =?utf-8?B?VkRjWWlWSmErRjNGeWFmMjdMVzV1cndvTWRyNkd2YWRib2NBa0Z2dUZuajVl?=
 =?utf-8?B?M0xpcGZaSzBHZGJaN2x5UU5uVEZUTW8zL1dYOG1yN2dHWlV5MEVXK1l5dTh5?=
 =?utf-8?B?SkttU3FhVjJQaW9LeFFib1Jna2Rrb3ZmbzU3VFJMVjBza3lpSWMzUEY5cmhz?=
 =?utf-8?B?cklKWlpsM0NKQzZJb3JLSm1qb2hVYU1iNjFpOW1zREl3ZG5jOUpOOFE2NEY4?=
 =?utf-8?B?LzFvZVlJOGtHVkhQQ2UrNHUySnZTQ3greU41K05qQ2VBWmw3SnQxTHdiQkFM?=
 =?utf-8?B?UG5Wd3hoTTQ5SVhxRThSSXQ0bXlwdm9tQU1Tb3NjeGErcmsrQmxrZVRWNGZl?=
 =?utf-8?B?Mzh1V2RuY0ZWcWM1L3NucGIxYU5wQWdRNjRWM0FrdU9Jb3FSV29HMjJ1TnZk?=
 =?utf-8?B?ekFkcEhsd0N5eDFXZnBUMDVCTk9OMWtySjU4WUpGMURPQ3d3ZDhzYmFrWWI4?=
 =?utf-8?B?Tkwxa1NRVExWQkdSYUNtMHZYSXI4dzUyRHFWNk53Y21ENTJJelo4WkVRdUo1?=
 =?utf-8?B?akJ6V0tTNG8vSEppODNJR21tUlNTemR1RnM0SUo1WDl4ZE1NZnBHcE1xUC9J?=
 =?utf-8?B?SnE0ZzF2dG1WcGNpaGpyVTRTQU1FcUhoRUd4Rkh0VzlwZFZ2WmVGZXByVTNz?=
 =?utf-8?B?VVY5TkV5TjEzYkhNMkRTWTVaYVVaa0twTkloaEdkblpqTi9hTDNDaVZNQVlq?=
 =?utf-8?B?RHhFWU9DbVBRSjdXSit6M3RxeVpPd1RkOUw3MVpSclltVTBjNWJLaXNxYUMz?=
 =?utf-8?B?UVhscE84OURjcUM0WlozVVZPNjQ5LzBnOTdCMnlDM1RIcFA4dCtyWjVRTzJq?=
 =?utf-8?B?TWdoajh6Q0wra2NWQ1A3V1RLN1FDOEdqZHhjZEFpOEtiOTZKa0lmOEtBZGJO?=
 =?utf-8?B?azRmT0tEN3AxTkpGVTRkMUE2MG1NdWVYS2ttTzI1RnVvZFI1cXFHM3pMWi9F?=
 =?utf-8?B?Nk03Ujd4SFhSSm0wcTZSMTNTMUkxNU9TYllkcENZTU9yR1ZGWDRrdkxyWEN3?=
 =?utf-8?B?SkhaTElTM3RuRkdLZ1dCVkhQUi90UDQ0TmZsd0dURVdlS3VaQW9SY210RjNI?=
 =?utf-8?B?MlRZbVVtRXdDZmtnR3pmTU1jb3VPekllamlEL3gxZmt1RER2OG5sMUNvcW9m?=
 =?utf-8?B?UVE0R2xGa2FtVzIwRnZqbXdxa2pkbGxNaUQ3TTA4RFJOenZEWGQvSSttQVdW?=
 =?utf-8?B?NW52ZFphZnViOTZmSENqUXZUWElLSlI0RDY0Tk5qZ1ZJS1B5RkdIbWR6NlhS?=
 =?utf-8?B?UlZ0SVErdXhvQnVEdDZ6aTdtNjZqRzh5Unp6c1Y1NktKYnAvRitWcnBGVm1J?=
 =?utf-8?B?SDNpUzlNUTd3MWwzektsV2pMVGVCQWVaQVd2czU3bHcyT05GU2hUZnNxTThh?=
 =?utf-8?B?aUZhei9wYk1oMjkvUjMzTXBDR1pwbGZES1V5ZjdXUmd6b0FCcy9XZ3ViMzdu?=
 =?utf-8?B?bnlOTlk1QkdFNmpSR1ArOWo2aktHQURtTHlQVkJmSmw3U2hCNmdIeEd4dWhx?=
 =?utf-8?B?ZENQQVMxU2Q1YjhYeUVPVlhmNFUyM3lYcmpmU1RoNkg5bVpIanBhMmMyeHJU?=
 =?utf-8?B?SnJtdVFRY2pHNE5LSUR2NVdZRTdzaTdvK1VzK1JtNUlkemlyRld2RFdxZXZn?=
 =?utf-8?Q?YpHnTaMXaL/ZUqv5aqo61GE=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16275d90-a2b4-40a1-fc7c-08d9f69cd271
X-MS-Exchange-CrossTenant-AuthSource: HK2PR02MB4097.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 07:19:25.7058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/SFU0kFPLXG9K5B2aQBroYn42U+1CjayBsOGD1NAT/PKga2ZmTtyCJwct2Hgsq/pvvXNWkpXgk12yctSYejlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR02MB4260
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
Cc: zhangshiming@oppo.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2022/2/18 15:02, Gao Xiang 写道:
> On Fri, Feb 18, 2022 at 11:11:36AM +0800, Huang Jianan via Linux-erofs wrote:
>> Execute fclose before return error.
>>
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> It's actually a file descriptor leakage?
>
> Thanks,
> Gao Xiang

Yes, I will fix this in the next version.

Thanks,
Jianan

>> ---
>>   lib/compress_hints.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/compress_hints.c b/lib/compress_hints.c
>> index c3f3d48..c52e2d3 100644
>> --- a/lib/compress_hints.c
>> +++ b/lib/compress_hints.c
>> @@ -88,6 +88,7 @@ int erofs_load_compress_hints(void)
>>   	char buf[PATH_MAX + 100];
>>   	FILE *f;
>>   	unsigned int line, max_pclustersize = 0;
>> +	int ret = 0;
>>   
>>   	if (!cfg.c_compress_hints_file)
>>   		return 0;
>> @@ -105,7 +106,8 @@ int erofs_load_compress_hints(void)
>>   		if (!pattern || *pattern == '\0') {
>>   			erofs_err("cannot find a match pattern at line %u",
>>   				  line);
>> -			return -EINVAL;
>> +			ret = -EINVAL;
>> +			goto out;
>>   		}
>>   		if (pclustersize % EROFS_BLKSIZ) {
>>   			erofs_warn("invalid physical clustersize %u, "
>> @@ -119,10 +121,12 @@ int erofs_load_compress_hints(void)
>>   		if (pclustersize > max_pclustersize)
>>   			max_pclustersize = pclustersize;
>>   	}
>> -	fclose(f);
>> +
>>   	if (cfg.c_pclusterblks_max * EROFS_BLKSIZ < max_pclustersize) {
>>   		cfg.c_pclusterblks_max = max_pclustersize / EROFS_BLKSIZ;
>>   		erofs_warn("update max pclusterblks to %u", cfg.c_pclusterblks_max);
>>   	}
>> -	return 0;
>> +out:
>> +	fclose(f);
>> +	return ret;
>>   }
>> -- 
>> 2.25.1

