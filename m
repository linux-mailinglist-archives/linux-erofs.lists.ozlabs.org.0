Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0D3607348
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 11:08:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtzD314Y0z3cdy
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 20:08:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666343331;
	bh=3k4FC4tJYJ7Lzft75iYSUZSubYwrp9SzcCTYm8uutv8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=i95PfvSsP+jn85KImxMdtFSq4seUEHYmGRaBeQA50UaAQJ5asf8ykULCmhiLDhyzQ
	 7YJhXb2d4nga2aOBbvdlpNiFS5g8Q51AHBmWa/v6dC83Xd8d2vZX9oZHn4+xgLKOJX
	 GXj7W7/cOAbwltuvF4lJ4WCSYn6Eae1+N2kZbLd28bHH6Ol8NvCtjwpCqgF3jQ8P2R
	 wrnRzZJ1t7w3taidS+/bDnTtXelHb9IdGn5ALVqoI4M51nEb1RPYkoOgGgs69IwwRf
	 J4caer4XLNC/vez5lm/HP0Xmj4Jhb3U5FmJ3cd6TCIqPU3c0mBmB/CWR4QA7TCMgfE
	 dZUzMgy2LqI2Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=40.107.220.72; helo=nam11-co1-obe.outbound.protection.outlook.com; envelope-from=luben.tuikov@amd.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T0iSEHJe;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtzCx66MXz3c7L
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 20:08:42 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OW0DPQxIQU8IP8X1mGjx3ZsJkRrxzHcalxezkkFt3H3Zvo+6NoVOOYIs/b10F7rD4JrBBrq+XGqYQXctwjQJcTd6cSghbWLielSFV0edR/1V/xXavemaUvvj7grnFTq9Go3FHaT3XQcgHbfHE8TYkTqRP4PFQRWlWFc2o0aOu98PoL4K0uiwVCLOyulDVP0LEWSvxoa4t1ASl+RtEm0w7VRDyKWH7cm61sEOXZY0sDygXXdpuIw2612VuN1JGlWAUxKLN9I76HBjZE4YL789jFpgRzpNE5SXXOu/Nxz9yIR15EjdQy3fbYlHw51NSYvmvNRGPOwRFkKFGuxTii+Q0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3k4FC4tJYJ7Lzft75iYSUZSubYwrp9SzcCTYm8uutv8=;
 b=DQAC94U1nbtpTGobvOyRKD4vHM7qZo0InXbWB9Eym8mcGfq9Epz7ag2VPohE7z6dJEOHGqnIVkyGbCbv/lFTjayMw40gybpxvRx5VP2GfJQdTTtU03Q1GVujQ+9+0UHpmTgG7Pd/Xc3+JKJwiPitFPpZS8VHOJ2ysiM270930sfagRuQm/K6s55wkVrA6lRzszU7/AH7jtw+nJJ7z8S/tvI1GWF+7ClVe2ARDeO1BbLKSGE+Mbevf0hSj9qAvk0kfDAh8CigYL7djiCd/bVR2w1tREHm4HaJK2QgLZRaW1l1hCzTs/VQiXKTXTyGra5cv+JWjJXsJKAiVs9w7Hg82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Fri, 21 Oct
 2022 09:08:20 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 09:08:20 +0000
Message-ID: <78f84006-955f-6209-1cae-024e4f199b97@amd.com>
Date: Fri, 21 Oct 2022 05:08:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
Content-Language: en-CA
To: Yang Yingliang <yangyingliang@huawei.com>,
 Greg KH <gregkh@linuxfoundation.org>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com> <Y1IwLOUGayjT9p6d@kroah.com>
 <0591e66f-731a-5f81-fc9d-3a6d80516c65@huawei.com>
 <Y1JZ9IUPL6jZIQ8E@kroah.com>
 <f1210e20-d167-26c4-7aba-490d8fb7241e@huawei.com>
In-Reply-To: <f1210e20-d167-26c4-7aba-490d8fb7241e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::7) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d61743-7a6a-40cc-4d66-08dab343cc51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	OWZfTnU9vpHZPckWRCiSry5n8OZPWtn1I/if5irOf7KjcbUxxoQcBU3mZYdWCmi2XlikT17oHZWq/IXoY+VEjfkqupSFvHTYa8Ui2wKiI1yBGeVpSxtznlG+rOq9UCdb7JHeMSSgfkOWhT1q0MKKddAmKagpcg6bqLQd4+BkA2tLjxrP65zNhWPFdgMLI4Z7GZ8zdGR1yArccvCLeOrE4ifF4f7kb3pEAdAGH3XZ+1eQ1w1My8E4B+m9GYH5SbCjSxwbwfoWxtOafnw62SQu5C0Z/LXPeuR+qDvoIu57bVprmb09NwdlxLUX5pE2h+KTyJjAbWgP+OF9gT1ZtoR8xdUW3xx013mQ58QtfVf+YRsM69sCZn9NUZ2bag1PN731JpPXUwSOZ9sh9aPgFchFkKWWoBj4PmIzT3jBJZAOKBsvjOmSMUXO0inr8LPAF2iBJJ2jumqRUqfDjSKITmyDCWNcZGcm6jKTGN6fAQho3JlxmZ7p/i+NQ/YNrlBWnLAk8vNPK40Z5tTo5WzdCYGsS/ECmFHyBjrEHTuH2wRKOneTQsx5W+I/szunq56iq/7xVf4BjvXaapdiuGPaZ2s8NxiJov0hgyXnYpujK5a5UKhaFlhGzvzsxy+feSDwG1PzWj6gBvtjhD+5dSOvfLCtgllsTxHQGeArjop36sLgNwV93P5NJ8CNeVePjoidHzNQWo022GpXbpZ5qdpW1k/KjYrIjSCErgIQ/JNCxJxvQI8NZaNqJxF/Lv2dIdVJsBeS6ZtIknYfYpEFQj7neXQrUGSG1Qj/Pa/MK7/ibOZfCfi6+titumFB6CUinl1m2PH4c38YqeGutZie0a/D+xnOxKOZLZYHY69ya5I7nLm87C5psgVRuKPJdySLWLGdNyDQ
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(186003)(38100700002)(2906002)(31686004)(4001150100001)(2616005)(478600001)(966005)(44832011)(45080400002)(6486002)(26005)(66476007)(66946007)(53546011)(31696002)(110136005)(36756003)(41300700001)(6512007)(7416002)(4326008)(66899015)(6666004)(8676002)(86362001)(8936002)(5660300002)(6506007)(66556008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?aDlOdFhXcGY3MzN3OFQ4d3hqandIWVZXcGl6Q0xjeGlyUWhPV2U3SU1CTTY0?=
 =?utf-8?B?OS8veWFJaFZkRnZ2eVdNTDVlMzBJZWNVT2l6WWxDZ2tkd3ZTdkJodW16ZTRl?=
 =?utf-8?B?SGpMMGdCcmxnY3ZPakJxWkhjY1JhZUV6aU15SHRPMFZTbkxDZS8wWm9zM2lE?=
 =?utf-8?B?Wlh4ZmlXTDFqazZDTVRLTmJ3eWM2eUF5amE2amdJelY1QUg0R21JSFpUZ2Nr?=
 =?utf-8?B?SUh3WXNxUVYvanV6RFVxc29NL3BaRjI3b0Mxalp3K3loYVo4WVdYVzlra1Zw?=
 =?utf-8?B?U0VJUFl4NlZrUGlsT2tsZVZTUXEya0M5K0MxVTlqeDVXODMzdTlZZnpIcW11?=
 =?utf-8?B?Ukx5dHJzVGpJOVRDYzlMWlNVZUs0QkF5eksxT29ncWk3WnY1enpOVFQySldm?=
 =?utf-8?B?cFJESVVEZFF2aEtLTlZaVFQvRnNrWStMREx1Q2ZjSUk3Q2svTXdwVDR2Szlw?=
 =?utf-8?B?RFJWSjFvZUxRdFVabm54K0N6UVNCUEJURDJhY1pmUFRicmducnFyN3JLcGlN?=
 =?utf-8?B?QUZqL0JmT0toN2lSUXRCMzN4RklVWHEwQjYwY2pTQmkvWldMaFdKT1RhNktq?=
 =?utf-8?B?SElmQXBoSS9wNHpDRXJRVkNmMXlyVTJQUEh1S2QrdjlFeDR4MVMvbjhwcEZJ?=
 =?utf-8?B?OUlLa3JwenRib3c4d2JTSTBkTjRtTXp6TDNQajVOOWdWRlpXc0VjcktzUnhM?=
 =?utf-8?B?ZVpjU0RLUFdPSWpLb0RlS2drVGdNYzZKNGF3d0ZOeGFGeEhobHdXUXNiRC9V?=
 =?utf-8?B?MndjUWFXR2hEL2szVW5zMmxXcDBOb0puV3pDT1c4MTBZZFEwMmNHc2RjVlpo?=
 =?utf-8?B?QStIM21HcGVFVHpJK3pQeTFjS2NuMnN0SVFWeklXY1pWR1lmVUM4K3ZsaUFu?=
 =?utf-8?B?dm1OcVlTNDVqZm94NUxNSm9CdUlsQ2pWamNLcVZwWXdmSXd2YVllUlBiRjgx?=
 =?utf-8?B?MlQ2TjZNME51b0V5ZVMvdjFLcXF4RlNYRHpUaEdjQ0k5RUU3UjVFQU1sekFl?=
 =?utf-8?B?dnllVFIxYUd6Q21rdUhaL2QyNU5qelZrWmdKamdiZlhFbG50WGtSOE1qWGx5?=
 =?utf-8?B?WXRZVnR2bFkzd0t5R0NVejIyZXZUN0NHS1dWaDczWTVKb3ROb1lCb0tWSnFB?=
 =?utf-8?B?SCtwdytycFNlUFlMYTJQc2lNTGx0RnI3Y2d4dENpNnJFY01zMkY5K0pmdnM1?=
 =?utf-8?B?cXN0cWp2NG1JVER3ZXFjQ215cW9DTlprdEN5bjdPNUd1MTVFSFU0TitjeFJM?=
 =?utf-8?B?MmxIdnVrT0w2d0lzbVhoa01Tc3FNamZlTFRVaEhGbFdiRU1LRzBSSmlYTTFH?=
 =?utf-8?B?Q0pMekswQnJzVHNXS1VhYTN2UjdkeHdMQjJLbDRTT2FJWTFkMUd2ZHFXNFlh?=
 =?utf-8?B?ZldnOXp5L2lWN25yRzVHTFkvdmtDelA0ays5T21Bd3lCWEhzbmhuNDlJZUNv?=
 =?utf-8?B?NWhlalpINDJURTdSR042QmlkQ1lnOE43dS9DNGJiY2lTQytCbXJOT1paVlhC?=
 =?utf-8?B?YWlrRE0vSDg1TTZaQWFXVTZqSWd1NGpwZTh4R09SR1hyZVVpK0ppNTlkcmwx?=
 =?utf-8?B?dVMrQXB6WmJSWmZGd1g0ZGZHOHZleG9sUnFVQU5zTlZMRVB3UkJDVUduN0th?=
 =?utf-8?B?ZTZCMVgrZGtVMkV3VEs2QkpaSUFMYnY1SFJLMTVZbk1OcTBHUlJyNnFhRGZ5?=
 =?utf-8?B?Y2RGaGdHNHV5SWN0TnBwUTdZaGI5ZXRGTE53NUpxbDQ3SmxpU1EzdVFHZXRU?=
 =?utf-8?B?UlBzZ0NEQWlEbzVVVTUrVDBNdTk1ZEd6ZklVRFlkYkdjWThXbTBQbTJZcXdZ?=
 =?utf-8?B?MjRpNEw2L0NWSld6UWVMNVpMOEY0cG9KRGJGdEJyMDJIcmJOZWVoNHpqbGNR?=
 =?utf-8?B?emxSZlJheTRuQVRxU1UvNWJTR2x0bjNvZG1FWXYybmNudlZHT1pEbnlxc3Vr?=
 =?utf-8?B?MTNkNGJDQklaajZqNXFTaWtibFNmR1NnUHVSK2J4UmJMTWVjWll5Z2pZcjA0?=
 =?utf-8?B?NlBnM0NWT0NiaDdDOVFqeUM4anVTeEwwVHNWUzgyTmdlUXpvMm82S2doQ0o5?=
 =?utf-8?B?UWZtUWUzdDlrTzdBSXI0Y3dzaC9SL00vRGFDSFRlaXh6aWFuaURKU3IwZWRJ?=
 =?utf-8?Q?nK6taBg6naes88DWeBghz1N3d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d61743-7a6a-40cc-4d66-08dab343cc51
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 09:08:20.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VBa1B4Bj4Z68NUzB461Fb2bHNyGtg5ulOr3lz8kkziiFdMuIX+87UPO2ZVBsxxJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
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
From: Luben Tuikov via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Luben Tuikov <luben.tuikov@amd.com>
Cc: rafael@kernel.org, qemu-devel@nongnu.org, richard@nod.at, somlo@cmu.edu, mst@redhat.com, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-f2fs-devel@lists.sourceforge.net, liushixin2@huawei.com, joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org, jlbec@evilplan.org, hsiangkao@linux.alibaba.com, alexander.deucher@amd.com, jaegeuk@kernel.org, akpm@linux-foundation.org, huangjianan@oppo.com, linux-erofs@lists.ozlabs.org, mark@fasheh.com, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022-10-21 04:59, Yang Yingliang wrote:
> 
> On 2022/10/21 16:36, Greg KH wrote:
>> On Fri, Oct 21, 2022 at 04:24:23PM +0800, Yang Yingliang wrote:
>>> On 2022/10/21 13:37, Greg KH wrote:
>>>> On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
>>>>> On 2022-10-20 22:20, Yang Yingliang wrote:
>>>>>> The previous discussion link:
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F0db486eb-6927-927e-3629-958f8f211194%40huawei.com%2FT%2F&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7C74aa9b57192b406ef27408dab3429db4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019395979868103%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=RcK05cXm1J5%2BtYcLO2SMG7k6sjeymQzdBzMCDJSzfdE%3D&amp;reserved=0
>>>>> The very first discussion on this was here:
>>>>>
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Fdri-devel%2Fmsg368077.html&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7C74aa9b57192b406ef27408dab3429db4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019395979868103%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=sHZ6kfLF8HxrNXV6%2FVjgdH%2BmQM4T3Zv0U%2FAwddT97cE%3D&amp;reserved=0
>>>>>
>>>>> Please use this link, and not the that one up there you which quoted above,
>>>>> and whose commit description is taken verbatim from the this link.
>>>>>
>>>>>> kset_register() is currently used in some places without calling
>>>>>> kset_put() in error path, because the callers think it should be
>>>>>> kset internal thing to do, but the driver core can not know what
>>>>>> caller doing with that memory at times. The memory could be freed
>>>>>> both in kset_put() and error path of caller, if it is called in
>>>>>> kset_register().
>>>>> As I explained in the link above, the reason there's
>>>>> a memory leak is that one cannot call kset_register() without
>>>>> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
>>>>> in this case, i.e. kset_register() fails with -EINVAL.
>>>>>
>>>>> Thus, the most common usage is something like this:
>>>>>
>>>>> 	kobj_set_name(&kset->kobj, format, ...);
>>>>> 	kset->kobj.kset = parent_kset;
>>>>> 	kset->kobj.ktype = ktype;
>>>>> 	res = kset_register(kset);
>>>>>
>>>>> So, what is being leaked, is the memory allocated in kobj_set_name(),
>>>>> by the common idiom shown above. This needs to be mentioned in
>>>>> the documentation, at least, in case, in the future this is absolved
>>>>> in kset_register() redesign, etc.
>>>> Based on this, can kset_register() just clean up from itself when an
>>>> error happens?  Ideally that would be the case, as the odds of a kset
>>>> being embedded in a larger structure is probably slim, but we would have
>>>> to search the tree to make sure.
>>> I have search the whole tree, the kset used in bus_register() - patch #3,
>>> kset_create_and_add() - patch #4
>>> __class_register() - patch #5,  fw_cfg_build_symlink() - patch #6 and
>>> amdgpu_discovery.c - patch #10
>>> is embedded in a larger structure. In these cases, we can not call
>>> kset_put() in error path in kset_register()
>> Yes you can as the kobject in the kset should NOT be controling the
>> lifespan of those larger objects.
>>
>> If it is, please point out the call chain here as I don't think that
>> should be possible.
>>
>> Note all of this is a mess because the kobject name stuff was added much
>> later, after the driver model had been created and running for a while.
>> We missed this error path when adding the dynamic kobject name logic,
>> thank for looking into this.
>>
>> If you could test the patch posted with your error injection systems,
>> that could make this all much simpler to solve.
> 
> The patch posted by Luben will cause double free in some cases.

Yes, I figured this out in the other email and posted the scenario Greg
was asking about.

But I believe the question still stands if we can do kset_put()
after a *failed* kset_register(), namely if more is being done than
necessary, which is just to free the memory allocated by
kobject_set_name().

Regards,
Luben
