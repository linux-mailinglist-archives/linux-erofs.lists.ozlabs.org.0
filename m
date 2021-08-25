Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C342D3F7074
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 09:34:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gvd664fW9z2yKM
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 17:34:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1629876878;
	bh=3MpnPHEizi39OC2Pdxfg9s3x9kzmHr/UEQN10fwjKR4=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ghe0H+sRxTqDiEPHWNMiEsb7LD892uooCmTYMmSs0KBOWySVkUoajxIbuqeYOgmlb
	 /fu1bR7lAM6oZy72klkIPM08QKPox0aE++UE1fUD6hOJqqb/IhbYxsykPinAs5V16o
	 6Kn05sKJh3uLao56jmf+YxDDMtkXpRDJmQBeBGUdWk5R14kQhhslbgClqOO8oP+kuj
	 8kXaVdVImhC73QA5ivUwVzI7XziJK2sHl6X2US/J7ViYfs3DKbabH/jnzrYA4YHobA
	 D00EpIOMx1jJ6UYa8UMdwaoNJBvo9iOR3BirGi75C+k9XO5+PBsBo15A9TSyOq2sNs
	 q0ejIpHNZ974Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.78;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=mdWD84Rt; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300078.outbound.protection.outlook.com [40.107.130.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gvd5y1gv1z2yHq
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Aug 2021 17:34:28 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg3eVABWhI/CE4SrXlxhLmgSv/tigdkz7oS8u1n2Q2zk7YCeQ9JrUIg3fJXh/JJgd8vkU6U9AopnZ8tJZ2fq/A2vXWfaEUsyw4vq5I9/TW5r/0uxk9AVi44mEpPMdx5MIYifXBT39zrOOXvTOQ0uKtAReMIbMtEXOBSYCyr8wLtV2oMGhp3LMX4MmCIuZZq1qwujnUtVQwSaWh5IUsYYJqsVjRbCeD4FvKETpQteV0fYNHNLQN/bNsZ1qbMAdalyL7zgz0osz213vjpl9BsJ7zhvsbT/o0SPWTZS+Aiht2kV08b88iFQxP0ERPyPjWXExJZCdGn2mI7yTygBFEb3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MpnPHEizi39OC2Pdxfg9s3x9kzmHr/UEQN10fwjKR4=;
 b=kbGPcNg3EJiYcv75rMxUuUvz4kUn23W/Xf//XZTx4mFHyUHsHOGX+b4TFJSgmrGuxCCawV0kJd9K4uE8TC5KSVU6VYobW+OkEtIEhti/v/04WqXv6fAoXnUB+Pc/neyXjMQD1s6s0+CPjoNtt87zaICJHQp5EM6SlF2uKO9xFaHCKlL9lX9OST87/MSMyC8wKYCOSZQ7ZWhqVLag8xbaXnW0nveeXI7EqdpRjJ+Je+8Orzw93WY1jWcPW000v5pR86uVNk/sDJIqAIJg3Mi4a4AUS1RMuBiiCjimBzUqL1TEmpE32moHrATGW0sCeQlMffZ2WXWCPhFOVtL9YCMp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR0201MB2095.apcprd02.prod.outlook.com (2603:1096:3:4::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Wed, 25 Aug 2021 07:34:07 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5%7]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 07:34:07 +0000
Subject: Re: [PATCH] AOSP: erofs-utils: increase val for WITH_ANDROID option
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20210825033416.19868-1-huangjianan@oppo.com>
 <YSXwgCND2Zf0sfl2@B-P7TQMD6M-0146.local>
Message-ID: <9e384527-b9b2-ea65-6c24-01ca6bf6ae72@oppo.com>
Date: Wed, 25 Aug 2021 15:34:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YSXwgCND2Zf0sfl2@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.7.229] (58.252.5.73) by
 SG2PR01CA0165.apcprd01.prod.exchangelabs.com (2603:1096:4:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Wed, 25 Aug 2021 07:34:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bd399bd-222f-4752-ab51-08d9679ab8c6
X-MS-TrafficTypeDiagnostic: SG2PR0201MB2095:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR0201MB2095967C412435E8C43B39F6C3C69@SG2PR0201MB2095.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAFD0a3l6XZB8LVtr3fuUfu148uGdsQWCCfWVMsbbE0y/MXRGuc7PDqYIhZfLhRwp0ViDJ4s8PWR7syY6COIhX7gnD1O+d5CCtndGjDPj4S7g4K/WxkZ4cDicRPk1bjqz4GSr8IgvW8/d0XX65uw5LwV221P2211URmdnf5FpYZLnDahFYVNYccQboiTYhRniqPS9NtQcZsGXndIWzbi/zZWDsY3jgcqPc+mH2u1Q5QvH7LAhKSr+MAIFHe5PGyN6ksXh/SzlAMkOLGWgxlNPLIrTI+9XWDCruuH/IFroIWu9d+0pxm4b+fbQzT2yB51qwZU5w25g310PwNrJxd0Kb4//y6zgm2sd0pRF1eLZ+UT6t0A/lLyRCquMvdi+ui1TcIYvWnILAVQ6j1O/yVkWC4Ku9hnBdzzBOhJ/fDIsElPoPP/bk60ZUQsE0Ndl98P8z5Gt4NpB9KsdALrp3aviMkhJruttCLtfBFu039uXCjD8KOVAgOtFLELBRVHTlxKqho/4YCaC0KuyU1NV/9G62quWGqVvb+nphwyjLyMZFqEMGZYAYlqH1Y6Rvybf1wgGiSOptLHG+L81kpi1gVKgMzGwcE70qrd1/mNtLMWPiodZjsVK3CBAHZdF+BxYRvLhhJ4pqfl7XNeo0uKTwd8dt+UrD9s8VHea4oEehb7RAH3Cm01X0d7AgwEtfzp/sfIhpF6qclRCAo4c5pUknTyMt96saeeqr6wTyfloAlY5w0m3sfzfJTIZGx+c3ouX5YC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(478600001)(66946007)(66476007)(66556008)(6486002)(83380400001)(86362001)(186003)(31696002)(52116002)(26005)(6916009)(16576012)(5660300002)(36756003)(316002)(956004)(38350700002)(38100700002)(2906002)(4326008)(8936002)(8676002)(107886003)(31686004)(2616005)(11606007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjlZRnFrRmRHVzFGaXZoT2k1WXcxWCtGYTdYeU1scGZ2RHErdXF4K1ZSVDUz?=
 =?utf-8?B?aXhjV1RzZVIxV1JON2hOTVZBWGRtQzc3YW96Ymk5UXFFVkgrLzRqNGZPMnAx?=
 =?utf-8?B?eFl0VzlhZDdpaDRocS93bVJRYmordnVsQzR6Qi9YOHJ0Q1ArcE1DWEtBRVFT?=
 =?utf-8?B?N2syMnZUNHNtckhoWDNmZTVzY29MZkhsazk1WUZORCtjNUhVOXlOUlhuN0Vp?=
 =?utf-8?B?MjVDaUNxQnFZSlE3UHl3VFpla3ZqYVJoYnN5cHVKU1U1YzdVZjRwc0RxNTJW?=
 =?utf-8?B?WjBJckNQazFXN3ZETGdWdy9CQTd3N0h0YlI1eFhtZDhyWWZwMThCOWdWMm1Y?=
 =?utf-8?B?RmR2dzh5R0d4YnVoKzlBQlZ4dGdFWmxvSnU2VDc3ZDh2VXFNcXZXQ3YyZHk4?=
 =?utf-8?B?TzBxcmJDalROOVcyWFRVNWF2Y3IrYmQ2cm1uODh4Y0JNUncxNFd2dEhxRVdj?=
 =?utf-8?B?QitpZUovTW5kdFEzbFQxc3pjUlRtUXgvUGpoQkJQRm54WXhwZ28yMVNhMlha?=
 =?utf-8?B?YVI0Q0Y4SW9IeXFhc3NGN0U3R0ZNd1N3Y3dTc1pVRDg2WHZRdjNjalJ6OW1r?=
 =?utf-8?B?azI2OEZVNFNWVG5JdkwwUGNmdFRmamRBNEJzOFRPRnMzdlJBanFqTG5Jb3Y3?=
 =?utf-8?B?cmhmU0t0dEhZaXU4R2tWc1ljb0JKcEhNYjhCc3VQY01RZW1VUDFRbjZLc094?=
 =?utf-8?B?WjZiVjZIZElwbk43SW1hQkxUQ2FOR1FwdlpCZVFWbHhoNlcyOUZhb1BkZXRU?=
 =?utf-8?B?clptVlEyRDRwL0pwTWF6Ym5maGZnb3lvQzUrTEduZ1kxUUREcUxiamVhaEZm?=
 =?utf-8?B?a3lzc1VibTdzZ3ZXck9QTXlEU0g2bncwY3BWY2ZFT2xIdWVqTVBpODUySm5o?=
 =?utf-8?B?aWpTYWtDRjRITEdaT2VQMGcwblNuaXV4QlFPeG1tV0tBSmhMTVNWaXdqSURS?=
 =?utf-8?B?eFdJNWh2OFREMTZWRENucDZ1dE1NSG5rd0lDY3BtOVJ4WC9zQzkvVC9JMG9w?=
 =?utf-8?B?bm1ablhoR3NLcTR5YUNtd0FxYzZZUzBWOXk3ZWx2VlJ6UWtFb2tleGJuY1B4?=
 =?utf-8?B?bDNob3R6WFM5Nkc0T3A2OGJOS3lRaFNXeGN1SDBFaEhKRXEyUW5uRWhhMTA1?=
 =?utf-8?B?aUxPR2ZIS0Nld2gwd09XUUN0RGQ3cGhUTjVjNk44QWxrR1RkcFcyK2NaYm9y?=
 =?utf-8?B?RVN2aGh6Tm53SGIzcHZ6TUNtbURqYkd0UE1IdVVRZmN2ZzlHMnRuNmlmMUdB?=
 =?utf-8?B?WDQ0dUR6U0Q4aERNUnVVdWMvYUtSQThCdGJYak1NNE5JbTNubGtFbUUzdGdC?=
 =?utf-8?B?Sm80dGR2V2lHMUNGSTRVM1E2c09YMTJ5WkNLL3pCT1FLdnQ1UnZ0L1VrQ0c5?=
 =?utf-8?B?U1l1YUEvQyt2RzlCa2lJYS9CdGJHSzNLaUlXWkpEcDd3eWdvMXR4dklzclFq?=
 =?utf-8?B?ZXgxVnkyRGFtWk05NzA0dGVoK1hHV3l6NG9vdnhyRVdVSzI0Zitic0krVlhu?=
 =?utf-8?B?NXo2akQ1Q0RvTXRlbmFRRmp1WlNSQzlMZExwMysvOG9odmFSMllzVnRybzZX?=
 =?utf-8?B?Zk95VGNkdzlqdVVCZy92dzdQZytOVStZU2Z4eThyVzJwYU9ZUElydmRNOEZq?=
 =?utf-8?B?cytWL2haWkExSVFzcFd0OWxjcTNxaU5CT2g1TXNNenZZU3ozTytjWkJEanlS?=
 =?utf-8?B?Szh2Z2dWTDF5b29YSGVtQUt4N04zZlVBR3JjSGF3djRyTENXOFo2ajNjTTJ4?=
 =?utf-8?Q?/FjpEMMWWW4NNjOvPWdJ6kJKMOu6XND+EZ8SfX0?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd399bd-222f-4752-ab51-08d9679ab8c6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 07:34:07.3727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbfg/Jo7/gTzFgGt5+4EXJtR6Q1f+C2nDMSSNCMNlHAqEPGkHenr2ZYtK/5hQG6efAZUMdyKhR2zwZycAV40Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR0201MB2095
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

在 2021/8/25 15:25, Gao Xiang 写道:
> Hi Jianan,
>
> On Wed, Aug 25, 2021 at 11:34:16AM +0800, Huang Jianan via Linux-erofs wrote:
>
> Subject: AOSP: erofs-utils: increase val for AOSP-specific long options
>
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> ---
>>   mkfs/main.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index 10fe14d..9369b72 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -45,10 +45,10 @@ static struct option long_options[] = {
>>   #endif
>>   	{"max-extent-bytes", required_argument, NULL, 9},
>>   #ifdef WITH_ANDROID
>> -	{"mount-point", required_argument, NULL, 10},
>> -	{"product-out", required_argument, NULL, 11},
>> -	{"fs-config-file", required_argument, NULL, 12},
>> -	{"block-list-file", required_argument, NULL, 13},
>> +	{"mount-point", required_argument, NULL, 256},
>> +	{"product-out", required_argument, NULL, 257},
>> +	{"fs-config-file", required_argument, NULL, 258},
>> +	{"block-list-file", required_argument, NULL, 259},
>>   #endif
>>   	{0, 0, 0, 0},
>>   };
>> @@ -289,20 +289,20 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>>   			}
>>   			break;
>>   #ifdef WITH_ANDROID
>> -		case 10:
>> +		case 256:
> How about using larger numbers such as 512 for AOSP-specific options?
> I'm afraid in the future we might bump up generic options to >= 256
> like this as well.

Sounds good, I wiil update soon.

Thanks,
Jianan

> Otherwise looks good to me.
>
> Thanks,
> Gao Xiang

