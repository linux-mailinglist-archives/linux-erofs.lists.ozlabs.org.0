Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 02283608235
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Oct 2022 01:49:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MvLlc6BLxz3c7L
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Oct 2022 10:49:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666396140;
	bh=hPT+gWJ3KCHw4Umqffy2WWdonR4AwcF1DE2qSsnIkDY=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=WNi1lHVys5ZwGJQXGR6d5Io4xCJFTdI6kSHQZ/fcA9YxZusF3iW7SVimNV4ETfr9z
	 OxhrKvsSeSBYdXCmnRooeRwETjzETz+GeQXAIrJD//WjOwyTCqikeZ7AVKmwvauY8I
	 wGxouafvRqgRoZ/w0OUcqx/6UwhSAFuihEgOvZscbl4ihdkR3/2q3QqBzvEe3zhHH5
	 dkGx969tr0xpxNENKxTtyPlJ9r/m332Oee9Sp0+zACnzHJh/xFMnS8LPu2Lawks1/7
	 prKObTn5bmpYaBjOa0Z4eAfPNQYKfA6YIMK64edA5xO9Q2uh1I6d7VWARqUBCtkSml
	 5wzOSwTbSZLmA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=40.107.94.71; helo=nam10-mw2-obe.outbound.protection.outlook.com; envelope-from=luben.tuikov@amd.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cgSiwDMd;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MvLlX2p53z2yRV
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Oct 2022 10:48:53 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbxxYzbj4iBWml1cmNJyvTiy2ed+DBTiWEQWfSGnj7IHD/hLcBlK1ksKY+4KFKKerDy6yeBzt1iQD8EpUeos9XWOERyP6xpRYrpFUMDI4g0JscPe8iZ19crnnEReRmDVbI3nQGjxfTdbOJybGX8IbaUENvBnHrndx//6QowRs31ozmFmvicUwWZ3y4rqzkPWKZWsr//4j40QZm9aOocPG5BWjGh8hFOO8XqUCO3bC2d2JOTuK0SPssfYgXsR4W43ySmjKxr2SIo8seNBBcZ/mwiT8A/4KotNpyGQ9IeD96eGry/dtM7ChKDWuehvZadWyWe0gh4PH57vLWWhvVFiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPT+gWJ3KCHw4Umqffy2WWdonR4AwcF1DE2qSsnIkDY=;
 b=KsZNpGLswcYpHjntGCmR+FBiNBAJgvj1g/fUkaKHVp8JEGqZVmqXeWj3sJLwUg4aMv+VF8cEJ1NjxY1FaG13MR7pof0Mg1siu8qdy2y9dlathg2mAJLP7YJBvZBwcTqFtLMi3KRsurz+OEH7btfmXHuVLW/xuMp2Miz4PLyWDjt+HwJGBFFDi+rsbWOuywPkaqTwHyJwAlGlk9ADKcfduRa6DsxLQIsw0ZHsBoNLWyTQnej32XkNTXBAoX3kni2phcdOn8kBQcdr/gYSCygBeBxsoNLRpAxB5vP5RSZNX0gs/pdqZcN8m4CWOhNTYG/5rJDVM8FiZyZ6LpRy1oM2Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CH0PR12MB5075.namprd12.prod.outlook.com (2603:10b6:610:e2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.35; Fri, 21 Oct 2022 23:48:35 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 23:48:35 +0000
Message-ID: <3a068724-8fb3-920e-a529-9a232b6830a9@amd.com>
Date: Fri, 21 Oct 2022 19:48:32 -0400
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
 <1f3aa2ac-fba6-dc7a-d01d-7dd5331c8dc5@huawei.com>
In-Reply-To: <1f3aa2ac-fba6-dc7a-d01d-7dd5331c8dc5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::23) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CH0PR12MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5ce8e3-f289-45b3-cd42-08dab3bec48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	sXe3UHoS1sNO/at/vFqnPnaMxoDW/6R4DFzmSexR5iIlSmQFdACrzZZG+TvCrmzSHd5HFzKM0xwSAAF5wLmWo9JYAiMgledc7g1Y2fidUE8ccSsKYdiepEd4f+Dsw6uElglxFrGUSSHUgI6qLclAQ7A+icUwoUrTb0HDRIFJ1uSlwnxNqufVhQFD3Ry5i6WSz+j5xe5Kqs5u0//kRRVew0m3JCO/kRgcfBaz6DCFPQNks1M7gbn1qAZqnSP4Nl22HYwKTJWHhODgJr/+7nblnuEPhpfx184XeJwEgBvyYN5QMBvJyftWujuXILLjCjb15WOJw6MnjL/mjofDxpdbWmj3Vybs+UpzOxQTuzrsFhvMQQTdrTYQ1XVuIICav7Ikly7ppsLAuEjgLTy8B+VBpgijtl2muz3PaWGgJIoA6VctQ9AKVrLGNN/+1ueOGEQXEHL9OOdfVAI1WKyqRWLJ0MsVVCHUv8T4dL0x45EUU+Pr9eVEbzgI3NkqVTAp5H6FMhYbFOM9w8yNePuDgEzm5m9rj3PnYCpxxV8/5rWj5D45dzL+3E8u8+GfGHx2QRdKUfAtbY5bTBXuC2g0i34A9bLhkSpNtnNyTnAY7AW3+8fP1uLIlFDJVtuCJPqwgQxsQI8nruEYm0sdOV1rix6rbRGocvdJjfWfjJ0biuDvLobqa87qfXAOC9Furja1JgCheMvld+FP70I/0D1uyIEXi6D2O5K8oQcmqQ4UsL6Ej8lHxg0ZgZgUqUum7rez7OKpW2ndu8ud2xXZopkozraKPZHQEPvJcwh3TTmTROqtdbWIUY/AOM6Rwvm7WVSOmE1nzNyKFKnTPoJsp4WKbfcAog==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199015)(36756003)(66476007)(4326008)(31696002)(41300700001)(6512007)(53546011)(8676002)(26005)(66556008)(7416002)(5660300002)(86362001)(66946007)(45080400002)(8936002)(966005)(6506007)(44832011)(478600001)(6666004)(6486002)(110136005)(316002)(38100700002)(2616005)(186003)(4001150100001)(31686004)(2906002)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?TUJjUmYwaC9UMjdwNHo0YTFsejUzRWJvL0poSEUzVEZ3VzdYZU9kQkxkMDRn?=
 =?utf-8?B?ZEhjVGRUOHhEK2xLQ3p1a2k2aGkzdU5HbkxmbGhQakZDNHQrc01YN04yWEsw?=
 =?utf-8?B?VnJzalNmM0hCSlU1dXppOGh3MHpFT2tEeTF3NW9tdmo3NUNyWllLOFRKeGdj?=
 =?utf-8?B?MFBRbEYrVjZPTTRDRmdmUWVRbjlhM3hMc1p3N09GWWgzTVNRR1JtanJpTjlw?=
 =?utf-8?B?d29wdFJhZ0lhVmRJNjdBdHBZeUhNZ0t6MVRSMk5DWDRoajd0dGR6bDFWOS9s?=
 =?utf-8?B?LzZUNmh5TlZrNWZCU2lPaEFlNi9meDJzNjVpOHllRDRnQ3BaeC96YWRvbVhw?=
 =?utf-8?B?S0UxNnpISUk2VHhCN0xIUFhTVTk2L0FNY0hXSkZRbHNQRWsrZDhOaGtJUXlk?=
 =?utf-8?B?elYrWVZaMStrN0oybGdhL2lvMm1BSWd2NVlZOTl4OG5aejhvVnI5SGdKMThr?=
 =?utf-8?B?eEY3aDNWVHdmSThPRkY1eHVKOHdQVGVzNWIzVlZOMFFwR2pOYWJSRks4eWJi?=
 =?utf-8?B?Q3BldnBZSmNQajFCWkJ0aDlBM3NGdlNQWWFWMFBSdk45cHZVL2NTQUJVTi9M?=
 =?utf-8?B?MW9KL0NYck9pL3JKUXFOZjlMMUhhN1dUZDFSd2lqVmEyU1FVMzZIenp3REw2?=
 =?utf-8?B?T1pVaXdlcDBYdVNhRnpXNUpCdUdTMmZ4SFZZMk9URmFUVitTbGhwM0duTnVl?=
 =?utf-8?B?ZXNjQkhmRDVKNExqcVNMUXBDcUdmNGZuaVlrdkpTeFFyaXp1Rk5PbGMwREdB?=
 =?utf-8?B?SXlMYzBSOVh3ZVRObHlwNzJtaENHR1d4NlpBYnc4bDdvRGgyRWIwZWpPWk5B?=
 =?utf-8?B?Zkc3elJLRDBrTkNKekVab1hDNWlZVGNLRitZVHBnYmNCdHc2T0ZBTExwVDlM?=
 =?utf-8?B?QmFOOTBmUjk5S29jMHhwd0dudGhKV0ZkRkhCWGlqQnliNXREN1lLK3phejFN?=
 =?utf-8?B?Vjc2Vk1ZUWM0WTdER3VpVTRQVXZQTG96b3dJVEh4bTh5ejZ5eTEvWkcyZ1RL?=
 =?utf-8?B?ZG1tdWVPN2JFWVZYOWFDSzZ1emhnNFRpdTJVTlM5eHdjK3FXa3RoVHdtVURi?=
 =?utf-8?B?R0UxZXBLR0FmcU1LK0tGRHVmd2M1bVM2dys4bStTMDZ4NFM0QlBQRnVVMzZG?=
 =?utf-8?B?YUNpblNpbE5HcU5JcGtxR0JmRC8vVnFScXN2b1dJRHNXNUc1RzhkUm9aYWtY?=
 =?utf-8?B?TVF0MHRjTVM1ZTJRbkRDaTYrSThMZm4wOStmQjI2ZFVzTlREbnZhbEU2Nnpt?=
 =?utf-8?B?ekxucVovbHozZVhUdjVCWGJXWU56OXpZVklqMnM5cnBGbkpKaTNhV0JjQWMx?=
 =?utf-8?B?bUUvRWxjYVdsTHFHR1RRYVR1WWVoR3NiaXk3QW1GYkRYSjJkRjJlT2tuTmh4?=
 =?utf-8?B?MWRIRUprUlZGOVRkMXpXNGMvY3licy9ISXlZdS81V3RsbVo5eHJnemx6UXpK?=
 =?utf-8?B?MVI5dE9OS2ZwUEhxc0J2dENFZ1hJLzhhZFJhVmV3eXYvYmU0ZnRYd0Q3TDBi?=
 =?utf-8?B?OG5USC9lclpsMVVvdUdXVlZYTFl1b1YyNnZLN1paS0NZT1l2ODdWQlJlcDlS?=
 =?utf-8?B?QlI3VWowRlZIUzk0YmtDUHFuSHZVblJWR3V0K0xHcnF5VzBvTnVQSldaelZu?=
 =?utf-8?B?RmNnajZSMzlva0pHVm44UEpYSWpzcnBtWU1ENnBGb1Nmd29BVWlad0g4Y2VC?=
 =?utf-8?B?eUpLUHBFWkt2UG03UjR2akJQVC9lT3Y1NWw5VTVlU2NCUFEveXRKbkFUcktR?=
 =?utf-8?B?Ym95U1VBUzJnYzMxaEc3b3hLdHh0WDdoYUIydnE4ODlpVmdJS0RUb1huL2dX?=
 =?utf-8?B?QjVJR3M2dFJMWWV6YS9rMTRxR1VrQnQ3OEE4dWhFRXNDUjk3LzlZWTI4MEhP?=
 =?utf-8?B?V3NyTFJnYnRxMWNwbmVuS3pHQ3VPcmhTOENQZXZOUUVGVmVwTHBYcWt2blVB?=
 =?utf-8?B?MDNaRGNFU1JxWEpZYTY1UWlTcG5jWDJ2WDhSRVhVUHhQWjhrR3pSR281VEI2?=
 =?utf-8?B?SS9nalBETUx4ZHdnRTBsbGJGRUh2aXFzMVBtOW16aGNRSkx3S1pHR3puMDdX?=
 =?utf-8?B?UFdHTTFDZVd5L3d4OXZXUVBObE1NNWZrODlpUUpaQUdpR0NMV3hWZEdVdDZ3?=
 =?utf-8?Q?070NBE4PkkWKbQB3jHPo7pNAh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5ce8e3-f289-45b3-cd42-08dab3bec48f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 23:48:35.0356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5guKvYv7nE6SpmZugR0KPfIUxlvHAtSD1kV2E8jSSEfFB+VJZJWlbm09NsfLoWh+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5075
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

On 2022-10-21 05:12, Yang Yingliang wrote:
> 
> On 2022/10/21 16:36, Greg KH wrote:
>> On Fri, Oct 21, 2022 at 04:24:23PM +0800, Yang Yingliang wrote:
>>> On 2022/10/21 13:37, Greg KH wrote:
>>>> On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
>>>>> On 2022-10-20 22:20, Yang Yingliang wrote:
>>>>>> The previous discussion link:
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F0db486eb-6927-927e-3629-958f8f211194%40huawei.com%2FT%2F&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7C26ed7dc8053f4793d54d08dab344731e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019403819761348%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=PD93EC%2FcBmkfSBbdmK8FNtXhqS%2FKmmcByfkx5lqQfpY%3D&amp;reserved=0
>>>>> The very first discussion on this was here:
>>>>>
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Fdri-devel%2Fmsg368077.html&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7C26ed7dc8053f4793d54d08dab344731e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019403819761348%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=k0fTSmAPTnLFCe4zN4z%2FY1Z7CvwO4gR2vgj%2FLH%2FSRRk%3D&amp;reserved=0
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
> Read through the code the only leak in this case is the name, so can we 
> free it
> directly in kset_register():
> 
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -844,8 +844,11 @@ int kset_register(struct kset *k)
> 
>          kset_init(k);
>          err = kobject_add_internal(&k->kobj);
> -       if (err)
> +       if (err) {
> +               kfree_const(k->kobj.name);
> +               k->kobj.name = NULL;
>                  return err;
> +       }
>          kobject_uevent(&k->kobj, KOBJ_ADD);
>          return 0;
>   }

This may work, but absolutely needs to be documented since we don't
exactly know how the name was allocated by the caller! FWIW, the caller
may have set the name pointer to point to a static array of strings...

> or unset ktype of kobject, then call kset_put():
> 
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -844,8 +844,11 @@ int kset_register(struct kset *k)
> 
>          kset_init(k);
>          err = kobject_add_internal(&k->kobj);
> -       if (err)
> +       if (err) {
> +               k->kobj.ktype = NULL;
> +               kset_put(k);
>                  return err;
> +       }
>          kobject_uevent(&k->kobj, KOBJ_ADD);
>          return 0;
>   }

That's a no. You shouldn't set the ktype to NULL--maybe the caller is relying on it...

Regards,
Luben
