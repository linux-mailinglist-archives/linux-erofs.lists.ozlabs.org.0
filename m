Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A8944E464
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 11:11:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HrDrM1HDRz2yp2
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 21:11:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1636711875;
	bh=LnWlPS2x8jzSiUjoXpFNj9zHJyFfCvebYP7sK9XAY90=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bdwTDnTIE4mgvDHhZPWTrgDBazksv/p5Pd8dPlUbUAkIbHjKnPFXRazWATGtCdfAN
	 2N+Ih7hiCIqVfrCsuz4bMU2ODnjF/AdlxUTt78xI6tmdKd1lsehNhW+flWZWDlfpJh
	 BP9h8RKz96EI2QGm4Fwf4jb0XvM3K3Cu5ZKzzEs/RZ4S9Q+llpGW99CoBLQ1BCoIz5
	 OsDE8z0rvFuIiISQQFgaBMIfcZAKaY87Ob8dUJmFYoAHrnFubh9OxdiBot1iQawKpD
	 smquwGjUStiq1HR6wNORY/vJJVbVdrsR3IKSUieyPe/yXPeEy92txwVJtliVzvgA96
	 iaUvjwzBCiXTQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.50;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=e7QhjFgk; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320050.outbound.protection.outlook.com [40.107.132.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HrDr9054Bz2yJ2
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Nov 2021 21:11:03 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkvHykgLUjZZ9pBy2grP/aBXRz2nBABTnjv3/aFjFAKKAbC/zZ9x1/XFtEm86nqnvM5o8nxRJ2wOXCmriB8P/dEo4kI04loYuGufDkEnAhFwVG8DybvJXjEK+lG+buCXwnpBTRgNFpFLSyywjWA7aZf4ludTwaYdcvQwXqEfZX5SSUHcD0dLW7YBEmur+OzG0iNP7Wuuv/IDXI7PVfT/jSUz2Z8qm9mR0mxth/pDkiZ5gjexrhOmsuRlkwIdlReTSVqxUtuv5BKNoFH8xuj62vRCRJYh3Ek8+fOKSObtJJzLw/ct2wA9KZFAIejdJ+RVKWr3d4QZjVKgrTI67vTdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnWlPS2x8jzSiUjoXpFNj9zHJyFfCvebYP7sK9XAY90=;
 b=IRUiUYzZLfe9hxUVWoZtqZ/H+L6nHlKJ3VCGIb2nyFRKQG26myWmA4sdHMMdMbjT2OL7ZGZ39Km1x2Hh3wQVHgNnicvv8Vw2jqhSlnY0SxnbH8rJBcEbpcbzlUik9z05eEEEdFyDW2O52WYEghNfUM1sFL9aNh8h5/mdKu1VpO1l5SWkJJDb5dfC8YIySCB/pJ0iaeral6ezhY3cJx+xVNPlH+VvU0Z1Ase6rxovSxD1DzCEEIIsFaKQ1rkAOJKAMfpfsUnatDC1VKUOYRbfDMBEhJjydEDtzp27hKv8Nm+90cIyp92zn3brD2leqKBK9P0vkZ6spk+p+ENmVWjoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4022.apcprd02.prod.outlook.com (2603:1096:4:83::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Fri, 12 Nov 2021 10:10:41 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988%7]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 10:10:40 +0000
Subject: Re: [PATCH v5 1/2] erofs: add sysfs interface
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211112023003.10712-1-huangjianan@oppo.com>
 <YY39YZcn/a6F0PMh@B-P7TQMD6M-0146.local>
Message-ID: <67b86422-3133-ff7b-ddb7-c25939bee549@oppo.com>
Date: Fri, 12 Nov 2021 18:10:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YY39YZcn/a6F0PMh@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::26) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from [10.118.7.229] (58.255.79.105) by
 HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.0 via Frontend Transport; Fri, 12 Nov 2021 10:10:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fa0eff1-e8ab-4167-d236-08d9a5c4adec
X-MS-TrafficTypeDiagnostic: SG2PR02MB4022:
X-Microsoft-Antispam-PRVS: <SG2PR02MB4022CA548BA2370361DFB16BC3959@SG2PR02MB4022.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWVCeeB2zD58Pfo7qZEnp1unfOQ/jDgVz7hiAX6Y2W3H/S+J5/+FZDN+3u+CVP+7SpyperTqsYfoB3zR/wJcuPWXa6DLuUzityBVy7UefcUFfwbfqvGV1gJYbVRzHjRlxWKa328mPK5wVedLVRxhJjxFKneEB89DZeU92pFZSyE5MbV7SC2QBxi7+pCMrqD6nAPEvkIXI/yvQo5pF+sUSnf0T2njAvI6juSN8S77Z8LN4NTU09oPPxZa0xEFJmCb2qlSPmJjUH3feO4bx6cZiHXdU72OOxGtj5qLkkPMETr+MYv8t9EkdlCd6b/jB4sToG6i1/slGfhm4RbPWKKayuvnN2WzgRgFAETYkFxjZpTe/ZonOjRopzHM854hk5knvgR+VNikPm6KhzbXNkEqvdkQapj9ZF7WnlBE3Cf3mofKbiGCXoilxHA6GOV3vpx2owZWo5+AagmI9K+m+nLYkZ1/kmRviHQcUOyOJJSlUxIomz4AG9wgQiFE3rCQXtjKTROvke2fY5ivz1iD4d5AQkWVxAdGzsUG1aky+pNlK3dJkfql1O/vuZHV3qB19wVW5Nurova8CH+tuoDdlJUahPyszi8hoaVrsk/16SnQ/I10/Fu06lGrir39n7Y8vfoRggWnO4nAPt/L/zmQzxXuEkBUGLjg9OigDWh09lCwb6NSBNBp7eShyq95eA3oLlg4MvKhs1gaVd8Az1nt/JIWViuO5TW+KE74NsjSKuyGGXFsQO5EH6DysMYmcNpcht7xOVmqIA2fMkfUMQkg9yWLkj9siow6yiZEoVzh57mgIys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(2616005)(26005)(6916009)(16576012)(8936002)(31696002)(316002)(4326008)(66476007)(6486002)(66946007)(66556008)(86362001)(31686004)(2906002)(36756003)(52116002)(508600001)(186003)(8676002)(83380400001)(38100700002)(38350700002)(5660300002)(11606007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aCtqM1h4ekRHSVlQZWNuODhGS3NaTzNpVTVjTzJJUXFTWm84WFExd3psa2VX?=
 =?utf-8?B?ZXVQbVFxZVdRSnNoeldHbXVRMFZDSFNONk93b1RoT21acmw4cm9kTnNJNlVs?=
 =?utf-8?B?U2M4amFhTXB1Z3o0YVdrSlNabDhPZFFPTXd6dWk2Ny96bFFyUk90UXF4WXZ2?=
 =?utf-8?B?WVNaYzhUZzVPWDBzNlJ4dlNYbWVHWWt4M2ozeWtGNUNjeWdUKzJCOGNKNUhU?=
 =?utf-8?B?NWx6OW4yZlJLa2ZOcmZwcFZ3VU1uU0NEa1FZaHhUVzU2UFBZYk93WEdieU81?=
 =?utf-8?B?a01SRG9DTmY2WGNzQlY5OXUreGNraGZKSkYrOGo5bWFRcEtwMFFMV01PUE5H?=
 =?utf-8?B?WnRRN2pFZFl0Rk5oOWx3S3hrdWU0S2RodE9nSHZpeXFlS2xSWlE1dmZ4dWp5?=
 =?utf-8?B?L3MwWENxWms5VjNRTE14T3Vjem9JR1piQkhBU29ZRHRYRFFCQkFCT3U5VTZw?=
 =?utf-8?B?aHBaTGg4U21vTVVtWnh1dGF5eEl2K0FXdFVMNDc5Zm1OSUlGYVpUcDlWdEpG?=
 =?utf-8?B?WUNUaDdTMGJLZDlzeS9ybnIvMUM4LzNldW9zcmlGN3RiMHlWelExMjZRNjF3?=
 =?utf-8?B?N0tIZ2srR0dDSjNMbjQvQ1piK2I2eVN2UUl2dS9rS1JZMnh2elJGMjNTYmhL?=
 =?utf-8?B?QlV6K2ZzcVNUVGF4cDB1dWdMS1JBNFliQVV1TWxjUUlkNVd5SDRmMlZ6eWt2?=
 =?utf-8?B?TUJJam50VzdQcVhWRXFoTWo5eWM4RkQ5clMwaXZwem9lT3dEaXhSZ1hSUWxu?=
 =?utf-8?B?TE9oVjZDU0tjVm5JWkpMY1NRZThWUm82RlIvNmozQitoUTg2cjFGWWZqeW1C?=
 =?utf-8?B?MzVheDliU3lWNGFpQmN3V2NJcmlBVlRtUy9sTjJNVS8rSHFFZzlZT1c0cUV6?=
 =?utf-8?B?S0tTbkpqdytHcS9aRXBOUDlUYmtUVVZ1MmgrekZtMG0zZUtNVXBJRWhHUFBD?=
 =?utf-8?B?cFBqRzV5VmRxSk5wQ1RLY0NMY1VBSlROZk9VVmhRZHNiWmUyWElKRTZvem1B?=
 =?utf-8?B?Mlgzb1dGaStzZWcwT21jOWlwdjM3REtiOVBPMjRLL1FpQU8xL0FYQzIwN2pH?=
 =?utf-8?B?Rm5XQ0lvek8yMUJqRkZVYm81SHViVTdyVklBbUtPa2lXVTdJZVExaWtzNFYv?=
 =?utf-8?B?SisrL2NCYUFJZFI3RjN1OC9pMkdYQ1dxN21sNWpkdUJ5K1ZESmVLYi9PaGgw?=
 =?utf-8?B?UEVwYjd6S1hOcUd5ckxXVWpLOXRKRFduUTdjUDB1cGllRFZXWVhWMldOVUdL?=
 =?utf-8?B?ZDZyenVacmxVUFhlZ3liSzJGOFVJZjJ2RmZxT3pQU1JsZURJaU5KdnEzMTFB?=
 =?utf-8?B?UkJESlFva1ZyYytLRjErWVkwZmR6L2VGYURBY0lEanVURXpCTWljY1hqelk4?=
 =?utf-8?B?bUErcS9vMHhIdDFna3lXMTJ4clc5aFFCeHVNK3pId2JudC9wd0syMEtraExJ?=
 =?utf-8?B?OEFVSzlHek9DSnNEalpsNW9UNEhnVlA3d0IzcUVKNDZ0WnpnZTh3aHhVQmNx?=
 =?utf-8?B?YXA1RXZNblBuRk8waWI1UVBXand3UWVLaHFaZE1VSVVpR1Q0WWovMU5lNzhr?=
 =?utf-8?B?K0QyYit1RFg4dWNSbmRKUmpPYmhLNVBrNTVkZjY0VHJNTXdPcUZXbHpBZFZ1?=
 =?utf-8?B?eWxtWDZoaFNqWkdERXJZbzVSUmdjU1AvNVpPcktBamE2VHRvRkQ3Zk80VEU2?=
 =?utf-8?B?S1V3VS8vRzI3T0lyQ2hEeUszbDRGZ2dNNmNwd2pRZWxSVWQ0Um95aTJGdVox?=
 =?utf-8?B?eWNrcmhiRXlVWGJKNHprdWswWnBRc0pERGdnV0w1N3ZkVFJ5S2tGbFZxckxE?=
 =?utf-8?B?aHRLWGpCU1cwYUI5K2wwRkxwQUF6cG1raTJZQlYxOHU2SlhnSFJlYXBpeHlR?=
 =?utf-8?B?QlVtZFBEZk9zV1NIMHpRYUFscmlOQTQ0RmNMalNUQkU5NkY0b1hyNjdzbDZD?=
 =?utf-8?B?Y0xQM0EwNGtuTDhwSFpLQ1JnZ1FCRENsV21Dc3Y0QnZOWDZ6T1VBa2M3bDNV?=
 =?utf-8?B?OVo5ODhFaDlRNDczREtTbHFHQk9CYVFlMVBLOUlFUXZRWWNERjFzQlVkMk1I?=
 =?utf-8?B?b0NCbkxvUE9kMXBuakJzRlJFbzlVeURRcDQ4NDRSdGdycFA4YmdEMHdwUXMx?=
 =?utf-8?B?V0ZVQ0Y1K0lvZ0ZjRWVIRnc3b3ZURkZTeVR4N1dmWE5xREprNS9tNWlINGNk?=
 =?utf-8?Q?uNlKE5LISG+9fI7AMRnEfww=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa0eff1-e8ab-4167-d236-08d9a5c4adec
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 10:10:40.6653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gs3L569+0VzcfetWi0Rp6HKZLhz+bSuUJwok/O0csiOMoBYGqZPkfOqYJwcVHGUSMXOEgNmUrrJefN8NEdI88w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4022
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org, yh@oppo.com,
 guanyuwei@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2021/11/12 13:36, Gao Xiang 写道:
> Hi Jianan,
>
> On Fri, Nov 12, 2021 at 10:30:02AM +0800, Huang Jianan wrote:
>> Add sysfs interface to configure erofs related parameters later.
>>
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> Reviewed-by: Chao Yu <chao@kernel.org>
>> ---
>> since v4:
>> - Resend in a clean chain.
>>
>> since v3:
>> - Add description of sysfs in erofs documentation.
>>
>> since v2:
>> - Check whether t in erofs_attr_store is illegal.
>> - Print raw value for bool entry.
>>
>> since v1:
>> - Add sysfs API documentation.
>> - Use sysfs_emit over snprintf.
>>
>>   Documentation/ABI/testing/sysfs-fs-erofs |   7 +
>>   Documentation/filesystems/erofs.rst      |   8 +
>>   fs/erofs/Makefile                        |   2 +-
>>   fs/erofs/internal.h                      |  10 +
>>   fs/erofs/super.c                         |  12 ++
>>   fs/erofs/sysfs.c                         | 240 +++++++++++++++++++++++
>>   6 files changed, 278 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-fs-erofs
>>   create mode 100644 fs/erofs/sysfs.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
>> new file mode 100644
>> index 000000000000..86d0d0234473
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
>> @@ -0,0 +1,7 @@
>> +What:		/sys/fs/erofs/features/
>> +Date:		November 2021
>> +Contact:	"Huang Jianan" <huangjianan@oppo.com>
>> +Description:	Shows all enabled kernel features.
>> +		Supported features:
>> +		lz4_0padding, compr_cfgs, big_pcluster, device_table,
>> +		sb_chksum.
> Please help submit a patch renaming lz4_0padding to 0padding globally
> since LZMA and later algorithms also need that...
>
> Also, lack of chunked_file and compr_head2 as well?

It seems that these features are also missing in internal.h, I will send 
a new
patchset containing these fixes.

Thanks,
Jianan

> Thanks,
> Gao Xiang

