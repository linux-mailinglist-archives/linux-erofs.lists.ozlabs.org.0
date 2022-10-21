Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E2860822C
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Oct 2022 01:46:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MvLh82LMmz3c7L
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Oct 2022 10:46:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666395960;
	bh=bpGBa9Rr4uN64ok9iDDV/hFbcVrvfG/84EdVCW/8ySE=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=A7J+P5Dr4oYTRQUZVCrlfUxiIUUe/XypzBaARoi+cBuaxcI8rB6YM+PYbWndryAQj
	 O+B8GgQXYrA7qn7g+xOOSHyO73Jw36D4rfLAlzT4UmU5qTgbwfh6DWGzAxBV/MMk/Y
	 onp1CUab5vprq1W8S/O3eLwFQiPE2GdkHGEHitZdjIHddIIxOjAj4wgV0n0DMUTdTj
	 vbyrgYV925+UnU1J0C7w/RwMEkdJdtQa7J3weaZR4YHYCTEpq/KcJuqk+GDkMh/eVw
	 7XYWM8zlZAt2AJIkcNxqhfcF3MSC6yUGUoIJXkYcX5T5rKk1TYcfxVa/pscm4dA3Ob
	 VIuungr2VzcDw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=40.107.92.43; helo=nam10-bn7-obe.outbound.protection.outlook.com; envelope-from=luben.tuikov@amd.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sikIsTSB;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MvLh00Rqvz2yHc
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Oct 2022 10:45:48 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfgLgnrqxfnApVTN7pcxZUGWZSXDqaoJTvcG+gjlQkk/1NS7C8CtLbjEVyO14kXX78rp6uc7yNuWYwLO4bpZqrsOpMQHgUiMzZU+VHpLvmP/nHmX69RI4vEsgxUptZyadYqfZe7iambjMJUbAuR0wSV/hQs/Au32szORymPZNLs8eyOXqz9GS4YQryw/LKw7wHOUb2jOms64nPwUL1c4wNcyaoNxOZYozfyFjMUP+hhV0RvsFpW/mv2yMDhPFHk8xFmvAHjfF97UEyGv/tjTV0mFpzhZWbyydNruRxXuW5edu7G/pjFPS2FAkGdZnvSSEBVjEkxWC4dZP+LWzN9Mag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpGBa9Rr4uN64ok9iDDV/hFbcVrvfG/84EdVCW/8ySE=;
 b=Tc0WAeDHHAlh3ldQuKqNVdkW8Poac3KPtya50OFkSwsely9fRfTpw94y7+JEWxv6BY7nWTsLvhhKT9ZvC/I4BtLSKjZRv8KORPhuoMMCiNTw1KV2q4oWwssfkI+ibffqh4iNVZT3QYa6sk42jFXdoXcCLnqVlPJIzSoNJL6R2o5Mj8iefkxyCByP6wPnGS1RCiImCifStV5yWBD3x6NEncH0ye5eD0WKmnseY127cHRt0uiCOXy8SiOEKYE+IBCdvKvDwRqB3lgdZrXBXnVDMYyQsJ1SrRGkZs5hha+i/ahvXb8aVjCO4/kIX5hjQsW8VREXggNjiFn6WtyHrNrkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 23:45:26 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 23:45:26 +0000
Message-ID: <dddec689-c945-a564-3870-b8cebf142323@amd.com>
Date: Fri, 21 Oct 2022 19:45:22 -0400
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
 <78f84006-955f-6209-1cae-024e4f199b97@amd.com>
 <9ee10048-f3fe-533b-5f00-8e5dd176808e@huawei.com>
In-Reply-To: <9ee10048-f3fe-533b-5f00-8e5dd176808e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::32) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 54580e30-f48c-4ace-142d-08dab3be53f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	aGw1DrPLFR4cKWXUAaEcDXP7kewxDGHHsexFg+bcleKM44gaAlIfGy7WDrKTwPi758grxCfL14m28Qfzy1zAFeihOhbCSkTRgYXx451/vS5EpxKSCGKoPYFob1YDAmBBy2hUdXaFJy9du+OqrQ580BGM//1l/PQPwjSO15AYjEI7DQXW8DvpCYA5eQCRwRp2oA1UJV35og8h93wl/LVn0KAsdU/Ch5ZLzMWDbF2IH8/FnjM6EtMn+1XSdMvlaV/4mDnTrP0oFj9EuWyAKOvJjYKcqZMVLai8jVxW7UbKn2XU6kCQI4Qg2bGWDEIpyVKmmZJqBdjxc10eDer4H/WVPC5XFpAhYajU1YPpOADE8XZFmjQ8CaX9ts7ZM6oY1ZHuPoT9FqL/nbXYbzDfasrkByqBiEUaZ5jYGM9DPTO5gK8l9Hk/ao/7ZEw0pD3gvVrbt1QA2MubHmhtqjv3gOE/3ZY2y152uBTOyDiLZKasmc0tONJvUo/omNxiweDwV2TfndKqn1f8+EIoQ/WiMmwWW8h9pPy1pR3GZxgEccgL7jklmS4MGMn+uemyKTUIJF2ErugTZtcu6Bnnh+iYHPorsRXtOMFrYak6IUReOEDdQdPkJxGGFUvfe598C3FWfMhpf5uc2/QbcC6v7ksUSmXGopjeKu88e7BEaIZytmxckU8p+W9cw8gxRRnymlxX3FfUz6zziOZ6NeLmU/ATcfY5oERHUUIrKZJxiedMZRlc/lw2gFjMY5APJeGw9Ev6l9HMEOMRLC/THaeCUb/7V4Tg6+Zx4p4dLThLmUpXkaYqvQgv5T3LBR6i2kEk2dAdx0N+VEDT3/v03YuyyfqilHuLaw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199015)(6666004)(6486002)(966005)(45080400002)(7416002)(5660300002)(66556008)(41300700001)(478600001)(36756003)(8936002)(4326008)(8676002)(44832011)(316002)(110136005)(66946007)(66476007)(2616005)(6512007)(38100700002)(26005)(6506007)(53546011)(31696002)(186003)(31686004)(2906002)(86362001)(4001150100001)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?Q2FWellvK2p6ZmpiRkFPK3Bkc2Y0SVhJbUV6WUlJOEpPQk9uU3E5Z0crVHJU?=
 =?utf-8?B?SzBtZkxZSzI0MjBGYWlGSmNqZ2d1WGlpd0s0VUExcE9Zd084b1J6blg2VW8r?=
 =?utf-8?B?UzFpMEsyRnhPQnRuNnNEMktzdUIwT0p3MmdoZ0xCUGxwdlo2STQvZ2p0bENz?=
 =?utf-8?B?OG5saldyQkg0NTJwaTdPZm5NV1NLZ3RBSlF6eXdSV2FGeGNva0NsRXZaS2ZC?=
 =?utf-8?B?d0Vma3d4WEg3dVEzYlRWQlVIU1VnQUdaclBOU3ZLeWlmN25WelZIaC84WVJY?=
 =?utf-8?B?c2FaaDljK0tTWWJPSEVjR3lhaERrSi9WQk5SOXFRMkRWeTFRR0dXaEtKTGlW?=
 =?utf-8?B?RkdWbzJCY2k0MkkzUVJtTldWV090amhoNEpEcU43b3FMbHQvdW5mQ0lHUjRR?=
 =?utf-8?B?dkJSMFUxb1hxUkg2aVcrcTMxQkdrVVZGU3R3QUppSTdVczIva21ydG9vVWZC?=
 =?utf-8?B?VStkd2M0YUEvL09PVjdKZFFBMndvUGF5blp2ajA5ek50K1JLdDBwN2QyZTN0?=
 =?utf-8?B?MXkwaW1zamkrbk4wNldZLzNuaDdUUkZnRGs4MjZHOUU2akUrVGZCZFpaY1Nw?=
 =?utf-8?B?Y3FGcFk2VHEvOXJoZTBOUzNLYXdjdm1BenVCL1lWajkzVUN0NHl0NXpIdFVl?=
 =?utf-8?B?QWdqUjVFYWlKZzh5YWh2eFVvYXAveldMcm1hVVYxaSt3ZXRFenN1RmErbVhI?=
 =?utf-8?B?b1FNeFgxczJoRnhJc1FkcS9vdW9GTjN5bHA4OW5OVjNnSUViQ0s5YkdPcnJF?=
 =?utf-8?B?UXF5SEJ2TlN5SmZVSXo0OFFjWHpHUzZsU2c5bFgzSk95WlVVYXpERWNGdnB6?=
 =?utf-8?B?dDVmTlJMdVNCRDk0bFZQZWxwa2h2eUNmVFNzOFZrQXFLTGJwc3dMRjZ0RzVv?=
 =?utf-8?B?WStCdFUxeEFIcmRxWXcxNEpCU25NMjJIZ2ExZlVqdUorM3FWYmN2MTRXQjVk?=
 =?utf-8?B?U1hKVnJoVldsZGZwRWRocmVjSEFxakZYT2NuQXdhRTF4OU91YVdIaStldis3?=
 =?utf-8?B?QzBEc1QvM2V6UmJZYjdPdk03NitjMGNtdFVCc3FPN0VSRnJpV3lKbEkrUnZr?=
 =?utf-8?B?MW52anZDUmE2QUxJbjJyMDdsS0xILzI2U3BMQ2gzaTh5SjQwQWM0V0ZDQzVq?=
 =?utf-8?B?OGdOUTh6WU9PWE1OaU9Za2g5N1FONUo2NGREZHdZcHE3dzZybGE1TkVzaWVL?=
 =?utf-8?B?Y01TcjN0Q2s1M2EwNS9TakNhMWlIM1dhUCsrclo3cTRVaThabDVEUkd6UWo1?=
 =?utf-8?B?ZlVpcmFpY3dxSTltTkxlbktlZ0g1MGl0bCtjNVBJQ1lUZU1GMko2SG11YnN1?=
 =?utf-8?B?cnk3VDdJU2o1K0xjMWs3TlJLWm04WmlCTWxvUjhzYWxGWGpzWWxIa29Ya1lR?=
 =?utf-8?B?V2p1czg3YWVaNGNkeHVBbTMvTlJvZGFjMWtJRHR4bEtpNVJEQ3hFb3lNeS9R?=
 =?utf-8?B?NXowM3E5dk40NFR2VXZ3Ky9McVNhb0NidGZsekp0VlErQ3YzNXdoK0FpS0ZX?=
 =?utf-8?B?UmJOMmVvSS9mbGtNZnRmRUliUlRzeEFLMW56RGNTY1JqYU1Ia0tld2xKVVJW?=
 =?utf-8?B?ZVZRQTVoMllrYnU1Y2dUaEFmKzJUWEFodmRUT2RiUFBQbVZkNzFoVys3Z3Nk?=
 =?utf-8?B?MndTNytmRDYvWWxuaStDeFJWb3l2anZMVUR1b3Y5RVJLNHlEaGdmcnVIWEV1?=
 =?utf-8?B?MngzZHErMm5Uc1dSUmFNRE9Ed253VGdLL1c2cGp2NUtjcUN4aFJHQnBOY3h2?=
 =?utf-8?B?b2NUakJNWlpwa0ZGWjhVWXhZU2E1bjhFRTkvWnFnenEvemIrSHVQd2xRZXJz?=
 =?utf-8?B?bUlDS2V5L253M0VHbmpURDVLWVQrWmRMeGZBVVY1ei9wMVl3RkVKVWtNQmMw?=
 =?utf-8?B?YUVicHY2aVptYW1ueFFTZk9sQVh4UlhiNmRIYXRsbmFPbkczUXNVRWVhUzNS?=
 =?utf-8?B?S0NZZFZyR2Vid2svd014RythOWxPU2FWL01rc3Q0TFcrbUJHQUFwMHdBalFJ?=
 =?utf-8?B?VHVQZVcxQUhEZXJ2VVJSQ1JhM0ozSld5OERxNjFVWXJNaFNpWmQ5WTNUTURY?=
 =?utf-8?B?REpuWmJpRmFhYmh5VlVNWnlIUFhuMmJ0VkZVZFBmNTVSc29NeUMydWQ0bk9X?=
 =?utf-8?Q?J4JTjMsig2S9FxnKmAe7Vbw1M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54580e30-f48c-4ace-142d-08dab3be53f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 23:45:26.1743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iawkYfgjKrRJkKVJ9PC3JfmAwNlzjkogEihwWkOSQrKv8vCMKol/DssN80A9GML
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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

On 2022-10-21 05:56, Yang Yingliang wrote:
> 
> On 2022/10/21 17:08, Luben Tuikov wrote:
>> On 2022-10-21 04:59, Yang Yingliang wrote:
>>> On 2022/10/21 16:36, Greg KH wrote:
>>>> On Fri, Oct 21, 2022 at 04:24:23PM +0800, Yang Yingliang wrote:
>>>>> On 2022/10/21 13:37, Greg KH wrote:
>>>>>> On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
>>>>>>> On 2022-10-20 22:20, Yang Yingliang wrote:
>>>>>>>> The previous discussion link:
>>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F0db486eb-6927-927e-3629-958f8f211194%40huawei.com%2FT%2F&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7C2597f1097c204be54c7c08dab34a8654%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019429914730071%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=NNVCtbTxI5uzxxJA9mKvnsy8d3jyudtl1u4CTcm3tsU%3D&amp;reserved=0
>>>>>>> The very first discussion on this was here:
>>>>>>>
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Fdri-devel%2Fmsg368077.html&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7C2597f1097c204be54c7c08dab34a8654%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019429914886316%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ByCQk0qGktyyoNQg8IFj5AGxmaeWOXnbIA4rFnX%2B6%2BA%3D&amp;reserved=0
>>>>>>>
>>>>>>> Please use this link, and not the that one up there you which quoted above,
>>>>>>> and whose commit description is taken verbatim from the this link.
>>>>>>>
>>>>>>>> kset_register() is currently used in some places without calling
>>>>>>>> kset_put() in error path, because the callers think it should be
>>>>>>>> kset internal thing to do, but the driver core can not know what
>>>>>>>> caller doing with that memory at times. The memory could be freed
>>>>>>>> both in kset_put() and error path of caller, if it is called in
>>>>>>>> kset_register().
>>>>>>> As I explained in the link above, the reason there's
>>>>>>> a memory leak is that one cannot call kset_register() without
>>>>>>> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
>>>>>>> in this case, i.e. kset_register() fails with -EINVAL.
>>>>>>>
>>>>>>> Thus, the most common usage is something like this:
>>>>>>>
>>>>>>> 	kobj_set_name(&kset->kobj, format, ...);
>>>>>>> 	kset->kobj.kset = parent_kset;
>>>>>>> 	kset->kobj.ktype = ktype;
>>>>>>> 	res = kset_register(kset);
>>>>>>>
>>>>>>> So, what is being leaked, is the memory allocated in kobj_set_name(),
>>>>>>> by the common idiom shown above. This needs to be mentioned in
>>>>>>> the documentation, at least, in case, in the future this is absolved
>>>>>>> in kset_register() redesign, etc.
>>>>>> Based on this, can kset_register() just clean up from itself when an
>>>>>> error happens?  Ideally that would be the case, as the odds of a kset
>>>>>> being embedded in a larger structure is probably slim, but we would have
>>>>>> to search the tree to make sure.
>>>>> I have search the whole tree, the kset used in bus_register() - patch #3,
>>>>> kset_create_and_add() - patch #4
>>>>> __class_register() - patch #5,  fw_cfg_build_symlink() - patch #6 and
>>>>> amdgpu_discovery.c - patch #10
>>>>> is embedded in a larger structure. In these cases, we can not call
>>>>> kset_put() in error path in kset_register()
>>>> Yes you can as the kobject in the kset should NOT be controling the
>>>> lifespan of those larger objects.
>>>>
>>>> If it is, please point out the call chain here as I don't think that
>>>> should be possible.
>>>>
>>>> Note all of this is a mess because the kobject name stuff was added much
>>>> later, after the driver model had been created and running for a while.
>>>> We missed this error path when adding the dynamic kobject name logic,
>>>> thank for looking into this.
>>>>
>>>> If you could test the patch posted with your error injection systems,
>>>> that could make this all much simpler to solve.
>>> The patch posted by Luben will cause double free in some cases.
>> Yes, I figured this out in the other email and posted the scenario Greg
>> was asking about.
>>
>> But I believe the question still stands if we can do kset_put()
>> after a *failed* kset_register(), namely if more is being done than
>> necessary, which is just to free the memory allocated by
>> kobject_set_name().
> The name memory is allocated in kobject_set_name() in caller,  and I 
> think caller
> free the memory that it allocated is reasonable, it's weird that some 
> callers allocate
> some memory and use function (kset_register) failed, then it free the 
> memory allocated
> in callers,  I think use kset_put()/kfree_const(name) in caller seems 
> more reasonable.

kset_put() would work only in implementations, such as amdgpu_discovery.c,
where the ktype.release is defined and it frees the embedding object in
which the kset is embedded.

Depending on the implementation, you may need to call kfree_const(name).

And this is why this needs to be documented in kset_register(), as I noted
in the review earlier.

Regards,
Luben
