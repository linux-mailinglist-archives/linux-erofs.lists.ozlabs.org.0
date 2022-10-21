Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79B5606F7C
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 07:34:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MttT13TMXz3c9p
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 16:34:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666330485;
	bh=9kswLU+QXVjGel8efLF/xe4ADNltyaBWMDBUjsYNU08=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SpzZEc4H3Fmso6dLG4zArRjQYLCbIWgJCktPtuGBaj6zGNNptXwQzpjzUWLjDEHVG
	 IbeqzQ+XGwwSceAVwCGfJDheMLHDD81OGHMwCiYBerqg6Uapl4i8JQD6gMoks886XM
	 UF32hLyAE2Fr0OmNpuJxEqYOB9QiPYwqWUU0I0c83MSxDXrKzHcsX3cUKkwGzA9QRa
	 4qL+wlZlSfH1Gvr6qhMbp+k4BnNRjY8eOEXtYKQMu3mcwvKNjWbpu2sy46lyWiBvMK
	 eUnkh+/D41W2QbNgBr5KSqhq8Hw0T/qp8DKwBESuBIOpsTQVyOdSwedoufrePEr9hA
	 3faepDKfZi//g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=40.107.220.40; helo=nam11-co1-obe.outbound.protection.outlook.com; envelope-from=luben.tuikov@amd.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WJ0jQImW;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MttSy2lY1z2xGq
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 16:34:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiBPhBQ2nOXbUFCs7D5HGwyluye/fUQqBA5PvYJzQia3laq2GSwSgX9uKFeQmE2Z4eUmTR+WA4i0N/txe5YgN3ABkzYz5gp86j/g1VC4gxLdBePTAVcv6h2eoXwjEk/Z2UwwG9PzgDziyphoQXTibIpcqDdCfUWYUpLur1XLIi3C62H7VC2maEJ2EaAJDCqBR04PR/xzzyQv7PotlEcXukxbUipM9gP4/UK99wm0DTfj4xGuMfCymQPbp9lnmAthbaeLUcr/xCtkc33CLVo6u7iZL+2PjaNJeIzZ8zjDvoBOz1S8Xt1Gx2lPsczbo7VId3dwy7bR5cDKXeZ7hcjJYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kswLU+QXVjGel8efLF/xe4ADNltyaBWMDBUjsYNU08=;
 b=ls2NCoToUapn5syZLlITC1Q92jhiM1KsupxiqT6XAiM7y47WnLbE0CKGDSfmkO0qbBxKmfhpi62BPt0BiEtdv5MJlQNTWQth5eSDb2gAyg8sVAxCEgsMYFG8ZQmye7JuxL3SFQIfwIdcsJ5mnq4MahSkP3YL3JWhnwMcrsdPiWtXy/HNKcqFOL+zn/e0TwfqwcnUN5I1abLk5sqMZZsSM08QCwI2qS40i37LMn9IP/aZCB0i3EeS/g6x/RX/28F8J1XKhmnzKioqik+tg6o75m2OismFj5WF/WFIxQfJvnW8kDyDmcyeYJ+2ump0V5CCGVIj9YtUOjMEToC69+aZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Fri, 21 Oct 2022 05:34:20 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 05:34:20 +0000
Message-ID: <eb0f1459-7980-4a7b-58f9-652eeccc357e@amd.com>
Date: Fri, 21 Oct 2022 01:34:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 01/11] kset: fix documentation for kset_register()
Content-Language: en-CA
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <20221021022102.2231464-2-yangyingliang@huawei.com>
In-Reply-To: <20221021022102.2231464-2-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::7) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: a9491d3e-ef28-48f9-3113-08dab325e753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	XB5kmHg66LbsiNDVHYvX4BkXOvPZMSQENQW2K0Ywy67IaMYSlA9fdZfyzQiqQ7UvWfVNQprVMrRDBSlE1nrQD+T0HPOwNqlVyQ2eknHecE3s6m5ZpvE9y5gOzc+6ncEOGp0RviEYzkDCvrDnLVSzuhjiSBRr3gFKOQ+ZD4S4UNDDXICZC1jN02ICapAkYGmagRK3qcYt5j+IRMmjpGE7v5Y5gwtwOxkrlD8UYhKpD3Phq1KPzHsbtj/9hZFV7SAEEMu+xXNraJavmY6cQ+Rc12QPY1X388Ohu8C+8IK0y8T9A7JNOZm3q7kZ/uo4P/v6DK0cQBSJ9ga3o3wZLOjfHjkudSK4tu726VjbUJdax992742RCHna5ZqQ+S0DnNxd7REGBQxITGyiwBLttgqRlziPDKsfLBzNPfK07+XMFWiepmJXxfsEU7gFyRkrjkj8LbQ5QNZqYPcCcemjusVgIlvGap0Jqz2QqnT0hIP3hAlV1vUIajOB/p23IqfBE8QrD8chd22+QqCdV3/TfKT6q4Utt90XAlS1/V0Q4orpxZZm8D2DG75dFq8Jc9EQVgXDlzJK3xaCzvh8Vs4HWSTc8MkzlfYIHAy0RW05nOxpfVCHy/Qw0Ky5QCp5dA6aUKynRLizYW56+e100DoI5shkfCQj6uE9yMXoCsXM9CFqghKCpFgNrlrPHVkqkz7M2mGX+b2CCVp0TFSi6eZVT7UkmTQCaNAN+ZzAjZedGcmkGpQj3k/RTrZahFTBmWKEMv/7wJ0FQ+2dYZMmP9bfQ9djEqewnp+SeXFxKKGApaGPyVg=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(36756003)(31686004)(31696002)(86362001)(5660300002)(7416002)(38100700002)(4001150100001)(44832011)(26005)(41300700001)(2906002)(2616005)(186003)(316002)(6512007)(4326008)(6506007)(53546011)(478600001)(6666004)(66556008)(66946007)(66476007)(8936002)(8676002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?WU9MZW5zNG0wTEJDR3AwL3Fzd0YvdEs5c1JVUzBsMHlUZFAwL2F0TTQrV291?=
 =?utf-8?B?eXBZb0wyNVVOMmdIazlZMkxtUnhMeW16WjZJaE03RmFtZUhLbUV0UzFqREpO?=
 =?utf-8?B?SktyR2liUDhLTTM1WC9Od0RTQzZwaDAxUzA3VmQyZDRSTmREcmVHSFRHVVhJ?=
 =?utf-8?B?QURCOXJPNnc5bDdmeEtjbnk2QkJqWllLSWhjVCs2SDB2ZERqRGtzeXFhVE50?=
 =?utf-8?B?QWtoS09FejdvZ2kxQ3Q3cDZGRkZLZ3FrR0NKd0NFSkhSczltRVQvb1FkSUp1?=
 =?utf-8?B?YllTV1dnRFpFTldYeElTOTIyTHQrTzBJdjNEU2dHdSt0cHB1S0xzMFJJOWNz?=
 =?utf-8?B?aE5oVHRUODZLUWRWQmtlL2dOS0wzWE8waUljS3dTVVp0Z3ZwMDdBV3daRTA4?=
 =?utf-8?B?MXVQc29DQThiOUZqVnN4bWF1YTloMEY5RExENDF4U1lWbDdXMTd2UTBBU2di?=
 =?utf-8?B?VjlnZS9PMElWNXJVeUd4TEZHUmxUN3FkYXpaRTR1YWVqZ3pQSVcyWElwbFpu?=
 =?utf-8?B?dXVhS2pNYzR3bWdsY0JGckMzdlFSdGpoai92Y1RPZVQ3bUVCZE5HbVlEVkFh?=
 =?utf-8?B?M3YyeWxDemwxamhEdFpXb3J0M3p5b2x0bEdNVXBiL0hIR1ROWm11alFEbUZM?=
 =?utf-8?B?ZVlPTE1xVnBGdmFxdUljZm14MkFLTmpDTGs0ZHlwUUYzZTRTcUR6dzVPMUdj?=
 =?utf-8?B?eVBXcUo5b1JOTXVRNzlqR0hkc1VrdUxxRnQ1SSt6VUVCRXJZTml4eitqU3VF?=
 =?utf-8?B?YjhlMkN5ZWJidVo4Zld2SDExSDFLNzIxVStDeW84NUtycFBrQ1JwTGpsQmUx?=
 =?utf-8?B?VXFpR3pHY08yVXQ5cEhZVWlqV1dZTFdHTm5qOC9sc1VxeVU4QkpZNEpYcS9W?=
 =?utf-8?B?ZWVlUmxKQkdPenhDMVUvL01uaWgzc3EzUHFRUmdkNW1ZSFdWZ2RFMHNKcXZr?=
 =?utf-8?B?UklrOHh0VmEwYkdCM21lemRBVXc1U1FWZFlGVTVud3EzYnJUejRRT0Qwem5y?=
 =?utf-8?B?c09lNHphdEhvdUNUWWlIMytXekROUFBIV0ljM1FRMk1ZbDk0V1NVKzhLR0ZM?=
 =?utf-8?B?SEdSaXNmTSsxTEdIR3NZUURZVnBwSVZpVjd5TUVxUVBoMEM2M3BjekZZMG1F?=
 =?utf-8?B?d1pSS2E1MlZNMXNzbkhlQUFVQVh2Q1VncnNmRHRuNVhzOWtDcEthSjltbGtO?=
 =?utf-8?B?dGdzaFNxWi9ITXZKb3ZSbExLNnlsN280V0NVeFZWNHlGZlpTV251OXRxMEFB?=
 =?utf-8?B?Yi9wZWJIT0k0ekY1dncvYWxPWkUwU3owL0JsRnUwNjZqYmJjY29MZStHVitL?=
 =?utf-8?B?RHlhTmZ5TitTcWdsQkplcGJCZjNTTSt3QW5zcVhpUENKMDNpcG5YOXNUNFFT?=
 =?utf-8?B?N3BJckNGVk05OXhHUzVqVDQ4YnV1Zys4SktvbTBCcFIva2RjeEw2RytkRVdS?=
 =?utf-8?B?NUVrZnlVRmk1MjFpSmtrdHlNNEVuTWRWNDFhQlhBZzN0N1psaVgybDA2RWd2?=
 =?utf-8?B?TkFjcHFxMlp4dyswZEprdUMzRlY1OURLWWNFSTlGemJSWUlEd25ZMFpNSjlY?=
 =?utf-8?B?TjV2UnY3WEhCNks5eFVOZlFqbE1VS0dnK0hqNld6K3ZwT3RSeGkrUE12czdO?=
 =?utf-8?B?RDE4TVk1RVZPYWRXTzUzcVptR2pnamtZb3dndkM3WXc0b280VmwyK2VlWENP?=
 =?utf-8?B?WlZTRFVlVGl2WlcrZDZIcFhiQzNReVd0Rk1jbml1WkdRbGFUTmVOckd5MGxr?=
 =?utf-8?B?QktnQXFIZVdGaGhxVVBrNml6cDhzbEd3dWp2eDljMGhRcFBsbDhXUXYrZEJj?=
 =?utf-8?B?ZzQwL0VpcVVwQUJGU0crN09EdEtYd3FIYXlkZmEzTExXWFpmY2d2Z2RMc3gx?=
 =?utf-8?B?S0Rrc1JteUZKTlVNa2hjRmhQUkw2RW5KWXIrYTBraFVLTE5aWkxYL05tNzg2?=
 =?utf-8?B?SVhubjBCYWNtK1I2aE14blBsc0FkRlBRTHJaUm5jMG9EVXhIcHB5NVlNWERq?=
 =?utf-8?B?VXhibDlPOW1Wby8wajBGSGNxcjBHSEpPRmN3dksxd3FVRU1EV2xFVURLUk5l?=
 =?utf-8?B?aGtybmJjajVmYjdQQTBYLzFXcUtDN3lzcWN3U0VxTVIrQlVxeFE5VWV0SXlM?=
 =?utf-8?Q?ktrLQnaJ7A6j7KaUaHQbK4eVE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9491d3e-ef28-48f9-3113-08dab325e753
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 05:34:20.4840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgM7bHitqJbwFff0I0CDSiuhgmDyEAiTYxABfres5w6+GwGkXJ2liUUMwrvM60Rp
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
> kset_register() is currently used in some places without calling
> kset_put() in error path, because the callers think it should be
> kset internal thing to do, but the driver core can not know what
> caller doing with that memory at times. The memory could be freed
> both in kset_put() and error path of caller, if it is called in
> kset_register().
> 
> So make the function documentation more explicit about calling
> kset_put() in the error path of caller.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  lib/kobject.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index a0b2dbfcfa23..6da04353d974 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -834,6 +834,9 @@ EXPORT_SYMBOL_GPL(kobj_sysfs_ops);
>  /**
>   * kset_register() - Initialize and add a kset.
>   * @k: kset.
> + *
> + * If this function returns an error, kset_put() must be called to
> + * properly clean up the memory associated with the object.
>   */

And I'd continue the sentence, with " ... with the object,
for instance the memory for the kset.kobj.name when kobj_set_name(&kset.kobj, format, ...)
was called before calling kset_register()."

This makes it clear what we want to make sure is freed, in case of an early error
from kset_register().

Regards,
Luben

>  int kset_register(struct kset *k)
>  {
