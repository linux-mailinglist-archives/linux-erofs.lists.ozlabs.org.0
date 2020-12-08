Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D3B2D2BB0
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 14:12:31 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cr0vw3PmpzDqPm
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 00:12:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.54;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=L1XDWit2; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320054.outbound.protection.outlook.com [40.107.132.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cr0s71qDqzDqZF
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 00:10:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ymm5A/Ztn4CjpILWlT+z97o3pOOYeadeygfr/ZT/6+mKry4CHnXyV0wVgkTGkMF8WkthazFsvs7i3zgRCliMgt9sVaXPDBhZKCITrt2011oMr8YU43Yz/kTAD/lsxcpdkN/Qbk3DJG+r7wuqzfoxeUy6GbtumLsVJ4F2UpqAYYhHZukh+MvHM2QWX1FGoGrcog5mA6X27l0w9sEvT5TOKzHfn/fF3ElD57HWjIJTYx3g6EF1cQL3t1mp8gAeL0ogJ/tBTd1iZVqbO+YNOJEdmQ2JOlyFgDLFMu3IsIQfoe6Yeh36m36O3e8Py6isnD5TnycUjnmZjCNdsflwRBqoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEdH82tC5BoXAnZQbGFuljsI9EpliINyowZmm3340V4=;
 b=jcIbDpw7kWJH7cik4ZKnI/9gMXZw/tu5CCWcOta4hrPgH4+MqAqTQ+xvM9gRPpmArrW8gl6YxSB2atKiUKn+YFG8jGRj1wiHGirRMiSVdRm/2Cp8xrmuZdDrRLMCtKmuanrYbzoDqNIuq0YjsMLFlUmcvndE2ibvSphrg3wQJ3rgBqnJORIkQLeLSOGzbNIc8wq61NL8wYeiw3XvLJ8DyV7rm++gefBmQDRu90x0sxcX9X5XsWiDb1v/UU8oK1uZrouTiY39DA+sw8oxorCEGK1aJ/rwnmoC5uQYFDWs2lJ+UwXrXkY/jZu2NX4ndvPLPUlQzO7g3zkbDC85hiMdrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEdH82tC5BoXAnZQbGFuljsI9EpliINyowZmm3340V4=;
 b=L1XDWit2QFbM28Rso/CsV61BRZ7jovDcUlOk6woP0f9vCFc0+w0g3Azjz2NacrK0XXclkBEQSfPgkfEPg5H1Vqb6Vlmh3ep35BYdGMyYVVeson43arv07mPzEVhMLTaA3LL6IVFTA1XLtHI+c/frKitzhRm8AcBmtQrczfoOX6A=
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3273.apcprd02.prod.outlook.com (2603:1096:4:48::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Tue, 8 Dec 2020 13:09:47 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 13:09:47 +0000
Subject: Re: [PATCH v2] erofs: fix wrong address in erofs_get_block
To: Gao Xiang <hsiangkao@redhat.com>
References: <20201208093133.5865-1-huangjianan@oppo.com>
 <9fb238a9-ad1e-cf7b-7b42-291e5f0e8929@huawei.com>
 <20201208103535.GA3139231@xiangao.remote.csb>
From: Huang Jianan <huangjianan@oppo.com>
Message-ID: <9a969b71-cea1-452e-dd97-75406e490973@oppo.com>
Date: Tue, 8 Dec 2020 21:09:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20201208103535.GA3139231@xiangao.remote.csb>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.252.5.72) by
 HK2PR02CA0142.apcprd02.prod.outlook.com (2603:1096:202:16::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 13:09:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ca3351c-30b2-448f-c435-08d89b7a89a5
X-MS-TrafficTypeDiagnostic: SG2PR02MB3273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3273D4861B8758A0754CF346C3CD0@SG2PR02MB3273.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRx1puhVyfhuwOOBhj0VncKpfdhNMQL2FVVoa9iWh6kZ7HcgB6+U7K9ZV00o9coPdh1X6bZ7pyS+AcucbbSbsHvFum1WtmasV0BglU8zdxMQ1BHHlCiZk9O9tfKKpPXzz5YdB7plFQ+tAHfAt+x8nuk5O3NF0sDamoOLI1kCEwsiP2jWaPbThpte9QllwkDF1yFKnR3EWvcYyavE0NaztCIwUYMCZXd5Ti6rREbvz0ihV99uUAL1D+uweAOAxIuP9/3lgl2b8nT9WTDLTthMo1MZhR1LgOcQVvnpNfNfet0qf+xnh9mcUZyQvOLeXuFk5Cpc/NHUZWKvgwj+Pcn+TumW7ZLx8y65jNqTp0LhieNI/xYkQazlyCGWvnSYEtjd0twComPJ6OhbRciOzHfFAUHx4qVUb/fiu8CSLXlX52sSqzIO0TDjMue4vftfdr10hUxA7z1RJRDpVvCD/PUDxXFL4/mTjK0vyZASHAd5JUq4wGTZ5/Ue+0UYPi4OK4JdyWGFeCjtAMnPqiPIHxjrpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(4744005)(31696002)(6666004)(5660300002)(2616005)(8936002)(478600001)(66556008)(36756003)(4326008)(8676002)(66476007)(66946007)(2906002)(86362001)(16526019)(956004)(186003)(26005)(6486002)(53546011)(52116002)(966005)(16576012)(83380400001)(107886003)(31686004)(6916009)(316002)(11606006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Vkk2ckJsejRLa3d5dG9CeFdWUGVsK1o3QXQwREtlQnU0R2xkanlCTDdmWWpS?=
 =?utf-8?B?VDVKcm9ZUVVlVUtpVUFrOFMvcVZJaGtvcEp1V0JiNUR5amRLOXJNMy84VFhq?=
 =?utf-8?B?R0ttcUVzbkIremltSnh2RTJteVFFaThIcHF4dFJFQ2VvSFo4b1JjTVRNVG5w?=
 =?utf-8?B?cmFSWDhEUXlaZUUzcU9LNkI1V1YzNVpmL0xtRFp3Wk9ZY0wrcWtuNjdRWFNU?=
 =?utf-8?B?bURzM2Y5c3JOTzlHdGhPZmZMOGJobThPSWRLTVRxc1JvWnBmVy82cXdIc1Qw?=
 =?utf-8?B?Z0RpQXFQdm11a2RFWVQrWW9CeU80SjhGLzBTUTU0YjlYb2dybktYTGN3UjFM?=
 =?utf-8?B?UzdsdURzWFh3dnRCWWZLWVI4QWJzNG5BdkNiYzFtNTN3VEZUTlNTYjBRN3hP?=
 =?utf-8?B?Y3k1bUYyU1IyTDMzUnlqQ3FCZjFpMUl5alk4QlMrd3Q2eFJTc3Z4OFUxS1NR?=
 =?utf-8?B?eWxNWDQ4Zlo3dVB6QVdVNUM3bktZSWF3TmhYZVdrNnQxbVh2Qkt1TXZGVjEv?=
 =?utf-8?B?VlcwMUkxUkxJWmdJUHk0cG1jMXRxT09TeEVvVlcyYU5vU1BvcXk4UXVkcHdx?=
 =?utf-8?B?R0lvc1psSklva21Cd2xMZDZMQWFab3JzckNRVDFSKzNRSGFQTm45NGNFREtx?=
 =?utf-8?B?Snh1MXVqakJ0L1hod2FSQ1BLWCtWT0p1V01EdkVYQjIxdHoxSGhUS0oyNDdM?=
 =?utf-8?B?ZHRwY3FWeExVYThrZU8rTmJJZ0JCblpYNC9DK0l0YnVRQklWbEp0VkYwMWdS?=
 =?utf-8?B?MFNyMEVlZGxqWkw1MkZoc3NHbCtDZndTdTlQbWFpNFVxUjNpRFZxM0NNUEZo?=
 =?utf-8?B?dDc0THN1MFJ0amtCRTc0UmZ6L0NOdUtBaVRiUGxHUnllS1U2bmhBYzJFcVVL?=
 =?utf-8?B?VUFOajFYUjVwTUprUE5KQ0R4MWNMOU44UmtpV1c0N3YwQWx6NlhtamVhenBk?=
 =?utf-8?B?MEtqQldqYUZoYzZsd1hQWTFzekxFN0dzVGdaTm5CSExhMEtwRUg3QXNQcklP?=
 =?utf-8?B?ZG9WUDV2SzZvbkQxQ2FJQzBuQW1laktTdGdFdGxIUTkxN0xIbWFRMGhZNHo2?=
 =?utf-8?B?eDVjNCtiVWI0WE9zQktSWVc0a3FmMjllK0QwNDV4WFQ1MXBsZWZ0ZFV2LzhS?=
 =?utf-8?B?RWdxbnVNMW5JTFVLYnNLaXlGV1E3WHdYODZVY0NtWTROL3lkbmd4bmhYYm5F?=
 =?utf-8?B?VmdSbDdjZW5sWEZmdmdLU3pKcElRY1RqUU95djRvNjhVdTduWHFuWTdqTDk2?=
 =?utf-8?B?bTViZWRFdkp1THY3M2plcVE0WG5KVnFnQVFiMERBYkU3NjZmeGZMM0lWSmtK?=
 =?utf-8?Q?f6Urf+NXgOLuo=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca3351c-30b2-448f-c435-08d89b7a89a5
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 13:09:47.2521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IivTV53aNJ5l0AF510ex1ZziRDGSJNrDbbJEQgydTx+a2a7TVRzgVRkBCJkELH4+E5/tMX3NZ7FeyP4SVHSjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3273
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
Cc: zhangshiming@oppo.com, linux-erofs@lists.ozlabs.org, guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


在 2020/12/8 18:35, Gao Xiang 写道:
> On Tue, Dec 08, 2020 at 05:48:10PM +0800, Chao Yu wrote:
>> On 2020/12/8 17:31, Huang Jianan wrote:
>>> iblock indicates the number of i_blkbits-sized blocks rather than
>>> sectors, fix it.
>>>
>>> If the data has a disk mapping, map_bh should be used to read the
>>> correct data from the device.
>> Thanks for the fix, I was misled by sector_t type...
>>
>> What about avoiding using generic_block_bmap() which uses buffer_head
>> structure, it limits mapped size to 32-bits:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=b876f4c94c3d1688edea021d45a528571499e0b9
> Also a minor thing is to Cc: LKML <linux-kernel@vger.kernel.org>
> in the next version and for all kernel patches, which is needed
> for upstreaming.
>
> (quite closing to merging window...)
>
> Thanks,
> Gao Xiang
>
>> Thanks,
Thanks, good to learn about this.
