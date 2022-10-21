Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260206072F2
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 10:53:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtytC6Xq5z3drS
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 19:53:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666342403;
	bh=8tgJbDECy1xY+raNOW2piIhcXYjWuQC+Pyq127+CAqg=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PYupd9CrTgoLn8BuZ0bo68HPGKxJMOLUjG5ayGeiKQpKk+GDDmhw6wM+Bwy4RExAM
	 3atWMV2i/KCNELqWP/s66u/n/sO2vH3I40a82kUwsoMijtAAEKaPF7Vs2wC1h2+tJb
	 ZMYHAndqixT/3Gcu59ZgM4iDyCqCgjWanm9rrW+VhU++TTWCs3YJ5yg6bfcz6OqXT+
	 cGPL8tixL+CESV8HkEFWSp4bVN8bfzBVCOlk9CD8Jex8GWbwuaa+GDfYTvCYBIyUPo
	 q+Dk/g130Ojonu5eJxZR5OiX9fOtPEe0cFhNfCDUoWez0XSJf9xX/XvuOR1Zvi0fh4
	 6owP73M3hAQYg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=40.107.220.63; helo=nam11-co1-obe.outbound.protection.outlook.com; envelope-from=luben.tuikov@amd.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aS5L/YiH;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mtyt64svjz2xH6
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 19:53:15 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Px6XYnBqhpU1/Nyy6U9ykVTKqHY2mTE3tMI+xsrwspUKeXBjvFBqiaEXkrX52c1X1QZMn3+n8AJDCxwHuKsJ3QA801wQHhxDA4YmY3USPcygzmi2UhhHUby/7wah+B52eSPSAxmhY4dPyHp154UK8SnBBCBpPcuzRQ3tM5FGA0a5B6SJ3Sefiyv8xrCNhB9mtp1EhWUw5RdCVlWlRRJvXDrd+Fmv4j+vVI9B4BoKkoHb8XTk0Oq5ouQVXYs/wBxJTrwDQtXJ+qkKs817ibpQxmXxY5nfzr5BEs6zb6MKBbQjR4UroI49o54Fn4LwdIfXPMW1GL7yZ1/iSGh33Mxxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tgJbDECy1xY+raNOW2piIhcXYjWuQC+Pyq127+CAqg=;
 b=fJcFq+b9F3odM9dXa1Ko7Dbvhr46PoLuLX577NEIT1QXRe+ngyGJn7DX0Sxjt0J3JgqXqeslyvFhSjKF1S755WTTc0Ef3Mh+IJXYJPV5jxkJ21NU6RrXeNr4E/RxflMD5KmDAS653gICLKzDvSAHiLjk+WXptIFvUbf3c3Wczziq4RTx1aRc26kxUfneETHGw1ZwL6nrhi6wGk+P9zeLN7b5LcsB1jvOjp1/CQsBYMDJcDaWI7czWMrYvUrLEOTwT67WvwPJCtOoWab1ekGMIMX1u61clSUfY/UXZ9d2MHpBvBJf3j0s7yx3G4tGB7KPIbHtZGzxz7OZiIXQqVE8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.35; Fri, 21 Oct 2022 08:52:56 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 08:52:56 +0000
Message-ID: <1c150db1-dc49-e3b0-4dca-f1427a180e4b@amd.com>
Date: Fri, 21 Oct 2022 04:52:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
Content-Language: en-CA
To: Greg KH <gregkh@linuxfoundation.org>,
 Yang Yingliang <yangyingliang@huawei.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com> <Y1IwLOUGayjT9p6d@kroah.com>
 <0591e66f-731a-5f81-fc9d-3a6d80516c65@huawei.com>
 <Y1JZ9IUPL6jZIQ8E@kroah.com>
In-Reply-To: <Y1JZ9IUPL6jZIQ8E@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::35) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DM4PR12MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: c35ac337-61fd-4e8a-9c78-08dab341a5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	s2nLFrbuhJHsKhSgpZ7C/fUA3n6j6d/EHHwT+HVUXO4Q1zUKhWelW6H39+RTAjQeAkD9ayjMdsrZ5kBLak/Gkuy6MxeXEEgsJZRIKSFTwbJJN8PUYt8VgPa1e9fdqX6VVAX7EirXley62g7KQIGpqGdVyYUThEtezm1LRUyzA97mPtLjwBhtQgNKBuFRLvmj6abTCjclR19p6tU+0zqphvGP007LJ1YJYTGk7JdG1cm9h39gpXZ1taXU0uVwOpYQlFAHU7rTyjP7aNqJriKS7E8tCoeRh/eWh/yoeagCGl2la7+42shG5Gbx8KnJi9msayN4SXoWD/15xiW4cj+nnRQmWJiJ03n4Eg4PBTYAta9M5osqJAhV+BOc1M8NxQKNUFAHMsE3cEnMenKKRmptFP8H8tjNJ5aaoBvvtvW7N3rMpXAkQ3c3KoIwQ/HJU0CrlpVH2hCaWmK1cbxuXkIVwdAeqpBYVs4deiUwkj7JlhVcl6tM6nqAFHYN4aTTMygu5Av6PaWzvrK1jWv+U/qODhPKHRIg6sg/Lv2PjWLH2wxCk28DsYDFlzmpnq0encVgLRmJA+rx/REvSOSdyB1M2BDdEynC+CQI20VCBYDrEVLOEVgg2UUphEK4s8LfklsULxLp1IeT2MGAXklK0WUOtLZqA5cuzzBJSJAxOtY/x9qZJwV+59TyT/BBEOQC3I/VPlKF+FgO8g4FpmuIZZTaXS0Nwnh6AnoqaVUznlCYJoFPJ2dSApnsKvnb6oy0io6ppXZflnKfG/f6YPb05mq5U6S2pAjrUnw7GOjN7FZxqdYRpQUGj1NasM1CrK0n9K2o
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(26005)(66899015)(4326008)(8676002)(41300700001)(38100700002)(6512007)(86362001)(6506007)(966005)(53546011)(8936002)(31696002)(6486002)(36756003)(316002)(4001150100001)(66476007)(66946007)(31686004)(2906002)(66556008)(110136005)(478600001)(186003)(7416002)(5660300002)(2616005)(44832011)(45080400002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?eGtnZXUvUEkrQmE3cm9nMVl6TTlxT1RVN245SElTVVF3T0lXSEpJcHkwL2Vi?=
 =?utf-8?B?UXhvOFcyYTlNcHcra1c1K1cyUDJrcTUwT08zRDRpbmZKalI5aEVYak5aU3Ji?=
 =?utf-8?B?QmFjTmg0dkRQZmdSQTZha2hsTlhValM1TnJMdWxrcm5vL2dVc1VLVnQ3VFJ5?=
 =?utf-8?B?bWJjRlpxZ0tlL3l2QzNGQ1QzQzE1S2pPQWRqR1RsTHZ1cE0raFJxeUZSZDRH?=
 =?utf-8?B?NDdCRkJmZUpzQlBZei9RRFhyOHA2cW42bERtSzU1T2JHc29aNU9rQ0xsdVBu?=
 =?utf-8?B?V3liSGdPT1RRM3E1eERlVTVqbjBGbWVEcW5janArYURIN1JqUzFCU3Zmcmx6?=
 =?utf-8?B?c1B0cm91MURyaklxWnZYT2FWODhTZ1JRVCtwS3JHTjZ5UDdsRUpnTTA2cGZY?=
 =?utf-8?B?VXhXekNDcFFPSkR2dit6MFZOTW44MXdDUmF3Z1ZCUGg5NkNoY1Z5UVdnRVNI?=
 =?utf-8?B?WjUzVFpVcnhlWkpwdWVRcktscHhHZUtTeVNlRWdlVGI4eTgvaEtFdS9BRmp4?=
 =?utf-8?B?ZFMrUDl3UEd0bnJ2TDNmQzN5ZkhSZEtTVjF3QUgyK1RXNkJmdUloSTgxTUZt?=
 =?utf-8?B?SGJuYmR2YjdMT1NJN0tsVmtvSmVtb1lqR2taUDNwSmgvWkx3Q2JURnMxRDlv?=
 =?utf-8?B?ajlZVC9EalVUZ29mV0YzTmt0ckc2ek1HR2NsenR1SzV5UHEyUWZEOXpPVkRs?=
 =?utf-8?B?UTN1eXYxOWRmeEpheWdSUGxJemdIMXBZZTEzcEZTeVZybzZTQjg5UjR0blZ5?=
 =?utf-8?B?T1NoSmhyckFJSGtPa3o0R2lBYVZzd21rc2NkYU91SGErLzNnTW0vUVF0NTQ2?=
 =?utf-8?B?Y0xZcDdSRytKMlFnZDhyNmRqUDFmT3FkVHdHeEpvZlFKSU1DcmRoOFhLaWU2?=
 =?utf-8?B?c3FBZEM4VWNpaSt5L1UyS1ZLeUgyT1pIVWdJU1NoK0hkVlZRV2NiQXBkY2JT?=
 =?utf-8?B?VEVrc0JOUWdONi8zMU1hOStKaytmblBmMklsV0dYbERhSHFIUldIRkxzZDRx?=
 =?utf-8?B?dWtSNGVQQVdIS1g3SHZvaVBBZ2N2b290OFZOWTRJRkFOMldJY2lSbC9Lc25D?=
 =?utf-8?B?Y2hZTjVCWjhSb3Y3ZzhsYUswUGEvSjFtSGZnNnVjbkdJcDEzN1lxaHFVMEpY?=
 =?utf-8?B?bS9UUlptZzd4TXI0dnBxaU1hcUpzR2Fxa0VYSzRKRCtqNys1Ti85Sk05anBV?=
 =?utf-8?B?cm9aa0VjaldSRWtYclZhVnd4ZmxWK1daeStweDE4djI1SUpLMk8zMDVRUHpI?=
 =?utf-8?B?VGp6eXdPNkxIQllqcXV4M3VoYnMvWVZFVkhxUVVDOU1HRXBFVnBVNkYvWldi?=
 =?utf-8?B?Nm1jUWJ1ZTNOcHMyQ1ltbXRlQlYyc3I4ZkZPZkJ6bndsTEwwbjlyNVJYbERL?=
 =?utf-8?B?eWJtcU4xcVRBT2dVTVZSNjJTZTh0SGpNL0xHMmY4N29vS0ViWXp0eUt3TUhn?=
 =?utf-8?B?ZnBTUU1zYkhrdVUwQnJ2WERSeUVCNkVYN1JmS3BZNmYvdXhjR29ZQ29RQmtG?=
 =?utf-8?B?aWIwQUhjZXBocmt5WnRpc0E3cU9iTThHL0tFTE5ycllWMnh4SE9RcFdlOWRJ?=
 =?utf-8?B?dkpwZ3dhaGRBNVpZMkZQT1NkU0lOcFRUOTA2ZWQ0aVNxUDErelhWK1NTaEc4?=
 =?utf-8?B?MWgxOW5ZV2RodVEweUt6UFhqU1Flc0VPanl3V2RtWXNKQ0JJcThaOU9qMlV5?=
 =?utf-8?B?R1oyMjNFN05HbzJReUxIcCsrd3RLZ0NIK2VhaVR1MWR4aFBzNTh5ckNjcGRY?=
 =?utf-8?B?MVp1dUJPYWFiTjNuT08rUVAyd05tQmpUZDFZd1lYMWljSStUdnpTQ29UcVNJ?=
 =?utf-8?B?YitMQWVzRHltNTZaVnc2QnA1dGJLSmIwR21zY1FFeVhIVENFMjlCdFBBZ1lT?=
 =?utf-8?B?Qnd0K1VJcDBiUFp6N2svQk5XNnVhb2FhZVQ3dWNKalllem1IRExxeXk0N3pR?=
 =?utf-8?B?Q1FFYjNlUVF3UW5VYUQ1WHRBN29xWlNOMHNCZDFHMTIxcUJDNFNkejNTdStT?=
 =?utf-8?B?dEdkVWFOUHZoQit2V3ZhdHRZOWFWdEN4YUliRFJqMSszZTAzdlE2VGd0am91?=
 =?utf-8?B?Ryt4VW4xL3c2eWJJQ0JPUkFIM2VaUHFacW9FRUZxTXZtMGFZR0dza2dOc0J1?=
 =?utf-8?Q?uSEokRlrA5NJ8Otkiic9IY7Of?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35ac337-61fd-4e8a-9c78-08dab341a5c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 08:52:56.3462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSzjlRoWN73eufyNO9FEyRxUfRhlplZ4QvI49ZCld/3HcNILECOnKYpicxvYAJx6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
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

On 2022-10-21 04:36, Greg KH wrote:
> On Fri, Oct 21, 2022 at 04:24:23PM +0800, Yang Yingliang wrote:
>>
>> On 2022/10/21 13:37, Greg KH wrote:
>>> On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
>>>> On 2022-10-20 22:20, Yang Yingliang wrote:
>>>>> The previous discussion link:
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F0db486eb-6927-927e-3629-958f8f211194%40huawei.com%2FT%2F&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7Ca8206f9348e04b13e3da08dab33f4f53%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019381738406942%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=HqvF1p4ejF6%2BYS5u0pe15ZdDgUAIVP%2BB1xQXICWjNwY%3D&amp;reserved=0
>>>> The very first discussion on this was here:
>>>>
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Fdri-devel%2Fmsg368077.html&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7Ca8206f9348e04b13e3da08dab33f4f53%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019381738406942%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=LmRgWUSQgK6wJvMdfBgjO4CiaKQ2TBoeW836r0UbcjU%3D&amp;reserved=0
>>>>
>>>> Please use this link, and not the that one up there you which quoted above,
>>>> and whose commit description is taken verbatim from the this link.
>>>>
>>>>> kset_register() is currently used in some places without calling
>>>>> kset_put() in error path, because the callers think it should be
>>>>> kset internal thing to do, but the driver core can not know what
>>>>> caller doing with that memory at times. The memory could be freed
>>>>> both in kset_put() and error path of caller, if it is called in
>>>>> kset_register().
>>>> As I explained in the link above, the reason there's
>>>> a memory leak is that one cannot call kset_register() without
>>>> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
>>>> in this case, i.e. kset_register() fails with -EINVAL.
>>>>
>>>> Thus, the most common usage is something like this:
>>>>
>>>> 	kobj_set_name(&kset->kobj, format, ...);
>>>> 	kset->kobj.kset = parent_kset;
>>>> 	kset->kobj.ktype = ktype;
>>>> 	res = kset_register(kset);
>>>>
>>>> So, what is being leaked, is the memory allocated in kobj_set_name(),
>>>> by the common idiom shown above. This needs to be mentioned in
>>>> the documentation, at least, in case, in the future this is absolved
>>>> in kset_register() redesign, etc.
>>> Based on this, can kset_register() just clean up from itself when an
>>> error happens?  Ideally that would be the case, as the odds of a kset
>>> being embedded in a larger structure is probably slim, but we would have
>>> to search the tree to make sure.
>> I have search the whole tree, the kset used in bus_register() - patch #3,
>> kset_create_and_add() - patch #4
>> __class_register() - patch #5,  fw_cfg_build_symlink() - patch #6 and
>> amdgpu_discovery.c - patch #10
>> is embedded in a larger structure. In these cases, we can not call
>> kset_put() in error path in kset_register()
> 
> Yes you can as the kobject in the kset should NOT be controling the
> lifespan of those larger objects.
> 
> If it is, please point out the call chain here as I don't think that
> should be possible.

WLOG, I believe it is something like this:

	x = kzalloc();

	kobject_set_name(&x->kset.kobj, format, ...);
	x->kset.kobj.kset = parent_kset;
	x->kset.kobj.ktype = this_ktype;  /* this has a .release which frees x */
	res = kset_register(&x->kset);
	if (res) {
		kset_put(&x->kset);       /* calls this_ktype->release() which frees x */ 
		kfree(x);                 /* <-- double free */
	}

And since kref is set to 1, in kset_register(), then we'd double free.
This is why I don't have kset_put() in that error path in amdgpu.

Regards,
Luben
