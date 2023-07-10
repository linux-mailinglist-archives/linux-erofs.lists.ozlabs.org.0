Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CECE374D1C2
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 11:37:56 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=AtDkIdXB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QzzSf5DTHz3c3C
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 19:37:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=AtDkIdXB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::721; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20721.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::721])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QzzSb529Bz2yV5
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 19:37:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHSGHvBk1ZSesdTEy4idLSv8Oz2VJtfLAswLlRsi0SCX35gz8/IQRi/Xpq3dxfB8IzLHzIjh6Bq2xlTT21EI/hoZajgXFgIpGKT56C58sxHmhrzovY59RGWdDpnlL1uePD9qBYXuiRDmpM+Z9AgIOiWBDM3pMpLwb1xpdOFKs/Rhv3G9OQnx1ULw6CFxGwYNBc20btM1SfP/IBAI9GT0IdNXuUnGd5rnJ7KD8h6xDFTjLuZDobn3luyUh0DDrDU7YEeMSLf6Hj92ImvlDQRWITTfuR6kDRtWbw6wr7ot2xQy+b1Yzmn2K0jm30xnnY8U5D3Tqr5jV3wMaxj5aq61qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc5VbaQwUAskmlbLCG9X0yrIpMat+oHNiyMTIckJ+Oo=;
 b=NECZ9ezjR8kx1D00K8yoOCZbjkg1xS7FigWGThoP/Akl9OmDzj/ggEWapwte075mqPG2+BkidNWRRlvPqt/8gxp8uQ+tbHGHy0PtsbofGhAKc9EmGXLulXAzEy8O4hD5ffqyGNwcnqC7HRoBIGdX62iM5WXhNAue1pu0GTuKCwaD8hk8CXBJRrW6Uiftv/x+1tLBc6Jui3rO8i6RMV/OQkWwjyry877mDLrVqP/zDF7AWafFl/xVjs5jwMpGt41t/DKtQ9MkIG9nlQ9tW8tbIwkwhGYAtJHHER8hicXWJrZ38YsLx0TorfvF03wJHDtGT5VQpno3bFtfX2QV0nTIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc5VbaQwUAskmlbLCG9X0yrIpMat+oHNiyMTIckJ+Oo=;
 b=AtDkIdXBPRaNoLgR79llbvH6jHRX5uOtPYm63j1jc0zZYml6Rqozys9uAtRI76S4j1pbL6NI5tM9PEE5TgI8ho02XwImgi+UmFtUdMm5XfXwR576KdBOSE/FfUnnkTOu2+wdg3vNXZ1gh6YpiJPLLiwf2iMwW2fVV4BwC8u+/H29wywaEoYO0m/friEVe1Gs88Xuo8Rb/ygsZW9TpRQ9jJ2rhRNVsWgHavkMcIPJyRZfLlEJFQnXdmhqZdaFVR93cjwGgHjoCPgiFwt+6lD59e/B7Iu785pf7hsa6hvcd/mcP4p1jzO4PWIIU6QoclzwQlrToNy2tYGTySlbqROZRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com (2603:1096:4:97::23) by
 PUZPR06MB5555.apcprd06.prod.outlook.com (2603:1096:301:eb::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 09:37:32 +0000
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::a05b:2f8b:fba5:50fb]) by SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::a05b:2f8b:fba5:50fb%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:37:32 +0000
Message-ID: <a55d468a-7358-5079-a903-e2240a6e30ee@vivo.com>
Date: Mon, 10 Jul 2023 17:37:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH] erofs: fix two loop issues when read page beyond EOF
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 "xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org" <chao@kernel.org>
References: <20230708062432.67344-1-guochunhai@vivo.com>
 <97875049-8df9-e041-61ca-d90723ba6e82@linux.alibaba.com>
 <d6ee4571-64d6-ebd2-4adb-83f33e5e608d@vivo.com>
 <fd738d38-17de-4b61-e4e8-d4f98ef8d1db@linux.alibaba.com>
 <ac05d6e3-79b4-a470-2a30-8c809c277209@vivo.com>
 <1a107593-e411-70a0-b6b8-3c34a9036ff3@linux.alibaba.com>
From: Chunhai Guo <guochunhai@vivo.com>
In-Reply-To: <1a107593-e411-70a0-b6b8-3c34a9036ff3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To SG2PR06MB3338.apcprd06.prod.outlook.com
 (2603:1096:4:97::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3338:EE_|PUZPR06MB5555:EE_
X-MS-Office365-Filtering-Correlation-Id: 0204bb1b-1d97-4b6a-ab3f-08db8129491d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	NF8fjbBGpGe/1r7N37smSa3VgG79q1K/U24ZPSTQyD1nHawFPVkHvw0BOf+zygX7lhBbd8BqAWafwCYllILozKsTt4DL9XMa2/8ORV5beGeyJnl+IAl04SgC3H20DaQ8q5Pm0WSqepu9CcyMNDZDecvRu1zAsG09muMdnyc2Vz9iH+JO5/ssRq0s83LJNRbeBozAPiBuA+cSmsrhVv+qnhfQ2DVYvvQfvyT0MU1+riwmdmZHnKkBevH7fyhKNRZ4mBGyoVbuRYS4H5K2YmDv0gDV2l9Iy3bmIAwhsHnQEDmttJpdy0WcySA0lE4e1cyKExkEJcq07s5PxjAS5wJqdZI3RAkxpBsRfj5XUM0ZbosnXESgX7dZd+zOwhGF4DZaSEYp9d52LB4B0sMP1luA9J377ldwTV68N0gPACjVnrqToUDSGt8vzZBteUftB+ZK1E/bh9eRiXrqivJI2PfKazdexV8wJl7ztjEVjmPrv/MYo22nBZqnN8J0Rzgp5pNkzL5lxH7lx76GX+8Jn2PKpUKOWE960ZI4D4DwtufVtzwSKT1VT79wGpkWpkedufrFSCmjvz2KmuxIeA+tuVmLrlnohcZbcXYa7UCzbrBFu5PTvFRkUd17kAbvCFoObWQxH3QUGx/xuXgH/sSVu+ckFQ==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3338.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(36756003)(86362001)(31696002)(38100700002)(478600001)(110136005)(6666004)(54906003)(6486002)(6512007)(8676002)(8936002)(5660300002)(2906002)(316002)(4326008)(66946007)(66556008)(66476007)(31686004)(41300700001)(2616005)(26005)(53546011)(6506007)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?cGhNNTBOd0liMUtFTWF1L3FZdkFSQ0phUVNlWVZyVS9Ea2c1b2xlVUpQdVZZ?=
 =?utf-8?B?WGhZSCtQeVFPZGxrMTZlclR3akdWZXRPWFZ1bERWb0pIdVpManNZMnZRRzJC?=
 =?utf-8?B?T3NqQXN0b3B3VGh0QldLMzl0eHBCNlFRcHJyMVBFR0hiRUI2aXl1bCtqbmlB?=
 =?utf-8?B?VHR0em1xeWF6UVFQSWRqNDZadUpPOU1jdWVLWmluaXBBTHBvRVNiV2JWaVcr?=
 =?utf-8?B?M0RtN3o2bzgvYmFYTCt0NnR0WENJdkxyV1k1YTNveTFWTUtJdDRLd0IzeTBm?=
 =?utf-8?B?R0ZON2xtMkFOM2o3MGdCaTFCQ1ZOSVpOR1Q0SFVaNXNVOEhjRzhLUWtzRFgv?=
 =?utf-8?B?QVFkU25EaW12WGJHYjNJYXdwN1RKWUdESkJHVHk0YlJyYU50cXpHM0RHbEZH?=
 =?utf-8?B?cUpSYWJRUVNVOFRpaWxIcnk0dnB3NGNBd3NzbWRoRVl4K0doRGtFVXh3d3d1?=
 =?utf-8?B?d0pvUmZ3RlhOSlAxd0djS2N5aHNvMkN0L3F6b0tvL3EyVHJMRDVUdFB6b2Vo?=
 =?utf-8?B?ZituNmVJRlF6ODVSSHdCeEdlcUlwQ3REYkF1Q1BiMEtkNkpjaXFzdHhyWWFS?=
 =?utf-8?B?cnRUSFQrVHlHSE9sZVFRRHc0ZXVJTWI4MGZOSGtrd1FFWVNqRjRhajZqazdS?=
 =?utf-8?B?VHdueFJOQjNRTm5GNSt2SHlQQVJVVHFpclljaktHNlQwOUNqVUlQR2lTVUFE?=
 =?utf-8?B?d2dLcG9UeEltdWFUbUZQelpBVmNvNVc2d2k2R3RMUG9LZHByMHB2V0hEYnJU?=
 =?utf-8?B?SXRIc01qVFp2Q2dVT2RqREZJbzZwMThSOXorbjZUQ0JpeHhmS2Y4cWRHYmxk?=
 =?utf-8?B?VUZVdHN2NG1OZ2gxR3ZGbkVOSFpFU25ybEdCeGJNUG9UMTkrMDZUQ0liK21F?=
 =?utf-8?B?V1YxQjZtbTlvOFRtTFJoQlFIS2R6NXhEakVacE50ZTJDT05SUXhtdU1PWlVl?=
 =?utf-8?B?N2cxaTJUNThpMXBDRjcwQng0cGtwWVpKMWJvQms1NDNCR0hNUENSc25mbU5m?=
 =?utf-8?B?UHhQc2pEQlBVSTFBaVkxYnBWTFBTajRXYlo0ZWVIcmlKeGw1QVZKNFN4bzA4?=
 =?utf-8?B?bFRmamxjUGErK25ZL1NBd3NvUWtLQ1M3ZENyUlZjNUplQW5veWVsaUlWM2s2?=
 =?utf-8?B?SEZWTkNWUnozaWtaV0ZsODVrZjExVVZxZzBMYmtzeGt4YmU4S1RVVUM5UE9u?=
 =?utf-8?B?WkxHeGlYWFpaMFFadk9LS00rQkNQdVc4dHRKZ0NsLytIZWRBTjhJNXU4MnE5?=
 =?utf-8?B?UTlqK0M1ZHJYYTR2RHM2WVlnOGs5M3NIYUZCQzU2Q0hyRkEvcGZsL0I0VGJC?=
 =?utf-8?B?R0hVTFlBT05jVzNydm5taXB6UFR6SU1XK1ZoNWVQQ1pCK2E0dzNEYWtaQ1R1?=
 =?utf-8?B?KzBrRUFPM1h1QkcwZmozdzgwM2tIYWN0ZEt6THhRb1VsaFkyRG9SWitWejYx?=
 =?utf-8?B?ZVZkZXErNFNuam9MbGZ5U0k2MEh5RXQ2YUJXQVZ4eHRoSEFsMWpYSWJEU3Fy?=
 =?utf-8?B?d2ZTbUJPTTE5MzVxVlVwUVkxdnpJdUlMd21lUzE1VjFBK1dvY2RMMXNUUnc1?=
 =?utf-8?B?RFJTZVIvUXRDK2NucmlzOWFCbmN6Rkhuay9RVEFxVHJRaHlkZDFYbjhHaC9U?=
 =?utf-8?B?alk1azIrV2o5NUNTYk9rUENuWEt4RzR1b0F4aVd0Q1pia050UHNSVTg1YnRx?=
 =?utf-8?B?Rk9uaExXNDRudWdlMFcrRERvMGFmbVpkaExnQlFlWHk4L2NFL2xUOHZCV1Qw?=
 =?utf-8?B?YVR3aVcwVHY1YlRjdE5OUmpVd3NIQmplZTdFdE93YkFLbXNWbWQzTW9TT3NG?=
 =?utf-8?B?WnB1WW9pNFhMdlJLaTd5WEx3M3oxMGF2L3Y0b2h1ankxanJ1OFJUanF4WjFs?=
 =?utf-8?B?VDJJT2RmNnhITkVNT3ZoZmNWcHdjcXk0VCs4Y3dUSng3eWRpQUpnZEJtdERG?=
 =?utf-8?B?Tk5tUFdHN0dlRjZVZmhBa0lhNjEvNzRBSS95N0I4MnJ6Vy83VmFCbndEUWly?=
 =?utf-8?B?b0IxaCtQcW1lTVU0M3krSDVSOEp6azAxUkJsTnlwS2RBSENUYzZsY0VHM3pz?=
 =?utf-8?B?aVR0dHZsWnIwZGQyNnVQY1pITmJ6c1N5QzRzOEVzMElTdVl4UG1NZnd4c3U0?=
 =?utf-8?Q?nICPdtaT5iRFqqkfOew+0E6uX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0204bb1b-1d97-4b6a-ab3f-08db8129491d
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3338.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:37:32.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gn+bCT4hyz2+ixwAn5DrgD+M3EoX4jUnKA8E8WJN+G8CuyrMSvvJHjr0OBt5ouoINVKWlhsC4cfwgAAsttuzbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5555
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



On 2023/7/10 13:02, Gao Xiang wrote:
> 
> 
> On 2023/7/10 12:35, Chunhai Guo wrote:
>>
>>
>> On 2023/7/10 11:37, Gao Xiang wrote:
>>>
>>>
>>> On 2023/7/10 11:32, Chunhai Guo wrote:
>>>> Hi Xiang,
>>>>
>>>> On 2023/7/8 17:00, Gao Xiang wrote:
>>>>> Hi Chunhai,
>>>>>
>>>>> On 2023/7/8 14:24, Chunhai Guo wrote:
>>>>>> When z_erofs_read_folio() reads a page with an offset far beyond EOF, two
>>>>>> issues may occur:
>>>>>> - z_erofs_pcluster_readmore() may take a long time to loop when the offset
>>>>>>       is big enough, which is unnecessary.
>>>>>>         - For example, it will loop 4691368 times and take about 27 seconds
>>>>>>           with following case.
>>>>>>             - offset = 19217289215
>>>>>>             - inode_size = 1442672
>>>>>> - z_erofs_do_read_page() may loop infinitely due to the inappropriate
>>>>>>       truncation in the below statement. Since the offset is 64 bits and
>>>>>> min_t() truncates the result to 32 bits. The solution is to replace
>>>>>> unsigned int with another 64-bit type, such as erofs_off_t.
>>>>>>         cur = end - min_t(unsigned int, offset + end - map->m_la, end);
>>>>>>         - For example:
>>>>>>             - offset = 0x400160000
>>>>>>             - end = 0x370
>>>>>>             - map->m_la = 0x160370
>>>>>>             - offset + end - map->m_la = 0x400000000
>>>>>>             - offset + end - map->m_la = 0x00000000 (truncated as unsigned int)
>>>>>
>>>>> Thanks for the catch!
>>>>>
>>>>> Could you split these two into two patches?
>>>>>
>>>>> how about using:
>>>>> cur = end - min_t(erofs_off_t, offend + end - map->m_la, end)
>>>>> for this?
>>>>>
>>>>> since cur and end are all [0, PAGE_SIZE - 1] for now, and
>>>>> folio_size() later.
>>>>
>>>> OK. I will split the patch.
>>>>
>>>> Sorry that I can not understand what is 'offend' refer to and what do you mean. Could you please describe it more clearly?
>>>
>>> Sorry, there is a typo here, I meant 'offset'.
>>>
>>> `cur` and `end` both are not exceed 4096 if your page_size
>>> is 4096.
>>>
>>> Does
>>> cur = end - min_t(erofs_off_t, offset + end - map->m_la, end)
>>>
>>> fix your issue?
>>
>> Yes. I think this will fix this issue. Do you mean the below change is unncessary?
>>   >>>> -    unsigned int cur, end, spiltted;
>>   >>>> +    erofs_off_t cur, end;
>>   >>>> +    unsigned int spiltted;
> 
> Yes, please help send a fix for this!
> 
> Thanks,
> Gao Xiang
> 

Got it. I have sent the patch. Please have a check.

Thanks,
Guo Chunhai
