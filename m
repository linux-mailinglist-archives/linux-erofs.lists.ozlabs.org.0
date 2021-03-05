Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8AD32E37A
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 09:15:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsLBq4VY7z30RQ
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 19:15:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614932115;
	bh=pHgO2z85fN9yTkedJMwuAXscl93bpXMoDMtvvjRG1gs=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=IWvUcvH6Wpg1ajWivZOmyVxVla5LHWV2tRy+MO8vSxLTrBsS8VXfv97h8WlumX5VG
	 JCttiDoUpAcgXaqYpeP58Bk7i4MGRqUjNjP9Gt0eMcbOYFnhll6MYPLtAqsiqv819w
	 EcCA6RTvvA1LXH4A1imwGG2eXIPwy/avTyzTxuWZNowvnpcHmE51iRjyzYw49h3UlA
	 5aMFerDADEsfuQuxjnW+qHx8AGnninGWx4hAO+T20f6OSq87B2JU5ZdrPdKJkQSfCH
	 G7oIkdFkSrkoCe08vv+t7o1azY0F1DH09QyZKWKh0nKPETJYNecU8hkigbVOPGvHB/
	 V2+D9MUu3lMSg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.57;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=ZvRU78me; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310057.outbound.protection.outlook.com [40.107.131.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsLBn5PL0z30Md
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Mar 2021 19:15:13 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QotU8QJMhfsf282U9LfZV5jtaffr2JOXQWMDZ5j7NSWSPm7rcBjzOmYjf2D7rmy3PzK+d0KS3e0YM2kAfgz87EXhJ3CXbgB9DgCaBL5UBvNb0CcG31o51IAWhnZdZ4s423Aka80Qc/BxsfvVe3FAi/AzoGStLD+8kv+1packEy3ogPNSiMoCd4Eua2xag7t4EkIolR3Se0S2yxDJwglBY7e+vPaJdwPEEV8FH3c2i+OThUOpxnnT9/G9kHX9Vd6AfX847XiHyLJ49qKqKyLdx33YYEgBqaFSoMu1vR3uqf2ptOs7Yve3sQrIYNJuFHQ1/reRbH7YG3PiEfgeKaw7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHgO2z85fN9yTkedJMwuAXscl93bpXMoDMtvvjRG1gs=;
 b=NJvo9IJzW9Z/2Zdb7eZbnr+wPMhKoY8pVK14KO76YA4e2pV5caGmoN37rYenussC4rj0NbQ8DL0BYjM8q5yuPlCzV6oDo0jueh6G9E+4RnFpIvR2DbMlYXpFxSWfAz4rM3fQdMFSQpL7z8btKQZzuG7LsO2CVhK3z6yGGCQxh7dKbQvyejetGTowenFON3Cg66vMUeqMv75mC7/pSjkS4V0dcrVIKXtqSswxLNwIN0xil6RaRS0Wa79V+FBdrdnQGPQVO6BB2MNK3gceZ9C0X759aYX0ZIs5qOXSAU7w8qEftWYMP+NrbkeOOgOMXdOfFaeapqULCOf1S/nJCYF/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2857.apcprd02.prod.outlook.com (2603:1096:4:5a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.29; Fri, 5 Mar 2021 08:15:03 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 08:15:03 +0000
Subject: Re: [PATCH v2 2/2] erofs: decompress in endio if possible
To: linux-erofs@lists.ozlabs.org
References: <20210305080803.789634-1-huangjianan@oppo.com>
 <20210305080803.789634-2-huangjianan@oppo.com>
Message-ID: <4c1defe3-b62d-5efe-be2d-9055f3b7df06@oppo.com>
Date: Fri, 5 Mar 2021 16:14:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210305080803.789634-2-huangjianan@oppo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK2PR04CA0061.apcprd04.prod.outlook.com
 (2603:1096:202:14::29) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.255.79.104) by
 HK2PR04CA0061.apcprd04.prod.outlook.com (2603:1096:202:14::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 08:15:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f602ce6-9297-44ef-8cf8-08d8dfaec6de
X-MS-TrafficTypeDiagnostic: SG2PR02MB2857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB28577BE8E47DF9AEA923F680C3969@SG2PR02MB2857.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sznuINqKJXlAMgiKSI1UCMN/KJulqsvBWQz+JIGzKh8gppYFA5rNsWkpoCErWFKrjfshSswiP9m61/BIuo9EeM8K9R0xnrWBRDYgJSR/rwu9ytjYoHVxel67aTIUFVUxvw3MCJ+GMfSsRoY5QlekNBglj/O5uj4M4KW7qYJ24lzteSZyw5MDiTAS/Yb9l46NhzAv6u0VJ6axnWOKBjEpcAEP91VthltNFEuT2vxb8UJY/CpKdwak+p0Xzl7W7DcQKDQJma4Twf/XbJ28iCz1+bicOE0ufD5Tau++qbFbLl1m1w6xHLQ89vUszWx3+IL0iOwwZUeQ+y9DuBfzIAet3J36up1s0lxngD1ecf/2IFxvIXNyduH53r1UdBRzVdycMms6G9w89T9RyK7cO7TfL3dI3bQnSYNaSK5iDDaarv3+VkIHRTzFR+97NZPYoFWcPDNWZpSWeBHGsIrunim2ft/6R+eDjNuKzDyd+wcM3JrIfxheoXW8ajI6clyj4H0jswzpiAz7wSw6d4GwsfsnpZvYUbHvD/DErhcacqfvcsNR/sXNhf3mRusVblvV/d8Z0dZmqtiZbl5l0IwgJoI/Kb4Znie2V5Pt7VXHYQFWgkw8eW9s12bTOUqTjImS74bH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(86362001)(2906002)(16526019)(6486002)(66476007)(186003)(52116002)(31686004)(8936002)(66556008)(83380400001)(53546011)(316002)(16576012)(31696002)(4326008)(5660300002)(66946007)(26005)(8676002)(36756003)(6666004)(956004)(6916009)(478600001)(2616005)(11606007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VUVoWlk4UUk5WElGNzFaSUxPZ1p3WmtocElZM0ZWNnZXdHVVNFZid04vRTlU?=
 =?utf-8?B?S2lSTlJOMXZxd0JKYzFlUmFnU1ZXRDBXVXkzdGRCQ0JnWS9wYnlJSkpwc25Z?=
 =?utf-8?B?akdPdUI2a3ZOYm9MRytTbThYcjFDTVkwcTZzSjYvaDYyV2lwOFZQZHlnbmxX?=
 =?utf-8?B?L25EQ2dmVDNZSGZ4SitQNzAyMTZaZHNMc1NGQUhZTTFlUDB6c2Z1NFpFcEpC?=
 =?utf-8?B?N0FFT01pc3VjNUxrWjIzbSs2ZERVUDVVTjJXVmkrd0h6Z3J3VVl5ZWNVVVcy?=
 =?utf-8?B?eXRVQVFqZzREU2JCd1ZRbTk5KzZ5R2tTWDVRQU11RmFDb0M1aUUzbXUvdnhh?=
 =?utf-8?B?NXplbWFPbTJWL3VTTllGYWNwcUcvd0FDNHJJWVg2Z0R3dnNCTktPMEhGekxD?=
 =?utf-8?B?NUx3WmdKSlVWdkRIcXhaV0RKdGF6RUJuZW02bjhBN0xkOEtzWWZxdVRLUkxy?=
 =?utf-8?B?Y21OV1cvcXhhV243WThGVGE2RlBuV2xsaEx3VlBxTXRGUzJaYktrR3kzQ2FO?=
 =?utf-8?B?WlNkQ2ZQZmxPRnZlNDBoNkluajNYUGxuMlZJWWdtcnJ3VWNOVmN3NnkxYTIv?=
 =?utf-8?B?T0t2MlMzNmR5STNSMTM5dXFvOWgrVG5ZV1JjS1I4eDdpRGV2NGdCTXlXdmFK?=
 =?utf-8?B?OGxQYVk4cDc0TGZpVTdmRHVEM1dndFpmSHp2a25ERER6UWhxVnl5dHdHbGVi?=
 =?utf-8?B?ampvZDI1OWRDSEtwYnlGVXF2RTBOR3NxOXNrSUtZZ2xXOEM2WkZmQWRHeTE5?=
 =?utf-8?B?RkVYVk9JRTFJcUFzVmFCdHk5VDEwU1A4TnBmbXR1R3d5Ykp6Z2dkZldWRXRw?=
 =?utf-8?B?QW83WUZRTWdaWm9DbVpZVzAzU2hWdGdWZi9NVDBxdlZJS1hFamNLUVlhUHhp?=
 =?utf-8?B?WUtCYTFQa1g0S20wU0EzVm9qejdhYTN3d3l4dXl1ZWRLaDJVeEtkUldLNHhl?=
 =?utf-8?B?NjJ6YnVpZEZKd2M2Uk5FOVJvQ0lEM0NIcDkrL2R4NUlOd1NsUFRWYTFCZk1w?=
 =?utf-8?B?cTQ2TDhQZFJvRDhUQkFUZFNnK2hCampVYzRpZTlHUUkvMVN4QnZlM3dTVENk?=
 =?utf-8?B?SmRmWldGOHFQZ21mWHVVZldWMmplWVZXeUNYQndSVHpqeUlxRzFXbUJBbW9R?=
 =?utf-8?B?NzROK0twcHovTjZ6K2tBQkhZa0RDb1U2RjgwRW4wdVZTUkVZWThoSzh4ZW5l?=
 =?utf-8?B?SXY0TVZMMkkrK2wwK3ZFRDRkMTFJMzVMWG9IeXM4a2VaeXo1ZnNicFZyc1Ex?=
 =?utf-8?B?SXVnZkQxK3c0RUdkV3RiL2I4OVBrRjNBYlRuU1J4c2N2K0E5OHptZFZialNV?=
 =?utf-8?B?N1cxU25HemUvMVNXdjhyeEtrMW9DQzVGaFAyT2lCdmFhMDVRTGpEaCt5TGda?=
 =?utf-8?B?Ym8wZG1taldHTE9zVjMrWU5kTTE1ZldwNm9ZRWZmTTdVTU1GY0ZGb0xwRzZ0?=
 =?utf-8?B?ZjIvWlpYaW5yVkpsTzBjS2VYNjcyTTNCK0NGc3p2UGRHUEc0ZkJvRW5pKzl5?=
 =?utf-8?B?cWUrU1BhVmFZQlR1OWREMUlUSlNCbjc4c0J5NjhLS3hVdVpwb3J3ZERGaTRZ?=
 =?utf-8?B?L2s2L2pnUE1vYVMvQkJSN2xxbHpNS25nUXJrUW1ra2k2azNNSTB5WjBXOTFD?=
 =?utf-8?B?MlUvbk91UEFkS0tlUXNPb1RKLzV4N2RvNGFzZVlsdXQzQjJxUFpZcnYydWI1?=
 =?utf-8?B?ZGJvR21uL3dMUEVjSC9ISUp2cVJoQTFDTUdIVzg1dzZ3SDJOWld6ZE9iMFF1?=
 =?utf-8?Q?MDEI2Ky7v5oOGqAQC/QzNdN7yElPqoln7Wk46do?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f602ce6-9297-44ef-8cf8-08d8dfaec6de
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 08:15:02.9381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dYOS1BKkycZyuMfrU2owh6MbIPYuOkj39dp3zm9IdEHpdZEe2jWt0NHsJ2jWDCrJwUvoA6O8uxeU4CwvUuqnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2857
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
Cc: guoweichao@oppo.com, zhangshiming@oppo.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2021/3/5 16:08, Huang Jianan wrote:
> z_erofs_decompressqueue_endio may not be executed in the atomic
> context, for example, when dm-verity is turned on. In this scenario,
> data can be decompressed directly to get rid of additional kworker
> scheduling overhead. Also, it makes no sense to apply synchronous
> decompression for such case.
>
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>   fs/erofs/internal.h |  3 +++
>   fs/erofs/super.c    |  4 ++++
>   fs/erofs/zdata.c    | 13 +++++++++++--
>   3 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 67a7ec945686..b817cb85d67b 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -70,6 +70,9 @@ struct erofs_sb_info {
>   
>   	/* pseudo inode to manage cached pages */
>   	struct inode *managed_cache;
> +
> +	/* decide whether to decompress synchronously */
> +	bool readahead_sync_decompress;
>   #endif	/* CONFIG_EROFS_FS_ZIP */
>   	u32 blocks;
>   	u32 meta_blkaddr;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index d5a6b9b888a5..77819efe9b15 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -175,6 +175,10 @@ static int erofs_read_superblock(struct super_block *sb)
>   	sbi->root_nid = le16_to_cpu(dsb->root_nid);
>   	sbi->inos = le64_to_cpu(dsb->inos);
>   
> +#ifdef CONFIG_EROFS_FS_ZIP
> +	sbi->readahead_sync_decompress = false;
> +#endif
> +
>   	sbi->build_time = le64_to_cpu(dsb->build_time);
>   	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
>   
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 6cb356c4217b..49ffc817dd9e 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -706,6 +706,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>   	goto out;
>   }
>   
> +static void z_erofs_decompressqueue_work(struct work_struct *work);
>   static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>   				       bool sync, int bios)
>   {
> @@ -720,8 +721,14 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>   		return;
>   	}
>   
> -	if (!atomic_add_return(bios, &io->pending_bios))
> -		queue_work(z_erofs_workqueue, &io->u.work);
> +	if (!atomic_add_return(bios, &io->pending_bios)) {
> +		if (in_atomic() || irqs_disabled()) {
> +			queue_work(z_erofs_workqueue, &io->u.work);
> +			sbi->readahead_sync_decompress = true;
> +		} else {
> +			z_erofs_decompressqueue_work(&io->u.work);
> +		}
> +	}
>   }
>   
>   static bool z_erofs_page_is_invalidated(struct page *page)
> @@ -1333,6 +1340,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
>   	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
>   
>   	unsigned int nr_pages = readahead_count(rac);
> +	bool sync = (sbi->readahead_sync_decompress &&
> +			nr_pages <= sbi->ctx.max_sync_decompress_pages);
>   	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages);
sorry for my mistake here, i will send v3 to fix this.
>   	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
>   	struct page *page, *head = NULL;
