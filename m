Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069BF606F71
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 07:31:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MttNf5r6Vz3f1F
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 16:30:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666330258;
	bh=c1p/x8XJ+Q362Wu9z4oBoXAVVel641qCZMxeygRMU98=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cD7dkhwBdWLPLsmFGB+yG/nvWdQvSzOYtRIBfhDJV49AnENp8qCzYMUnQ4PpVAFkg
	 xXsGrwVe4Nw7qX7D5gCTCWmHGr74s0isRiIrx+si2P+36hFSH8FJsM3M6MWvWqUnIi
	 SOZglqwVdhf/8tbXhwyvSEvpEQou/CV2B/zkpSN8urY2/YbMKVq6PmNoqXOd/LRGt4
	 HJEcpQKibKIo1cB0yqcBRV8CAyyPiBtgxm+OeG2gj/tcp7DCYm4gbYZKr+3GR/JbsH
	 T9sHyqEPHrHT0NA10mqE6woKoY8JSRIAAuxfj//K9EmMbQYva4e3ixw4Ec3kkM5Zip
	 GPL1aHqRJTPmQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=40.107.220.58; helo=nam11-co1-obe.outbound.protection.outlook.com; envelope-from=luben.tuikov@amd.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5qc34ng+;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MttMV3hTbz3f3y
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 16:29:55 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cvqp3P3B8BLfAmpNZxHvh7i9DBRLxrF0L/Puf+VClskgfrGn6tLUXXdLD+sHtspD2l57WBbG2sjZXzUG6eiPg0fU4jRvyKPxdOw6GkssGXnsjsRrL9aZ4M6qGsrWDrN1J4VAE6nd64uj3ZIumGRMhdXMHTT8uIvxSkcOO6Hac8nLvgmtOx/DEf2WEwHPE4xZEhCUfM3uvaVO0tPrVnmu3szQEJAv0N6hVRs38BgnAA30Xd1hhOrzqwbj2MD4CZ06cYwpIMSiJRVJouM1O2UVPuLKefpkM8lBbJMVqnzgbK2k+ke7+RkXiWWZD0mY1Y291mXuICqnfv9gfQIbujqbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1p/x8XJ+Q362Wu9z4oBoXAVVel641qCZMxeygRMU98=;
 b=mbQtjLOiAVIvijp3wfz9SNisohTWlTmCr+CaK2KbmRjNdggP7RN6VTe5KnTkk3Q9Na6J5WGrNntWGz4iFlAdTMFNvzSqkcdP9ZPwkWnjTj1xTOFM6DZFwrmpDiciNvlWtEe5G2CrwXG/CXWKYfQvvbSCnquY2VQwKNElLbwaxWx7z9QCaZJ9u2TgxZjwmijEoVfBoHs/zURaraT/erHU4XTzMVCZmpGB99rKRz46qwgCjnPjBcOX6xJ9yjY/Lqy1aa1bKS/Lw55thpRJ+fwE7RCFoyPVRWpJ/+S9+ijFYIAGBptPbVSpVkEzPGOqPBmpdfrPU7CX0x/BOhpPyfKppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Fri, 21 Oct 2022 05:29:35 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 05:29:34 +0000
Message-ID: <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com>
Date: Fri, 21 Oct 2022 01:29:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
Content-Language: en-CA
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
In-Reply-To: <20221021022102.2231464-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::11) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: c28566e1-cfbf-4438-67ea-08dab3253d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	mjWTlJ3Cv2/NULzy2Tc/vPlmV1pquOu9JJpHuBRHadPSWO9WG7mI5LRewAMLLM8Fwbt1IwxsJ7d63QBVd5/QMJ3xzdznICvg0MENoiuIBR3+FzawRsnpGezkk4+BDlVtwb6DSxRHE/QpV50QTyd2hHXLtU1Csld2td4wd+GPY1okb4Xj9sPSOc2hcU8WfdSxMG0blhkkjv4xMMnQZhT3pd04DroIdsH6NEQ51ibKfXcoDQbTQPfB6D/y7ZcI2oAiCjM5RIWLL2F1O8ouOBUvcHO5tb1FmYOx9osZXajXC9YtuVC3l/t9RJR9q/KhdXhMtzovyBRvvENKYIakR/j4pbZ2RdCZ9HWAmX8M/AS7VT1kVK2RAjVgOuhkQvbSWj8Qk69i0yXXZCTtTvgllUCwsVDK9+nSjtH9QUCeCuOf6aBMInSjslizYFzHulVZTBkQ0sE3uYM6utUh7+n0aNFpJs2STvSt2DCzBuxmr8ZzWCUzrK6UKK6hs3x1umkdWfFWf1EZXe2o7/jqKD7QbfZAqiTPPnqjC7Iq/HihwxIIl7UNTDXa+5ABMBvvYF6bW2pHRJG9xh48T02IyyZxcDZhlHhQA9J8/yuyNMauyQujmbyy8wgkeZP45quE09aJFQ05NkRWHDCsGkCuj+/2h0ZZEClofr5LSPMAtmWB9Zmyvm9e4uLF89Rr/Y8++k+fZ6AAxKJZBu/oL5AxjrG5kwMwU+3hiI2dAkPx2iwpnjrFEF71UrWU6F9cyzMY82azhObAQR8/BVRhj3wuICFWEWTQRhmGT7zJh/Iu0btVUHwtzyBzklJg9/atoyu9ZsWBhTfiHBZAC/IQVEtqF5f5NfajGw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(36756003)(31686004)(31696002)(86362001)(5660300002)(7416002)(38100700002)(4001150100001)(44832011)(26005)(41300700001)(2906002)(2616005)(83380400001)(186003)(316002)(6512007)(4326008)(6506007)(53546011)(478600001)(6666004)(66556008)(66946007)(66476007)(8936002)(966005)(8676002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?Wmw5T0xrR2xpTTQ4ZjNDOWYzeWgrNkovb3dEdlNNNXFOeXhLejVqc3duRkdU?=
 =?utf-8?B?blFLY1VEa21IMEhlOHdTNGFJeHo1bzZQT3cvYW8waHJyUmFBS21NVGVNT0F4?=
 =?utf-8?B?WVZRUjU3UXBUaTZ1MUlJQ3pSekhkTVVhR1hRUTJqQmJkM2VYWVVQWGYwMzhS?=
 =?utf-8?B?VEc4SVJxcTg4aWZ3UGdrN2J3T3YwWUdacThiUW1kbjlXd3hEZEh4T3ZqU1Js?=
 =?utf-8?B?a21QOWNkZXNFVk9JQklVRXJ1TDhPVGJ3NzE1UUhXaGE1MnlBYVpubERPUDdh?=
 =?utf-8?B?K3J2eUl1WWNjc2NyK1RvdWI0NDRCM3M0eVVkWHhLODFnMFE5NUh6SUI5Tzl4?=
 =?utf-8?B?cG5tVXZHbmpqQnU0dVp3L2RMRWpWL0NHOHcrRHV5Q21HWmFsQkFzYlExaGJp?=
 =?utf-8?B?dlowS1Z2ZktlOUMyMzEwdGR5bDJ6ak9IR1JQRTQ4M0F1em95a25lRHZSUGwy?=
 =?utf-8?B?Z3MzcHIzbFd2WUlqcm00WGFVOURDYUNjQWFlVGxUd2x4ZDNjdE9LSUpTVGtX?=
 =?utf-8?B?VDFNK1hCYlQydGd0c2grYVUzVHFiWHBxdmpEQ2xSKzE5YjI5aHd2aE90ZjNF?=
 =?utf-8?B?cnVxcGFLb21weGY0MmtyRVBWZmJYM05JaERTektIaHE0MmVqbklpbDVjdk04?=
 =?utf-8?B?Zkw1bXJWeWdTdEgzMVJRNU5NKzlpMlBsTlZURkQxME5lcVUvRkUxYS9MVDZ1?=
 =?utf-8?B?ZDBYNDBYQ1VuV0NuOThOZ0hzL0Y1dFltUG1PYitXbkZ2Q0hqM09ydktpd1lm?=
 =?utf-8?B?cG00SzVTeDJTWWk5MVZnUTVoaC80cCtUMFQxUjJWWFdwRjdsdHhlVlFCT2JH?=
 =?utf-8?B?YzBYTXJzSXozNitJck1IQkZqeFdWQjBvajNLYUFjditESDcya3hwd2MzUkE3?=
 =?utf-8?B?WGVmLzkxNnNZNFFPVkRYS2RZYmxEN0NKcC82ZmhUdGNSVnc1TDFtQnJvZ1RI?=
 =?utf-8?B?OEJ0M3Q1bTNlenBxSm1NRHhKQmdKNjFkYXp2eU5GeVI3VDJIYVB0SGZOODYv?=
 =?utf-8?B?aTlnSURSVmp4YW9pRkh6RlkxZG9Fb2FKM254NkJjK1F3SnNHaU9Ibi9HTTYx?=
 =?utf-8?B?TDlKY1Zvb1dESnJ6ZXliR1hLSTQ5NHo1RUNZOGFpZk9OQitWNFF1K2JhcHhv?=
 =?utf-8?B?MVBwNE9lRmdsMHB6VlJ2b0xaR3VQK0owZzF4WWJkQ05zaEF2L1V0ZVpKSWN6?=
 =?utf-8?B?bzFQOXh2MUFQZDBGNHBKVXRyZm42WnR5a3RaVHZCL1pabzVIb2I0OFhBTlVs?=
 =?utf-8?B?UmY3RmdDcjN5SnFyU3BwRmJhcFUrNFppbDduL01RZFZRVDZFV2JPRXdic1Bl?=
 =?utf-8?B?aU54c0huUDJrMWxkRmhUdVcwT1h3V0ZaMGJQS0pyb2FyWlBFMXZlVWc4SWNN?=
 =?utf-8?B?ek9TYmJjZ0srZUZvOTF5MUdzeGk3eEZCaWp1aXBIaGJPMzJMcmU5K2Qrb2I5?=
 =?utf-8?B?RThpNjdEZCtHQ2pDTUxQOGgvSGZOamMxWU1LNFJrQVo2TzZ2cWJqQlhmUnRj?=
 =?utf-8?B?Si9vVTkwdzU0dnFzUld5RHdLS25yMEJ4ZWN3T2wzeVQ1Y1MrRWVER1BrOWJM?=
 =?utf-8?B?cjdGdHBVcGpVdzlLZmptQUZSZ05WS3FwdERVckNVQWxHRDZudjYrK0NwcHRp?=
 =?utf-8?B?c0ZpTVM4eTIyOHUzbmV4M1g1Zlo1QjFvb1ZPVjZCNmNqaXhSdVJzMVhZMTJ2?=
 =?utf-8?B?b0xRdXpKOGVBcGlJelA5Y3UzQ3hNcWJ5SnkyRUUxa3RPUlZQQ0hkb0c4M05T?=
 =?utf-8?B?NHJiQVF6bnhBbmpKSkZDaUZSSFhCdk5XR3orVFphVlhVZHdNZ2F3Q1dZNDBo?=
 =?utf-8?B?c3pFMEVtaldJbGZmakFLSGUxWHFmV01XWUpBSklPWC9XUklVUVpGcXI5ZzBT?=
 =?utf-8?B?VE1tdzlzLyttQllkRVB0aFBIbWFOMnZ4QkJaaVltajdMdW56Z1o0MDhBQjNh?=
 =?utf-8?B?ZWFQWXdmL3RrVkpYeThFYzgxb2FBQmJqbFRUbXRoQlAyN3pqNmxUMUcvcTFZ?=
 =?utf-8?B?YTZvQkQ1alFaUnRBOEJJWmh0VTlWRndCVVM5eDIrUXc5aHhRbjdrVWhDUlhB?=
 =?utf-8?B?Tjh5NWJ3M3krOXRIWGhmM24ybzZWZjFLdGt4RkxsK3VsSHFOMXlHZUZqZktp?=
 =?utf-8?Q?3UzzgtirfBpiDA4Ptxkl45avu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28566e1-cfbf-4438-67ea-08dab3253d04
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 05:29:34.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hbu/u6glgoW0HucQLPGQd6k/0y2eEgO7DiDM7flyTq6Wd4We8kaohSkQXEa+eJKK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796
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
Cc: alexander.deucher@amd.com, richard@nod.at, mst@redhat.com, gregkh@linuxfoundation.org, somlo@cmu.edu, huangjianan@oppo.com, liushixin2@huawei.com, joseph.qi@linux.alibaba.com, jlbec@evilplan.org, hsiangkao@linux.alibaba.com, rafael@kernel.org, jaegeuk@kernel.org, akpm@linux-foundation.org, mark@fasheh.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022-10-20 22:20, Yang Yingliang wrote:
> The previous discussion link:
> https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/

The very first discussion on this was here:

https://www.spinics.net/lists/dri-devel/msg368077.html

Please use this link, and not the that one up there you which quoted above,
and whose commit description is taken verbatim from the this link.

> 
> kset_register() is currently used in some places without calling
> kset_put() in error path, because the callers think it should be
> kset internal thing to do, but the driver core can not know what
> caller doing with that memory at times. The memory could be freed
> both in kset_put() and error path of caller, if it is called in
> kset_register().

As I explained in the link above, the reason there's
a memory leak is that one cannot call kset_register() without
the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
in this case, i.e. kset_register() fails with -EINVAL.

Thus, the most common usage is something like this:

	kobj_set_name(&kset->kobj, format, ...);
	kset->kobj.kset = parent_kset;
	kset->kobj.ktype = ktype;
	res = kset_register(kset);

So, what is being leaked, is the memory allocated in kobj_set_name(),
by the common idiom shown above. This needs to be mentioned in
the documentation, at least, in case, in the future this is absolved
in kset_register() redesign, etc.

Regards,
Luben

> 
> So make the function documentation more explicit about calling
> kset_put() in the error path of caller first, so that people
> have a chance to know what to do here, then fixes this leaks
> by calling kset_put() from callers.
> 
> Liu Shixin (1):
>   ubifs: Fix memory leak in ubifs_sysfs_init()
> 
> Yang Yingliang (10):
>   kset: fix documentation for kset_register()
>   kset: add null pointer check in kset_put()
>   bus: fix possible memory leak in bus_register()
>   kobject: fix possible memory leak in kset_create_and_add()
>   class: fix possible memory leak in __class_register()
>   firmware: qemu_fw_cfg: fix possible memory leak in
>     fw_cfg_build_symlink()
>   f2fs: fix possible memory leak in f2fs_init_sysfs()
>   erofs: fix possible memory leak in erofs_init_sysfs()
>   ocfs2: possible memory leak in mlog_sys_init()
>   drm/amdgpu/discovery: fix possible memory leak
> 
>  drivers/base/bus.c                            | 4 +++-
>  drivers/base/class.c                          | 6 ++++++
>  drivers/firmware/qemu_fw_cfg.c                | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++--
>  fs/erofs/sysfs.c                              | 4 +++-
>  fs/f2fs/sysfs.c                               | 4 +++-
>  fs/ocfs2/cluster/masklog.c                    | 7 ++++++-
>  fs/ubifs/sysfs.c                              | 2 ++
>  include/linux/kobject.h                       | 3 ++-
>  lib/kobject.c                                 | 5 ++++-
>  10 files changed, 33 insertions(+), 9 deletions(-)
> 
