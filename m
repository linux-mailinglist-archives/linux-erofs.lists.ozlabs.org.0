Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69292D2781
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 10:25:40 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cqvt96dKJzDqXN
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 20:25:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.40;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=weiTFxpn; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310040.outbound.protection.outlook.com [40.107.131.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cqvt40YplzDqVx
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 20:25:30 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw1cb8qOtIPanJOEVtCTi0qQ5S4/wN3hGX/mKXEvUYSuR8bUELxkrMxar3qOpXkPMMJfdIp9aqf9ufK/lCPlzRXnQpdxWtqTYFqD1/b0L6jmLZLDmgQgi6hsaVrqXUfLzjOqgCpCiqoe4PQN8S5aDCxYr4TRSKE2oyJqHP4JEYZNAxd+kR7beJpLLGws37SSTqvMuU5A659RkcLGz/ckX3St3rDKJjlqiR4xI/Zn4wKGDCihNvouseIf2s0fI1xZVVLnfBpaRaDPKldE9P3SZxv/heTZMj9VHqG0JpbyCgY1jEXzOVAJUrEYlByKT6wTA2JHm3lsm9d6xWHhs0Ynuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTvxpDAQPed3myTzbhv96i2ezK8HsCqzWCJa8Xmn8kQ=;
 b=fdRqfxHkBOXTfxjyZXHjDH8ZUx/cB+RzQVw/RjQO8+0C+Vy3m4dQRd53D6UYUt9Viqpv3xmMYWBlF9vf64t9OMRxTOsbda2KLneir5hrYtZ+t8VoMq24GJ1wp4T94Pk74uDiaGdfEG6hKi+d2Nk+KfmFfhG6ETAWnJ7pcsY99kvZTA1RMQpvIcmJrwclYmH3vXT9qOWVektd91uVzBns00c5GJSrjwbiEFQJnN+a/BjKuhQLrRz/aVxgzGpjWy+bqD1fvaxD82m0uygF0TUJSk3q3tifhMG27JvQPO9umA9rA2uJ/GEAtzPJfR4B6csoJFBo3dxcStuP3XubUW8vHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTvxpDAQPed3myTzbhv96i2ezK8HsCqzWCJa8Xmn8kQ=;
 b=weiTFxpn5wPklkyMa2rHytdRRpMt3RF+Dhiij1hP3fmJXaYK6USr3OJ/UV9ecte3FFAXp34jxbdZ0vs6qhssrLRsENQvCHC3J7VeNvBma8ZRSmf0/C2y+2DiN5IB22b3QYEIOdzLL7aQFKYtcOZ+Vu2ex2ox4FcVJwPwEZgQX1w=
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3576.apcprd02.prod.outlook.com (2603:1096:4:31::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Tue, 8 Dec 2020 09:25:24 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 09:25:24 +0000
Subject: Re: [PATCH] erofs: fix wrong address in erofs_get_block
To: Gao Xiang <hsiangkao@redhat.com>
References: <20201208084750.5469-1-huangjianan@oppo.com>
 <20201208090303.GA3062064@xiangao.remote.csb>
From: Huang Jianan <huangjianan@oppo.com>
Message-ID: <f6874d6f-138e-e490-9961-1b7f6cb883c4@oppo.com>
Date: Tue, 8 Dec 2020 17:25:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20201208090303.GA3062064@xiangao.remote.csb>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR02CA0164.apcprd02.prod.outlook.com
 (2603:1096:201:1f::24) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.252.5.72) by
 HK2PR02CA0164.apcprd02.prod.outlook.com (2603:1096:201:1f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 09:25:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6184f0e6-6435-42f5-6d12-08d89b5b311d
X-MS-TrafficTypeDiagnostic: SG2PR02MB3576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB35761A6C60247851A88909DDC3CD0@SG2PR02MB3576.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DPknAoXxECWknz1Ljdp/Wb1qry2UXT1dv9v5236vAHN/Xj8QYYh7uYC4z6flrHl4xykE4yu2+XM1PBYQx6RQaQZ0WIYl6/Rh1KrNw1cQ3+tXl0T+Ca2s9BpMH1phGjWCTdhKV53yznDUzwJPK2yXd5PKNdEMcKkuyHV7j5BhMGx+Bu7hNaYWl3TvZlLYuEbndQ6wwvlMO31NkJTXV0AP3V7TTsiqVpa0Yb90+byIK5jM05KfrXLkNBXh/JZQR4vFaoRDy1yVwFZCj3qfotX222CBmtC7NVKASVf2fcboGaTjNpWyDqzHQCg2y47llg/Kif9p8x4dhe6bKWCCAEcoeQi+ofc7QTmlIq+x6tuxX6QjvCxU40xu0+Kd1IR2f/iDhYuhrmKfVJfBjdKyWTUT44RGzxY6pSIp+OnCc6UajR20pHIyJ7wpBKZWFDeVzH3j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(186003)(66556008)(66946007)(66476007)(52116002)(31686004)(2616005)(6486002)(36756003)(31696002)(2906002)(8936002)(107886003)(6666004)(5660300002)(8676002)(4326008)(956004)(26005)(16526019)(86362001)(316002)(478600001)(83380400001)(16576012)(6916009)(11606006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SGVuZnB3RHN2dTVsUWJReXBHczh0Mi9Fc3JmZWpVVjhzaFYxZnNGQlllQ3JK?=
 =?utf-8?B?dUltS3QvbTd6Yjh3WllLWnFkQWlyT1VMVm1aZ1l3WnkrRURNYWNCcWdMeGcv?=
 =?utf-8?B?MU5yVDlmaXlFNTFpa0dtNkNYRHh5UktyekVVMWpvK0hxUDNOVFcyR3laMnI0?=
 =?utf-8?B?Q28vN01UL1BDWWVLRlFadGlCemlwaTdjMXY4MW5RdGFJOVhXaTMrOERSUVNO?=
 =?utf-8?B?a3BpeTQvWWtwbFJQVGZEZlNDWnBxeENiclErMDhnMFU5S3pNd3FlcHViTU05?=
 =?utf-8?B?Rnl4R2xDV09lalFqMUhNWk56MzFqZW1RSjlDcWNvMDB3amRIdUNnTGl5OGJM?=
 =?utf-8?B?MmVrclRDdzh5MEgwTytsTVFLS1ZCYnhuTTN2N0p5VnlBdzAzR2RocnBsY3hK?=
 =?utf-8?B?dS9HL1JEb05BTG5hakZNUlZ5akVxeSt6SWlGVlhMbDI1dHd1OW50aS9QTTBz?=
 =?utf-8?B?K0tVU0x2TVIrRU5rSzlZYnRkdmw5QXhralliTFhEYUNSTTcrUTBXdHJCREFx?=
 =?utf-8?B?NFlHaDF6R3NvbFhHb0RSZHRqV210Ni9Zd3Juak9WNTZjRE16YTZPTTI4RjZV?=
 =?utf-8?B?ZDhTNWUvcWNlYzNSVXRHQ01lQ0tVd1lVWlpnVHZXNnFLa1lvYzFYdXdIQkRw?=
 =?utf-8?B?NENMWUQ0eTBJcktyZGZ4MEtWcSs2MndpWllhNGU4bnVCZzFKNWFzelVKcmRX?=
 =?utf-8?B?NWUwWHlqNWhnVEQwdElkWE9KWDFQS1pmSDFqSlhGRUwvWVFtR0creW9aK3JY?=
 =?utf-8?B?Z3Q3L01uUjFYRkt0YlQwUDgzZ3VCcW9IRk5SM2g3UTNTY2VRTEJpRnpIMWUz?=
 =?utf-8?B?eDMrWjFONW1IdzVoZHlIeDY4c3IzSjF0Wk85djdFQjExbC9CT2kzTHdxa21u?=
 =?utf-8?B?ZGtpZE1UR2FOdGZXNU82Tm1NdW93b2c2Umh2MVVEei9BUFQrdnRvOVZOZ3B6?=
 =?utf-8?B?MFA2VnVoaUlGelBUOFNBZ0RIQVJ0YkxacVBMUVMxaUxCem4rM2xrMitIQU15?=
 =?utf-8?B?RmlrVUJUL3lkcFBaRHpHODJ4VS9JOHZIM0tIMW5sZ3huRzcwUnlWallUbHR4?=
 =?utf-8?B?OTREakZudG5URGJ6Vkt6ZUxENnZJWE5UMDZrenV5NEgvV0lNK0pDNXJxcTRa?=
 =?utf-8?B?Nm50VUh2T2dEdGtEcGhoK1pOQStGVzlRUElZbHlYOTVDSERubVB6RjNBOG5R?=
 =?utf-8?B?TFU3NVJYRWlpMU1OVndsclBMNnVBZ0RTOTYzU284VEhpRWhLVnRiN3BEV2hh?=
 =?utf-8?B?bUx3cnBsdTVaNUYwcWRCbDdwd2dzUkdZUis3alNORVlWTGJqRXc3MUluTzlQ?=
 =?utf-8?Q?MDWT7Fsql0vIU=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6184f0e6-6435-42f5-6d12-08d89b5b311d
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 09:25:24.4444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWb4+TQcxiJ4+KGt6IcFWk8SXEFa1j54P6N2L76OJnx9V8fY2DMmNprR0nDnfZjlsgVdynV8VGHOKDYEtDEVCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3576
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
Cc: guoweichao@oppo.com, linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

sorry, it

在 2020/12/8 17:03, Gao Xiang 写道:
> Hi Jianan,
>
> On Tue, Dec 08, 2020 at 04:47:50PM +0800, Huang Jianan wrote:
>> iblock indicates the number of i_blkbits-sized blocks rather than
>> sectors, fix it.
>>
>> If the data has a disk mapping, map_bh should be used to read the
>> correct data from the device.
>>
>> Fixes: 9da681e017a3 ("staging: erofs: support bmap")
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
>> ---
>>   fs/erofs/data.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 347be146884c..1415fee10180 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -316,7 +316,7 @@ static int erofs_get_block(struct inode *inode, sector_t iblock,
>>   			   struct buffer_head *bh, int create)
>>   {
>>   	struct erofs_map_blocks map = {
>> -		.m_la = iblock << 9,
>> +		.m_la = iblock << blknr_to_addr(iblock),
> Sorry I don't get the point although I think the problem may exist....
> I mean is that correct? since it equals to iblocks << (iblock * EROFS_BLKSIZE) ....
>
> Thanks,
> Gao Xiang
>
Sorry, it should be :

.m_la = blknr_to_addr(iblock),

I will send patch v2 to fix this. 😅

>>   	};
>>   	int err;
>>   
>> @@ -325,7 +325,7 @@ static int erofs_get_block(struct inode *inode, sector_t iblock,
>>   		return err;
>>   
>>   	if (map.m_flags & EROFS_MAP_MAPPED)
>> -		bh->b_blocknr = erofs_blknr(map.m_pa);
>> +		map_bh(bh, inode->i_sb, erofs_blknr(map.m_pa));
>>   
>>   	return err;
>>   }
>> -- 
>> 2.25.1
>>
