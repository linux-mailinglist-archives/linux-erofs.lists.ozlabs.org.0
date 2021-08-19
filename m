Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5D43F1033
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 04:06:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gqp6K0rmKz3bWT
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 12:06:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1629338793;
	bh=ZujmxoqG2WcJjx475B5cPsdw52uolt+BXXri7AYkznQ=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ay731NIyo3DgCGllx9ZlJSG3N2FhSgviZIglSJlicgrpAl8z604j+S8i1jqGopLtp
	 iZrxV6PNeV82pjSMCBsGorV24UEdL+gkfQVUoda4j4RGf4CSPAqjoi+516KC+eh9u0
	 CNaMgriN7NO9yFTBR41O/1yWM6BaUrpnhBqlAm/znM+PfmAgSAnFfStbyjE0SSMKb2
	 XnUyxNkqtIUXLBP2AdfMlCP/oPpEjmBzajdX4PKKxTktmsw02fZPvmQVmiaB/ipLpS
	 zqEmOZXSk1ePSkTiZuya6vMweXkxQp/MYMABeus4TsqANxBMupD/PJL6UT/+90fcn7
	 D0Q1RzCaEBXBw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.77;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=Zc8G65r8; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320077.outbound.protection.outlook.com [40.107.132.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gqp682V7dz2yWR
 for <linux-erofs@lists.ozlabs.org>; Thu, 19 Aug 2021 12:06:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFtd8p6BFOrnRzeHATzGRCvKXAidzJlDnVCwPbDJNfGdoljeUcRobSnfCiNbQP0rMufqXHQJlL/PHZOJiMjhLqS98qwaGKVUH97Eg+Q25Qalm1qXtn3hBsMXV1tr7QS9pkR1T7IqUIHI4/HrkyAqicNOghJHq1ZDpflSyIbhxPwyAdUoOlbTbL2N5zF7aqoEEeScRiaeHSygQc4zkE/TI8pieKx3E++en8/YHupe+yod02feaXYyZbEXdICL9QH/zXnV1UINPkqVh5ofbTzWxiA6Jqt/apnjKZ0q4yAkjeohsnNr1VB9m1rRW25OPImfr8NzJ/KTMi1MGEwfGoK3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZujmxoqG2WcJjx475B5cPsdw52uolt+BXXri7AYkznQ=;
 b=JP3SVOsIWk0dj8Z57WDhVJ0cAZMx9LphvQAqbZc9RTtZ7SKWPqb5oobD3e8dBPtm2NQnlRpOef+VyCv/+5xLKB8lpmf5T4oETuF/ctlfCVfQ1SzluGFbS4vTJwmQGJvDZEXAdY6l5yHFzuLgzP2xn/ZnsJilPNiorDBRliLr85quxMj9jIGkXmc4WrOpoo3+6wERCFDI1TTKeizAbKGFmcOyQSrCZwd4MQVNeMrlyzlJdt6xmFfiAVnjgrDnDixfyuiixmm+5cNdS9IYgfMwqgu5euoUj1UKc30Brv+LdKzwM3PkceGXs88E3bapvuqyfn6TwEUKzfruHF9Q3ItnDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4204.apcprd02.prod.outlook.com (2603:1096:4:99::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.21; Thu, 19 Aug 2021 02:06:04 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5%7]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 02:06:03 +0000
Subject: Re: [PATCH] erofs-utils: add mkfs.erofs and erofsfuse to .gitignore
To: Gao Xiang <xiang@kernel.org>
References: <20210818043539.25417-1-huangjianan@oppo.com>
 <20210818164855.GA4664@hsiangkao-HP-ZHAN-66-Pro-G1>
Message-ID: <7e71b92c-9abd-582d-e934-268e69c1801f@oppo.com>
Date: Thu, 19 Aug 2021 10:06:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210818164855.GA4664@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:203:c8::18) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.7.229] (58.252.5.73) by
 HKAPR03CA0013.apcprd03.prod.outlook.com (2603:1096:203:c8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.9 via Frontend Transport; Thu, 19 Aug 2021 02:06:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a62ce5f-d85d-47ad-a6e1-08d962b5e5bd
X-MS-TrafficTypeDiagnostic: SG2PR02MB4204:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB4204EB545B9D5746A4497564C3C09@SG2PR02MB4204.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEJb00cnkS3Rfl3uKgHgPjQ6YGTKPfcjf1POl296jwPT/iql+09DXWM+VvG5kq5BVtugzQrcmWfirsLMW+eKUrDd2/bz0Q7gSlvaZmDQG79uOw6wq9OPiJdPBl4ZSEyzl+GleEL4Qu48g0ClTIhnSVhkir+d16mYHWSv8wCMRyqaBQaiiA3EQNDic5MNuOBH0gyzQ8f64ShNRHpfhwNhmneaoO/dMD2QYcSICQyAGr/F1HaNjYBVKL6jxWGmyeDxwK9OFs1HTrQkHz5zTRv9Q8YMmAuv/MkzYy7mqdiZXsGQoJkd0lkpzs6JZDGs858u1aw9uNMayhD+Q3d74Zc/B7CM+HZZjnHxUu4ui8jKMiN6/pQwsfGL2WZPp1ZCl0iIayJgj6vf5C7BpQhuqSmYB2d26UzgMco4Ky+mLxmuAus2/eM5UO6BEsFOdSf4Wwme1dYrtp0eUfKH65aQiuhoadTyUIUJwBtHIHPci/AY9Mef0Im2xVVUO4mxh692Z29AHHikbbMK5Pys8L6XfVFKyovmo6AbzOVFlespeEZyMeoE+7cis+m0MahHpH6D6T0lI/NoWNRa379l3PICPuSVWmJlbhEVWTv1lfMbRCCrfgSywMJbV1TWkxc/tbXc21p+EiZvmvWmHs4HUJuWIyDrHVX4hldJg2JMqiznRXOBYaIWLf/trpUGVhc4o0sy2OTBJ3FhKNva28ONIBE1qC6Bs+CPStcOQ24Euo3kDMYD6wUCLhEJxPlehEeMfoOR5a4nTS690mbl+r7sYWbpBMGCbtla1kJEI6gbq74/8xTkHe4XiXz7bktTA14Wi0rR4qbV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(83380400001)(38100700002)(2906002)(5660300002)(38350700002)(4744005)(6916009)(107886003)(86362001)(16576012)(8936002)(186003)(956004)(2616005)(66946007)(53546011)(31696002)(6486002)(508600001)(4326008)(26005)(66556008)(31686004)(66476007)(316002)(36756003)(52116002)(11606007)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3BKWGk0aUdsQkQ4Y3JtVjdJbkNMSlhkRkJlN05YbDdoS1dGaE1ON2pzMUtS?=
 =?utf-8?B?Y0ptMGRGdE1QR0hsSzcyMkZBK0c4SWhnQ0ZueG1zMnViU1ZBTHRPV2daRFV1?=
 =?utf-8?B?T0xnRk5SSko4Y2I3NWk0QmpleWhnMklqbGhSNmtZbE8zTUIyS0duVUdsZzdo?=
 =?utf-8?B?OWFXTWh5cEJkZ0tjQ0FwcWxJUy9MRGpTUlU4R1gxRDVicFVKT3FLTGxqU0Fx?=
 =?utf-8?B?V0M2THhoMy9aZXVITFpJb3NQbzRPbTZaTFNrNFFadUhaNHhqMGt2VW5lNFV6?=
 =?utf-8?B?Yyt3a1pQVWkxZnZmY3EwYTY1VUUzWEM1bklORXpzcmluaUU0VmIrZ3psNE1T?=
 =?utf-8?B?dSt1dmpIaWxKd3NtZTNKYjdaQTdYNFJrQjJnTk4xcll6SlU2eTV5eFhKeHpL?=
 =?utf-8?B?SlM3anZvZWV3NlhuZnBDL1djbmJOdWxrbUh2eVJBOTdvNEZpTTdjMEZ6UVEw?=
 =?utf-8?B?M3dxRGtlcndjVEdJdjNCMjB1R21PcmQ3V1B6ZitqYlZFU1o4c0hLZGVzWUhw?=
 =?utf-8?B?U2Z6Y3JVc1BWMEVXTW9LUGJFVkptc0dzNUt0VTk2cVd2UktnSTVZTFRETG5v?=
 =?utf-8?B?alFEYnRkWWdveFNQRVJUUkVCWVNmaG12cHBBTmNxR2xUODNOdUpXeTh0NUZQ?=
 =?utf-8?B?K1pHdXlidlhScThldVRLY3VTbVoyZVZpTzR0a0dGLzZmZVlBdHV6cStuNGI0?=
 =?utf-8?B?NFBkMmlqc3luQ2Zxakpnc1VadHdQeDlUbGtmbGpFR1EyS3N2OVFhSGZSWjNy?=
 =?utf-8?B?dE01SVA1SVBkV2JJK213MzR2S2NGNGhBYTFuSlhNQ1gwanJYVGhwTXcwU1N4?=
 =?utf-8?B?WEU1TDRKWmRabFdjQWhOekhUbUJMajU3ZDIzMVJKL04ydjhhb0pySEU1TGk1?=
 =?utf-8?B?ZTZ1b1NKY2dxVDZKc2V1V0Ivbm16NVRTalY3UlgvR0pxWnE2azF1eVYvQVAz?=
 =?utf-8?B?ZjI1UGp1ZGR1NW9BamxOY1J0UW8yWW1taUV1MmNzYXhxV0k4U3pJTEZqWjJV?=
 =?utf-8?B?NlorSSs1aFNCWlk0RW9xNndTTlV5VytCRTFnMmlRNWtSckh1ZUNGekJqWDNq?=
 =?utf-8?B?UEZvZHMvc0Z3K2E2bkRLZG1EOXRLM2pMSGZFZlp3ZnVKVEREZ3M1K3pmZ2RK?=
 =?utf-8?B?NWFmdmg1UitFU1c0cTNFQ1YyYlArMzlFc2Y5V1BqMG50TDU4K1NwM2NDVDJp?=
 =?utf-8?B?ZEN0dCtOam12amVXUHExKzg0cmk4ZzB0WnorU1JDOTFGaXJDdUVkL1E1VDlo?=
 =?utf-8?B?UmFrOTJxa05ucXc3YzlQNjVEN2ZmeEE5RnNWcllzUFJJd0R3VkdSdFBidkxz?=
 =?utf-8?B?UDF5UzZGY0xkRDExQ2g0MVJ4Y2xDQVMyVGRFNjl4UnBmS0dEeGtnNHhVSFFB?=
 =?utf-8?B?dVhvQ25Cb0hnSlFtMTBtRVUrcUdLMmV4VG5wV21xU3lyZ0orYm5QanVFUWU0?=
 =?utf-8?B?SE83UzBrLzh0SlE1UjNaZzByTC9WTy9DZFNnK0ErWHd2aE4vYmlHeWpLYkdu?=
 =?utf-8?B?ejJRbGEyWFRpU05zS2xWTm1Gb0MwZ0RYUUUwRDhib042TEU3eGcxSkwvQzdo?=
 =?utf-8?B?SGw2bkZEWVVZY3lJbUZVNGJHYjdOOWkxdDNqd21UTWxwNkVZT20yUkl0YkUy?=
 =?utf-8?B?OWNuemU0cmZ3NmE0WThVMURVb21pbGtzanZ5TGdyWEhtRHpkV1hnOXBWZUxX?=
 =?utf-8?B?M1l0M0NuMXZ4RGI1RW9VQWg0Y2ZIYWpDOXlQcnJEayt4ank3cWo0OUUzVDRt?=
 =?utf-8?Q?FGqJJ+tOZDFVSDwx6e9ggYMjW2wTQJ1w6WC+PlU?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a62ce5f-d85d-47ad-a6e1-08d962b5e5bd
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 02:06:03.6537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMLHW6fRZrK6qoJdgzQbc+l3C23GrfdkXMSgghBvKsm2PY4MIKLYX1jgc0KtOkIpLcErtrrVd3P6nOBdJnsrew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4204
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


On 2021/8/19 0:49, Gao Xiang wrote:
> On Wed, Aug 18, 2021 at 12:35:39PM +0800, Huang Jianan via Linux-erofs wrote:
>> ---
>>   .gitignore | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 8bdd505..0e54836 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -27,4 +27,5 @@ configure.scan
>>   libtool
>>   stamp-h
>>   stamp-h1
>> -
>> +mkfs.erofs
>> +erofsfuse
> Should it be written as
> /mkfs/mkfs.erofs
> /fuse/erofsfuse
>
> ?
>
> Thanks,
> Gao Xiang

I thought these two files won't be repeated in other directories...

I will send a v2 to limit the path.


Thanks,

Jianan

>> -- 
>> 2.25.1
>>
