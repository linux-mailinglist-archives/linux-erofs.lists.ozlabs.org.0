Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E4E402A3E
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 15:54:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H3mwf31Ngz2y8P
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 23:54:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1631022882;
	bh=v851Aj04QDg149fLQMU3F15wUfk5Wneg9nw4Dtryu+g=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=RYstchO+qztipbFV+UiHgcQo62t+WG9J2XnwzmO0pwcxcQ0RCmQ3G8CfofA0oq38t
	 dDCRTPqLT+xSJip/hghfsgrmm2X5aG75Z9FArJ3bLjl639UKNsU1SCdKvD2rUeOUHX
	 MbbjMYrxQeGFcIPT+GmNUgeMLywUPORIiI1lgSn++HnK2njaEmCsXtu3l90s49pALv
	 BnmOtmNaGJY04vkH0CkkptzJ+fQui+CKS1paJ72Pm6DX0ypFCoBceE2jk0B+JNJOJ5
	 cMbYsJwgVGXev7ricMZeWwWWCyAOp8Spi76iOxRHAENzurDMRsHXJeqCTfiJSYyXsl
	 FBjUo0Ioya1Uw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.84;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=gTgQXdiV; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300084.outbound.protection.outlook.com [40.107.130.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H3mwV1d5Yz2xYQ
 for <linux-erofs@lists.ozlabs.org>; Tue,  7 Sep 2021 23:54:27 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfcgL32CPH4piHAMt/mYAtjWURHo1/GFAfWWbZdfNeBfFUxWukogr5ebADj4GIs8ckh4lIh2GYSyTySDdXEo1tmSyYcLUlEUk5VYMJIb4kYfLZ9sZvgDYY2Ecme/Dpkgo+y7J61dCEr7bNhAE4odobT2xN8H4cLRWSN9X843gFZDx7L3rtHqxT5/M2WYmNAOXBp1BYpZkgARB9tssLrqpHPKou1raHiLRrFXcI44qdFBo8tZozKPJ6cpZdeg9GifjgZ3nKXbYJhIEo0mJSNxGftRJYMP/Fgy6jN+/tmkaYb8m6ZD67E+j+raGNZQAqyJTFlRlsmSSHRhCeww36mGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=v851Aj04QDg149fLQMU3F15wUfk5Wneg9nw4Dtryu+g=;
 b=KZBnHw3jL3BGQPmUoYFxZIF11mMwSub/o9g91mdKbIRVZ5P1Tmh7/uNb3i6CxFnSyCxscAYbS512pdaBb33QEWMPwOmKJ5r8x2PcYrB/jPfR8qTR3gAzprn96TDakeJolLx7IJEn0ea/NaLv3tGD6GNHzKrUqhL8USz/HhawqYpFbR01UDtKj15fZwMdIZVvVu6dzGPwLjQwPunGC5ktc8KVnsiWsSL8lp3tqLzY4FN287dB70ym0DiPCUDuMkifvt69KNM8qCVi5euGyfjlOEJj2XHvNZs7xpU05M0DPwi/N91jQdiB/V5U6FAZ4QX9tVsBkZj2esl3EKoMSQHptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2697.apcprd02.prod.outlook.com (2603:1096:4:66::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.25; Tue, 7 Sep 2021 13:54:08 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 13:54:08 +0000
Subject: Re: [PATCH V2] erofs-utils: fix random data for block-aligned
 uncompressed file
To: Gao Xiang <xiang@kernel.org>
References: <20210906081359.17440-2-huangjianan@oppo.com>
 <20210907035345.22735-1-huangjianan@oppo.com>
 <20210907132048.GA2401@hsiangkao-HP-ZHAN-66-Pro-G1>
Message-ID: <1ecb04cf-9372-4470-48e3-cc88302c7a90@oppo.com>
Date: Tue, 7 Sep 2021 21:54:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210907132048.GA2401@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0205.apcprd02.prod.outlook.com
 (2603:1096:201:20::17) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.7.229] (58.255.79.105) by
 HK2PR02CA0205.apcprd02.prod.outlook.com (2603:1096:201:20::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 13:54:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da035b6c-de60-4a0a-416d-08d97206f682
X-MS-TrafficTypeDiagnostic: SG2PR02MB2697:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB26972B56FD39EB5BF247334EC3D39@SG2PR02MB2697.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TukYAqudE/pV/+ybvVhVPXD6Ys6TrVUtCwbwBoeGQocIlkb8iUWJrLFykTdUtsDdbkx/BlJJW/BOYyYRBdi+ld0RZO80KrICyvaSwLB8sCDQuZ4r+hIjJD117dEbgR+ILmjPzToxg8K6eV+/VPScdR9CQJRLjmWN65yL+/CAxn+VHaX4ySrG9Tfd/ub8DtoW1HFOOYKUBe9RgeMSDErnEiXODlZI+PHmsUjB7OHgcJVN5Shz9yesFuDhp7/nYFqfCK1YEMvSkeHYaQXMfp6K/QW7+6jL4jGY/a9zcGtil8k0SjOrGtGxMLVG2Ed2uWPpHLJ6bGUpFKUo2ZZfZN29oUk/wzvsjUu1nkTJWrO7yqzm4xqY4V9mTDiJhfM/RnNQLQCQcxDnpAacucyDV+8KA8iAoS7VbiIGgeB5OsDjQXBq4tIe12bSfUiTOyrlrswDhx0LT5PWZx9I3IFDPPSRJX3r3uZB2BUemwXFJMZGfiJXaE34TlCrxxMpQvt7ajka+kIMEYfjIkbaVN8i9X7bUYSOzMs/HvMwVep8DYdFvT0NYH+6j+TthFt/1zoLpRLoZSi7sAVrKjti6pXdBfKMk1XcyvMdeD0tVBo6F4sITuIiafbqqkczaXfolpICbEf7SJlFos33b9LjpLFwnTHSd7q98UG3ZwNTn+hb5kc4CG4xWaqQF5rvpvDGwtag29mknTac2Dn3oQJJChdMJGyZQwfratA2DcoeqqncVVdhYHRcfaw8Aqq4VnQdXE1p2HwQ61/iAGClvI9HExyuKlcbUy9KLITi5MsoUXUycqKip2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(8676002)(6486002)(478600001)(36756003)(66946007)(186003)(83380400001)(5660300002)(66556008)(38100700002)(66476007)(4326008)(86362001)(38350700002)(2906002)(8936002)(31696002)(6916009)(956004)(16576012)(316002)(26005)(31686004)(52116002)(2616005)(107886003)(11606007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGNPUFg1WnhoYkxrVytoUDYyMElRWktLTkVBNTFkT1M5eTJOaElxRWdnQUhD?=
 =?utf-8?B?eitEK1dsRlA4dG1NeEUyd3ZPempRa1NtWVNVb1JVVVdUdFhvc3hZUWlmbUF6?=
 =?utf-8?B?YmtJb0NYNmtDYW4xZi9sd2JYcEQ5TjFWSTYzNFBIbmxRWkpSNStyQ2dpUHdY?=
 =?utf-8?B?L3J2eWNheE1TU1ZiUDBoMkd5c21hd29vd1F4UUhWbGRoN0dvOEZSdVozUXVG?=
 =?utf-8?B?dDVXQnYzamZqMGxYNDZYRXp3Tytoa0ZzNGN3Q1BXcjZIZ2dOZ2hUbEV3N2Y4?=
 =?utf-8?B?QVNOalhlaXYyZEZ5TVZKSE9jRGx6UVUvS056YXB2ZGZlMHZoMTdoeW5CUTZD?=
 =?utf-8?B?SVZIejBNUWxReW1hZjRTVGs0YW9qZTZHVkxGWXloMUNUdVNNRkxnSjhxN2xy?=
 =?utf-8?B?MHQvZGVnU2NPQ2h2NUNYL2pUUTJVeTI2dk11a2pjM3FSUjVPYWRHN1J3Wlh2?=
 =?utf-8?B?d1hTMkVleVdhOTNFVURBcUxiL04zUDU1NitaR2YyMDBjcWk2aFd2ZHJrWHdh?=
 =?utf-8?B?dmxBQzF5TU51RXpHWUFiaitBaEJPTDlrR2U5U1BwSEt3WTY0ZGNkMUNoMUhK?=
 =?utf-8?B?TERicllTT0tYZFU5cE0wMkZXTzNBYlZNaG1wVlQ5TUNZMW1zQVg2MG03bUlL?=
 =?utf-8?B?R0JsbFVVMHR3aHE3bE9ucHVaWTZ0dWJEc3ZoZ1VEY2RUQXoveVZOU3IzOGpu?=
 =?utf-8?B?bDhYK2FCMUR5dzNId1FmS3pSZWNOMlBVVUZFYTJYZ0xXVFRtU3lJQVZ2MnJW?=
 =?utf-8?B?NnRWdXVSMExNb0FuNEdmemZHS3E0eWhGMGowMkVYRi9QMHJpcDd2MGJ0UTBo?=
 =?utf-8?B?ZHp3MlJ3MG1MYUFmaHFDbGQwL2U4ak1kelozTUh3UEpzSE85TlkzY29UdFFY?=
 =?utf-8?B?UW8zRUNZTjMrbXJDbGZsUWV0RWRlQXlpL1BZNXZOSE5wdDVaZzBhSFVMNm44?=
 =?utf-8?B?d1JZSEpwNXVRVHFYUlVoV2F2MnUzRVFkYk9ONnR0OFBHd1g3VUlKdUpyK1BL?=
 =?utf-8?B?TmdrMG1nbE5kdmdSNnFmbkpiMkMrY0ZCcndrY2RqeEQreTdpT0RnRExDZVVB?=
 =?utf-8?B?b0NPQmVtYm9tN2FVengvTDhHU05nYURDckgwS293QS9UcGFiY3pBeVhFbGRu?=
 =?utf-8?B?MmxUMmczb295blhxTWVoT0JUNnNhWWZORkFYUFNvRHBvTUdBS1Bzd1pEcUdl?=
 =?utf-8?B?bGp3MU5ET3NZRkpkaElkN1J5bkdUQVlXbFprN2pzOVJVTU9VT3J6Y0ZJZEtB?=
 =?utf-8?B?OEZuMFVneXVRQzJLc2lnNGl3MUdwemRwOHVqWTkwOEdOUklCVnB5NnZSVS9X?=
 =?utf-8?B?ZVk0Q0lmUWVReEMycEIvVmxTYmIxMm1pQXRycEdjTEhJd0dpTlQ0MTZzWVFT?=
 =?utf-8?B?anl6VlR1YXVVOG9uQ0ROOGdITjd3VVBETGF6Y1ZzK3FxaFRzVzI4WXhlYlRH?=
 =?utf-8?B?RGQ4T3hTSXV2ODJoSnNicnpxM3F6bWNQMGw0RHlDd0Ywelhwam5Qd2RwLzZ0?=
 =?utf-8?B?Mno4M3ZLbUtveGZyT2g1bkJ3aFlvaGw2VWp0VUdqY3EzNERIMzQzSGhJenBp?=
 =?utf-8?B?ZnVpVkZCdUF3V3hjNUtqQ3B4VXhhVUR4MEloZEoyUmI0b0E4U2tXY1c5Y2xY?=
 =?utf-8?B?R2wwUE9LUURBQWNReHh5amVNYTlscHNUNGs2QUdwNnhDOE1xOTMvWUNvaC9n?=
 =?utf-8?B?a1NBZHZtU3Z4aTdIcTdHZkZwVGRzemFBTWxLbTlUcXRCa0YvWHVzb2w0WGJV?=
 =?utf-8?Q?WZDBtus2AAsUJtfMijchEyw555JImSaOyafRTv6?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da035b6c-de60-4a0a-416d-08d97206f682
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 13:54:08.2866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XP8ideZiu8CDmr8tJ7NQ0gnldsuj+p7SXc5c1BObZlrtTF/OcocWOQ7fbkqggsX8PGvL2EjC17ICnA6fXky79g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2697
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
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2021/9/7 21:20, Gao Xiang 写道:
> On Tue, Sep 07, 2021 at 11:53:45AM +0800, Huang Jianan via Linux-erofs wrote:
>> If the file size is block-aligned for uncompressed files, i_u is
>> meaningless for erofs_inode on disk, but it's not cleared when
>> datalayout is seted in erofs_prepare_inode_buffer.
>>
>> This problem will cause inconsistent reproducible builds. Clear the
>> entire erofs_inode to zero to fix this.
>>
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Reviewed-by: Gao Xiang <xiang@kernel.org>
>
> BTW, how about adding --from="Huang Jianan <huangjianan@oppo.com>" when
> sending patches with OPPO emails.
>
> Otherwise, it seems the author becomes
> "Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>" when
> reaching to the mailing list and I have to update it by hand....
Thanks for pointing this out, I will pay attention next time.

Thanks,
Jianan
> Thanks,
> Gao Xiang
>
>> ---
>>   lib/inode.c | 12 +-----------
>>   1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/lib/inode.c b/lib/inode.c
>> index 5bad75e..0cce07d 100644
>> --- a/lib/inode.c
>> +++ b/lib/inode.c
>> @@ -834,25 +834,15 @@ static struct erofs_inode *erofs_new_inode(void)
>>   	static unsigned int counter;
>>   	struct erofs_inode *inode;
>>   
>> -	inode = malloc(sizeof(struct erofs_inode));
>> +	inode = calloc(1, sizeof(struct erofs_inode));
>>   	if (!inode)
>>   		return ERR_PTR(-ENOMEM);
>>   
>> -	inode->i_parent = NULL;	/* also used to indicate a new inode */
>> -
>>   	inode->i_ino[0] = counter++;	/* inode serial number */
>>   	inode->i_count = 1;
>>   
>>   	init_list_head(&inode->i_subdirs);
>>   	init_list_head(&inode->i_xattrs);
>> -
>> -	inode->idata_size = 0;
>> -	inode->xattr_isize = 0;
>> -	inode->extent_isize = 0;
>> -
>> -	inode->bh = inode->bh_inline = inode->bh_data = NULL;
>> -	inode->idata = NULL;
>> -	inode->z_physical_clusterblks = 0;
>>   	return inode;
>>   }
>>   
>> -- 
>> 2.25.1
>>

